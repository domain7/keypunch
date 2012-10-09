class Entity < ActiveRecord::Base
  has_paper_trail skip: [:password]

  attr_accessible :group_ids, :name, :username, :password, :password_confirmation, :description, :protocol, :domain, :expire_at, :role_ids, :user_ids
  has_many :entity_groups
  has_many :entity_roles
  has_many :entity_users
  has_many :groups, :through => :entity_groups, :dependent => :destroy
  has_many :roles, :through => :entity_roles, :dependent => :destroy
  has_many :users, :through => :entity_users, :dependent => :destroy

  validates :name, :presence => true
  validates :username, :presence => true
  validates :password, :presence => true, :confirmation => true, :if => :password_changed?

  after_validation :set_password_changed_at

  after_save :default_role

  def self.search(search)
    entities = self
    if search
      group_ids = Group.where("title ~* ?",search).map { |g| g.id }
      entity_ids = EntityGroup.where(:group_id => group_ids).map { |e| e.entity_id }
      entities = entities.where("entities.name ~* ? OR entities.username ~* ? OR entities.description ~* ? OR entities.domain ~* ? OR entities.id IN (?)",
                                search, search, search, search, entity_ids)
    end
    entities
  end

  def self.load_keepass(file)
    require 'xml'
    doc = XML::Parser.file( file ).parse
    @entry_elements = %w[title username password url comment icon creation lastaccess lastmod expire]
    transaction do
      doc.root.children.each do |n|
        self.group_parse(nil, n) if n.name == 'group'
      end
    end
  end

  def domain_linkable?
    nil != URI::regexp(%w(http https)).match(self.domain)
  end

  def decrypt
    key_path = Rails.root.join('pgp')
    temp_file = Tempfile.new('message')
    temp_file.print(self.password)
    temp_file.flush
    `gpg --homedir #{key_path.to_s} -d #{temp_file.path}`
  end

  def role?(role)
    roles.map { |r| r.name }.include? role.to_s
  end

  def roles_include?(test_roles)
    test_role_ids = test_roles.map { |r| r.id.to_i }
    entity_role_ids = self.roles.map { |r| r.id.to_i }
    (test_role_ids & entity_role_ids).size > 0
  end

  def display_roles
    self.roles.map{ |r| r.name }.join(', ')
  end

  def user?(user)
    users.map { |u| u.id.to_i}.include? user.id.to_i
  end

  def display_users
    self.users.map{ |u| u.email }.join(', ')
  end

  private
    def self.group_parse(pid,node)
      title = node.find('title').first.content
      if pid.nil?
        gid = Group.find_or_create_by_title_and_ancestry(title, nil).id
      else
        ancestry = Group.find_by_id(pid).path_ids.join('/')
        gid = Group.find_or_create_by_title_and_ancestry(title, ancestry).id
      end

      node.children.each do |n|
        self.group_parse(gid, n) if n.name == 'group'
        self.entry_parse(gid, n) if n.name == 'entry'
      end
    end

    def self.entry_parse(gid,node)
      tmp = {}
      @entry_elements.each do |fname|
        tmp[fname.intern] = node.find(fname).first.content
      end
      current_entity = self.find_by_group_id_and_name(gid,tmp[:title])
      if current_entity
        current_entity.update_attributes( :group_id => gid, :name => tmp[:title], :username => tmp[:username], :password => tmp[:password], :description => tmp[:comment], :domain => tmp[:url], :expire_at => tmp[:expire], :created_at  => tmp[:creation], :updated_at => tmp[:lastmod])
      else
        self.create( :group_id => gid, :name => tmp[:title], :username => tmp[:username], :password => tmp[:password], :description => tmp[:comment], :domain => tmp[:url], :expire_at => tmp[:expire], :created_at  => tmp[:creation], :updated_at => tmp[:lastmod])
      end
    end

    def password_changed?
      if ! self.new_record?
        ! self.password.blank?
      else
        return true
      end
    end

    def default_role
      self.roles << Role.find_or_create_by_name('Public') if self.roles.empty? && self.users.empty?  #TODO: add check for private when this is implemented
    end

    def set_password_changed_at
      if !self.new_record? && password_changed?
        self.password_changed_at = Time.zone.now
      end
    end
end

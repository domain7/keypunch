class User < ActiveRecord::Base
  devise :database_authenticatable, :recoverable, :trackable, :validatable, :lockable, :timeoutable, :omniauthable
  attr_accessible :email, :password, :password_confirmation, :first_name, :last_name
  attr_accessible :role_ids, :first_name, :last_name, :as => :admin

  validates :password, :password_strength => true, :password_unique => true
  has_many :user_roles
  has_many :roles, through: :user_roles
  has_many :password_histories, :dependent => :destroy, :as => :uniqueable

  after_save :store_digest
  after_save :default_role

  def self.find_for_googleapps_oauth(access_token, signed_in_resource=nil)
    data = access_token['info']
    if user = User.find_by_email(data['email'])
      user
    else #create a user with stub pwd
      #NOTE: make sure password validation rules pass one uppper,lower,number,punctuation Pp!1
      User.create!(:email => data['email'], :password => Devise.friendly_token[0,20] + 'Pp!1' )
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session['devise.googleapps_data'] && session['devise.googleapps_data']['user_info']
        user.email = data['email']
      end
    end
  end

  def role?(role)
    roles.map { |r| r.name }.include? role.to_s
  end

  def full_name
    [self.first_name, self.last_name].join(" ")
  end

  def display_roles
    self.roles.map{ |r| r.name }.join(', ')
  end

  def store_digest
    if encrypted_password_changed?
      PasswordHistory.create(:uniqueable => self, :encrypted_password => encrypted_password)
    end
  end

  def default_role
    self.roles << Role.find_or_create_by_name('Public') if self.roles.empty?
  end
end

class PgpKeys < ActiveRecord::Base
  attr_accessible :key
  validates :key, :presence => true

  def self.new_key(name, email)

    key_path = Rails.root.join('pgp')
    Dir.mkdir(key_path) if !key_path.directory?
    tmp_file = ''
    batch = Tempfile.open('pgp', Rails.root.join('tmp') ) do |f|
     f.puts <<eos
# input file to generate GnuPG keys automatically

%echo Generating a standard key

#######################################
# parameters for the key

Key-Type: RSA
Key-Length: 2048
Subkey-Type: ELG-E
Subkey-Length: 2048

Name-Real: #{name}
Name-Comment: automatically Generated GnuPG key
Name-Email: #{email}

Expire-Date: 0

######################################

# perform key generation
%commit

%echo done
#EOF
eos
    f.flush
    end
    `gpg --homedir #{key_path.to_s} --no-options --batch --no-default-keyring --gen-key #{batch.path}`
    `gpg --homedir #{key_path.to_s} --export #{email} > #{batch.path}`
    bin_key = open(batch.path, "rb") {|io| io.read }
    self.create(:key => bin_key)
  end
end

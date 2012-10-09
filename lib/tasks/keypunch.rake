namespace :keypunch do
  desc "Create New PGP Key Development"
  task :install => [:environment] do
    puts "Creating new encryption keys"
    puts "============================"
    puts "What do you want to name your key: (Keypunch develop)?"
    name = STDIN.gets.chomp
    puts "What email address do you wish to assign: (keypunch@example.com)?"
    email = STDIN.gets.chomp

    name = 'Keypunch develop' if name.empty?
    email = 'keypunch@example.com' if email.empty?

    PgpKeys.new_key(name,email)
  end
end

namespace :keepass do
  desc "Import Keepass"
  task :import => [:environment] do
    require 'xml'
    default_file = Rails.root.join('test','fixtures', 'keepass.xml').to_s
    puts "Which keepass file would you like to import? (#{default_file}) "
    user_confirm = STDIN.gets.chomp
    if !user_confirm.blank?
      if FileTest.exists?( user_confirm )
        Entity.load_keepass( user_confirm )
      elsif FileTest.exists?( Rails.root.join( user_confirm ) )
        Entity.load_keepass( Rails.root.join( user_confirm ) )
      else
        puts "Aborting."
      end
    else
      Entity.load_keepass( default_file )
    end
  end
end

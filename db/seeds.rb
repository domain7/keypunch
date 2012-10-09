pass='F00B@rz!'

admin = Role.find_or_create_by_name({:name => 'admin'})
Role.find_or_create_by_name({:name => 'user'})

u = User.find_or_create_by_email({ :email => 'root@example.com',  :password => pass, :password_confirmation => pass })
u.save
u.roles << admin

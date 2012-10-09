# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Keypunch::Application.initialize!
ActiveRecord::Base.send(:attr_accessible, nil)
ActiveRecord::Base.send(:attr_accessible, :session_id)

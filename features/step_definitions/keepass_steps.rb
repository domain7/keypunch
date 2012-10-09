When /^I upload a keepass file$/ do
  default_file = Rails.root.join('test','fixtures', 'keepass.xml').to_s
  attach_file('keepass_filename', default_file)
  click_button('Submit Keepass')
end

module NavigationHelpers
  def path_to(page_name)
    case page_name

    when /the home\s?page/
      '/'

    when /^I go to the login page$/
      '/login'

    when /^I visit the logout page$/
      '/logout'

    when /^the import keepass page$/
      new_keepas_path()

    when /^the edit group page$/
      @group ||= Group.last
      edit_group_path(@group)

    when /^the edit entity page$/
      @entity ||= Entity.last
      edit_entity_path(@entity)

    when /^the edit entity page for "(.*)"$/
      @entity = Entity.find_by_name($1)
      edit_entity_path(@entity)

    when /^the edit user page$/
      @user ||= User.last
      edit_user_path(@user)

    when /^the edit user page for "(.*)"$/
      @user = User.find_by_email($1)
      edit_user_path(@user)

    when /^the user page$/
      @user ||= User.last
      user_path(@user)

    when /^the user page for "(.*)"$/
      @user = User.find_by_email($1)
      user_path(@user)

    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /the (.*) page/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue Object => e
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)

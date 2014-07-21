module NavigationHelpers
  def path_to(page_name)
    case page_name
    
    when /the home page/
      root_path
    when /the about page/
      about_path
    when /the contact page/
      contact_path

    when /the signup page/
      signup_path
    when /the login page/
      login_path
    
    when /the list of user page/
      users_path

    when /the list of category page/
      categories_path

    else
      raise "Can't find mapping from \"#{page_name}\" to a path."
    end
  end
end

World(NavigationHelpers)
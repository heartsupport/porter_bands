# frozen_string_literal: true

# name: porter_bands
# about: This is a plugin that restricts routes accessed by a band on a forum
#  coming form specific domains
# version: 0.0.1
# authors: Acacia Bengo Ssembajjwe
# url:git@github.com:heartsupport/porter_bands.git
# required_version: 2.7.0

after_initialize do
  # Code which should run after Rails has finished booting
  Discourse::Application.routes.append do
    # iterate through all the bands and create a route for each

    # restrict the root route to the bands category
    constraints subdomain: "augustburnsred" do
      # route all root requests to the bands category
      root to: redirect("/c/122")
      get "/abr", to: redirect("/c/122")
    end

    match "/abr", to: redirect("/c/122), via: :all
  end
end

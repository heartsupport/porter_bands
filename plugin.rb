# frozen_string_literal: true

# name: porter_bands
# about: This is a plugin that restricts routes of bands access a forum
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
    root to: "/category/122", constraints: { subdomain: "augustburnsred" }
    match "/abr", to: "category/122", via: :all
  end
end

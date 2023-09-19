# frozen_string_literal: true

# name: porter-bands
# about: This is a plugin that restricts routes accessed by a band on a forum
#  coming form specific domains
# version: 0.0.1
# authors: Acacia Bengo Ssembajjwe
# url:git@github.com:heartsupport/porter_bands.git
# required_version: 2.7.0

after_initialize do
  # add dependencies
  require_relative "lib/bands_constraint"
  require_relative "lib/band_user"
  require_relative "config/initializers/patch_users_controller"
  require_relative "app/controllers/bands_controller"

  # Code which should run after Rails has finished booting
  Discourse::Application.routes.append do
    # match "/abr", to: redirect { |params, request| BandsConstraint.new("augustburnsred").matches?(request) }, via: :all

    match "/abr", to: "bands#show", via: :all
  end
end

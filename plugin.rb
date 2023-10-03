# frozen_string_literal: true

# name: porter-bands
# about: This is a plugin that restricts routes accessed by a band on a forum
#  coming form specific domains
# version: 1.0.3
# authors: Acacia Bengo Ssembajjwe
# url: https://github.com/heartsupport/porter_bands.git
# required_version: 2.7.2

enabled_site_setting :porter_bands_enabled

add_admin_route "porter_bands.title", "bands"

register_asset "stylesheets/bands.scss"

# add dependencies
require_relative "lib/bands_constraint"
require_relative "lib/band_user"
require_relative "app/models/band"
require_relative "app/controllers/bands_controller"

after_initialize do
  require_relative "config/initializers/patch_users_controller"

  Discourse::Application.routes.append do
    get "/admin/plugins/bands" => "admin/plugins#index"
    get "/admin/plugins/bands/*all" => "admin/plugins#index"

    # band routes
    get "admin/plugins/porter/bands" => "bands#index"
    get "admin/plugins/porter/bands/new" => "bands#new"
    post "admin/plugins/porter/bands/" => "bands#create"
    delete "admin/plugins/porter/bands/:id" => "bands#destroy"

    # Band.all.each do |band|
    #   match "/#{band.path}", to: "bands#show", via: :all, constraints: BandsConstraint.new(band.name)
    # end

    match "/bands/:path", to: "bands#show", via: :get
  end
end

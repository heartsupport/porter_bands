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

after_initialize do
  load File.expand_path("../app/controllers/bands_controller.rb", __FILE__)
  # add dependencies
  require_relative "lib/bands_constraint"
  require_relative "lib/band_user"
  require_relative "app/models/band"
  require_relative "config/initializers/patch_users_controller"
  require_relative "app/controllers/bands_controller"

  Discourse::Application.routes.append do
    get "/admin/plugins/bands" => "bands#index"
    get "/admin/plugins/bands/new" => "bands#new"
    post "/admin/plugins/bands" => "bands#create"
    delete "/admin/plugins/bands/:id" => "bands#destroy"

    Band.all.each do |band|
      match "/#{band.path}", to: "bands#show", via: :all, constraints: BandsConstraint.new(band.name)
    end
  end
end

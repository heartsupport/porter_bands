PorterBands::Engine.routes.draw do
  root to: "bands#index"
  get "bands/new" => "bands#new"
  post "bands" => "bands#create"
  delete "bands/:id" => "bands#destroy"
end

Discourse::Application.routes.draw do
  mount PorterBands::Engine, at: "/admin/plugins/porter_bands"
end

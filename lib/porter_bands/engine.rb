# frozen_string_literal: true

module ::PorterBands
  class Engine < ::Rails::Engine
    engine_name "porter_bands"
    isolate_namespace PorterBands
  end

  class UsersController < ::UsersController
  end
end

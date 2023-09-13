# frozen_string_literal: true

# name: porter-bands
# about: This is a plugin that restricts routes accessed by a band on a forum
#  coming form specific domains
# version: 0.0.1
# authors: Acacia Bengo Ssembajjwe
# url:git@github.com:heartsupport/porter_bands.git
# required_version: 2.7.0

# add dependencies
require_relative "lib/bands_constraint"

after_initialize do
  # Code which should run after Rails has finished booting
  Discourse::Application.routes.append do
    match "/abr", to: redirect { |params,request| BandsConstraint.new("augustburnsred").matches?(request)} , via: :all
  end
end

class BandsConstraint
  ACCEPTED_BANDS = ["AugustBurnsRed"].freeze
  BANDS = {
    "abr" => "AugustBurnsRed",
  }.freeze

  def initialize(band_name)
    @band_name = band_name
  end

  def matches?(request)
    current_user = CurrentUser.lookup_from_env(request.env)

    current_user && !!current_user.groups.where(name: @band_name)
  end
end

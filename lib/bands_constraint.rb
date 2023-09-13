class BandsConstraint

  ACCEPTED_BANDS = ["augustburnsred"]

  def initialize(band_name)
    @band_name = band_name
  end

  def matches?(request)
    return "/login" unless ACCEPTED_BANDS.include?(@band_name)

    current_user = CurrentUser.lookup_from_env(request.env)

    if current_user
      return "/c/5"
    else
      return "/login"
    end
  end
end

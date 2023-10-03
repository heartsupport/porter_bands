class BandsConstraint
  def initialize
  end

  def matches?(request)
    path = request.url.split("/").last
    band = Band.find_by(path: path)
    if band.present?
      # current_user = CurrentUser.lookup_from_env(request.env)
      # current_user && !!current_user.groups.where(name: band.name)
      true
    else
      return "/latest"
    end
  end
end

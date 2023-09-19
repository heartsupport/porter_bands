class BandsController < ActionController::Base
  def show
    band_name = request.url.split("/").last

    if BandUser::BANDS.include?(band_name)
      # add band name to session
      band = BandUser::BANDS[band_name]
      session[:band] = { name: band["name"] } unless session[:band].present?

      # check if user is logged in
      current_user = CurrentUser.lookup_from_env(request.env)
      if current_user
        redirect_to "/c/#{band["category_id"]}"
      else
        redirect_to "/signup"
      end
    else
      redirect_to "/latest"
    end
  end
end

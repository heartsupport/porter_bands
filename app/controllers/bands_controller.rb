class BandsController < ActionController::Base
  def index
    @bands = Band.all
    respond_to do |format|
      # format.html { render "/plugins" }
      format.json { render json: @bands, status: :ok }
    end
  end

  def new
  end

  def create
  end

  def show
    path = request.url.split("/").last

    band = Band.find_by(path: path)

    if band.present?
      # add band name to session
      # band = BandUser::BANDS[band_name]

      session[:band] = { name: band.name } unless session[:band].present?

      # check if user is logged in
      current_user = CurrentUser.lookup_from_env(request.env)
      if current_user
        redirect_to "/c/#{band.category_id}"
      else
        redirect_to "/signup"
      end
    else
      redirect_to "/latest"
    end
  end

  def destroy
  end
end

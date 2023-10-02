class BandsController < ActionController::Base
  include Rails.application.routes.url_helpers

  def index
    @bands = Band.order("created_at DESC")
    render json: @bands, status: :ok
  end

  def new
    respond_to do |format|
      format.html { render "/admin/plugins" }
    end
  end

  def create
    path = params["path"]
    group_id = params["group_id"]
    category_id = params["category_id"]
    name = params["name"]

    @band = Band.new(path: path, group_id: group_id, category_id: category_id, name: name)

    if @band.save
      render json: @band, status: 201
    else
      render json: @band.errors, status: 422
    end
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
    band_id = params["band_id"]
    band = Band.find(band_id)
    Rails.logger.info("band: #{band.inspect}")
    if band
      # destroy band
      band.destroy
      render json: { message: "Band deleted successfully" }, status: 200
    else
      render json: { message: "Band not found" }, status: 404
    end
  end
end

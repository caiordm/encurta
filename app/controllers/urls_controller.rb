class UrlsController < ApplicationController
  before_action :set_url, only: %i[ show update destroy ]

  # GET /urls
  def index
    @urls = Url.all
    render json: @urls, headers: { 'Access-Control-Allow-Origin' => '*' }
  end

  # GET /urls/1
  def show
    render json: @url
  end

  # POST /urls
  def create
    @url = Url.new(url_params)
    @url.url_hash = Digest::SHA256.hexdigest(@url.url_original)[0..4]

    if @url.save
      render json: @url, status: :created, location: @url
    else
      render json: @url.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /urls/1
  def update
    if @url.update(url_params)
      render json: @url
    else
      render json: @url.errors, status: :unprocessable_entity
    end
  end

  # DELETE /urls/1
  def destroy
    @url.destroy!
  end

  def redirecter
    @url = Url.where(url_hash: params[:url_hash]).take

    if @url
      redirect_to @url.url_original, allow_other_host: true
    else
      render json: @url.errors, :status => 404
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_url
      @url = Url.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def url_params
      params.require(:url).permit(:url_original, :url_hash)
    end
end

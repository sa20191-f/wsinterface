class VideosController < ApplicationController
  before_action :set_video, only: [:show, :update, :destroy]
  require 'savon'
  # GET /videos
  def index
    @videos = Video.all
    client = Savon::Client.new(wsdl: "http://35.196.3.185:3008/wsvideos/wsdl")
    puts "HOLA COMO ESTAN"
    puts client.operations
    response = client.call(:find_videos, message: { title: "" })
    puts response
    puts "HOLA COMO ESTAN"
    render json: response
  end

  # GET /videos/1
  def show
    render json: @video
  end

  # POST /videos
  def create
    client = Savon::Client.new(wsdl: "http://35.196.3.185:3008/wsvideos/wsdl")
    puts "HOLA COMO ESTAN"
    puts client.operations
    response = client.call(:find_videos, message: { title: params[:title] })
    puts response
    puts "HOLA COMO ESTAN"
    render json: response
  end

  # PATCH/PUT /videos/1
  def update
    if @video.update(video_params)
      render json: @video
    else
      render json: @video.errors, status: :unprocessable_entity
    end
  end

  # DELETE /videos/1
  def destroy
    @video.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_video
      @video = Video.find(params[:title])
    end

    # Only allow a trusted parameter "white list" through.
    def video_params
      params.require(:video).permit(:name)
    end
end

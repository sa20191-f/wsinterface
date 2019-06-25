class ClientsController < ApplicationController
  before_action :set_client, only: [:show, :update, :destroy]
  require 'savon'
  # GET /clients
  def index
    @clients = Client.all
    client = Savon::Client.new(wsdl: "http://34.66.226.238:4000/wslists/wsdl")
    puts "HOLA COMO ESTAN"
    puts client.operations
    response = client.call(:view_list, message: { listId: 1 })
    puts response
    puts "HOLA COMO ESTAN"
    render json: response
  end

  # GET /clients/1
  def show
    render json: @client
  end

  # POST /clients
  def create
    client = Savon::Client.new(wsdl: "http://34.66.226.238:4000/wslists/wsdl")
    puts "HOLA COMO ESTAN"
    puts client.operations
    response = client.call(:view_list, message: { listId: params[:id] })
    puts response
    puts "HOLA COMO ESTAN"
    render json: response
  end

  # PATCH/PUT /clients/1
  def update
    if @client.update(client_params)
      render json: @client
    else
      render json: @client.errors, status: :unprocessable_entity
    end
  end

  # DELETE /clients/1
  def destroy
    @client.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client
      @client = Client.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def client_params
      params.require(:client).permit(:name)
    end
end

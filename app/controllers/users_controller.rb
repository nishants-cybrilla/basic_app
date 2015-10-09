class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to :back, :alert => "Access denied."
    end
  end

  def new_topic
  end

  def create_topic
    client = DiscourseApi::Client.new("http://localhost:4040")
    client.api_key = "f91f89da61720a14f93b80832544ac89654c4e2a6f99e3966c7eb66cd466b1d5"
    client.api_username = "nishant_samel"

    client.create_topic(params)

    redirect_to root_path, :notice => "Topic is successfully created."
  end
end

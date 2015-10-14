class StoresController < ApplicationController
  before_action :authenticate_user!

  def create
    @store = Store.new(store_params)
    @store.user = current_user

    if @store.save
      redirect_to products_path, notice: 'Store was successfully created.'
    else
      render :index
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def store_params
      params.require(:store).permit(:name, :user_id)
    end
end

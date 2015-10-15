class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @store = current_user.store.present? ? current_user.store : Store.new
    @product = Product.new
    @products = Product.all
  end

  def show
  end

  def create
    @product = Product.new(product_params)
    @product.store = current_user.store

    if @product.save
      redirect_to products_path, notice: 'Product was successfully added.'
    else
      render :index
    end
  end

  def edit
  end

  def update
    @product.remove_image! unless params[:product][:image]
    if @product.update(product_params)
      redirect_to products_path, notice: 'Product was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @product.destroy
    redirect_to products_path, notice: 'Product deleted successfully.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:title, :image, :product_url, :store_id)
    end
end

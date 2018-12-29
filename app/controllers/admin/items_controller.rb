class Admin::ItemsController < ApplicationController

def new

end
  #create a new item
  def create
    @items = Item.new(create_params)
    if @items.save
      render json: {status: 'SUCCESS', message: 'department created', data: @items},status: :ok
    else
      render json: {status: 'SUCCESS', message: 'department created', data: @items.errors},status: :ok
    end
  end


  #destroy the item
      render json: {status: 'SUCCESS', message: 'item deleted'},status: :ok
      render json: {status: 'SUCCESS', message: 'item deleted'},status: :ok
  def destroy
    item = Item.find(params[:id])
    if item.delete
      render json: {status: 'SUCCESS', message: 'item deleted'},status: :ok
    else
      render json: {status: 'FAILED', message: 'item not deleted'},status: :ok
    end
  end


#check if the item exists
  def existing_item
    item = Item.find_by(name: params[:name])
    if item.present?
      render json: {status: 'SUCCESS', message: 'item already exists',data: item},status: :ok
    else
      render json: {status: 'SUCCESS', message: 'item does not exists'},status: :ok
    end
  end

  #lists all the items
  def index
    @items = Item.order('created_at DESC')

  end


  #updates the details of selected item
  def update
    item = Item.find(params[:id])
    if item.update(create_params)
      render json: {status:"success" ,message:"updated"},status: :ok
    else
      render json: {status:"failiure" ,message:"not updated"},status: :ok
    end
  end


  private
  def create_params
    params.require(:item).permit(:department_id, :category_id, :name, :status, :description)

  end
end
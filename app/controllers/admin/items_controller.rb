class Admin::ItemsController < ApplicationController
  require 'barby'
  require 'barby/barcode/gs1_128'
  require 'barby/outputter/png_outputter'

def new

end
  #create a new item
  def create
    @items = Item.new(create_params)
    @items.code
    @items.generate_code
    if @items.save
      render json: {status: 'SUCCESS', message: 'department created', data: @items},status: :ok
    else
      render json: {status: 'FAILURE', message: 'department created', data: @items.errors},status: :ok
    end
  end


  def show
    item = Item.find(params[:id]).item_code_final
  @barcode = Barby::GS1128.new(item,'a','0')
  @barcode_png = Barby::PngOutputter.new(@barcode).to_png
  respond_to do |format|
    format.html
    format.png do
     send_data @barcode_png, type: "image/png", disposition: "inline"
    end
   #format.png do
    #send_data @text_png, type: "image/png", disposition: "inline"
 # end

end
  end

  def location
    item = Item.find(params[:id])
    item.name = params.require(:name)
    value = item.changed?
    render json: {status:"showing data", data:value }
  end

  def destroy
    item = Item.find(params[:id])
    if item.delete
      render json: {status: 'SUCCESS', message: 'item deleted'},status: :ok
    else
      render json: {status: 'FAILURE', message: 'item not deleted'},status: :ok
    end
  end

#check if the item exists
  def existing_item
    item = Item.find_by(name: params[:name])
    if item.present?
      render json: {status: 'SUCCESS', message: 'item already exists',data: item},status: :ok
    else
      render json: {status: 'FAILURE', message: 'item does not exists'},status: :ok
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
      render json: {status:"SUCCESS" ,message:"updated"},status: :ok
    else
      render json: {status:"FAILURE" ,message:"not updated"},status: :ok
    end
  end


  private
  def create_params
    params.require(:item).permit(:department_id, :category_id, :name, :status, :description)

  end
end

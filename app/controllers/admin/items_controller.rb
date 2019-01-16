class Admin::ItemsController < ApplicationController
  require 'barby'
  require 'barby/barcode/gs1_128'
  require 'barby/outputter/pdfwriter_outputter'
  require 'barby/outputter/prawn_outputter'
  require 'prawn-print'
  #require 'barby/outputter/text_outputter'
def new
  respond_to do |format|
      format.html
      format.js
    end
  end

  #create a new item
  def create
    @items = Item.new(create_params)
    @items.code
    @items.generate_code
    if @items.save
      render json: {status: 'SUCCESS', message: 'department created', data: @items},status: :ok
    else
      render json: {status: 'SUCCESS', message: 'department created', data: @items.errors},status: :ok
    end
  end


  def show

     item = Item.find(params[:id]).item_code_final
    @barcode = Barby::GS1128.new(item,'a','1')
     @barcode_pdf= Barby::PrawnOutputter.new(@barcode)
     doc =  @barcode_pdf.to_pdf
     respond_to do |format|
    format.html
    format.json
    format.pdf do
      send_data( doc, type: "application/pdf" ,filename: 'barcode.pdf', disposition: :inline)
    end
     end
   end




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


  def location
    item = Item.find(params[:id])
    old_location = item.current_location
    item.current_location = params.require(:current_location)

      if item.changed?
        location_detail = LocationDetail.new(:item_id => item.id ,:location_history => old_location)
        if location_detail.save
          if item.update(params.require(:item).permit(:current_location))
            render json: {status: "success", message: "location and item updated"},status: :ok
          else
            render json: {status: "success", message: "location updated"},status: :ok
          end
        else
          render json: {status: "failure", message: "not updated"},status: :ok
        end
        end





    end


  private
  def create_params
    params.require(:item).permit(:department_id, :category_id, :name, :status, :description, :current_location)

  end
  end


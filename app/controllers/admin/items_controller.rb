class Admin::ItemsController < ApplicationController
  require 'barby'
  require 'barby/barcode/gs1_128'
  require 'barby/outputter/pdfwriter_outputter'
  require 'barby/outputter/prawn_outputter'
  require 'prawn-print'
def new
  respond_to do |format|
      format.html
      format.js
    end
  end

  #create a new item
  def create
    @item = Item.new(create_params)
    @item.code
    @item.generate_code
    if @item.save
      redirect_to action: "show", id: @item.id
    else
      render json: {status: 'FAILURE', message: 'department created', data: @items.errors},status: :ok
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def barcode
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
    @items = Item.all

  end

  def edit
    @items = Item.find(params[:id])
  end
  def update
    @items = Item.find(params[:id])
    old_location = @items.current_location
    if @items.attributes = create_params
      if @items.current_location_changed?
        location_detail = LocationDetail.new(:item_id => @items.id ,:location_history => old_location)
        location_detail.save
      end
      @items.save
      redirect_to action: "index"
    else
      render :action => 'edit'
    end
  end

  private
  def create_params
    params.require(:item).permit(:department_id, :category_id, :name, :status, :description, :current_location)

  end
  end


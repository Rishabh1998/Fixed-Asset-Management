class Admin::CategoriesController < ApplicationController

def new

end
  #create a new category
  def create
    @categories = Category.new(create_params)
    @categories.code
    if @categories.save
      render json: {status: 'SUCCESS', message: 'department created', data: @categories},status: :ok
    else
      render json: {status: 'FAILURE', message: 'department created', data: @categories.errors},status: :ok
    end

  end


  #destroy the item
  def destroy
    category = Category.find(params[:id])
    if category.delete
      render json: {status: 'SUCCESS', message: 'category deleted'},status: :ok
    else
      render json: {status: 'FAILURE', message: 'category deleted'},status: :ok

    end
  end

def show
  @categories = Category.find(params[:id])
end
  #check if the item exists
  def existing_category
    category = Category.find_by(name: params[:name])
    if category.present?
      render json: {status: 'SUCCESS', message: 'category already exists',data: category},status: :ok
    else
      render json: {status: 'FAILURE', message: 'category does not exists'},status: :ok
    end
  end

  #lists all the items
  def index
    @categories = Category.all

  end

def edit
  @categories = Category.find(params[:id])
end
def update
  @categories = Category.find(params[:id])

  def update
    category = Category.find(params[:id])
    if category.update(create_params)
      render json: {status:"SUCCESS" ,message:"updated"},status: :ok
    else
      render json: {status:"FAILURE" ,message:"not updated"},status: :ok
    end
  end
  end

  private
  def create_params
    params.require(:category).permit(:department_id, :name, :status, :description)

  end
  end


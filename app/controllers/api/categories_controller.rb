class Api::CategoriesController <ApplicationController


  #create a new category
  def create
    category = Category.new(create_params)
    if item.save
      render json: {status:"success" ,message:"category created", data: category },status: :ok
    else
      render json: {status:"failiure" ,message:"category can not be created", data: category.errors},status: :unprocessable_entity
    end
  end


  #destroy the item
  def destroy
    category = Category.find(params[:id])
    if category.delete
      render json: {status: 'SUCCESS', message: 'category deleted'},status: :ok
    else
      render json: {status: 'SUCCESS', message: 'category deleted'},status: :ok

    end
  end


  #check if the item exists
  def existing_category
    category = Category.find_by(name: params[:name])
    if category.present?
      render json: {status: 'SUCCESS', message: 'category already exists',data: category},status: :ok
    else
      render json: {status: 'SUCCESS', message: 'category does not exists'},status: :ok
    end
  end

  #lists all the items
  def index
    category = Category.order('created_at DESC')
    render json: {status: 'SUCCESS', message: 'Loaded item',data: category},status: :ok
  end


  #updates the details of selected item
  def update
    category = Category.find(params[:id])
    if category.update(create_params)
      render json: {status:"success" ,message:"updated"},status: :ok
    else
      render json: {status:"failiure" ,message:"not updated"},status: :ok
    end
  end


  private
  def create_params
    params.require(:category).permit(:department_id, :name, :status, :description)

  end
end

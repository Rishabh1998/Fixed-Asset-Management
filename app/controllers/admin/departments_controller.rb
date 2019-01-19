class Admin::DepartmentsController < ApplicationController

  def new

  end
  #create new department
  def create
    @department = Department.new(create_params)
    @department.code
    if @department.save
      redirect_to action: "show", id: @department.id
    else
      render json: {status: 'FAILURE', message: 'department not created', data: @department.errors},status: :ok
    end

  end

  #destroys selected  department
  def destroy
    department = Department.find(params[:id])
    if department.delete
      render json: {status: 'SUCCESS', message: 'department deleted'},status: :ok
    else
      render json: {status: 'FAILURE', message: 'department not deleted'},status: :ok
    end
  end

  def show
    @department_show = Department.find(params[:id])
  end

  def edit
    @department = Department.find(params[:id])
  end
  def update
    department = Department.find(params[:id])
    if department.update(create_params)
      redirect_to action: "index"
    else
      render json: {status:"FAILURE" ,message:"not updated"},status: :ok
    end
  end


  def index
    @department = Department.all
   # render json: {status: 'SUCCESS', message: 'Loaded department',data: @department},status: :ok
  end

  private
  def create_params
    params.require(:department).permit(:name, :description, :status)

  end
end

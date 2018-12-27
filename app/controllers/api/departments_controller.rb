class Api::DepartmentsController < ApplicationController

  #create new department
  def create
    department = Department.new(create_params)
    if department.save
      render json: {status:"success" ,message:"department created", data: department },status: :ok
    else
      render json: {status:"failiure" ,message:"department not created", data: department.errors},status: :unprocessable_entity
    end
  end

  #destroys selected  department
  def destroy
    department = Department.find(params[:id])
    if department.delete
      render json: {status: 'SUCCESS', message: 'department deleted'},status: :ok
    else
      render json: {status: 'FAILED', message: 'department not deleted'},status: :ok
    end
  end



  #updates the details of selected department
  def update
    department = Department.find(params[:id])
    if department.update(create_params)
      render json: {status:"success" ,message:"updated"},status: :ok
    else
      render json: {status:"failiure" ,message:"not updated"},status: :ok
    end
  end

#lists all the department
  def index
    department = Department.order('created_at DESC')
    render json: {status: 'SUCCESS', message: 'Loaded department',data: department},status: :ok
  end


  private
  def create_params
    params.require(:department).permit(:name, :description, :status)

  end
end

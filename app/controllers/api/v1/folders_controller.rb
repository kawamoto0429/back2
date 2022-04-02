class Api::V1::FoldersController < ApplicationController
  def index
    p "----------"
    p request.headers['Authorization']
    p "==="
    if logged_in?
      user = User.find(params[:user_id])
      folders = user.folders.order(id: "DESC")
      render :json => folders
    else
      render :json => {errors: "message"}
    end
  end

  def show
    user = User.find(params[:user_id])
    folder = Folder.find(params[:id])
    if folder.format_id == 1
      plans = folder.plans.order(id: "DESC")
      render :json => [folder, plans]
    elsif folder.format_id == 2
      todoes = folder.todoes.order(id: "DESC")
      render :json => [folder, todoes]
    else
      render :json => "error"
    end
  end
  
  def create
    folder = Folder.new(
                        name: folder_params[:name], 
                        format_id: folder_params[:format],
                        user_id: folder_params[:user_id]
                      )
    if folder.save && logged_in?
      render :json => "created!!"
    else
      render :json => {message: folder.errors.full_messages}
    end  
  end

  def destroy
    p ">>>>>>>>>>>>>"
    p request.headers['Authorization']
    p "======================="
    user = User.find(params[:user_id])
    folder = Folder.find(params[:id])
    if logged_in?
      folder.destroy
      render :json => "delete!!"
    else
      render :json => "error!!"
    end
  end

  def todo
    if logged_in?
      folders = Folder.where(format_id: 2, user_id: params[:user_id]).order(id: "DESC")
      render :json => folders
    end
  end

  def plan
    folders = Folder.where(format_id: 1, user_id: params[:user_id]).order(id: "DESC")
    render :json => folders
  end

  private
    def folder_params
      params.require(:data).permit(:name, :format, :user_id)
    end
end


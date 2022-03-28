class Api::V1::FoldersController < ApplicationController
  def index
    user = User.find(params[:id])
    if user.password_digest == params[:password]
      folders = user.folders
      p "======"
      p folders
      p "======"
      render :json => folders
    else
      render :json => "error"
    end
  end

  def show
    user = User.find(params[:user_id])
    folder = Folder.find(params[:id])
    if user.id == folder.user_id
      if folder.format_id == 1
        plans = folder.plans
        render :json => [folder, plans]
      elsif folder.format_id == 2
        todoes = folder.todoes
        render :json => [folder, todoes]
      else
        render :json => "error"
      end
    else
      render :json => "error"
    end
  end
  
  def create
    p "========"
    p folder_params[:format]
    p "========"
    folder = Folder.new(
                        name: folder_params[:name], 
                        format_id: folder_params[:format],
                        user_id: folder_params[:user_id]
                      )
    "======"
    p folder
    "======"
    if folder.save
      render :json => "created!!"
    else
      render :json => {message: folder.errors.full_messages}
    end  
  end

  def destroy
    user = User.find(params[:user_id])
    folder = Folder.find(params[:id])
    if user.id == folder.user_id
      folder.destroy
      render :json => "delete!!"
    else
      render :json => "no!!"
    end
  end

  def todo
    folders = Folder.where(format_id: 2, user_id: params[:user_id])
    render :json => folders
  end

  def plan
    folders = Folder.where(format_id: 1, user_id: params[:user_id])
    render :json => folders
  end

  private
    def folder_params
      params.require(:data).permit(:name, :format, :user_id)
    end
end


class FoldersController < ApplicationController
  def index
    folders = Folder.all
    render :json => folders
  end

  def show
    folder = Folder.find(params[:id])
    if folder.format_id === 1
      plans = folder.plans
      render :json => [folder, plans]
    end
    if folder.format_id === 2
      todoes = folder.todoes
      render :json => [folder, todoes]
    end
  end
  
  def create
    p folder_params
    # folder = Folder.new(folder_params)
    folder = Folder.new(name: params[:data][:name], format_id: params[:data][:format])
    "======"
    p folder
    "======"
    if folder.save
      render :json => "created!!"
    else
      render :json => "error"
    end  
  end

  def destroy
    folder = Folder.find(params[:id])
    folder.delete
    render :json => "delete!!"
  end

  private
    def folder_params
      params.require(:data).permit(:name, :format)
    end
end

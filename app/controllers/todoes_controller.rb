class TodoesController < ApplicationController
  def create
    todo = Todo.new(
      content: params[:data][:name], 
      folder_id: params[:data][:folder], 
      memo: params[:data][:memo]
    )
   
    if todo.save
      render :json => "create"
    else
      render :json => "error"
    end
  end

  def destroy
    todo = Todo.find(params[:id])
    if todo.delete
      render :json => "delete"
    else
      render :json => "error"
    end
  end

  def complete
    todo = Todo.find(params[:todo_id])
    p todo
    if todo.complete
      todo.update(complete: false)
      render :json => "解除"
    else
      todo.update(complete: true)
      render :json => "完了"
    end
  end

  def alone
    todoes = Todo.where(folder_id: nil)
    render :json => todoes
  end
end

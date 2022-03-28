class Api::V1::TodoesController < ApplicationController
  def index
    user = User.find(params[:id])
    p user
    if user.password_digest == params[:password]
      todoes = user.todoes
      render :json => todoes
    else
      render :json => "error"
    end
  end
  def create
    p todo_params
    todo = Todo.new(
      content: todo_params[:content], 
      folder_id: todo_params[:folder_id], 
      memo: todo_params[:memo],
      user_id: todo_params[:user_id]
    )
   
    if todo.save
      render :json => "create"
    else
      render :json => {message: todo.errors.full_messages}
    end
  end

  def show
    todo = Todo.find(params[:id])
    p "======"
    p todo
    p "======"
    render :json => todo
  end

  def destroy
    user = User.find(params[:user_id])
    todo = Todo.find(params[:id])
    if user.id == todo.user_id
      todo.destroy
      render :json => "delete!!"
    else
      render :json => "no!!"
    end
  end

  def complete

    user = User.find(params[:user_id])
    todo = Todo.find(params[:todo_id])
    if user.id == todo.user_id
      if todo.complete
        todo.update(complete: false)
        render :json => "解除"
      else
        todo.update(complete: true)
        render :json => "完了"
      end
    else
      render :json => "error"
    end
  end

  def update
    todo = Todo.find(params[:id])
    p "===="
    p todo
    p "===="
    if todo.update(todo_params)
      render :json => "update"
    else
      render :json => "error"
    end
  end

  def alone
    todoes = Todo.where(folder_id: nil)
    render :json => todoes
  end

  private
  def todo_params
    params.require(:data).permit(:content, :folder_id, :memo, :user_id)
  end
end


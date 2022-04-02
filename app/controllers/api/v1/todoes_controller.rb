class Api::V1::TodoesController < ApplicationController
  def index
    p "===========+++++=========="
    p request.headers['Authorization']
    p "===========+++++=========="
    user = User.find(params[:user_id])
    todoes = user.todoes.order(id: "DESC")
    render :json => todoes
  end
  def create
    todo = Todo.new(
      content: todo_params[:content], 
      folder_id: todo_params[:folder_id], 
      memo: todo_params[:memo],
      user_id: todo_params[:user_id]
    )
    if logged_in? && todo.save
      render :json => "create"
    else
      render :json => {message: todo.errors.full_messages}
    end
  end

  def show
    todo = Todo.find(params[:id])
    if todo && logged_in?
      render :json => todo
    else
      render :json => "error"
    end
  end

  def destroy
    user = User.find(params[:user_id])
    todo = Todo.find(params[:id])
    if todo && logged_in?
      todo.destroy
      render :json => "delete!!"
    else
      render :json => "no!!"
    end
  end

  def complete
    todo = Todo.find(params[:todo_id])
    if logged_in?
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
    if todo.update(todo_params) && logged_in?
      render :json => "update"
    else
      render :json => "error"
    end
  end

  # def alone
  #   todoes = Todo.where(folder_id: nil)
  #   render :json => todoes
  # end

  private
  def todo_params
    params.require(:data).permit(:content, :folder_id, :memo, :user_id)
  end
end


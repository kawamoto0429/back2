class Api::V1::PlansController < ApplicationController
  def index
    user = User.find(params[:id])
    if user.password_digest == params[:password]
      plans = user.plans
      render :json => plans
    else
      render :json => "error"
    end
  end
  def create
    p "========"
    p plan_params
    p "========"
    plan = Plan.new(
                    title: plan_params[:title],
                    place: plan_params[:place],
                    start: plan_params[:startDate],
                    timestart: plan_params[:startTime],
                    end: plan_params[:endDate],
                    timeend: plan_params[:endTime],
                    folder_id: plan_params[:folder_id],
                    memo: plan_params[:memo],
                    user_id: plan_params[:user_id],
                  )
    if plan.save
      render :json => "created!!!!"
    else
      render :json => {message: plan.errors.full_messages}
    end              
  end

  def update
    plan = Plan.find(params[:id])
    if plan.update(plan_params)
      render :json => "update"
    else
      render :json => "error"
    end
  end

  def show 
    if Plan.find(params[:id])
      plan = Plan.find(params[:id])
      render :json => plan
    else
      render :json => "error"
    end
  end

  def destroy
    user = User.find(params[:user_id])
    plan = Plan.find(params[:id])
    if user.id == plan.user_id
      plan.delete
      render :json => "delete!!"
    else
      render :json => "no!!"
    end
  end

  def alone
    plans = Plan.where(folder_id: nil)
    render :json => plans
  end

  def find
    p "====="
    p params
    p "====="
    plans = Plan.where(start: params[:date], user_id: params[:user_id])
    render :json => plans
  end

  private
  def plan_params
    params.require(:data).permit(:title, :place, :startDate, :startTime, :endDate, :endTime, :memo, :folder_id, :user_id)
  end
end


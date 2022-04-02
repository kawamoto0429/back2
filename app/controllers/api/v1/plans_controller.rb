class Api::V1::PlansController < ApplicationController
  def index
    user = User.find(params[:user_id])
    if logged_in?
      plans = user.plans.order(id: "DESC")
      render :json => plans
    else
      render :json => "error"
    end
  end
  def create
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
    if logged_in? && plan.save
      render :json => "created!!!!"
    else
      render :json => {message: plan.errors.full_messages}
    end              
  end

  def show 
    plan = Plan.find(params[:id])
    if plan && logged_in?
      render :json => plan
    else
      render :json => "error"
    end
  end

  def destroy
    user = User.find(params[:user_id])
    plan = Plan.find(params[:id])
    if logged_in?
      plan.delete
      render :json => "delete!!"
    else
      render :json => "no!!"
    end
  end

  def update
    plan = Plan.find(params[:id])
    if plan.update(plan_params) && logged_in?
      render :json => "update"
    else
      render :json => "error"
    end
  end

  # def alone
  #   plans = Plan.where(folder_id: nil)
  #   render :json => plans
  # end

  def find
    if logged_in?
      plans = Plan.where(start: params[:date], user_id: params[:user_id])
      render :json => plans
    end
  end

  private
  def plan_params
    params.require(:data).permit(:title, :place, :startDate, :startTime, :endDate, :endTime, :memo, :folder_id, :user_id)
  end
end


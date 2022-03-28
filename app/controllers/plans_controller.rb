class PlansController < ApplicationController
  def index
    plans = Plan.all()
    render :json => plans
  end
  def create
    p "======"
    p params[:data]
    p "======"
    # plan = Plan.new(
    #                 title: plan_params[:title],
    #                 place: plan_params[:place],
    #                 start: plan_params[:start],
    #                 timestart: plan_params[:starttime],
    #                 end: plan_params[:end],
    #                 timeend: plan_params[:timeend],
    #                 folder_id: plan_params[:folder_id],
    #                 memo: plan_params[:memo],
    #                 user_id: plan_params[:user_id],
    #               )
    plan = Plan.new(
                    title: params[:data][:title],
                    place: params[:data][:place],
                    start: params[:data][:start],
                    timestart: params[:data][:starttime],
                    end: params[:data][:end],
                    timeend: params[:data][:timeend],
                    folder_id: params[:data][:folder_id],
                    memo: params[:data][:memo],
                    user_id: params[:data][:user_id],
                  )
    if plan.save
      render :json => {message: "created!!!!"}
    else
      render :json => {message: "error!!!!"}
    end              
  end

  def destroy
    plan = Plan.find(params[:id])
    if plan.delete
      render :json => "delete"
    else
      render :json => "error"
    end
  end

  def show
    plan = Plan.find(params[:id])
    render :json => plan
  end

  # private
  #   def plan_params
  #     params.require(:data).permit(:title, :place, :start, :timestart, :timeend, :end, :memo, :folder_id, :user_id)
  #   end
end

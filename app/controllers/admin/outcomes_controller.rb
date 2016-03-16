class Admin::OutcomesController < ApplicationController

  before_action :load_category
  before_action :require_outcome, except: [:index, :new, :create]

  def index
    @outcomes = Outcome.all
  end

  def create
    @outcome = Outcome.new(outcome_params)
    @outcome.category = @category
    if @outcome.save
      # @skill.outcomes << @outcome
      redirect_to [:admin, @category]
    else
      render :edit
    end
  end

  def update
    if @outcome.update(outcome_params)
      redirect_to [:admin, @category, @skill]
    else
      render :edit
    end
  end

  def destroy
    @outcome.destroy
    redirect_to [:admin, @category, @skill]
  end

  def show
    @activities = @outcome.activities
    # @activities = (Activity.all - @outcome.activities).map do |activity|
    #   activity.name
    # end.to_json
  end

  def autocomplete
    @activities = (Activity.search(params[:search_term]) - @outcome.activities)
    render json: @activities

    # activities = (Activity.all - @outcome.activities).map do |activity|
    #   {
    #     id: activity.id,
    #     name: activity.name,
    #     value: (activity.name + ' ' + activity.day rescue activity.name),
    #     type: activity.type,
    #     day: activity.day,
    #   }
    # end

    # respond_to do |format|
    #   format.html
    #   format.json {
    #     render json: activities #.map {|e| e[:name] }.sort
    #   }
    # end
  end

  private

  def load_category
    @category = Category.find params[:category_id]
  end

  def require_outcome
    @outcome = Outcome.find params[:id]
  end

  def outcome_params
    params.require(:outcome).permit(:text)
  end
end

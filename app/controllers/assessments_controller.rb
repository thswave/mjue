class AssessmentsController < ApplicationController
  skip_before_filter :authenticate_user!, only: [:show]
  before_filter :fetch_top_standings
  before_filter :find_lecture

  def new
    @assessment = Assessment.new
  end

  def index
    if @lecture
      @assessments = @lecture.assessments
      @assessment = current_user.assessment_for(@lecture)
      render 'lectures/show'
    else
      @assessments = Assessment.paginate(page: params[:page] || 1)
    end
  end

  def my
    @assessments = current_user.assessments.paginate(page: params[:page] || 1)

    render 'index'
  end

  def create
    @assessment = Assessment.new params[:assessment]
    @assessment.lecture = @lecture
    @assessment.user = current_user

    unless @assessment.save
      flash[:alert] = @assessment.errors.full_messages.first
    end

    @assessments = @lecture.assessments
    redirect_to lecture_path(@lecture)
  end

  def update
    @assessment = Assessment.find params[:id]

    unless @assessment.update_attributes params[:assessment]
      flash[:alert] = @assessment.errors.full_messages.first
    end

    @assessments = @lecture.assessments
    redirect_to lecture_path(@lecture)
  end

  def destroy
    @assessment = Assessment.find params[:id]
    @assessment.destroy
    redirect_to @assessment.lecture
  end

  private
    def find_lecture
      if params[:lecture_id]
        @lecture = Lecture.find params[:lecture_id]
      end
    end

    def fetch_top_standings
      @lectures = Lecture.where('assessment_count >= ?', Lecture::MIN_NUMBER_OF_ASSESSMENTS).order('overall_score DESC').first(20)
    end
end

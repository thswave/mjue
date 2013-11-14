class LecturesController < ApplicationController
  skip_before_filter :authenticate_user!, only: [:search]
  before_filter :fetch_top_standings

  def index
    #@assessments = Assessment.paginate(page: params[:page] || 1)
  end

  def search
    @query = params[:query]
    @query.gsub!(/[+\-|!(){}\[\]\^"~*?:\\]/, "\\\\\\0") if @query

    if @query && @query.length > 0
      @result = Lecture.search("*#{@query}*", page: params[:page] || 1, per_page: 12, load: true)
    else
      @result = Lecture.paginate page: params[:page] || 1
    end
  end

  def show
    @lecture = Lecture.find params[:id]
    @lecture.update_hit_count

    @assessment = Assessment.new
    @assessments = @lecture.assessments.all.sort do |a2, a1|
      if a1.positive_votes_percentage == a2.positive_votes_percentage
        a1.votes.count <=> a2.votes.count
      else
        a1.positive_votes_percentage <=> a2.positive_votes_percentage
      end
    end
  end

  private
    def fetch_top_standings
      @lectures = Lecture.where('assessment_count >= ?', Lecture::MIN_NUMBER_OF_ASSESSMENTS).order('overall_score DESC, assessment_count DESC').first(3)
    end
end

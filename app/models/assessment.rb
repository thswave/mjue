class Assessment < ActiveRecord::Base
  attr_accessible :content, :overall_score, :presentation_score, :workload_score, :grading_score

  belongs_to :lecture
  belongs_to :user

  has_many :votes

  after_save :update_assessment_count_of_lecture
  after_save :update_assessment_count_of_user

  after_initialize :initialize_with_defaults

  validates :user_id, presence: true, uniqueness: { scope: :lecture_id }
  validates :content, presence: true
  validates :presentation_score, presence: true, inclusion: { in: 1..10 }
  validates :workload_score, presence: true, inclusion: { in: 1..10 }
  validates :grading_score, presence: true, inclusion: { in: 1..10 }

  default_scope { order 'id DESC' }

  def best_or_worst
    overall_score > 5 ? 'best' : 'worst'
  end

  def self.voted_for(criteria)
    if criteria == :best
      self.best
    else
      self.worst
    end
  end

  def self.best
    where('overall_score >= 8.0')
  end

  def self.worst
    where('overall_score <= 3.0')
  end

  def self.per_page
    10
  end

  def positive_votes_percentage
    return 0 if votes.empty?
    ((votes.positive.count.to_f) / (votes.count.to_f) * 100).to_i
  end

  def negative_votes_percentage
    return 0 if votes.empty?
    ((votes.negative.count.to_f) / (votes.count.to_f) * 100).to_i
  end

  def update_votes_count
    self.upvote_count = votes.positive.count
    self.downvote_count = votes.negative.count
    save
  end

  private
    def initialize_with_defaults
      self.overall_score ||= 1
      self.presentation_score ||= 1
      self.workload_score ||= 1
      self.grading_score ||= 1
    end

    def calculate_overall_score
      self.overall_score = (presentation_score + workload_score + grading_score) / 3.0
    end

    def update_assessment_count_of_lecture
      lecture.update_assessment_count
    end

    def update_assessment_count_of_user
      user.update_assessment_count
    end
end

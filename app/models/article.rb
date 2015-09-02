class Article < ActiveRecord::Base
  belongs_to :author
  has_many :comments

  def self.most_popular
    all.sort_by{|a| a.comments.count }.last
  end
end

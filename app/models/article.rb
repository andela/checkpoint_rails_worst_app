class Article < ActiveRecord::Base
  belongs_to :author
  has_many :comments

  def self.all_names
    all.map do |art|
      art.name
    end
  end

  def self.five_longest_article_names
    limit(5).order("(LENGTH(name)) desc").pluck(:name)
  end
end

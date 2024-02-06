class Author < ApplicationRecord
  has_many :articles

  def self.generate_authors(count=1000)
    count.times do
      Fabricate(:author)
    end
    first.articles << Article.create(name: "some commenter", body: "some body")
  end

  def self.most_prolific_writer
    all.sort_by{|a| a.articles.count }.last
  end

  def self.with_most_upvoted_article
    all.sort_by do |auth|
      auth.articles.sort_by do |art|
        art.upvotes
      end.last
    end.last.name
  end
end

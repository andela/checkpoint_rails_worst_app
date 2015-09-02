class Author < ActiveRecord::Base
  has_many :articles

  def self.generate_authors(count=1000)
    count.times do
      Fabricate(:author)
    end
  end
end

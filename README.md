# Andela Rails Checkpoint #3

1. Git clone this app and follow the instructions below.

```bash
git clone git@github.com:andela/checkpoint_rails_worst_app.git
```

### This is one of the worst performing Rails apps ever.

Currently, the home page takes this long to load:

```bash
Rendered author/index.html.erb within layouts/application (3521.1ms)
Completed 200 OK in 3544ms (Views: 2697.2ms | ActiveRecord: 845.6ms)
```

The view takes 2.5 seconds to load. The AR querying takes 1 second to load. The page takes 3.5 seconds to load. That's not great.

The stats page is even worse:

```bash
Rendered stats/index.html.erb within layouts/application (4.2ms)
Completed 200 OK in 6322ms (Views: 21.5ms | ActiveRecord: 1663.7ms)
```

It took 6 seconds to load and a lot of the time taken isn't even in the ActiveRecord querying or the view. It's the creation of ruby objects that is taking a lot of time. This will be explained in further detail below.

So, **What can we do?**

Well, let's focus on improving the view and the AR querying first!

Complete this tutorial first:
[Jumpstart Lab Tutorial on Querying](http://tutorials.jumpstartlab.com/topics/performance/queries.html)

# Requirements for this checkpoint
* add an index to the correct columns
* implement eager loading vs lazy loading on the right pages.
* replace Ruby lookups with ActiveRecord methods.
* fix html_safe issue.
* page cache or fragment cache the root page.
* No need for testing, but you need to get the time down to a reasonable time for both pages.
* The root page needs to implement includes, pagination, and fragment caching.

##### Index some columns. But what should we index?

[great explanation of how to index columns and when](http://tutorials.jumpstartlab.com/topics/performance/queries.html#indices)

Our non-performant app has many opportunities to index. Just look at our associations. There are many foreign keys in our database...

```ruby
class Article < ActiveRecord::Base
  belongs_to :author
  has_many :comments
end
```

##### Ruby vs ActiveRecord

Let's try to get some ids from our Article model.

Look at Ruby:

```ruby
puts Benchmark.measure {Article.select(:id).collect{|a| a.id}}
  Article Load (2.6ms)  SELECT "articles"."id" FROM "articles"
  0.020000   0.000000   0.020000 (  0.021821)
```

The real time is 0.021821 for the Ruby query.

vs ActiveRecord

```ruby
puts Benchmark.measure {Article.pluck(:id)}
   (3.2ms)  SELECT "articles"."id" FROM "articles"
  0.000000   0.000000   0.000000 (  0.006992)
```
The real time is 0.006992 for the AR query. Ruby is about 300% slower.

For example, this code is terribly written in the Author model:

```ruby
def self.most_prolific_writer
  all.sort_by{|a| a.articles.count }.last
end

def self.with_most_upvoted_article
  all.sort_by do |auth|
    auth.articles.sort_by do |art|
      art.upvotes
    end.last
  end.last
end
```

Both methods use Ruby methods (sort_by) instead of ActiveRecord. Let's fix that.

##### html_safe makes it unsafe or safe?.

This is why variable and method naming is important.

In the show.html.erb for articles, we have this code

```ruby
  <% @articles.comments.each do |com| % >
    <%= com.body.html_safe %>
  <% end %>
```

What's wrong with it?

The danger is if comment body are user-generated input...which they are.

See [here](http://stackoverflow.com/questions/4251284/raw-vs-html-safe-vs-h-to-unescape-html)

Understand now? Fix the problem.


##### Caching

Our main view currently takes 4 seconds to load

```bash
Rendered author/index.html.erb within layouts/application (5251.7ms)
Completed 200 OK in 5269ms (Views: 4313.1ms | ActiveRecord: 955.6ms)
```

Let's fix that. Read this:
[fragment caching](http://guides.rubyonrails.org/caching_with_rails.html#fragment-caching)

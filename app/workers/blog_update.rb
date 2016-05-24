class BlogUpdate

  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence backfill: true do
      minutely(1)
  end

  def perform
  	posts=Post.all
  	posts[0].slice!("id")
  	byebug
  end

end

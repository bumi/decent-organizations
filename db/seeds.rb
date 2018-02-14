# Categories
Category.create!(name: "Papers")
Category.create!(name: "Blogposts")
Category.create!(name: "Organisations")
Category.create!(name: "Tools")

# Posts
post_one = Post.new(
  title: 'Attention web designers: You have 50 milliseconds to make a good first impression!',
  description: 'Three studies were conducted to ascertain how quickly people form an opinion about web page visual appeal. In the first study, participants twice rated the visual appeal of webhomepages presented for 500 ms each.',
  url: 'http://www.anaandjelic.typepad.com/files/attention-web-designers-2.pdf',
)
post_one.categories << Category.first
post_one.save!

post_two = Post.new(
  title: 'Simplicity',
  description: 'I enjoy a certain aesthetic. I like things made from brown leather and light-coloured wood, from glass and metal and brick, from wool and cotton. I like cheerful (but not loud) colours. I like plants and sunlight, and open space.',
  url: 'https://mattgemmell.com/simplicity/',
)
post_two.categories << Category.second
post_two.save!

post_three = Post.new(
  title: 'Why Factories?',
  description: 'These days, most Rails projects use some form of factories in their test set up. What problem do they solve and why are they needed?',
  url: 'https://robots.thoughtbot.com/why-factories',
)
post_three.categories << Category.third
post_three.categories << Category.fourth
post_three.save!

# Comments
Comment.create!(text: "I'm waiting for AMP chat; I hear it's fast. /s", post: Post.first)
Comment.create!(text: "Honestly with all the versions of js libraries and all the CDN hosts, the limitations of cache size and the insane bloat of webpages, I think you're going to have to be pretty lucky to get any beneficial cache hits from unrelated third party sites.", post: Post.first)
Comment.create!(text: "And you can run it on any platform, so long as it's Google's. The best user choice since the color of your Model T.", post: Post.first)
Comment.create!(text: "And the offers the assistant delivers as ads will be extremely light-weight, signed off by Google-headed committee.", post: Post.second)



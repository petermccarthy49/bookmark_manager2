
post '/links' do
  url = params["url"]
  title = params["title"]
  tags = params["tags"].split(" ").map do |tag|
    Tag.first_or_create(:text => tag) # either finds or creates the tag
  end
  Link.create(:url => url, :title => title, :tags => tags)
  redirect to('/')
end
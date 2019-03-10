class Scraping
  def self.movie_urls
    puts 'get movies link URL'
    links = []
    agent = Mechanize.new

    next_url = ""

    while true do
      page = agent.get("http://review-movie.herokuapp.com/" + next_url)
      image_urls = page.search('.entry-title a')
      image_urls.each do |image_url|
        links << image_url.get_attribute('href')
      end

      next_link = page.at('.pagination .next a')

      break unless next_link
      next_url = next_link.get_attribute('href')

    end

    links.each do |link|
      get_product("http://review-movie.herokuapp.com/" + link)
    end
  end

  def self.get_product(link)
    puts 'get movie imformation'
    agent = Mechanize.new
    page = agent.get(link)
    title = page.at('.entry-title').inner_text if page.at('.entry-title')
    image_url = page.at('.entry-content img')[:src] if page.at('.entry-content img')
    director = page.at('.director span').inner_text if page.at('.director span')
    detail = page.at('.entry-content p').inner_text if page.at('.entry-content p')
    open_date = page.at('.date span').inner_text if page.at('.date span')
    product = Product.where(title: title).first_or_initialize
    product.save
  end
end

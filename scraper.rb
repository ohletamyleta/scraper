require 'httparty'
require 'nokogiri'
require 'byebug'

def scraper
  url = "https://blockwork.cc/"
  unparsed_page = HTTParty.get(url)
  parsed_page = Nokogiri::HTML(unparsed_page)
  jobs = Array.new
  job_listings = parsed_page.css('div.listingCard') #50 per page

  per_page = job_listings.count 
  total = parsed_page.css('div.job-count').text.split(' ')[1].gsub(',', '').to_i  #total jobs listed on site, varies
  last_page = (total.to_f / per_page.to_f).round
 
  while page <= last_page
    pagination_url = "https://blockwork.cc/listings?page=#{page}"
    job_listings.each do |job_listing|
      job = {
        title: job_listing.css('span.job-title').text,
        company: job_listing.css('span.company').text,
        location: job_listing.css('span.location').text,
        url: "https://blockwork.cc" + job_listing.css('a')[0].attributes["href].value"]
      }
    jobs << job
    end
  page += 1
end




end

scraper

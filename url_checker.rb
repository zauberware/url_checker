require 'sitemap-parser'
require 'open-uri'
require 'nokogiri'

sitemap_url = ARGV[0]

def check_url(url)
  begin
    open(URI.encode(url)) do |f|
      puts f.base_uri 
      puts "Status: #{f.status.join(' ')}"    #=> ["200", "OK"]
    end
  rescue OpenURI::HTTPError => error
    response = error.io
    puts "\e[31mError for URL #{url}\e[0m"
    puts "Status: #{response.status.join(' ')}"
  end 
end

def check_sitemap(url)
  puts "Parsing sitemap #{url}"
  sitemap = SitemapParser.new url
  sitemap_data = sitemap.to_a
  (0..sitemap_data.length-1).each do |j|
    check_url(sitemap_data[j])
  end
end

if sitemap_url.nil?
  puts "\e[31mNo URL given. Make sure to use the URL of your sitemap.\e[0m"
else
  puts "Running #{sitemap_url}"
  sitemap = Nokogiri::HTML(open(sitemap_url))
  
  # when it has sub sitemaps
  sitemap.xpath("//sitemap/loc").each do |node|
    check_sitemap(node.content)
  end

  # check urls
  sitemap.xpath("//url/loc").each do |node|
    check_url(node.content)
  end
  
  puts "\e[32mFinished!\e[0m"
end


# remove this ad ;)
puts ""
puts "\e[36m🧙 Write us a message if you need any help with your digital services:"
puts ""
puts " https://www.zauberware.com/"
puts " hello@zauberware.com\e[0m"
puts ""

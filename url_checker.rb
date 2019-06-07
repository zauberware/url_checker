require 'sitemap-parser'
require 'open-uri'
require 'nokogiri'

sitemap_url = ARGV[0]

def check_url(url)
  begin
    open(URI.encode(url)) do |f|
      puts f.base_uri  #=> http://www.example.org
      puts f.status    #=> ["200", "OK"]
    end
  rescue OpenURI::HTTPError => error
    response = error.io
    puts "Error for URL " + url
    puts response.status
    puts response.string
  end 
end

def check_sitemap(url)
  puts "Parsing sitemap " + url
  sitemap = SitemapParser.new url
  sitemap_data = sitemap.to_a
  (0..sitemap_data.length-1).each do |j|
    check_url(sitemap_data[j])
  end
end

if not sitemap_url.nil?
  puts 'Running...' #+ sitemap_url
  #mainSitemap = SitemapParser.new sitemap_url
  sitemap = Nokogiri::HTML(open(sitemap_url))
  
  # when it has sub sitemaps
  sitemap.xpath("//sitemap/loc").each do |node|
    check_sitemap(node.content)
  end

  # check urls
  sitemap.xpath("//url/loc").each do |node|
    check_url(node.content)
  end
end
puts 'Finished.'

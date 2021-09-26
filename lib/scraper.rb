require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper



  def self.scrape_index_page(index_url)
    html = open(index_url)

    page = Nokogiri::HTML(html)

    students = []

    page.css(".student-card").each do |student|

      students << {
        :name => student.css("h4").text,
        :location => student.css("p").text,
        :profile_url => student.children[1].attributes["href"].value
      }
    end
      students
  end

  def self.scrape_profile_page(profile_url)
    page = Nokogiri::HTML(open(profile_url))

    student_page = {}

    links = page.css(".social-icon-container").css("a").map {|a| a.attributes["href"].value}
    
    links.detect do |b|
      student_page[:twitter] = b if b.include?("twitter")
      student_page[:linkedin] = b if b.include?("linkedin")
      student_page[:github] = b if b.include?("github")
    end
    #below this is checking for a blog. It is seperate from the .detect
    #because there is no keyword to search for.
    student_page[:blog] = links[3] if links[3] != nil

    student_page[:profile_quote] = page.css(".profile-quote")[0].text
    student_page[:bio] = page.css(".description-holder").css('p')[0].text
    student_page
  end

end

#! /usr/bin/env ruby
##****************************************************************************
# RUBY - Scrapper
# ****************************************************************************
#   Ruby's Program - Scrapper
#   Written by: THP Tls session 7
# 	Date: 25-Jan-2019
#   
#   Description:
# 		- 
# 		- 
#
#****************************************************************************
class Scrapper
	attr_accessor :hash_town

	def initialize(url)
		url_dept = url
	  html = Nokogiri::HTML(open(url_dept))
	  @hash_town = {}

	  html.css('.lientxt').map do |link_to_town|
	    _town = link_to_town.text
	    begin
	    	_email = get_townhall_email("http://annuaire-des-mairies.com#{(link_to_town['href'])[1..(link_to_town['href']).length]}")
		    @hash_town = @hash_town.merge({"#{_town}" => "#{_email}"}.to_h)
		  rescue Exception => e
	    end
	  end
	end

	def get_townhall_email(url) #From an url retrieves the email address 
	  html = Nokogiri::HTML(open(url))
	  email_town = html.css('section:nth-child(2) div table tbody tr:nth-child(4) > td:nth-child(2)').text
	end
end
# End of Scrapper ...........................................................
#.............................................................................
#.............................................................................

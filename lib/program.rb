#! /usr/bin/env ruby
##****************************************************************************
# RUBY - @NameOfTheProgram
#****************************************************************************
#   Ruby's Program - Name of the program
#   Written by: THP Tls session 7
# 	Date: 25-Jan-2019
#   
#   Description:
# 		- 
# 		- 
#
#		Links:
			require './lib/scrapper'
#
#****************************************************************************
class Program

	def scrapping
		global_hash = {}

		scrapper_mairie_1 = Scrapper.new("http://annuaire-des-mairies.com/pyrenees-atlantiques.html")	
		scrapper_mairie_2 = Scrapper.new("http://annuaire-des-mairies.com/pyrenees-atlantiques-2.html")	
		scrapper_mairie_3 = Scrapper.new("http://annuaire-des-mairies.com/pyrenees-atlantiques-3.html")

		hash_mairie_1 = scrapper_mairie_1.hash_town
		hash_mairie_2 = scrapper_mairie_2.hash_town
		hash_mairie_3 = scrapper_mairie_3.hash_town

		global_hash = global_hash.merge(hash_mairie_1.merge(hash_mairie_2.merge(hash_mairie_3)))
	end
end
# End of Program's name
#.............................................................................
#.............................................................................
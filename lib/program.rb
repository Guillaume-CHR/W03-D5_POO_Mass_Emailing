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

	@@global_hash = {}

	def initialize
	end

	def perform
		hash_mairie_1 = Scrapper.new("http://annuaire-des-mairies.com/pyrenees-atlantiques.html")	
		hash_mairie_2 = Scrapper.new("http://annuaire-des-mairies.com/pyrenees-atlantiques-2.html")	
		hash_mairie_3 = Scrapper.new("http://annuaire-des-mairies.com/pyrenees-atlantiques-3.html")


		puts hash_mairie_1.hash_town
		puts "Mairie 1 ^  || Mairie 2 v"
		sleep(10)
		puts hash_mairie_2.hash_town
		puts "Mairie 2 ^  || Mairie 3 v"
		sleep(10)
		puts hash_mairie_3.hash_town
		puts "Mairie 3 ^"

		@@global_hash.merge(hash_mairie_1.merge(hash_mairie_2.merge(hash_mairie_3)))

		puts @@global_hash.inspect
		puts "Mairie All ^ "
	end
end

# End of Program's name
#.............................................................................
#.............................................................................
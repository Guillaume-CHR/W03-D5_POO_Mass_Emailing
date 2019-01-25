<<<<<<< HEAD
require 'bundler'
require 'csv'

Bundler.require

$:.unshift File.expand_path("./../lib", __FILE__)

require 'app/scrapper'


$page_mairie = Scrapper.new("http://annuaire-des-mairies.com/val-d-oise.html")
#met l'ensemble du hash des mairies dans "$my_hash"
$my_hash = $page_mairie.mairies


#sauvegarde sous fichier .json
def to_json
 File.open("db/emails.json","w") do |f|
 f.write($my_hash.to_json)
 end
end
to_json


#psauvegarde sous fichier .csv
def to_csv
$hash_my = $my_hash.map { |c| c.join(",") }.join("\n")
CSV.open("db/emails.csv", "wb") do |row|

  row << ["#{$hash_my}"]
end
end
to_csv


#sauvegarde sous fichier google spreadsheet
def save_as_spreadsheet

session = GoogleDrive::Session.from_config("config.json")
# création de mon fichier excel en ligne avec adresse ci dessous
# https://docs.google.com/spreadsheets/d/19fXbxVaXn9knKHPAQMuuMsiKH_Q50cN5jlj6K3H8VQc/edit#gid=0
ws = session.spreadsheet_by_key("19fXbxVaXn9knKHPAQMuuMsiKH_Q50cN5jlj6K3H8VQc").worksheets[0]

# Gets content of A2 cell.
#p ws[2, 1]  #==> "hoge"

# Changes content of cells.
# Changes are not sent to the server until you call ws.save().
#création d'une boucle qui va chercher chaque key et value de mon array pour en remplir mes cellules 
#(colonne 1 pour key, colonne 2 pour value)
x = 1
$my_hash.each do |key, value|
	ws[x, 1] = key
	ws[x, 2] = value
	x +=1
end
ws.save

#cette partie ne nous concerne pas
# Dumps all cells.
(1..ws.num_rows).each do |row|
  (1..ws.num_cols).each do |col|
    p ws[row, col]
  end
end

#cette partie ne nous concerne pas non plus
# Yet another way to do so.
p ws.rows  #==> [["fuga", ""], ["foo", "bar]]

# Reloads the worksheet to get changes by other clients.
ws.reload
end







=======
#! /usr/bin/env ruby
##****************************************************************************
# RUBY - TIC TAC TOE
#****************************************************************************
#   Ruby's Program - Main Program
#   Written by: THP Tls session 7
# 	Date: 25-Jan-2019
#   
#   Description:
# 		- Program to simulate a Tic Tac Toe game
# 		- It uses the MVC method ... or tries to ...
# 		
# 	Gems:
		require 'bundler'
		Bundler.require
#
#****************************************************************************
application_google.new.perform
# End of Main Program ........................................................
#.............................................................................
#.............................................................................
>>>>>>> 597a71596dc43b882b4148e2a46b8aaa4c5c7b4e

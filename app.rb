#! /usr/bin/env ruby
##****************************************************************************
# RUBY - Mass Emailing
#****************************************************************************
#   Ruby's Program - Main Program
#   Written by: THP Tls session 7
# 	Date: 25-Jan-2019
#   
#   Description:
# 		-
# 		- 
# 		
# 	Gems:
		require 'bundler'
		Bundler.require
#		
#		Links:
		require './lib/program'


#
#****************************************************************************
program = Program.new
hash = program.scrapping

require 'google/apis/gmail_v1'
require 'googleauth'
require 'googleauth/stores/file_token_store'
require 'fileutils'
require 'mime'
include MIME


OOB_URI = 'urn:ietf:wg:oauth:2.0:oob'.freeze
APPLICATION_NAME = 'Gmail API Ruby Quickstart'.freeze
CREDENTIALS_PATH = 'credentials.json'.freeze
# The file token.yaml stores the user's access and refresh tokens, and is
# created automatically when the authorization flow completes for the first
# time.
TOKEN_PATH = 'token.yaml'.freeze
SCOPE = Google::Apis::GmailV1::AUTH_SCOPE

##
# Ensure valid credentials, either by restoring from the saved credentials
# files or intitiating an OAuth2 authorization. If authorization is required,
# the user's default browser will be launched to approve the request.
#
# @return [Google::Auth::UserRefreshCredentials] OAuth2 credentials
def authorize
  client_id = Google::Auth::ClientId.from_file(CREDENTIALS_PATH)
  token_store = Google::Auth::Stores::FileTokenStore.new(file: TOKEN_PATH)
  authorizer = Google::Auth::UserAuthorizer.new(client_id, SCOPE, token_store)
  user_id = 'default'
  credentials = authorizer.get_credentials(user_id)
  if credentials.nil?
    url = authorizer.get_authorization_url(base_url: OOB_URI)
    puts 'Open the following URL in the browser and enter the ' \
         "resulting code after authorization:\n" + url
    code = gets
    credentials = authorizer.get_and_store_credentials_from_code(
      user_id: user_id, code: code, base_url: OOB_URI
    )
  end
  credentials
end

# Initialize the API
service = Google::Apis::GmailV1::GmailService.new
service.client_options.application_name = APPLICATION_NAME
service.authorization = authorize

hash.each do |town,email|
	#Création du contenu du message
	msg = Mail.new #msg est une instance de la classe « Mail ». On va définir ses variables d’instance
	msg.date = Time.now
	msg.subject = "Test du mass emailing via API gmail"
	msg.body = "Bonjour à la ville de #{town},

Nous sommes des apprenant de la formation de The Hacking Project.
Nous permettons de vous contacter à la mairie de #{town} à propos du remarquable travail que font Les Restos du Coeur. 
Cette association répand le bien dans la France et aide les plus démunis à s'en tirer.
							
Avez-vous pensé à travailler avec eux ?
Soutenir Les Restos du Coeur, c'est important pour notre cohésion sociale : rejoignez le mouvement !


Merci à vous
--
L'équipe The Hacking Project (THP) de Toulouse - Session 7
https://www.thehackingproject.org/fr"
	msg.from = {"gch.thp@gmail.com" => "Equipe THP Toulouse - Session 7"}
	msg.to   = email

	# Création de la requête, insertion du contenu dans la propriété `raw`
	#(https://developers.google.com/gmail/api/v1/reference/users/messages/send)
	message = Google::Apis::GmailV1::Message.new(raw: msg.to_s)

	service.send_user_message('me', message)
end
# End of Main Program ........................................................
#.............................................................................
#.............................................................................


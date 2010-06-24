# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_reservations_session',
  :secret      => 'd65bdab6d33f76fac009f763f2b353eb400e6f765cf014514801ea3dead819cc6e47b686469fd0712765488fdfb437887430a4084d053b12a9f7e02f8d071264'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store

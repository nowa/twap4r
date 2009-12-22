# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_twap4r_session',
  :secret      => '511b664b646a49ec38a1394e082121e395dec435f5c8163c65b8c89f29242bda7f46d588dbaa2dc31c54ce111308ab0b5c5ca31a017c39e762273f9025e5f6f4'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store

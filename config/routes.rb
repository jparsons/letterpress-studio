ActionController::Routing::Routes.draw do |map|
  map.signup 'signup', :controller => 'users', :action => 'new'
  map.logout 'logout', :controller => 'user_sessions', :action => 'destroy'
  map.login 'login', :controller => 'user_sessions', :action => 'new'
  map.resources :user_sessions

  map.resources :users


  map.resources :no_shows

  map.resources :reservations

  map.resources :holidays

  map.resources :work_days

  map.resources :presses
  
  map.resources :artists
  
  map.resources :notes, :member=> {:find_by_url_name => :get }, :collection => {  :find_by_tag_name => :get, :tag_list =>:get }
  
  map.resources :products
  
  map.resources :exhibitions do |exhibitions|
    exhibitions.resources :photos
  end
  
  map.resources :photos
  
  # The priority is based upon order of creation: first created -> highest priority.
  
  # Front-End Routing
  # Default
  map.connect '', :controller => "notes", :action => 'index'
  
  #
  # Notes
  #
  # View individual note
  map.date 'news/:year/:month/:name', :controller => 'notes', :action => 'find_by_urlname', :year => /\d{4}/, :month => /\d{1,2}/
  # View list of entries by year and month
  map.connect 'news/:year/:month', :controller => 'front', :action => 'note_list_by_date', :year => /\d{4}/, :month => /\d{1,2}/
  # View list of entries by year
  map.connect 'news/:year', :controller => 'front', :action => 'note_list_by_date', :year => /\d{4}/
  # View xml with a proper .xml extension
  map.xml 'news.xml', :controller => 'front', :action => 'note_feed'
  # Tags
  #old one: map.connect 'news/tags/:name', :controller => 'front', :action => 'tag_find_by_urlname'
  #new one:
  map.tags 'news/tags/:name', :controller => 'notes', :action => 'find_by_tag_name'
  #does this one really need to be here:
  map.connect 'news/tags', :controller => 'notes', :action => 'tag_list'
  #map.connect 'news/tags', :controller=> 'notes', :action=>:index
  map.connect 'news', :controller => "notes", :action => 'index'
  
  #
  # Exhibitions
  #
  map.connect 'exhibitions/:name', :controller => 'front', :action => 'exhibition_find_by_urlname'
  map.connect 'exhibitions', :controller => 'front', :action => 'exhibition_list'
  map.xml 'exhibitions.xml', :controller => 'front', :action => 'exhibition_feed'
  
  #
  # Artists
  #
  map.connect 'artists/:name', :controller => 'front', :action => 'artist_find_by_urlname'
  map.connect 'artists', :controller => 'front', :action => 'artist_list'
  map.xml 'artists.xml', :controller => 'front', :action => 'artist_feed'
  
  #
  # Products
  #
  map.connect 'products/:name', :controller => 'front', :action => 'product_find_by_urlname'
  map.connect 'products', :controller => 'front', :action => 'product_list'
  map.xml 'products.xml', :controller => 'front', :action => 'product_feed'
  
  #
  # Static
  #
  map.connect 'information/:name', :controller => 'front', :action => 'static_find_by_urlname'
  map.connect 'information', :controller => 'front', :action => 'static_list'
  
  # Install the default route as the lowest priority.
  map.connect ':controller/:action/:id'
  
  map.root :controller =>"notes", :action=>"index"
end

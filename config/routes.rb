ActionController::Routing::Routes.draw do |map|

  map.resources :password_resets, :only => [ :new, :create, :edit, :update ]

  map.signup 'signup', :controller => 'users', :action => 'new'
  map.logout 'logout', :controller => 'user_sessions', :action => 'destroy'
  map.login 'login', :controller => 'user_sessions', :action => 'new'
  map.resources :user_sessions

  map.resources :users, :member => { :confirm => :get, :suspend => :get, :unsuspend => :get }


  map.resources :no_shows

  map.resources :reservations, :collection=> {:bulk_create => :post}

  map.resources :holidays

  map.resources :work_days

  map.resources :presses
  
  map.resources :artists do |artists|
    artists.resources :pictures
  end
  
  map.resources :notes, :member=> {:find_by_url_name => :get }, :collection => { :list_by_date => :get, :find_by_tag_name => :get, :tag_list =>:get }
  
  map.resources :products do |products|
    products.resources :planes
  end
  
  map.resources :exhibitions do |exhibitions|
    exhibitions.resources :photos
  end
  
  map.resources :photos
  
  map.resources :statics do |statics|
    statics.resources :icons
  end
  
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
  map.connect 'news/:year/:month', :controller => 'notes', :action => 'list_by_date', :year => /\d{4}/, :month => /\d{1,2}/
  # View list of entries by year
  map.connect 'news/:year', :controller => 'notes', :action => 'list_by_date', :year => /\d{4}/
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
  #map.exhibition_name 'exhibitions/:name', :controller => :exhibition, :action => :find_by_url_name

  #map.connect 'exhibitions', :controller => 'front', :action => 'exhibition_list'
  #map.connect 'exhibitions/:name', :controller => 'exhibitions', :action => 'find_by_urlname',  :name => /.*[a-zA-Z\_]{1}/ 
  #map.connect 'exhibitions/:id', :controller => 'exhibitions', :action => 'show', :id=> /\d+/
  map.xml 'exhibitions.xml', :controller => 'front', :action => 'exhibition_feed'
  
  #
  # Artists
  #
  map.connect 'artists/:name', :controller => 'artists', :action => 'find_by_urlname'
  map.connect 'artists', :controller => 'front', :action => 'artist_list'
  map.xml 'artists.xml', :controller => 'front', :action => 'artist_feed'
  
  #
  # Products
  #
  map.connect 'products/:id', :controller => 'products', :action=>'show'
  map.connect 'products/:name', :controller => 'front', :action => 'product_find_by_urlname'
  map.connect 'products', :controller => 'front', :action => 'product_list'
  map.xml 'products.xml', :controller => 'front', :action => 'product_feed'
  
  #
  # Static
  #
  map.connect 'information', :controller => 'statics', :action => 'index'
  map.information_page 'information/:id', :controller =>'statics', :action=> 'show'
  # Install the default route as the lowest priority.
  map.connect ':controller/:action/:id'
  
  map.root :controller =>"notes", :action=>"index"
  
end

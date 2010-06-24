class Exhibition < ActiveRecord::Base
  has_and_belongs_to_many :artists
  has_many :photos, :dependent => :destroy, :order => :position
  acts_as_urlnameable :name, :overwrite => true
  validates_presence_of :name
  
  named_scope :future, :conditions => ['is_active = ? and event_start_at > ?', true, Time.now], :order => 'event_start_at desc'
  named_scope :active,  :conditions => ['is_active = ?', true], :order => 'event_start_at desc'
  named_scope :current, :conditions => ['is_active = ? and event_start_at < ? and event_finish_at > ?', true, Time.now, Time.now], :order => 'event_start_at desc'
  named_scope :past, :conditions => ['is_active = ? and event_finish_at < ?', true, Time.now], :order => 'event_start_at desc'
  
  def self.all_future_shows
    self.find(:all, :conditions => ['is_active = 1 and event_start_at > ?', Time.now], :order => 'event_start_at desc')
  end

  def self.all_current_shows
    self.find(:all, :conditions => ['is_active = 1 and event_start_at < ? and event_finish_at > ?', Time.now, Time.now], :order => 'event_start_at desc')
	end

  def self.all_past_shows
    self.find(:all, :conditions => ['is_active = 1 and event_finish_at < ?', Time.now], :order => 'event_start_at desc')
	end


  def self.find_all_exhibitions_with_artist_counters
    self.find_by_sql(%{
      SELECT id, name, COUNT(artist_id) AS artist_counter
      FROM exhibitions LEFT OUTER JOIN artists_exhibitions
        ON artists_exhibitions.exhibition_id = exhibitions.id
      GROUP BY exhibitions.id, exhibitions.name
      ORDER BY artist_counter desc
      })
  end
  
  def to_param
    urlname
  end
 

end

class Note < ActiveRecord::Base
  acts_as_taggable_on :tags # for tagging
  validates_presence_of :name, :summary
  acts_as_urlnameable :name, :overwrite => true
  named_scope :active, :conditions=>["is_active = ?", true]
  named_scope :current, :conditions=>["is_active = ?", true], :order => 'created_at desc', :limit => 7
  named_scope :inactive, :conditions => ["is_active = ?", false], :order => 'created_at desc'
#  file_column :image, 
#              :magick => {
#                :versions => {
#                  :tiny => {:crop => "1:1", :size => "50x50!", :name => "tiny"},
#                  :thumb => {:crop => "3:2", :size => "180x120!", :name => "thumb"},
#                  :square => {:crop => "1:1", :size => "100x100!", :name => "square"},
#                  :wide => {:size => "540x500>"},
#                  :normal => {:size => "800x800"}
#              }
#  }
  has_attached_file :image, :styles => { :tiny => "50x50!", :thumb => "180x120!", :square => "100x100!", :wide => "540x500>", :normal => "800x800"}, 
  :url => "/note/image/:id/:style_:basename.:extension",
  :path => ":rails_root/public/note/image/:id/:style_:basename.:extension"

  # before a note is created, set its modification date to now
  #def before_create
  #  self.updated_at = Time.now
  #end
	
  # get a list of notes for the index page, based on active, current notes
  #def self.find_current
  #  self.find(:all, :conditions => 'is_active = 1', :order => 'created_at desc', :limit => 7)
  #end
  
  #def self.find_inactive
  #  self.find(:all, :conditions => 'is_active = 0', :order => 'created_at desc')
  #end
  
  # get a list of notes for the feed
  def self.find_for_feed
    self.find(:all, :conditions => 'is_active = 1', :order => 'created_at desc', :limit => 7)
  end

  # get a list of notes tagged with `tag`
  #def self.find_by_tag(tag, only_active = true)
  #    if only_active
  #      self.find_tagged_with(:all => tag, :conditions => 'is_active = 1', :order => 'created_at desc')
  #    else
  #      self.find_tagged_with(:all => tag, :order => 'created_at desc')
  #    end
  #end
  
  # find the previous active note
	def self.find_previous(note)
	  self.find(:all, :conditions => ['is_active = 1 and created_at < ?', note.created_at.strftime('%Y-%m-%d %H:%M:%S')], :order => 'created_at desc', :limit => 1)
	end
	
	# find the next active note
	def self.find_next(note)
	  self.find(:all, :conditions => ['is_active = 1 and created_at > ?', note.created_at.strftime('%Y-%m-%d %H:%M:%S')], :order => 'created_at asc', :limit => 1)
	end
	
	# get a list of tags that are assigned more than once and sorts them by name ascending
  def self.get_tags
    self.tags_count(:count => '> 0', :order => 'name asc')
  end
  
  def self.find_by_date_and_urlname(year, month, name)
    from, to = self.time_delta(year, month)
    find(:first, 
    :select => "notes.*",
    :joins => "JOIN urlnames ON notes.id = urlnames.nameable_id",
    :conditions =>
    [%{urlnames.nameable_type = 'Note'
      AND urlnames.name = ?
      AND notes.created_at BETWEEN ? AND ?
      AND notes.is_active = ?
      }, name, from, to, true])
  end
  
  protected  

  def self.time_delta(year, month = nil)
    from = Time.mktime(year, month || 1)
    to   = from + 1.year
    to   = from + 1.month unless month.blank?    
    return [from, to]
  end
end


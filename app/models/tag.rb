class Tag < ActiveRecord::Base
  acts_as_urlnameable :name, :overwrite => true
  validates_presence_of :name
  
  def self.find_all_tags_with_note_counters
    self.find_by_sql(%{
      SELECT id, name, COUNT(note_id) AS note_counter
      FROM tags LEFT OUTER JOIN tags_notes 
        ON tags_notes.tag_id = tags.id
      GROUP BY tags.id, tags.name
      ORDER BY note_counter desc
      })
  end
end

require 'digest/sha1'


class Author < ActiveRecord::Base
  # acts_as_urlnameable :display_name, :overwrite => true
  validates_presence_of     :name, 
                            :password,
                            :password_confirmation
                      
                            
  validates_uniqueness_of   :name
 
  validates_length_of       :password, 
                            :minimum => 5,
                            :message => "should be at least 5 characters long"
                            
  attr_accessor :password_confirmation
  validates_confirmation_of :password
  
  
  def self.authenticate(name, password)
    author = self.find_by_name(name)
    if author
      expected_password = encrypted_password(password, author.salt)
      if author.hashed_password != expected_password
        author = nil
      end
    end
    author
  end
  
  def password
    @password
  end
  
  def password=(pwd)
    @password = pwd
    create_new_salt
    self.hashed_password = Author.encrypted_password(self.password, self.salt)
  end 
  
  def safe_delete
    transaction do
      destroy
      if Author.count.zero?
        raise "Can't delete last author"
      end
    end
  end  
  
  
  private
  
  
  def create_new_salt
    self.salt = self.object_id.to_s + rand.to_s
  end
  
  
  
  def self.encrypted_password(password, salt)
    string_to_hash = password + "wibble" + salt
    Digest::SHA1.hexdigest(string_to_hash)
  end
  

end
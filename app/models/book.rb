class Book < ActiveRecord::Base
  attr_accessible :author, :description, :genre, :isbn, :title, :photo
  mount_uploader :photo, PhotoUploader
end

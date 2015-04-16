class Page < ActiveRecord::Base

	belongs_to :subject
	has_many :sections
	has_and_belongs_to_many :editors, :class_name => "AdminUser"

	validates_presence_of :name
	validates_length_of :name, :maximum => 255
	validates_presence_of :permalink
	validates_length_of :permalink, :within => 3..255
	# Use presence_of with length to disturb spaces
	validates_uniqueness_of :permalink
	# for unique values by subject use ":scope => :subject_id"

	scope :visible,   lambda { where(:visible => true) }
	scope :invisible, lambda { where(:visible => false) }
	scope :sorted,    lambda { order("pages.position ASC") }
	scope :new_first, lambda { order("pages.created_at DESC") }
	scope :search,    lambda { |query| 
		where("name LIKE ?", "%#{query}%")
	}

end
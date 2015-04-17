class AdminUser < ActiveRecord::Base

	has_secure_password

	has_and_belongs_to_many :pages
	has_many :section_edits
	has_many :sections, :through => :section_edits

	EMAIL_REGEX 		= /\A[a-z0-9,_%=-]+@[a-z0-9.-]+\.[a-z]{2,4}\Z/i
	FORBIDDEN_USERNAMES = ['Ali', 'Talha']
	# validates_presence_of :first_name
	# validates_length_of :first_name, :maximum => 25
	# validates_presence_of :last_name
	# validates_length_of :last_name, :maximum => 50
	# validates_presence_of :username
	# validates_length_of :username, :within => 3..25
	# validates_uniqueness_of :username
	# validates_presence_of :email
	# validates_length_of :email, :maximum => 100
	# validates_format_of :email, :with => EMAIL_REGEX
	# validates_confirmation_of :email

	# Shortcut validations, aka "sexy validation"

	validates :first_name, :presence => true, :length => { :maximum => 25 }
	validates :last_name,  :presence => true, :length => { :maximum => 50 }
	validates :username,   :presence => true, :length => { :within => 3..25}, :uniqueness => true
	validates :email, 	   :presence => true, :length => { :maximum => 100 }, :format => EMAIL_REGEX, 
						   :confirmation => true

	validate :username_is_allowed
	## Custom validation on create for new user registration
	# validate :no_new_users_on_saturday, :on => :create

	scope :sorted, lambda { order("admin_users.last_name ASC, admin_users.first_name ASC") }

	def name
		"#{first_name} #{last_name}"
		# Or: first_name + ' ' + last_name
		# Or: [first_name, last_name].join(' ')
	end

	private

	def username_is_allowed
		if FORBIDDEN_USERNAMES.include?(username)
			errors.add(:username, 'has been restricted from user.')
		end
	end

	def no_new_users_on_saturday
		if Time.now.wday = 6
				errors[:base] << "No new users on Saturday."
		end
	end
end

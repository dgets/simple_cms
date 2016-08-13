class AdminUser < ActiveRecord::Base

  has_secure_password

  has_and_belongs_to_many :pages
  has_many :section_edits
  has_many :sections, :through => :section_edits

  EMAIL_REGEX = /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}\Z/i
  FORBIDDEN_USERNAMES = ['littlebopeep', 'humptydumpty', 'marymary']

  #validates_presence_of :first_name
  #validates_length_of :first_name, :maximum => 25
  #validates_presence_of :last_name
  #validates_length_of :last_name, :maximum => 50
  #validates_presence_of :username
  #validates_length_of :username, :within => 8..25
  #validates_uniqueness_of :username
  #validates_presence_of :email
  #validates_length_of :email, :maximum => 100
  #validates_format_of :email, :with => EMAIL_REGEX
  #validates_confirmation_of :email

  #shortcut validations (sexy validations)
  validates :first_name, :presence => true, :length => { :maximum => 25 }
  validates :last_name, :presence => true, :length => { :maximum => 50 }
  validates :username, :length => { :within => 8..25 }, :uniqueness => true
  validates :email, :presence => true, :length => { :maximum => 100 },
		    :format => EMAIL_REGEX, :confirmation => true

  validate :username_is_allowed
  #validate :no_new_users_on_saturday, :on => :create

  def username_is_allowed
    if FORBIDDEN_USERNAMES.include?(username)
      errors.add(:username, "has been restricted from use")
    end
  end

  #errors not related to a specific attribute can be added to errors[:base]
  def no_new_users_on_saturday
    if Time.now.wday == 6
      errors[:base] << "No new users on Saturdays."
    end
  end

  # to configure a different table name:
  #self.table_name = "admin_users"

  #this is how you do accessors; however, ActiveRecord already takes care of
  #accessors and shit for all table columns, so this crap is moot
  #short way
  #attr_accessor :first_name

  #long way
  #def last_name
  #  @last_name
  #end

  #def last_name=(whadevah)
  #  @last_name = whadevah
  #end

  #Challenge - #15 Improving the Simple CMS
  #guess I forgot to use this method in the applicable admin_users controller
  def name
    return "#{@first_name} #{@last_name}"
  end

  #scope :sorted, lambda { 
  #	order("admin_users.last_name ASC").order("admin_users.first_name ASC")
  #}

  #this can more easily be accomplished (if the above even worked) like this:
  scope :sorted, lambda { order("last_name ASC, first_name ASC") }

end

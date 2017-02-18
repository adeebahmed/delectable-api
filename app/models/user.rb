class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def self.search_by_last_name(lname)
    where("lastname LIKE ?", "%#{lname}" )
  end

  def self.search_by_phone(phone)
    where("phone LIKE ?", "%#{phone}" )
  end

  def self.search_by_email(email)
    e = email + ".com"
    where("email LIKE ?", "%#{e}" )
  end

end

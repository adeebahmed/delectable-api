class Order < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  def self.search_by_date(date)
    where("deliverydate LIKE ?", "#{date}" )
  end
end

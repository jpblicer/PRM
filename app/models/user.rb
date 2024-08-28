class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :events
  has_many :todos

  def notification_count
    todos.where(end_date: Date.today).count + events.where(start_date: Date.today).count
  end
end

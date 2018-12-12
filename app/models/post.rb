class Post < ApplicationRecord
	has_many_attached :pictures
	belongs_to :user
	# validates :description, presence: true, length: { maximum: 50 }
end

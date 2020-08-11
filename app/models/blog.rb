class Blog < ApplicationRecord
  belongs_to :user
  mount_uploader :image, ImageUploader

  validates :title, presence: true
  validates :content, presence: true
  validates :image, presence: true
end

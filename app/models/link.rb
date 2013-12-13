class Link < ActiveRecord::Base
  belongs_to :user

  validates :content, presence: true
  validates :url, presence: true
end

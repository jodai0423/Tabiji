class Post < ApplicationRecord
  belongs_to :user

  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :bookmarks, dependent: :destroy

  has_one_attached :post_image

  validates :title, presence:true, length:{maximum:20}
  validates :caption, presence:true, length:{maximum:300}
  validates :lat, presence:true
  validates :lng, presence:true

  def get_post_image
    (post_image.attached?) ? post_image : 'no_image.png'
  end

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def bookmarked_by?(user)
    bookmarks.exists?(user_id: user.id)
  end

end
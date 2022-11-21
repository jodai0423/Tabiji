class Post < ApplicationRecord
  belongs_to :user

  has_many :comments, dependent: :destroy
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


  def get_post_image(width, height)
    unless post_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.png')
      post_image.attach(io: File.open(file_path), filename: 'default-image.png', content_type: 'image/jpeg')
    end
    post_image.variant(resize_to_limit: [width, height]).processed
  end

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def bookmarked_by?(user)
    bookmarks.exists?(user_id: user.id)
  end

end
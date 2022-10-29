class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

        has_many :posts, dependent: :destroy
        has_many :favorites, dependent: :destroy
        has_many :bookmarks, dependent: :destroy
        has_many :footprints, dependent: :destroy
        has_many :comments, dependent: :destroy
        has_many :chats, dependent: :destroy
        has_many :user_rooms, dependent: :destroy

        has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
        has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy

        has_many :followings, through: :relationships, source: :followed
        has_many :followers, through: :reverse_of_relationships, source: :follower

        has_many :favorited_posts, through: :favorites, source: :post
        has_many :bookmarked_posts, through: :bookmarks, source: :post

        has_one_attached :profile_image

        def get_profile_image
          (profile_image.attached?) ? profile_image : 'no_image.png'
        end

        def get_profile_image(width, height)
          unless profile_image.attached?
            file_path = Rails.root.join('app/assets/images/no_image.png')
            profile_image.attach(io: File.open(file_path), filename: 'default-image.png', content_type: 'image/jpeg')
          end
          profile_image.variant(resize_to_limit: [width, height]).processed
        end

        def following?(user)
          followings.exists?(user.id)
        end

end

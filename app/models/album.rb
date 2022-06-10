class Album < ApplicationRecord
    paginates_per 3
    belongs_to :user
    has_many_attached :images
    has_many :taggings, dependent: :destroy
    has_many :tags, through: :taggings


    validates :name, presence: true
    validates :description, presence: true
    validate :image_type

    def thumbnail input
        return self.images[input].variant(resize: "300x250!").processed
    end

    def image_type
        if images.attached? == false
            errors.add(:images, "are missing!")
        end

        images.each do |image|
            if !image.content_type.in?(%('image/jpeg image/png image/gif image/webp'))
                errors.add(:images, 'need to be a JPEG or PNG or GIF')
            end
        end
    end

    def self.tagged_with(name)
        Tag.find_by!(name: name).albums
    end

    def all_tags=(names)
        self.tags= names.split(',').map do |name|
            Tag.where(name: name).first_or_create!
        end
    end   

    def all_tags tag= nil
        # tags.map(&:name).join(", ")
        if tag != nil
            tag.name
        end
    end
end

class Album < ApplicationRecord

    belongs_to :user
    has_many_attached :images


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

end

class Album < ApplicationRecord
    validates :name, presence: true
    validates :descriptions,length: { in: 50..100 }, presence: true
end

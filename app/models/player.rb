class Player < ApplicationRecord
  has_one_attached :image
  
  belongs_to :team, optional: true

  validate :correct_image_type
  validate :validate_date_of_birth

  enum playing_position: {
    Goalkeeper: 0,
    Defender: 1,
    Midfielder: 2,
    Striker: 3
  }

  def full_name_with_id
    "P##{id}: #{first_name} #{last_name}"
  end

  private

  def validate_date_of_birth
    if date_of_birth >= Time.now
      errors.add(:date_of_birth, "must be in the past.")
    end
  end

  def correct_image_type
    if image.attached? and !image.content_type.in?(%w[image/jpg image/jpeg image/png])
      errors.add(:image, "file type is invalid.")
    end
  end
end

class Team < ApplicationRecord
  has_one_attached :logo

  has_many :players, dependent: :nullify

  validates :name, uniqueness: true
  validate :correct_logo_type

  # ToDo: Need to define properly
  def total_wins
    return 1
  end

  # ToDo: Need to define properly
  def total_draws
    1
  end

  # ToDo: Need to define properly
  def total_loses
    1
  end

  def get_player_by_type(type)
    self.players.find_by(playing_position: type.capitalize)
  end

  private

  def correct_logo_type
    if logo.attached? and !logo.content_type.in?(%w[image/jpg image/jpeg image/png])
      puts "ERROR!"
      errors.add(:logo, "file type is invalid.")
    end
  end

end

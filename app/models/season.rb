class Season < ApplicationRecord
  RUNNING = 0
  ENDED = 1

  enum status: {
    running: RUNNING,
    ended: ENDED
  }

  validates :title, uniqueness: true

end

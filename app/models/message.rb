class Message < ApplicationRecord
  belongs_to :conversation
  attr_accessor :type
  default_scope { order(created_at: :desc) }
end

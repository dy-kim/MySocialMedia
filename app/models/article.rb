# frozen_string_literal: true

class Article < ApplicationRecord
  has_many :comments
  has_many :likes
  has_many :users, through: :likes

  validates :title, presence: true
end

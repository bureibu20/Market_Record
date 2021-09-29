class Article < ApplicationRecord
  belongs_to :user
  is_impressionable counter_cache: true
end

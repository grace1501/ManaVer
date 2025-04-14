# == Schema Information
#
# Table name: folders
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Folder < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  
  has_many :versions, dependent: :destroy
  has_many :users, through: :versions, source: :user

  def versions_count
    versions.size
  end
  
end

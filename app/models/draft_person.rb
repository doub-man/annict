# == Schema Information
#
# Table name: draft_people
#
#  id               :integer          not null, primary key
#  person_id        :integer
#  prefecture_id    :integer
#  name             :string           not null
#  name_kana        :string
#  nickname         :string
#  gender           :string
#  url              :string
#  wikipedia_url    :string
#  twitter_username :string
#  birthday         :date
#  blood_type       :string
#  height           :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_draft_people_on_name           (name)
#  index_draft_people_on_person_id      (person_id)
#  index_draft_people_on_prefecture_id  (prefecture_id)
#

class DraftPerson < ActiveRecord::Base
  extend Enumerize
  include DraftCommon
  include PersonCommon

  belongs_to :origin, class_name: "Person", foreign_key: :person_id
end

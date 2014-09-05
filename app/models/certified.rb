class Certified < ActiveRecord::Base
	attr_accessor :event
	belongs_to :user

	validates :event_id, :name_color, :background_url, :presence => true

	store :events, accessors: [ :event_title, :event_start_at, :event_venue, :event_slug ]
	serialize :attendees, Hash
end

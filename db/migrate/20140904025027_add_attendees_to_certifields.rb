class AddAttendeesToCertifields < ActiveRecord::Migration
  def change
    add_column :certifieds, :attendees, :text
  end
end

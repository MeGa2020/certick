class AddEventsToCertifields < ActiveRecord::Migration
  def change
    add_column :certifieds, :events, :string
  end
end

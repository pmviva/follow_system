###
# CreateDummyFollowees class
#
# This class defines the create dummy followees migration in follow system
###
class CreateDummyFollowees < ActiveRecord::Migration
  ###
  # Changes the database
  ###
  def change
    ###
    # Dummy followees table creation
    ###
    create_table :dummy_followees do |t|
      ###
      # Timestamps fields definition
      ###
      t.timestamps null: false
    end
  end
end


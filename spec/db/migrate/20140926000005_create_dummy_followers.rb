###
# CreateDummyFollowers class
#
# This class defines the create dummy followers migration in follow system
###
class CreateDummyFollowers < ActiveRecord::Migration[5.0]
  ###
  # Changes the database
  ###
  def change
    ###
    # Dummy followers table creation
    ###
    create_table :dummy_followers do |t|
      ###
      # Timestamps fields definition
      ###
      t.timestamps null: false
    end
  end
end


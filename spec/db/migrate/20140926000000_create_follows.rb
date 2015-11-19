###
# CreateFollows class
#
# This class defines the test create follows migration in follow system
###
class CreateFollows < ActiveRecord::Migration
  ###
  # Changes the database
  ###
  def change
    ###
    # Follows table creation
    ###
    create_table :follows do |t|
      ###
      # Followee id field and followee type field definition
      ###
      t.references :followee, polymorphic: true

      ###
      # Follower id fiel and follower type field definition
      ###
      t.references :follower, polymorphic: true

      ###
      # Timestamps fields definition
      ###
      t.timestamps null: false
    end

    ###
    # Follows table followee id field and followee type field index addition
    ###
    add_index :follows, [:followee_id, :followee_type], name: "follows_followee_idx"

    ###
    # Follows table follower id field and follower type field index addition
    ###
    add_index :follows, [:follower_id, :follower_type], name: "follows_follower_idx"

    ###
    # Follows table followee id field and followee type field and follower id field and follower type field unique index addition
    ###
    add_index :follows, [:followee_id, :followee_type, :follower_id, :follower_type], name: "follows_followee_follower_idx", unique: true
  end
end


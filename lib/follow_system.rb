require 'follow_system/follow'
require 'follow_system/followee'
require 'follow_system/follower'

###
# FollowSystem module
#
# This module defines common behavior in follow system
###
module FollowSystem
  ###
  # Specifies if self can be followed by {Follower} objects
  #
  # @return [Boolean]
  ###
  def is_followee?
    false
  end

  ###
  # Specifies if self can follow {Followee} objects
  #
  # @return [Boolean]
  ###
  def is_follower?
    false
  end

  ###
  # Instructs self to act as followee
  ###
  def act_as_followee
    include Followee
  end

  ###
  # Instructs self to act as follower
  ###
  def act_as_follower
    include Follower
  end
end

ActiveRecord::Base.extend FollowSystem

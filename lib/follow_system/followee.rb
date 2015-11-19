###
# FollowSystem module
#
# This module defines common behavior in follow system
###
module FollowSystem
  ###
  # Followee module
  #
  # This module defines followee behavior in follow system
  ###
  module Followee
    ###
    # Extends ActiveSupport::Concern
    ###
    extend ActiveSupport::Concern

    ###
    # Included configuration
    ###
    included do
      ###
      # Has many followers association configuration
      ###
      has_many :followers, class_name: "FollowSystem::Follow", as: :followee, dependent: :destroy
    end

    ###
    # Specifies if self can be followed by {Follower} objects
    #
    # @return [Boolean]
    ###
    def is_followee?
      true
    end

    ###
    # Specifies if self is followed by a {Follower} object
    #
    # @param [Follower] follower - the {Follower} object to test against
    # @return [Boolean]
    ###
    def followed_by?(follower)
      Follow.follows?(follower, self)
    end

    ###
    # Retrieves a scope of {Follow} objects that follows self filtered {Follower} type
    #
    # @param [Class] klass - the {Class} to filter
    # @return [ActiveRecord::Relation]
    ###
    def followers_by(klass)
      Follow.scope_by_followee(self).scope_by_follower_type(klass)
    end
  end
end


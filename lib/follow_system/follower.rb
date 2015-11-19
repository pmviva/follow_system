###
# FollowSystem module
#
# This module defines common behavior in follow system
###
module FollowSystem
  ###
  # Follower module
  #
  # This module defines follower behavior in follow system
  ###
  module Follower
    ###
    # Extends ActiveSupport::Concern
    ###
    extend ActiveSupport::Concern

    ###
    # Included configuration
    ###
    included do
      ###
      # Has many followees association configuration
      ###
      has_many :followees, class_name: "FollowSystem::Follow", as: :follower, dependent: :destroy
    end

    ###
    # Specifies if self can follow {Followee} objects
    #
    # @return [Boolean]
    ###
    def is_follower?
      true
    end

    ###
    # Creates a {Follow} relationship between self and a {Followee} object
    #
    # @param [Followee] followee - the followee of the {Follow} relationship
    # @return [Boolean]
    ###
    def follow(followee)
      Follow.follow(self, followee)
    end

    ###
    # Destroys a {Follow} relationship between self and a {Followee} object
    #
    # @param [Followee] followee - the followee of the {Follow} relationship
    # @return [Boolean]
    ###
    def unfollow(followee)
      Follow.unfollow(self, followee)
    end

    ###
    # Toggles a {Follow} relationship between self and a {Followee} object
    #
    # @param [Followee] followee - the followee of the {Follow} relationship
    # @return [Boolean]
    ###
    def toggle_follow(followee)
      Follow.toggle_follow(self, followee)
    end

    ###
    # Specifies if self follows a {Follower} object
    #
    # @param [Followee] followee - the {Followee} object to test against
    # @return [Boolean]
    ###
    def follows?(followee)
      Follow.follows?(self, followee)
    end

    ###
    # Retrieves a scope of {Follow} objects that are followed by self
    #
    # @param [Class] klass - the {Class} to include
    # @return [ActiveRecord::Relation]
    ###
    def followees_by(klass)
      Follow.scope_by_follower(self).scope_by_followee_type(klass)
    end
  end
end


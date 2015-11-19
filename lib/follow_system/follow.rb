###
# FollowSystem module
#
# This module defines common behavior in follow system
###
module FollowSystem
  ###
  # Follow class
  #
  # This class defines the follow model in follow system
  ###
  class Follow < ActiveRecord::Base
    ###
    # Belongs to followee association configuration
    ###
    belongs_to :followee, polymorphic: :true

    ###
    # Belongs to follower association configuration
    ###
    belongs_to :follower, polymorphic: :true

    ###
    # Creates a {Follow} relationship between a {Follower} object and a {Followee} object
    #
    # @param [Follower] follower - the {Follower} of the relationship
    # @param [Followee] followee - the {Followee} of the relationship
    # @return [Boolean]
    ###
    def self.follow(follower, followee)
      validate_followee(followee)
      validate_follower(follower)

      if follows?(follower, followee)
        false
      else
        follow = scope_by_follower(follower).scope_by_followee(followee).build
        follow.save
        true
      end
    end

    ###
    # Destroys a {Follow} relationship between a {Follower} object and a {Followee} object
    #
    # @param [Follower] follower - the {Follower} of the relationship
    # @param [Followee] followee - the {Followee} of the relationship
    # @return [Boolean]
    ###
    def self.unfollow(follower, followee)
      validate_followee(followee)
      validate_follower(follower)

      if follows?(follower, followee)
        follow = scope_by_follower(follower).scope_by_followee(followee).take
        follow.destroy
        true
      else
        false
      end
    end

    ###
    # Toggles a {Follow} relationship between a {Follower} object and a {Followee} object
    #
    # @param [Follower] follower - the {Follower} of the relationship
    # @param [Followee] followee - the {Followee} of the relationship
    # @return [Boolean]
    ###
    def self.toggle_follow(follower, followee)
      validate_followee(followee)
      validate_follower(follower)

      if follows?(follower, followee)
        unfollow(follower, followee)
      else
        follow(follower, followee)
      end
    end

    ###
    # Specifies if a {Follower} object follows a {Followee} object
    #
    # @param [Follower] follower - the {Follower} object to test against
    # @param [Followee] followee - the {Followee} object to test against
    # @return [Boolean]
    ###
    def self.follows?(follower, followee)
      validate_followee(followee)
      validate_follower(follower)

      scope_by_follower(follower).scope_by_followee(followee).exists?
    end

    ###
    # Retrieves a scope of {Follow} objects filtered by a {Followee} object
    #
    # @param [Followee] followee - the {Followee} to filter
    # @return [ActiveRecord::Relation]
    ###
    def self.scope_by_followee(followee)
      where(followee: followee)
    end

    ###
    # Retrieves a scope of {Follow} objects filtered by a {Followee} type
    #
    # @param [Class] klass - the {Class} to filter
    # @return [ActiveRecord::Relation]
    ###
    def self.scope_by_followee_type(klass)
      where(followee_type: klass.to_s.classify)
    end

    ###
    # Retrieves a scope of {Follow} objects filtered by a {Follower} object
    #
    # @param [Follower] follower - the {Follower} to filter
    # @return [ActiveRecord::Relation]
    ###
    def self.scope_by_follower(follower)
      where(follower: follower)
    end

    ###
    # Retrieves a scope of {Follow} objects filtered by a {Follower} type
    #
    # @param [Class] klass - the {Class} to filter
    # @return [ActiveRecord::Relation]
    ###
    def self.scope_by_follower_type(klass)
      where(follower_type: klass.to_s.classify)
    end

    private
      ###
      # Validates a followee object
      #
      # @raise [ArgumentError] if the followee object is invalid
      ###
      def self.validate_followee(followee)
        raise ArgumentError.new unless followee.respond_to?(:is_followee?) && followee.is_followee?
      end

      ###
      # Validates a follower object
      #
      # @raise [ArgumentError] if the follower object is invalid
      ###
      def self.validate_follower(follower)
        raise ArgumentError.new unless follower.respond_to?(:is_follower?) && follower.is_follower?
      end
  end
end


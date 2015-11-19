require 'spec_helper'

###
# Describes FollowSystem::Follow
###
describe FollowSystem::Follow, type: :model do
  ###
  # Let followee be DummyFollowee.create
  ###
  let(:followee) { DummyFollowee.create }

  ###
  # Let follower be DummyFollower.create
  ###
  let(:follower) { DummyFollower.create }

  ###
  # Describes associations
  ###
  describe "associations" do
    ###
    # Should belong to followee
    ###
    it "should belong to followee" do
      should belong_to(:followee)
    end

    ###
    # Should belong to follower
    ###
    it "should belong to follower" do
      should belong_to(:follower)
    end
  end

  ###
  # Describes class methods
  ###
  describe "class methods" do
    ###
    # Should raise argument error on invalid followee when follows
    ###
    it "should raise argument error on invalid followee when follows" do
      expect { FollowSystem::Follow.follow(follower, follower) }.to raise_error ArgumentError
    end

    ###
    # Should raise argument error on invalid follower when follows
    ###
    it "should raise argument error on invalid follower when follows " do
      expect { FollowSystem::Follow.follow(followee, followee) }.to raise_error ArgumentError
    end

    ###
    # Should follow
    ###
    it "should follow" do
      expect(FollowSystem::Follow.follow(follower, followee)).to equal(true)
    end

    ###
    # Should not follow
    ###
    it "should not follow" do
      FollowSystem::Follow.follow(follower, followee)

      expect(FollowSystem::Follow.follow(follower, followee)).to equal(false)
    end

    ###
    # Should raise argument error on invalid followee when unfollows
    ###
    it "should raise argument error on invalid followee when unfollows" do
      expect { FollowSystem::Follow.unfollow(follower, follower) }.to raise_error ArgumentError
    end

    ###
    # Should raise argument error on invalid follower when unfollows
    ###
    it "should raise argument error on invalid follower when unfollows" do
      expect { FollowSystem::Follow.unfollow(followee, followee) }.to raise_error ArgumentError
    end

    ###
    # Should unfollow
    ###
    it "should unfollow" do
      FollowSystem::Follow.follow(follower, followee)

      expect(FollowSystem::Follow.unfollow(follower, followee)).to equal(true)
    end

    ###
    # Should not unfollow
    ###
    it "should not unfollow" do
      expect(FollowSystem::Follow.unfollow(follower, followee)).to equal(false)
    end

    ###
    # Should raise argument error on invalid followee when toggle follow
    ###
    it "should raise argument error on invalid followee when toggle follow" do
      expect { FollowSystem::Follow.toggle_follow(follower, follower) }.to raise_error ArgumentError
    end

    ###
    # Should raise argument error on invalid follower when toggle follow
    ###
    it "should raise argument error on invalid follower when toggle follow" do
      expect { FollowSystem::Follow.toggle_follow(followee, followee) }.to raise_error ArgumentError
    end

    ###
    # Should toggle follow
    ###
    it "should toggle follow" do
      expect(FollowSystem::Follow.follows?(follower, followee)).to equal(false)

      FollowSystem::Follow.toggle_follow(follower, followee)

      expect(FollowSystem::Follow.follows?(follower, followee)).to equal(true)

      FollowSystem::Follow.toggle_follow(follower, followee)

      expect(FollowSystem::Follow.follows?(follower, followee)).to equal(false)
    end

    ###
    # Should specify if follows
    ###
    it "should specify if follows" do
      expect(FollowSystem::Follow.follows?(follower, followee)).to equal(false)

      FollowSystem::Follow.follow(follower, followee)

      expect(FollowSystem::Follow.follows?(follower, followee)).to equal(true)
    end

    ###
    # Should scope follows by followee
    ###
    it "should scope follows by followee" do
      scope = FollowSystem::Follow.where(followee: followee)

      expect(FollowSystem::Follow.scope_by_followee(followee)).to eq(scope)
    end

    ###
    # Should scope follows by followee type
    ####
    it "should scope follows by followee type" do
      scope = FollowSystem::Follow.where(followee_type: DummyFollowee)

      expect(FollowSystem::Follow.scope_by_followee_type(DummyFollowee)).to eq(scope)
    end

    ###
    # Should scope follows by follower
    ###
    it "should scope follows by follower" do
      scope = FollowSystem::Follow.where(follower: follower)

      expect(FollowSystem::Follow.scope_by_follower(follower)).to eq(scope)
    end

    ###
    # Should scope follows by follower type
    ####
    it "should scope follows by follower type" do
      scope = FollowSystem::Follow.where(follower_type: DummyFollower)

      expect(FollowSystem::Follow.scope_by_follower_type(DummyFollower)).to eq(scope)
    end
  end
end


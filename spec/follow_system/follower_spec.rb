require 'spec_helper'

###
# Shared examples for FollowSystem::Follower
###
shared_examples_for FollowSystem::Follower do
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
    # Should have many followees
    ###
    it "should have many followees" do
      should have_many(:followees)
    end
  end

  ###
  # Describes class methods
  ###
  describe "class methods" do
    ###
    # Should be a follower
    ###
    it "should be a follower" do
      expect(follower.is_follower?).to equal(true)
    end

    ###
    # Should follow a followee
    ###
    it "Should follow a followee" do
      expect(FollowSystem::Follow).to receive(:follow).with(follower, followee) { true }

      expect(follower.follow(followee)).to equal(true)
    end

    ###
    # Should unfollow a followee
    ###
    it "Should unfollow a followee" do
      expect(FollowSystem::Follow).to receive(:unfollow).with(follower, followee) { true }

      expect(follower.unfollow(followee)).to equal(true)
    end

    ###
    # Should toggle follow a followee
    ###
    it "Should toggle follow a followee" do
      expect(FollowSystem::Follow).to receive(:toggle_follow).with(follower, followee) { true }

      expect(follower.toggle_follow(followee)).to equal(true)
    end

    ###
    # Should follow a followee
    ###
    it "should specify if follows a followee" do
      expect(FollowSystem::Follow).to receive(:follows?).with(follower, followee) { true }

      expect(follower.follows?(followee)).to equal(true)
    end

    ###
    # Should scope followees filtered by followee type
    ###
    it "should scope followees filtered by followee type" do
      scope = FollowSystem::Follow.scope_by_follower(follower).scope_by_followee_type(DummyFollowee)

      expect(follower.followees_by(DummyFollowee)).to eq(scope)      
    end
  end
end

###
# Describes DummyFollower
###
describe DummyFollower do
  ###
  # It behaves like FollowSystem::Follower
  ###
  it_behaves_like FollowSystem::Follower
end


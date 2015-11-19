require 'spec_helper'

###
# Shared examples for FollowSystem::Followee
###
shared_examples_for FollowSystem::Followee do
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
    # Should have many followers
    ###
    it "should have many followers" do
      should have_many(:followers)
    end
  end

  ###
  # Describes class methods
  ###
  describe "class methods" do
    ###
    # Should be a followee
    ###
    it "should be a followee" do
      expect(followee.is_followee?).to equal(true)
    end

    ###
    # Should be followed by a follower
    ###
    it "should specify if is followed by a follower" do
      expect(FollowSystem::Follow).to receive(:follows?).with(follower, followee) { true }

      expect(followee.followed_by?(follower)).to equal(true)
    end

    ###
    # Should scope followers filtered by follower type
    ###
    it "should scope followers filtered by follower type" do
      scope = FollowSystem::Follow.scope_by_followee(followee).scope_by_follower_type(DummyFollower)

      expect(followee.followers_by(DummyFollower)).to eq(scope)
    end
  end
end

###
# Describes DummyFollowee
###
describe DummyFollowee, type: :model do
  ###
  # It behaves like FollowSystem::Followee
  ###
  it_behaves_like FollowSystem::Followee
end


# FollowSystem

[![Build Status](https://travis-ci.org/pmviva/follow_system.png?branch=master)](https://travis-ci.org/pmviva/follow_system)
[![Gem Version](https://badge.fury.io/rb/follow_system.svg)](http://badge.fury.io/rb/follow_system)
[![Dependency Status](https://gemnasium.com/pmviva/follow_system.svg)](https://gemnasium.com/pmviva/follow_system)
[![Code Climate](https://codeclimate.com/github/pmviva/follow_system/badges/gpa.svg)](https://codeclimate.com/github/pmviva/follow_system)

An active record follow system developed using ruby on rails 5 applying domain driven design and test driven development principles.

For rails 4 support use branch v0.0.7-stable.

This gem is heavily influenced by cmer/socialization.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'follow_system'
```

And then execute:

```ruby
$ bundle
```

Or install it yourself as:

```ruby
$ gem install follow_system
```

## Usage

### Run the generator

```ruby
$ rails g follow_system
```

Let's suppose for a moment that you have a celebrity news application and a User can follow a Celebrity or several Celebrity models.
The user model becomes the follower and the celebrity model becomes the followee.

### Celebrity object
```ruby
class Celebrity < ActiveRecord::Base
  act_as_followee

  validates :name, { presence: true, uniqueness: true }
end
```

### User object
```ruby
class User < ActiveRecord::Base
  act_as_follower

  validates :username, { presence: true, uniqueness: true }
end
```

### Followee object methods
```ruby
celebrity.is_followee? # returns true

celebrity.followed_by?(user) # returns true if user follows the celebrity object, false otherwise

celebrity.followers_by(User) # returns a scope of FollowSystem::Follow join model that belongs to the celebrity object and belongs to follower objects of type User
```


### Follower object methods
```ruby
user.is_follower? # returns true

user.follow(celebrity) # Creates an instance of FollowSystem::Follow join model associating the user object and the celebrity object, returns true if succeded, false otherwise

user.unfollow(celebrity) # Destroys an instance of FollowSystem::Follow join model that associates the user object and the celebrity object, returns true if succeded, false otherwise

user.toggle_follow(celebrity) # Follows / unfollows the celebrity

user.follows?(celebrity) # returns true if the user object follows the celebrity object, false otherwise

user.followees_by(Celebrity) # returns a scope of FollowSystem::Follow join model that belongs to the user object and belongs to followee objects of type Celebrity
```

For more information read the [api documentation](http://rubydoc.info/gems/follow_system).

## Contributing

1. Fork it ( https://github.com/pmviva/follow_system/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request


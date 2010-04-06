# FaceB

FaceB is a Facebook Library which aims to be more modular than Facebooker. You can use it only for the Facebook API client or if you use Rails you can have a lot of stuff helping you to develop your Facebook application (controller, helper methods).

## Installation

    $ [sudo] gem install faceb

## Getting started

### Facebook API client

FaceB is modular so you can use it just as a tool for interact with Facebook API.
You are free to use this syntax :

    require 'faceb'
    FaceB.call('api-key', 'secret-key', 'method.name', :param1 => 'value1')

Or if you call more than once API methods, you can create a persistent session like that :

    require 'faceb'
    FaceB.new('api-key', 'secret-key')
    FaceB.session.call('users.getInfo', :fields => 'name', :uids => 123456)
    FaceB.session.call('users.getInfo', :fields => 'name', :uids => 123456)

Or you can even call API method dynamically :

    require 'faceb'
    FaceB.new('api-key', 'secret-key')
    FaceB.session.users.getInfo(:fields => 'name', :uids => 123456)


### Rails integration

#### Rails 3 initialization

First thing to do is to add FaceB as dependency of your new project, add this line at the end of your `Gemfile` file : 

    gem 'faceb'

Then call the initialization script like this :

    $ ./script/rails generate face_b:config --api-key=xxxx --secret-key=xxxx

This generator will create a new file named `faceb.yml` in your `config` directory.
Edit this new file with your Facebook application properties.


#### Rails 2.3.x initialization

In your `config/environment.rb` add this line : 

    Rails::Initializer.run do |config|
      [...]
      config.gem 'faceb'
      [...]
    end

And run the following rake task :

    rake face_b:config API_KEY=xxxx SECRET_KEY=xxxx



## TODO

- Add mutli Facebook application settings (alternative api key)
- Add view helpers
- Add Facebook connect helpers
- Add Rails 2.3.x compatibility

## Contributors

- Mathieu Fosse

## Note on Patches/Pull Requests
 
* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

## Copyright

Copyright (c) 2010 Mathieu Fosse. See LICENSE for details.

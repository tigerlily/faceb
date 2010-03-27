FaceB
=====

FaceB is a Facebook client Library aim to be more modular than Facebooker. You can use it only for the Facebook API client or if you use Rails you can have a lot of stuff helping you to develop your Facebook application.


Why use FaceB instead of Facebooker ?
-------------------------------------

Firstable, FaceB is inspired by Facebooker and MiniFB. The goal of FaceB is to have the best of both of world. The ease to call the API without any configuration file (MiniFB) and the Rails integration (Facebooker).

Besides, unlike Facebooker, FaceB try to keep his complete documentation up to date.

So to resume FaceB is :

- Rails 3 compliant
- Modular
- well documented
- well tested
- easy to test


Installation using RubyGems
---------------------------

    $ [sudo] gem install faceb


Installation from source
--------------------------

    $ git clone git://github.com/tigerlily/faceb.git
    $ bundle install


Getting started
---------------

FaceB is modular so you can use it just as a tool for interact with Facebook API.
You are free to use this syntax :

    FaceB.call('api-key', 'secret-key', 'method.name', :param1 => 'value1')

Or if you call more than once API methods, you can create a persistent session like that :

    FaceB.new('api-key', 'secret-key')
    FaceB.current_session.call('method.name1', :param1 => 'value1')
    FaceB.current_session.call('method.name2', :param1 => 'value1')

TODO
----

- Add Rails 2.3.x compatibility
- Add mutli Facebook application settings



Note on Patches/Pull Requests
-----------------------------
 
* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

Copyright
---------

Copyright (c) 2010 Mathieu Fosse. See LICENSE for details.

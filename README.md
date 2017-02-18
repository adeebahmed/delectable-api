# Delectable API

[Ruby/Rails Setup on Ubuntu 10.04](http://ascarter.net/2010/05/10/rails-development-on-ubuntu-10.04.html)

##Install ruby stack

    $ sudo apt-get install irb libopenssl-ruby libreadline-ruby rdoc ri ruby ruby-dev

####Verify ruby version

    $ ruby -v

####Install ruby gems (use latest version possible)
    $ sudo apt-get install rubygems
if that doesn't work try:

    $ cd /usr/local/src
    $ wget http://production.cf.rubygems.org/rubygems/rubygems-1.3.6.tgz
    $ tar xzvf rubygems-1.3.6.tgz
    $ cd rubygems-1.3.6
    $ sudo ruby setup.rb

#Install Postgres

    $ sudo apt-get install postgresql postgresql-client postgresql-doc pgadmin3
    $ sudo gem install pg
    
 ####Start postgres server
    $ pg_ctl -D [path to postgres install] -l logfile start  #/Users/adeeb/usr/local/var/postgres
 
 ####Stop postgres server
    $ pg_ctl -D [path to postgres install]] stop -s -m fast #/Users/adeeb/usr/local/var/postgres

## Download and deploy the API
    $ git clone https://github.com/adeebahmed/delectable-api.git
    $ cd delectable-api
    $ bundle install    # install rails, devise, and other dependencies
    \n
    $ rails db:create    #creates database
    $ rails db:migrate   #migrates schema
    \n
    $ rails server      # deploys api
  

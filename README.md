# doctor\_rails

[![Build Status](https://api.travis-ci.org/fernandomm/doctor_rails.png?branch=master)][travis]
[travis]: http://travis-ci.org/fernandomm/doctor_rails

Doctor Rails is an incredibe gem that helps you to monitor your Rails application. It allows you monitor several parts of your Rails application. The results of your checks can be collected in a simple html or json/xml formats.

## Installation

Simply add this to your Gemfile:

    gem 'doctor_rails'

Them run:

    bundle install

And start your server.

## Creating your checks

Creating your checks is very simple. Add a new controller your application. We will call it ChecksController in this example. So in app/controllers/checks_controller.rb you would have:

	class ChecksController < DoctorRails::ChecksController

	end

And in config/routes.rb:

    match 'checks' => 'checks#index'

Now, create your checks. Any method that starts with check_ will be run:

	class ChecksController < DoctorRails::ChecksController
	  protected
	    def check_always_work
	      # Do something here
	      true
	    end
	end

Optionally, you may want to add a description to this check:

	class ChecksController < DoctorRails::ChecksController
	  protected
	    def check_always_work
	      # Do something here
	      true
	    end

	    def check_always_work_description
	      "Always work :)"
	    end
	end

If you access http://localhost:3000/checks.json you will get the following json:

	{
	   "check_always_work":{
	      "result":true,
	      "description":"Always work :)"
	   }
	}

Instead of getting a per-check result. You can get a boolean result by appeding a flag to the url http://localhost:3000/checks.json?boolean_result=true.

In this case, the result will be true or false. True if all checks worked or false if any of the checks failed.


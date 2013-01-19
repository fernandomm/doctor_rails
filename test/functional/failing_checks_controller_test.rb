require 'test_helper'

class FailingChecksControllerTest < ActionController::TestCase

  test 'index json should contain a failure when a check fails' do
    get 'index', :format => :json

    json = JSON.parse(response.body)

    assert !json['check_always_fail']['result']
    assert_equal json['check_always_fail']['description'], "Sorry, but i always fail :("
  end

  test 'index should return only false on failure when boolean_result is set' do
    get 'index', :format => :json, :boolean_result => true
    
    assert_equal 'false', response.body
  end
end

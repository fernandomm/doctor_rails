require 'test_helper'

class WorkingChecksControllerTest < ActionController::TestCase

  test 'index json should not contain a failure when all checks passes' do
    get 'index', :format => :json

    json = JSON.parse(response.body)
    
    assert json['check_always_work']['result']
    assert_equal json['check_always_work']['description'], "Always work :)"
  end

  test 'index should return only true on success when boolean_result is set' do
    get 'index', :format => :json, :boolean_result => true
    
    assert_equal 'true', response.body
  end
end

require 'rest-client'
require 'test-unit'

def create_environment(environ_name)
  @project.set_env_name(environ_name)
      environment_payload = {:name =>@project.env_name}.to_json
      response = post('https://www.apimation.com/environments',
                      headers: {'Content-Type' => 'application/json'},
                      cookies: @test_user.session_cookie,
                      payload: environment_payload)

  #Check if 200 OK is received
  assert_equal(200, response.code,"Creating environment failed! Response: #{response}")
  response_hash = JSON.parse(response)
  #Assigning id environment to array
  @project.set_environment_id(response_hash['id'])
  #Check if name of environment is returned correctly
  assert_equal(@project.env_name, response_hash['name'], 'Response returns: Name is incorrect!')
  #Check if id of environment is returned correctly
  assert_equal(@project.environment_id, response_hash['id'], 'Response returns: Project id in response is incorrect')
end

def check_environment
  response = get('https://www.apimation.com/environments/'+@project.environment_id,
                 headers: {},
                 cookies: @test_user.session_cookie)

  #Check if 200 is OK
  assert_equal(200, response.code, "Failed to receive data! Response : #{response}")
  environment_response_hash = JSON.parse(response)
  #Check if provided environment name is correct
  assert_equal(@project.env_name, environment_response_hash['name'], "Returned environment name is incorrect! Response: #{response}")
  #Check if returned environment id is correct
  assert_equal(@project.environment_id, environment_response_hash['id'], "Returned environment ID is not correct! Response: #{response}")
end


def create_global_variable(name,value)
    @project.set_glob_var({'key'=>'$'+name,'value'=>value})
    glob_var_payload = {:global_vars =>@project.global_variables}.to_json
    response = put('https://www.apimation.com/environments/'+@project.environment_id,
                   headers: {'Content-Type'=>'application/json'},
                   cookies: @test_user.session_cookie,
                   payload: glob_var_payload)

    #Check if 204 No Content is received
    assert_equal(204, response.code,"Assigning global variables was unsuccessful! Response: #{response}")
end
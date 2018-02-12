def create_collection(name)
  collection_payload={:description=>'',:name =>name}.to_json
  response=post('https://www.apimation.com/collections',
                headers: {'Content-Type'=>'application/json'},
                cookies: @test_user.session_cookie,
                payload: collection_payload)
  #Check if 200 OK is received
  assert_equal(200, response.code,"Creating collection failed! Response: #{response}")
  response_hash=JSON.parse(response)
  #Assigning id to collection array
  @project.set_collection_id(response_hash['id'])
  #Check if correct name is sent
  assert_equal(name.to_s,response_hash['name'],"Creating collection failed! Response: #{response}")
  #check if collection id is as expected
  assert_equal(@project.collection_id,response_hash['id'],"Creating collection failed! Response: #{response}")
  @collection_array << (response_hash)

end



def check_collection
  response = get('https://www.apimation.com/collection/'+@project.id,
                 headers: {},
                 cookies: @test_user.session_cookie)
  #Check if 200 is OK
  assert_equal(200, response.code, "Failed to receive data! Response : #{response}")
  collection_response_hash = JSON.parse(response)
  #Check if provided name is correct
  assert_equal(@project.env_name, collection_response_hash['step_name'], 'The email in response is not correct!')
  #Check if provided id is correct
  assert_equal(@project.collection_id, collection_response_hash['step_id'], 'The ID in response is not correct!')

end

def create_login_request
  request_name='Login request'
  request_payload={collection_id: @project << ['id'],
                 :description=>'',
                 :name=>request_name,
                 :paste=>false,
                 :request=>{:method=>'POST',
                            :url=>'https://www.apimation.com/login',
                            :type=>'raw',:body=>{},
                 },
                 :auth=>{:type=>'basicAuth',:data=>{:Username=>@test_user.email,:password=>@test_user.password}}}.to_json
  response=post('https://www.apimation.com/steps',
                headers: {'Content-Type'=>'application/json'},
                cookies: @test_user.session_cookie,
                payload: request_payload)
  #Check if 200 OK is received
  assert_equal(200, response.code,"Creating request failed! Response: #{response}")
  response_hash=JSON.parse(response)


  @project.set_testcase_id(response_hash['id'])

  #assert_equal(@project['id'], response_hash['id'], 'Project id in the response is incorrect')

  #@collection_array.insert_collection_id(response_hash['id'])
  #assert_not_equal(nil, response_hash['id'], 'Project id is empty!')
  # Check if correct collection
  assert_equal(@project.testcase_id,response_hash['collection_id'],"Incorrect collection  returned! Response: #{response}")
  # Check if correct request name
  assert_equal(request_name,response_hash['name'],"Incorrect request name returned! Response: #{response}")
  #Check if correct url is returned
  # assert_equal(@collection_array['url'],'https://www.apimation.com/login',"Incorrect URL returned! Response: #{response}")
  puts @project
end

def create_project_request
  request_name='set_project'
  steps_payload='{"name":"'+request_name+'","description":"","request":{"method":"PUT","url":"https://www.apimation.com/projects/active/'+@project.project_id+'","type":"raw","body":"","binaryContent":{"value":"","filename":""},"urlEncParams":[{"name":"","value":""}],"formData":[{"type":"text","value":"","name":"","filename":""}],"headers":[{"name":"Content-Type","value":"application/json"}],"greps":[],"auth":{"type":"noAuth","data":{}}},"paste":false,"collection_id":"'+@project.collections.detect{|e| e.name=='Projects'}.id+'"}'
  response=post('https://www.apimation.com/steps',
                headers: {'Content-Type'=>'application/json'},
                cookies: @test_user.session_cookie,
                payload: steps_payload)
  #Check if 200 OK is received
  assert_equal(200, response.code,"Creating request failed! Response: #{response}")
  response_hash=JSON.parse(response)
  # Check if correct collection
  assert_equal(@project.collections.detect{|e| e.name=='Projects'}.id,response_hash['collection_id'],"Incorrect collection  returned! Response: #{response}")
  # Check if correct request name
  assert_equal(request_name,response_hash['name'],"Incorrect request name returned! Response: #{response}")
  #Check if correct url is returned
  assert_equal('https://www.apimation.com/projects/active/'+@project.project_id,response_hash['request']['url'],"Incorrect URL returned! Responce: #{response}")
  # Add request to project requests array
  @project.set_request(response_hash)
end
def create_login_request
  @project.collections = []
  request_name='Login request'
  request_payload={collection_id: @project.collections << ['id'],
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
  #Check if returned id is correct
  assert_equal(@project.collections,response_hash['collection_id'],"Incorrect collection  returned! Response: #{response}")
  #Check if correct request name
  assert_equal(request_name,response_hash['name'],"Incorrect request name returned! Response: #{response}")
end
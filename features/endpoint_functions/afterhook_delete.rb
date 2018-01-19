#Check if 204 OK is received
def delete_hook(name_1, id2)
  delete_response = delete('https://www.apimation.com/'<< name_1 << '/' << id2,
                            headers: {'Content-Type' => 'application/json'},
                            cookies: @test_user.session_cookie)
  assert_equal(204, delete_response.code, "Failed to delete items! Response: #{delete_response}")
end




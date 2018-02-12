Before() do
  puts "Before hook. This will work before every test case!"
  @test_user = User.new( '','babauskis2@gmail.com', 'parole123')
  @project = Project.new()
  @project_array = []
  @collection_array = []
end

After() do
  puts "After hook. This happens after every test case!"
  delete_hook('environments', @project.environment_id)
  delete_hook('cases', @project.testcase_id)
  for collections in @project.collection_id
    delete_hook('collections', collections)
  end
end

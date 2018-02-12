
class Project
  attr_accessor :env_name

  attr_accessor :type

  attr_accessor :id

  attr_accessor :environment_id

  attr_accessor :collection_id

  attr_accessor :testcase_id

  attr_accessor :project_id

  attr_accessor :global_variables

  def initialize()
    @env_name = ""
    @type = 'basic'
    @project_id = ""
    @environment_id = ""
    @collection_id = [1]
    @global_variables = [2]
  end

  def project_id(id)
    @project_id = id
  end

  def set_env_name(env_name)
    @env_name = env_name
  end

  def set_collection_id(collection_id)
    @collection_id = collection_id
  end

  def set_environment_id(environment_id)
    @environment_id = environment_id
  end

  def set_testcase_id(testcase_id)
    @testcase_id = testcase_id
  end

  def set_glob_var(value)
    @glob_var = [value]
  end

end
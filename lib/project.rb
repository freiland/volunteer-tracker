class Project 
  attr_accessor :title 
  attr_reader :id

  def initialize(attributes)
    @title = attributes.fetch(:title)
    @id = attributes.fetch(:id)
  end

  def title
    return @title 
  end

  def id 
    return @id
  end

  def save
    result = DB.exec("INSERT INTO projects (title) VALUES ('#{@title}') RETURNING id;")
    @id = result.first().fetch("id").to_i
  end

  def ==(other_project)
    self.title == other_project.title 
  end 

  def self.all
    returned_projects = DB.exec('SELECT * FROM projects;')
    projects=[]
    returned_projects.each() do |project|
      title = project.fetch("title")
      id = project.fetch("id").to_i
      projects.push(Project.new({:title => title, :id => id}))
    end
    projects
  end 

end
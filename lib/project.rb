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

  def self.find(id)
    project = DB.exec("SELECT * FROM projects WHERE id = #{id};").first()
    title = project.fetch('title')
    id = project.fetch('id').to_i
    Project.new({:title => title, :id => id})
  end

  def update(attributes)
    if (attributes.has_key?(:title)) && (attributes.fetch(:title) != nil)
      @title = attributes.fetch(:title)
      DB.exec("UPDATE projects SET title = '#{@title}' WHERE id = #{@id};")
    # elsif (attributes.has_key?(:city_name)) && (attributes.fetch(:city_name) != nil)
    #   # binding.pry
    #   city_name = attributes.fetch(:city_name)
      
    #   # time = attributes.fetch(:time)
    #   city = DB.exec("SELECT * FROM cities WHERE lower(name) = '#{city_name.downcase}';").first
    #   if city != nil
    #     DB.exec("INSERT INTO train_city (city_id, train_id) VALUES (#{city['id'].to_i}, #{@id});")
    #   end
    end
  end
  
  

end
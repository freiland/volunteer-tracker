class Volunteer 
  attr_reader :id
  attr_accessor :name, :project_id

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @project_id = attributes.fetch(:project_id)
    @id = attributes.fetch(:id)
  end

  def name 
    return @name 
  end 

  def project_id 
    return @project_id
  end 

  def ==(other_volunteer)
    self.name() == other_volunteer.name()
  end
end 
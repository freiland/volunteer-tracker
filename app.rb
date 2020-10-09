require('sinatra')
require('sinatra/reloader')
require('./lib/project')
require('./lib/volunteer')
require('pry')
require('pg')
also_reload('lib/**/*.rb')

DB = PG.connect({:dbname => "volunteer_tracker"})

get ('/') do 
  @projects = Project.all
  erb :projects
end

post ('/') do 
  title = params[:project_title]
  project = Project.new({:title => title, :id => nil})
  project.save
  redirect to ('/')
end

get ('/projects/:id') do
  'on project view can rename and delete project '
  @project = Project.find(params[:id].to_i)
  erb :project
end

patch ('/projects/:id') do 
  @project = Project.find(params[:id].to_i)
  title = params[:title]
  @project.update({:title => title})
  redirect to ('/')
end

delete ('/projects/:id') do 
  @project = Project.find(params[:id].to_i)
  @project.delete
  redirect to('/')
end

post ('/projects/:id') do 
  @project = Project.find(params[:id].to_i())
  volunteer = Volunteer.new({:name => params[:volunteer_name], :project_id => @project.id, :id => nil})
  volunteer.save()
  erb :project
end

get ('/projects/:project_id/:id') do
  @volunteer = Volunteer.find(params[:id].to_i())
  @project = Project.find(params[:project_id].to_i())
  erb :volunteer
  
end

patch ('/projects/:project_id/:id') do 
  @project = Project.find(params[:project_id].to_i())
  volunteer = Volunteer.find(params[:id].to_i())
  name = params[:name]
  volunteer.update({:name => name, :project_id => @project.id, :id => @id})
  redirect to ('/projects/:project_id')
end

delete ('/projects/:project_id/:id') do 
  volunteer = Volunteer.find(params[:id].to_i())
  volunteer.delete
  @project = Project.find(params[:project_id].to_i())
  redirect to ('/projects/:project_id')
end

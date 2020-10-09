require('sinatra')
require('sinatra/reloader')
require('./lib/project')
require('./lib/volunteer')
require('pry')
require('pg')
also_reload('lib/**/*.rb')

DB = PG.connect({:dbname => "volunteer_tracker"})

get ('/') do 
  #'homepage will list all projects, from here you can click each project to edit'
  @projects = Project.all
  erb :projects
end

post ('/') do 
  title = params[:project_title]
  project = Project.new({:title => title, :id => nil})
  project.save
  erb :projects
end

get ('/projects/:id') do
  'on project view can rename and delete project '
  @project = Project.find(params[:id].to_i)
  erb :project
end
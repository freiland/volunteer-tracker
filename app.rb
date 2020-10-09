require('sinatra')
require('sinatra/reloader')
require('./lib/project')
require('./lib/volunteer')
require('pry')
require('pg')
also_reload('lib/**/*.rb')

DB = PG.connect({:dbname => "volunteer_tracker"})

get ('/') do 
  'homepage will list all projects, from here you can click each project to edit'
  @projects = Project.all
  erb :projects
end
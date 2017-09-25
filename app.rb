require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("./lib/volunteer")
require("./lib/project")
require("pg")

DB = PG.connect({:dbname => "volunteer_tracker"})

get('/') do
  @projects = Project.all()
  erb(:index)
end

get('/projects/') do

  @projects = Project.find(params.fetch("id").to_i())
  project = Project.new({:title => title, :id => nil})
  erb(:project)
end


post('/projects') do
  title = params.fetch("title")
  project = Project.new({:title => title, :id => nil})
  project.save()
  @projects = Project.all()
  erb(:index)
end

# this is to update the project
get("/projects/:id/edit") do
  @projects = Project.find(params.fetch("id").to_i())
  erb(:project_edit)
end

patch("/projects/:id") do
  title = params.fetch("title")
  @projects = Project.find(params.fetch("id").to_i())
  @projects.update({:title => title})
  erb(:project)
end

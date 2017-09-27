require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("./lib/volunteer")
require("./lib/project")
require("pg")

DB = PG.connect({:dbname => "volunteer_tracker"})

  # ** Routes **

  # - READ ALL: index -
  # - Form for CREATING: new
get('/') do
  @projects = Project.all()
  erb(:index)
end

#  ** -CREATE NEW PROJECT: create**
post('/projects/new') do
  title = params.fetch("title")
  project = Project.new({:id => nil, :title => title})
  project.save()
  @projects = Project.all()
  erb(:index)
end

# -** READ INDIVIDIAL PROJECT: update
get("/projects/new:id") do
  @project = Project.find(params.fetch("id").to_i())
  @project_id = params.fetch("id")
  erb(:project_show)
end





get("/projects/:id/edit") do
  @projects = Project.find(params.fetch("id").to_i())
  erb(:project_edit)
end

# - Form for UPDATING: edit
get("/projects/:id/edit") do
  project = Project.new({:title => title, :id => nil})
  project.save()
  erb(:project_edit)
end
  #  ** -UPDATE PROJECT: update **
patch("/projects/:id") do
  title = params.fetch("title")
  project = Project.new({:title => title, :id => nil})
  project.save()
  @projects = Project.all()
  erb(:index)
end

patch("/projects/:id") do
  title = params.fetch("title")
  @projects = Project.find(params.fetch("id").to_i())
  @projects.update({:title => title})
  erb(:project)
end





# --** DESTROY PROJECT: destroy--

delete('/projects/:id') do
end

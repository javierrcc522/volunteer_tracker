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

# this is so i can click in the link and take me to project_edit
get("/projects/:id") do
  @projects = Project.find(params["id"].to_i())
  erb(:project_edit)
end

#  ** -make more PROJECT:**
post('/projects/new') do
  title = params.fetch("title")
  project = Project.new({:id => nil, :title => title})
  project.save()
  @projects = Project.all()
  erb(:index)
end

# - Form for UPDATING: projects
get("/projects/:id/edit") do
  @projects = Project.find(params.fetch("id").to_i())
  erb(:projects)
end

  #  ** -UPDATE PROJECT: update **
patch("/projects/:id/edit") do
  projects = Project.find(params[:id])
  title = params.fetch("title")
  projects.update({:title => title})
  redirect("/projects/#{params[:id]}/edit")
end

# --** DESTROY PROJECT: destroy--
delete('/projects/:id/edit') do
  @projects = Project.find(params[:id])
  @projects.delete
  redirect('/')
end

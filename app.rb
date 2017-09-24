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


post('/projects') do
  title = params.fetch("title")
  project = Project.new({:title => title, :id => nil})
  project.save()
  @projects = Project.all()
  erb(:index)
end

get("/projects/:id") do
  @projects = Project.find(params.fetch("id").to_i())
  erb(:project)
end

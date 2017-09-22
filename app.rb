require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("./lib/volunteer")
require("./lib/project")
require("pg")

DB = PG.connect({:dbname => "volunteer_tracker"})

get('/') do
  erb(:index)
end

post('/') do
  volunteer = Volunteer.new({:name => params["name"], :project_id => params[1], :id => nil})
  volunteer.save
  erb(:index)#this reloads webpage
end

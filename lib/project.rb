class Project
  attr_reader(:title, :id)

  def initialize(attributes)
    @title = attributes.fetch(:title)
    @id = attributes.fetch(:id)
  end

  def self.all
    returned_projects = DB.exec("SELECT * FROM projects;")
    projects = []
    returned_projects.each() do |project|
      title = project.fetch("title")
      id = project.fetch("id").to_i()
      projects.push(Project.new({:title => title, :id => id}))
    end
    projects
  end

  def volunteers
    all_volunteers = []
    volunteers = DB.exec("SELECT * FROM volunteers WHERE project_id = #{self.id};")
    volunteers.each() do |volunteer|
      id = volunteer.fetch("id").to_i()
      name = volunteer.fetch("name")
      project_id = volunteer.fetch("project_id").to_i()
      all_volunteers.push(Volunteer.new({:id => id, :name => name, :project_id => project_id}))
    end
    all_volunteers
  end

  def update(attributes)
    @title = attributes.fetch(:title, @title)
    @id = self.id
    DB.exec("UPDATE projects SET title = '#{@title}' WHERE id = #{@id};")
  end

  def self.find(id)
    project = DB.exec("SELECT * FROM projects WHERE id = #{id};")
    title = project.first().fetch("title")
    Project.new({:title => title, :id => id})
  end

  def save
    project = DB.exec("INSERT INTO projects (title) VALUES ('#{@title}') RETURNING id;")
    @id = project.first().fetch("id").to_i()
  end

  def ==(another_project)
    self.title().==(another_project.title()).&(self.id().==(another_project.id()))
  end



  def delete
    DB.exec("DELETE FROM projects WHERE id = #{self.id()};")
  end






end

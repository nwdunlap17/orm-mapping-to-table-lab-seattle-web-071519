class Student
  attr_accessor :name, :grade
  attr_reader :id
  def initialize(name,grade)
    @name = name
    @grade = grade
    @id = nil

  end

  def self.create(args)
    student = Student.new(args[:name],args[:grade])
    student.save
    return student
  end

  def save
    sql = <<-SQL
      INSERT INTO students (name,grade) VALUES (?,?);
    SQL
    DB[:conn].execute(sql,@name,@grade)
    foo = DB[:conn].execute("SELECT id FROM students ORDER BY id DESC LIMIT 1")
    @id = foo[0][0]
  end

  def self.create_table
    sql = <<-SQL
    CREATE TABLE IF NOT EXISTS students (
      id INTEGER PRIMARY KEY,
      name TEXT,
      grade int
    );
    SQL
    DB[:conn].execute(sql)
end
def self.drop_table
    sql = <<-SQL
    DROP TABLE students;
    SQL
    DB[:conn].execute(sql)
end
  
end
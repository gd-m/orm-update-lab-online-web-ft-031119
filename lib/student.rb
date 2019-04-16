require_relative "../config/environment.rb"

class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]
  attr_accessor :name, :grade, :id

  def initialize(name, grade, id = nil)
    @name = name
    @grade = grade
    @id = id
  end

  def self.create_table
    sql = <<-SQL
    CREATE TABLE IF NOT EXISTS students (
      id INTEGER PRIMARY KEY,
      name TEXT,
      grade INTEGER
    )
    SQL

    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = <<-SQL
    DROP TABLE students
    SQL

    DB[:conn].execute(sql)
  end

  def save
    if self.id
      self.update
    else
      sql = <<-SQL
      INSERT INTO students(name,grade)
      VALUES (?,?)
      SQL

      DB[:conn].execute(sql, self.name, self.grade)
      @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
    end
  end

  def self.create(name ,grade)
    student = Student.new(name, grade)
    student.save
    student
  end

  def self.new_from_db(row)
    new_student = self.new(row[1], row[2], row[0])

    new_student
  end

  def self.find_by_name(name)
<<<<<<< HEAD
    sql = "SELECT * FROM students WHERE name = ? LIMIT 1"
    DB[:conn].execute(sql, name).map do |row|
      self.new_from_db(row)
    end.first
  end

  def update
    sql = <<-SQL
    UPDATE students
    SET name = ?, grade = ?
    WHERE id = ?
    SQL

    DB[:conn].execute(sql, self.name, self.grade, self.id)
=======
    sql = "SELECT * FROM students WHERE name = ?"
    result = DB[:conn].execute(sql, name)
    found_name = Student.new(result[1],result[2],result[0])
>>>>>>> 84f45ebcc60f5676d60557028a49be503f34fed6

  end


end

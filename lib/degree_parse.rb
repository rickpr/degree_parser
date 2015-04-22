require "degree_parse/version"
require 'yaml'
require 'erb'

module DegreeParse
  
  class Student
  
    attr_reader :courses, :satisfied
  
    def initialize(courses, requirements)
      @requirements  = Requirements.new(requirements)
      @courses = courses.map { |name, attr| Course.new(name, hours: @requirements.get_hours(name), grade: attr["grade"]) }
    end
  
    def check
      @satisfied ||= @requirements.check @courses
    end
  
  end
  
  class Requirements
  
    attr_reader :requirements
  
    def initialize(filename)
      @requirements = YAML.load(import filename).merge YAML.load(import "courses.yml")
    end
    
    def import *files
      files.map{ |file| { File.basename(file, File.extname(file)) => YAML.load(ERB.new(File.read file).result(binding)) } }.reduce(:concat).to_yaml
    end
  
    def check(taken, requirements = @requirements, name = "main", checked = [])
      requirements.each do |key, value|
        if key == "courses"
          courses = value.map { |name, attr| Course.new(name, hours: get_hours(name), grade: attr["grade"]) }
          checked << { name => match(taken, courses, hours: requirements["hours"], take: requirements["take"]) }
        else
          check(taken, requirements[key], key, checked) unless key == "hours" || key == "take"
        end
      end
      checked
    end
  
    def match(taken, required, hours: nil, take: required.length)
      take ||= required.length
      courses_in_scope = taken.select { |course| required.map(&:name).include? course.name }
      passed = courses_in_scope.select { |course| required.find{ |r| r.name == course.name}.check(course.grade) }
      taken_hours = passed.map(&method(:get_hours)).reduce :+
      taken_hours.to_i >= hours.to_i && (passed.map(&:name) & required.map(&:name)).length >= take
    end
  
    def get_hours(course)
      name = course.is_a?(Course) ? course.name : course
      @requirements["courses"][name]["hours"].to_i
    end
  
  end
  
  class Course
  
    attr_reader :name, :hours, :grade
  
    @@grades = ["I","F","W","D-","D","D+","C-","C","C+","B-","B","B+","A-","A","A+"]
  
    def initialize(name, hours: nil, grade: "C")
      @name  = name
      @hours = hours
      @grade = grade || "C"
    end
  
    def check(grade)
      @@grades.index(grade).to_i >= @@grades.index(@grade).to_i
    end
  
  end
  
end

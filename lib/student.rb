class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  def initialize(student_hash)
    @name = student_hash[:name]
    @location = student_hash[:location]
    @@all << self

  end

  def self.create_from_collection(students_array)
    students_array.each do |student|
      student = self.new(student)
    end
  end

  def add_student_attributes(attributes_hash)
    #This metaprogramming is to add the social media/blog links
    attributes_hash.each do |key, value|
      self.class.attr_accessor(key)
      self.send(("#{key}="), value)
    end
  end

  def self.all
    @@all
  end
end


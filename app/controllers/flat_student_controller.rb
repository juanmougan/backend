class FlatStudentController < ApplicationController
  def index
    @flat_students = FlatStudent.all
  end
end

json.array!(@students) do |student|
  # json.extract! student, :id
  json.id student.id
  json.first_name student.first_name
  json.last_name student.last_name
  json.file_number student.file_number
  json.regid student.regid
  #json.url student_url(student, format: :json)
end

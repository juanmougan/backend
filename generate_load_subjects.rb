def create_subject_from_file_line(line)
	array = line.split('	')
	puts "Subject.create(:code => #{array[0]}, :name => '#{array[1].strip!}')"
end

text = File.open('subjects.txt').read
text.gsub!(/\r\n?/, "\n")
text.each_line do |line|
  create_subject_from_file_line(line)
end

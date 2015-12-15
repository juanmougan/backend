if ARGV.size == 0 
	raise RuntimeError, "File name needed"
end
file_name = ARGV.shift
text=File.open(file_name).read
text.gsub!(/\r\n?/, "\n")
text.each_line do |line|
  puts line.rstrip
end

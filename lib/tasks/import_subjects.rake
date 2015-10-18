desc "Import subjects." 
task :import_subjects => :environment do
  File.open("subjects.txt", "r").each do |line|
    code, name = line.strip.split("\t")
    s = Subject.new(:code => code, :name => name)
    s.save
  end
end

$PROGRAM_NAME = "source_code.rb"
File.open($PROGRAM_NAME,"r") do |file| 
	file.each_line do |line|
		puts line
	end
end

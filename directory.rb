require 'csv'
@months = ["january","february","march","april","may","june","july","august","september","october","november","december"]
@students = []
@full_list_of_students = []

#=====================
# get methods
#=====================
	
def get_student_name(student_name)
	if student_name.length >= 12 then	student_name = student_name[0..8]+('...') end 
	return student_name
end

def get_student_values
	new_array = []
	@students.each {|student| new_array << student}
	return new_array
end

#=======================
# input methods
#=======================

def input_chohort
	cohort = ''
	until @months.include?(cohort)
		puts "which cohort?"
		cohort = STDIN.gets.chomp.downcase
		if cohort.empty? or !@months.include?(cohort)
			puts "please enter a valid cohort."
		end
	end
	return cohort
end

def input_students
	puts "Please enter the names of the students"
	puts "To finish, just hit return twice"
	name = STDIN.gets.chomp
	while !name.empty? do
		cohort = input_chohort
		update_students(name,cohort)
		puts "Now we have #{@students.count} students"
		name = STDIN.gets.chomp
	end
end

#======================
# menu methods
#======================

def interactive_menu
	loop do
		print_menu	
		process(STDIN.gets.chomp)
	end
end

def print_menu
	puts "1. Update students"
	puts "2. Show the students"
	puts "3. Save student list"
	puts "4. Load student list from students.csv"
	puts "9.exit"
end

def process(selection)
	case selection
		when "1"
			input_students
			success("input students")
		when "2"
			print_students
			print_footer(@students)
		when "3"
			save_students
			success("saved students")
		when "4"
			load_students
			success("loaded students")
		when "9"
			exit
		else 
			puts "I don't know what you meant,try again"
	end
end

def success(string)
	puts "Successfully #{string}"
end


#======================
# print methods
#======================

def print_footer(names)
	string  = "Overall, we have #{names.count} great student" 
	if names.length > 1 then string += "'s" end
	puts string
end

def print_header
	puts "The students of Villains Academy"
	puts "--------------------------------"
end

def print_students
	initial_student_values = get_student_values
	student_sort
	print_header
	print_student_names(@students)
	@students = initial_student_values
end

def print_student_names(students)
	if students.length > 0
		i = 0
		while i < students.length do 
			student_name = get_student_name(students[i][:name])
			puts "#{i+1}. #{student_name} (#{students[i][:cohort]} cohort)"
			i = i + 1
		end
	else
		puts "No students found"
	end
end


#======================
# save/load methods
#======================

def load_students(file_name="students.csv")
	@students = []
	CSV.foreach(ARGV[0]) do |line|
		name, cohort = line
		update_students(name,cohort)
	end
end

def save_students
	puts "Save to which file?"
	file_name = STDIN.gets.chomp
	CSV.open(file_name, "w") do |file|
		@students.each do |student|
			student_data = [student[:name], student[:cohort]]
			file << student_data
		end
	end
end

def set_first_argv
	if ARGV.length == 0 or !File.exist?(ARGV[0]) then ARGV[0] = "students.csv" end
end

def try_load_students
	file_name = ARGV.first
	return if file_name.nil?
	if File.exists?(file_name)
		load_students(file_name)
		puts "Loaded #{@students.count} from #{file_name}"
	else 
		puts "Sorry, #{file_name} doesn't exist."
		exit
	end
end

def update_students(name,cohort)
	@students << {name: name, cohort: cohort.to_sym}
	@full_list_of_students << {name: name, cohort: cohort.to_sym}
end

#======================
# sorting methods
#======================

def cohort_sort
	puts "which cohort?"
	cohort = ''
	until @months.include?(cohort)
		cohort = STDIN.gets.chomp
	end
	@students.select! {|student| student[:cohort] == cohort.to_sym } 
end

def letter_sort
	puts "which letter?"
	search_letter = STDIN.gets.chomp
	@students.select! {|student| student[:name][0] == search_letter }
end


def sort_by?(string)
	puts "would you like to sort by #{string}?"
	input = ''
	while input != "n" or input != "y"
		puts "Enter y/n:"
		input = STDIN.gets.chomp.downcase
		if input == "n"
			return false
		elsif input == "y"
			return true
		end		
	end
end

def student_sort
	if sort_by?("letter") then @students = letter_sort end
	if sort_by?("cohort") then @students = cohort_sort end
end







def execute
	set_first_argv
	try_load_students
	interactive_menu
end
execute

@months = ["january","february","march","april","may","june","july","august","september","october","november","december"]
@students = []
@full_list_of_students = []
def print_header
	puts "The students of Villains Academy"
	puts "--------------------------------"
end

def print_footer(names)
	string  = "Overall, we have #{names.count} great student" 
	if names.length > 1 then string += "'s" end
	puts string
end

def input_chohort
	cohort = ''
	until @months.include?(cohort)
		puts "which cohort?"
		cohort = gets.chomp.downcase
		if cohort.empty? or !@months.include?(cohort)
			puts "please enter a valid cohort."
		end
	end
	return cohort
end

def input_students
	puts "Please enter the names of the students"
	puts "To finish, just hit return twice"
	name = gets.chomp
	while !name.empty? do
		cohort = input_chohort
		@students << {name: name, cohort: cohort.to_sym}
		@full_list_of_students << {name: name, cohort: cohort.to_sym}
		puts "Now we have #{@students.count} students"
		name = gets.chomp
	end
end

def reset_student_list
	@students = @full_list_of_students
end
	
def get_student_name(student_name)
	if student_name.length >= 12 then	student_name = student_name[0..8]+('...') end 
	return student_name
end

def sort_by?(string)
	puts "would you like to sort by #{string}?"
	input = ''
	while input != "n" or input != "y"
	puts "Enter y/n:"
	input = gets.chomp.downcase
		if input == "n"
			return false
		elsif input == "y"
			return true
		end		
	end
end

def letter_sort
	puts "which letter?"
	search_letter = gets.chomp
	@students.select! {|student| student[:name][0] == search_letter }
end

def cohort_sort
	puts "which cohort?"
	cohort = ''
	until @months.include?(cohort)
		cohort = gets.chomp
	end
	@students.select! {|student| student[:cohort] == cohort.to_sym } 
end

def print_students
	if sort_by?("letter") then letter_sort end
	if sort_by?("cohort") then cohort_sort end
	print_header
	if @students.length > 0
		i = 0
		while i < @students.length do 
			student_name = get_student_name(@students[i][:name])
			puts "#{i+1}. #{student_name} (#{@students[i][:cohort]} cohort)"
			i = i + 1
		end
	else
		puts "No students found"
	end
	reset_student_list
end

def print_menu
	puts "1. Update students"
	puts "2. Show the students"
	puts "3. Save student list to students.csv"
	puts "9.exit"
end

def process(selection)
	case selection
		when "1"
			input_students
		when "2"
			print_students
			print_footer(@students)
		when "3"
			save_students
		when "9"
			exit
		else 
			puts "I don't know what you meant,try again"
	end
end

def interactive_menu
	loop do
		print_menu	
		process(gets.chomp)
	end
end

def save_students
	file = File.open("students.csv", "w")
	@students.each do |student|
		student_data = [student[:name], student[:cohort]]
		csv_line = student_data.join(",")
		file.puts csv_line
	end
	file.close
end

interactive_menu
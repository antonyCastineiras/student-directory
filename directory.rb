
$months = ["january","february","march","april","may","june","july","august","september","october","november","december"]

def input_chohort
	cohort = ''
	until $months.include?(cohort)
		puts "which cohort?"
		cohort = gets.chomp.downcase
		if cohort.empty? or !$months.include?(cohort)
			puts "please enter a valid cohort."
		end
	end
	return cohort
end

def input_students
	puts "Please enter the names of the students"
	puts "To finish, just hit return twice"
	students = []
	name = gets.chomp
	while !name.empty? do
		cohort = input_chohort
		students << {name: name, cohort: cohort.to_sym}
		puts "Now we have #{students.count} students"
		name = gets.chomp
	end

	students
end

def get_student_name(student_name)
		if student_name.length >= 12 
			student_name = student_name[0..8]+('...') 
		end 
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

def letter_sort(students)
	puts "which letter?"
	search_letter = gets.chomp
	sorted_array = []
	students.each {|student| if student[:name][0] == search_letter then sorted_array << student end }
	return sorted_array
end

def cohort_sort(students)
	puts "which cohort?"
	cohort = ''
	until $months.include?(cohort)
		cohort = gets.chomp
	end
	sorted_array = []
	students.each {|student| if student[:cohort] == cohort.to_sym then sorted_array << student end } 
	return sorted_array
end

def print_students(students)
	if sort_by?("letter") then students = letter_sort(students) end
	if sort_by?("cohort") then students = cohort_sort(students) end
	print_header
	i = 0
	while i < students.length do 
		student_name = get_student_name(students[i][:name])
		puts "#{i+1}. #{student_name} (#{students[i][:cohort]} cohort)"
		i = i + 1
	end
end

def print_header
	puts "The students of Villains Academy"
	puts "--------------------------------"
end

def print_footer(names)
	print "Overall, we have #{names.count} great student"
	if names.length > 1
		print "'s"+"\n"
	end	
end


students = input_students
print_students(students)
print_footer(students)

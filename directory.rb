def input_students
	puts "Please enter the names of the students"
	puts "To finish, just hit return twice"
	students = []
	name = gets.chomp
	while !name.empty? do
		students << {name: name, cohort: :november}
		puts "Now we have #{students.count} students"
		name = gets.chomp
	end

	students
end

def search_letter
	puts "would you like to sort by letter? Enter letter or leave blank:"
	search_letter = gets.chomp
end

def print_header
	puts "The students of Villains Academy"
	puts "-----------------"
end

def print(students)
	letter = search_letter
	students.each_with_index do |student,index|
		first_letter = student[:name][0]
		student_name = ''
		if student[:name].length >= 12 
			student_name = student[:name][0..8]+('...') 
		else 
			student_name = student[:name]
		end 
		if letter.empty?
			puts "#{index+1}. #{student_name} (#{student[:cohort]} cohort)"
		elsif !letter.empty? and first_letter == letter
			puts "#{index+1}. #{student_name} (#{student[:cohort]} cohort)"
		end
	end
end

def print_footer(names)
	puts "Overall, we have #{names.count} great students"	
end


students = input_students
print_header
print(students)
print_footer(students)

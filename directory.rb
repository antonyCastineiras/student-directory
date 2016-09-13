def input_students
	puts "Please enter the names of the students"
	puts "To finish, just hit return twice"
	students = []
	name = gets.chomp
	while !name.empty? do
		puts "which cohort?"
		cohort = gets.chomp
		students << {name: name, cohort: cohort}
		puts "Now we have #{students.count} students"
		name = gets.chomp
	end

	students
end


def search
	puts "would you like to sort by letter? Enter letter or leave blank:"
	search_letter = gets.chomp
end

def print_header
	puts "The students of Villains Academy"
	puts "-----------------"
end

def print(students)
	search_letter = search
	print_header
	i = 0
	while i < students.length do 
		first_letter = students[i][:name][0]
		student_name = ''
		if students[i][:name].length >= 12 
			student_name = students[i][:name][0..8]+('...') 
		else 
			student_name = students[i][:name]
		end 
		if search_letter.empty?
			puts "#{i+1}. #{student_name} (#{students[i][:cohort]} cohort)"
		elsif !search_letter.empty? and first_letter == search_letter
			puts "#{i+1}. #{student_name} (#{students[i][:cohort]} cohort)"
		end
		i = i + 1
	end
end

def print_footer(names)
	puts "Overall, we have #{names.count} great students"	
end


students = input_students
print(students)
print_footer(students)

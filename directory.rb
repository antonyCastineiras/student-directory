def input_chohort
	months = ["january","february","march","april","may","june","july","august","september","october","november","december"]
	cohort = ''
	until months.include?(cohort)
		puts "which cohort?"
		cohort = gets.chomp
		if cohort.empty? or !months.include?(cohort)
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


def search
	puts "would you like to sort by letter? Enter letter or leave blank:"
	search_letter = gets.chomp
end

def get_student_name(student_name)
		if student_name.length >= 12 
			student_name = student_name[0..8]+('...') 
		end 
		return student_name
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
		student_name = get_student_name(students[i][:name])
		first_letter = student_name[0]
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

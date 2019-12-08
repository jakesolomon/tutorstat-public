# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'
require 'date'

csv_text = File.read(Rails.root.join('lib', 'seeds', 'Scores-SAT.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|
  t = Test.new
  t.date_entered = Date.strptime(row['Date Entered'], "%m/%d/%y")
  t.student_name = [row['Student First Name'], row['Student Last Name']].join(' ')
  t.student_id = row['Student ID']
  t.tutor_name = [row['Tutor First Name'], row['Tutor Last Name']].join(' ')
  t.tutor_id = row['Tutor ID']
  t.form = row['Form']
  t.total = row['Total']
  t.reading_writing = row['Reading Writing']
  t.reading = row['Reading']
  t.writing = row['Writing']
  t.math = row['Math']
  t.extended = row['Extended']
  puts t.save!
end

puts "There are now #{Test.count} rows in the test table"

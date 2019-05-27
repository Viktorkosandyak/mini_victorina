require_relative 'lib/question'
require_relative 'lib/sklonjator'

question = Question.read_from_xml('/data/questions.xml')
sklonjator = Sklonjator.new

start_time = Time.now

puts "МИНИ-ВИКТОРИНА."
puts "Ответьте на вопросы и проверьте свои знания :-)"
puts

right_answers = 0

question.each_with_index do |questions, index|
  puts "Вопрос № #{index+1}"
  questions.show
  right = questions.ask
  right_answers += 1 if right
end
second_spent = Time.now - start_time.to_i

puts "У Вас #{right_answers} правильных #{sklonjator.answers(right_answers)} из 8 вопросов. Вы потратили на викторину: #{second_spent.strftime("%M мин. %S сек.")}"

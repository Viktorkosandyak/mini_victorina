require 'rexml/document'

class Question

  def initialize(question, variants, right_answer, time)
    @question = question
    @variants = variants
    @right = right_answer
    @answer_time = time
  end

  #Считываем данные из файла и возвращаем массив обьектов класса Question
  def self.read_from_xml(file_name)
    # Получим абсолютный путь к файлу
    file_path = File.dirname(__FILE__) + "/../" + file_name

    # Если файла нет, сразу закончим выполнение программы, сообщив об этом
    unless File.exist?(file_path)
      abort "Файл #{file_path} не найден"
    end

    # Открываем файл и передаём его в парсер
    file = File.new(file_path, "r:UTF-8")
    doc = REXML::Document.new(file)
    file.close

    questions = []

    doc.elements.each('questions/question') do |item|
      answer_time = item.attributes['minutes'].to_i
      question_text = item.elements['text'].text

      variants = []

      item.elements.each_with_index('variants/variant') do |variant, index|
        variants << variant.text
        @right_answer = index + 1 if variant.attributes['right'] == 'true'
      end

      question = Question.new(question_text, variants, @right_answer, answer_time)
      questions << question
    end

    questions
  end

  def show
    puts @question
    puts
    puts 'Варианты ответа:'

    @variants.each_with_index do |variant|
      puts variant
    end
    puts
    puts "Чтобы оветить на вопрос у вас есть #{@answer_time} мин."
  end

  def ask
    user_answer = nil
    start_time = Time.now
    until (1..@variants.size).include?(user_answer) do
      puts 'Выберите верный вариант ответа. Наберите цифру 1 2 3 или 4'
      user_answer = gets.to_i
    end
    time_spent = Time.now - start_time

    if time_spent/60 > @answer_time.to_i
      # мутки с временем
      time_spent = Time.now - start_time.to_i
      abort "Сожалею, но Вы не уложились в заданное время. Ваше время #{time_spent.strftime("%M мин. %S сек.")}"
    else
      if user_answer == @right
        puts 'Верный ответ!'
        puts
        true
      else
        puts 'Неправильно :-('
        puts
        false
      end
    end
  end
end

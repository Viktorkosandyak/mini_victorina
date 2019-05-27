class Sklonjator

  def answers(right_answers)

    if (right_answers >= 5 && right_answers <= 7) ||right_answers == 0
      return "ответов"
    elsif right_answers == 1
      return "ответ"
    else
      return "ответа"
    end
  end
end

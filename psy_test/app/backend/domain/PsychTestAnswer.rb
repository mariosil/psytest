class PsychTestAnswer
  def initialize(patient_name, age, date, psych_test=nil)
    @test_name = test_name
    @patient_name = patient_name
    @patient_age= age
    @date = date
    @answers = Hash.new
    @psych_test = psych_test
  end

  def update_answer(entry_name, value, reactive_text)
    @answers[entry_name] = {:value => value, :reactive_text => reactive_text}
  end

  def test_name
    @test_name
  end
  def patient_name
    @patient_name
  end
  def patient_age
    @patient_age
  end
  def date
    @date
  end
  def answers
    @answers
  end
  def psych_test
    @psych_test
  end

  def set_patient_name(patient_name)
    @patient_name = patient_name
  end
  def set_patient_age(patient_age)
    @patient_age = patient_age
  end
  def set_date(date)
    @date = date
  end
  def set_psych_test(psych_test)
    @psych_test = psych_test
  end
end

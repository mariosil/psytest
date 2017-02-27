require 'csv'
require 'json'
require_relative '..\domain\PsychTest'
require_relative '..\domain\PsychTestAnswer'


class TestApplicationController
  @@reports_dir_path = "#{File.dirname(__FILE__)}/internal/report_dir_path.csv"

  def initialize(date, patient_name=nil, age=nil)
    @patient_name = patient_name
    @age = age
    @date = date
    @psych_test_answer = PsychTestAnswer.new(@patient_name, @age, @date)
    @avaliable_tests = Dir["#{File.dirname(__FILE__)}/../entries/*.json"].collect { |dir| PsychTest.new(JSON.parse(File.read(dir).force_encoding('UTF-8'))) }
  end

  def get_test(test_name)
    @avaliable_tests.select { |psych_test| psych_test.test_name == test_name }.first
  end

  def get_avaliable_test_names
    @avaliable_tests.collect { |psych_test| psych_test.test_name }
  end

  def get_patient_name
    @patient_name
  end
  def get_age
    @age
  end
  def get_date
    @date
  end
  def get_psych_test_answer
    @psych_test_answer
  end
  def get_reports_dir_path
    csv_report_dir_csv = CSV.read(@@reports_dir_path, {headers: true})
    return csv_report_dir_csv.first ? csv_report_dir_csv.first['path'] : nil
  end

  def set_patient_name(patient_name)
    @patient_name = patient_name
    @psych_test_answer.set_patient_name(patient_name)
  end
  def set_age(age)
    @age = age
    @psych_test_answer.set_patient_age(age)
  end
  def set_date(date)
    @date = date
    @psych_test_answer.set_date(date)
  end
  def set_psych_test(psych_test)
    @psych_test_answer.set_psych_test(psych_test)
  end
  def set_reports_dir_path(dir_path)
    CSV.open(@@reports_dir_path, "wb") do |csv|
      csv << ['path', 'updated']
      csv << [dir_path, Time.now.strftime("%d/%m/%Y-%l:%M%P")]
    end
  end
end

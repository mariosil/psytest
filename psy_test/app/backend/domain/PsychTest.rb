require 'json'
require_relative 'Entry'

class PsychTest
  def initialize(test_json)    
    @test_name = test_json['test_name']
    @instructions = test_json['instructions']
    @entries = test_json['entries'].collect { |entry_map| Entry.new(entry_map) }
  end

  def test_name
    @test_name
  end
  def instructions
    @instructions
  end
  def entries
    @entries
  end
end

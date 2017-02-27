require_relative 'Reactive'

class Entry
  def initialize(entry_map)
    @entry_name = entry_map['entry_name']
    @entry_label = entry_map['entry_label']
    @entry_question = entry_map['entry_question'] ? entry_map['entry_question'] : nil
    @complementary = entry_map['complementary'] ? entry_map['complementary'] : false
    @reactives = entry_map['questions'].collect { |reactive_map| Reactive.new(reactive_map['value'], reactive_map['text']) }
  end

  def entry_name
    @entry_name
  end
  def entry_label
    @entry_label
  end
  def entry_question
    @entry_question
  end
  def reactives
    @reactives
  end
  def complementary
    @complementary
  end
end

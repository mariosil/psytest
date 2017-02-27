require 'csv'
require 'axlsx'
# require_relative '..\domain\PsychTestAnswer'

class TestReportGenerator
  def initialize(path)
    path.end_with?('.csv') ? @path = path : @path = path.concat('.xlsx')
    @p = Axlsx::Package.new
  end

  def generate_test_report(psych_test_answer, palette=nil)
    debug "generate_test_report: #{@path }"
    sheet = @p.workbook.add_worksheet(name: psych_test_answer.test_name)

    title = sheet.styles.add_style(sz: 16, alignment: {horizontal: :center, vertical: :center}, fg_color: palette ? palette.first_color[:hex] : 'FFFFFF', bg_color: palette ? palette.first_background[:hex] : '000000')

    style1 = sheet.styles.add_style(sz: 12, alignment: {horizontal: :center, vertical: :center}, fg_color: palette ? palette.first_color[:hex] : 'FFFFFF', bg_color: palette ? palette.first_background[:hex] : '000000')

    style2 = sheet.styles.add_style(sz: 12, alignment: {horizontal: :center, vertical: :center}, fg_color: palette ? palette.second_color[:hex] : 'FFFFFF', bg_color: palette ? palette.second_background[:hex] : '000000')

    style3 = sheet.styles.add_style(sz: 12, alignment: {horizontal: :center, vertical: :center}, fg_color: palette ? palette.third_color[:hex] : 'FFFFFF', bg_color: palette ? palette.third_background[:hex] : '000000')
    style3_right = sheet.styles.add_style(sz: 12, alignment: {horizontal: :right, vertical: :center}, fg_color: palette ? palette.third_color[:hex] : 'FFFFFF', bg_color: palette ? palette.third_background[:hex] : '000000')

    style4 = sheet.styles.add_style(sz: 12, alignment: {horizontal: :center, vertical: :center}, fg_color: palette ? palette.fourth_color[:hex] : 'FFFFFF', bg_color: palette ? palette.fourth_background[:hex] : '000000')

    sheet.add_row ["Prueba aplicada", "", "Nombre del paciente", ""], style: style1
    sheet.merge_cells "A1:B1"
    sheet.merge_cells "C1:D1"

    sheet.add_row [psych_test_answer.psych_test.test_name, "", psych_test_answer.patient_name, ""], style: title
    sheet.merge_cells "A2:B2"
    sheet.merge_cells "C2:D2"

    sheet.add_row ["Aplicada el  #{psych_test_answer.date.to_s.gsub("\n", "-")}", "", "#{psych_test_answer.patient_age} años", ""], style: style1
    sheet.merge_cells "A3:B3"
    sheet.merge_cells "C3:D3"

    case psych_test_answer.psych_test.test_name
    when 'BDI-II'
      sheet.add_row ["Rubro", "Valor", "Respuesta", ""], style: style2
      sheet.merge_cells "C4:D4"

      mandatory_entries = psych_test_answer.psych_test.entries.select { |entry| !entry.complementary }
      mandatory_entries.each do |entry|
          answers = psych_test_answer.answers[entry.entry_label]
          sheet.add_row [entry.entry_label, answers[:value], answers[:reactive_text], ""]
          sheet.merge_cells "C#{sheet.rows.length}:D#{sheet.rows.length}"
      end
      sheet.add_row ["TOTAL", "=SUM(B5:B#{sheet.rows.length})", "", ""], style: style3_right

      sheet.add_row ["", "", "", ""]
      sheet.add_row ["Preguntas complementarias", "", "", ""], style: style2
      sheet.merge_cells "A#{sheet.rows.length}:D#{sheet.rows.length}"

      complementary_entries = psych_test_answer.psych_test.entries.select { |entry| entry.complementary }
      complementary_entries.each do |entry|
        answers = psych_test_answer.answers[entry.entry_label]
        sheet.add_row [entry.entry_question, answers[:value], answers[:reactive_text], ""]
        sheet.merge_cells "C#{sheet.rows.length}:D#{sheet.rows.length}"
      end
    when 'PBQ'
      entry_names = psych_test_answer.psych_test.entries.collect { |entry| entry.entry_name }.uniq!
      entry_names.each do |entry_name|
        sheet.add_row ["", "", "", entry_name.capitalize], style: style2
        sheet.merge_cells "A#{sheet.rows.length}:C#{sheet.rows.length}"
        formula_row_index = sheet.rows.length

        entries_by_name = psych_test_answer.psych_test.entries.select { |entry| entry.entry_name == entry_name }
        entries_by_name.each do |entry|
          answers = psych_test_answer.answers[entry.entry_label]
          sheet.add_row [entry.entry_question, answers[:reactive_text], answers[:value]]
        end
        sheet.rows[formula_row_index].add_cell("=SUM(C#{formula_row_index + 1}:C#{sheet.rows.length})", style: style3)
        sheet.merge_cells "D#{formula_row_index + 1}:D#{sheet.rows.length}"
      end
    when 'PBQ_demo'
    end

    @p.serialize(@path)
  end


end

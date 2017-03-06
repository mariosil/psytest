require_relative '..\color_schemes\ColorSchemes'
require_relative '..\..\..\backend\controllers\TestApplicationController'
require_relative '..\..\..\backend\controllers\TestReportGenerator'
require_relative '..\..\..\backend\utilities\util'
include ColorSchemes

def init_login(icon_path)

# @@palette = ColorSchemes.palette(ColorSchemes::Modern_and_Clean)
# @@palette = ColorSchemes.palette(ColorSchemes::Elegant_and_Sophisticated)
@@palette = ColorSchemes.palette(ColorSchemes::Clean_Gradients_and_Fresh_Blues)
# @@palette = ColorSchemes.palette(ColorSchemes::Unexpected_Color_Combinations)

@@test_control = TestApplicationController.new(Time.now.strftime("%d/%m/%Y\n%l:%M%P"))

@@hide_entry_labels = true

Shoes.app(title: "Psytest") do
  app.set_window_icon_path(icon_path)

  @login_stack = stack do #-----------------------------------------------------

    stack do
      background(@@palette.first_background[:rgb])
      config_btn_stack = stack(width: 60) do
        para("📁").style(stroke: @@palette.first_color[:rgb], align: 'center')
        hover {
          config_btn_stack.clear {
            highlight = "##{@@palette.first_background[:hex]}"
            highlight[2] = 'F'
            highlight[4] = 'F'
            highlight[6] = 'F'
            background(highlight)
            para("📁").style(stroke: @@palette.first_color[:rgb], align: 'center')
          }
        }
        leave {
          config_btn_stack.clear {
            para("📁").style(stroke: @@palette.first_color[:rgb], align: 'center')
          }
        }
        click {
          config_btn_stack.clear {
            border(@@palette.first_color[:rgb])
            para("📁").style(stroke: @@palette.first_color[:rgb], align: 'center')
            @@test_control.set_reports_dir_path(ask_open_folder)
            alert("Los reportes de las pruebas se guardarán en:\n#{@@test_control.get_reports_dir_path}") if @@test_control.get_reports_dir_path
            @generate_test_report_stack.hide if @@test_control.get_reports_dir_path
            @close_app_btn_stack.show if @@test_control.get_reports_dir_path
          }
        }
      end
    end

    @title_stack = stack(height: 140) do
      background(@@palette.first_background[:rgb])
      title("Psytest").style(stroke: @@palette.first_color[:rgb], align: 'center', weight: 'ultralight', margin_top:77)
    end

    @init_form_stack = stack do
      background(@@palette.second_background[:rgb])
      tagline("Ingrese los siguientes datos para comenzar").style(stroke: @@palette.second_color[:rgb], align: 'center', margin: 20)

      stack do
        flow do
          stack(width: '50%') do
            para("Nombre").style(align: 'right', stroke: @@palette.third_color[:rgb])
          end
          stack(width: 250) do
            edit_line(width: 240).change { |el|
              if valid_name(el.text)
                @@test_control.set_patient_name(el.text)
                @patient_name_ins.text = ""
              else
                @@test_control.set_patient_name(nil)
                el.text.empty? ? @patient_name_ins.text = "* Ingrese nombre" : @patient_name_ins.text = "* Solo texto"
              end
              @@test_control.get_patient_name && @@test_control.get_age ? @select_test_stack.show : @select_test_stack.hide
            }
            @patient_name_ins = inscription("").style(stroke: @@palette.error_color[:rgb])
          end
        end

        flow do
          stack(width: '50%') do
            para("Edad").style(align: 'right', stroke: @@palette.third_color[:rgb])
          end
          stack(width: 250) do
            edit_line(width: 50).change { |el|
              if valid_age(el.text)
                @@test_control.set_age(el.text.to_i)
                @patient_age_ins.text = ""
              else
                @@test_control.set_age(nil)
                @patient_age_ins.text = "* Ingrese edad en números"
                el.text = ""
              end
              @@test_control.get_patient_name && @@test_control.get_age ? @select_test_stack.show : @select_test_stack.hide
            }
            @patient_age_ins = inscription("").style(stroke: @@palette.error_color[:rgb])
          end
        end

      end
    end

    @select_test_stack = flow(hidden: true) do
      background(@@palette.fourth_background[:rgb])
      stack(width: '50%', margin_top: 10) do
        para("Seleccione el tipo de prueba").style(stroke: @@palette.fourth_color[:rgb], align: 'right')
      end
      stack(width: '50%', margin_top: 10) do
        test_items = @@test_control.get_avaliable_test_names
        list_box(items: test_items) { |list|
          @selected_test = @@test_control.get_test(list.text)
          @@test_control.set_psych_test(@selected_test)
          @init_stack_button.show
        }
        test_items.empty? ? inscription("* No hay pruebas disponibles").style(stroke: @@palette.error_color[:rgb]) : inscription("* Pruebas disponibles").style(stroke: @@palette.fourth_color[:rgb])
      end
    end

    @init_stack_button = flow(width: '75%', margin_left:'25%', margin_top: 20, hidden: true) do
      background(@@palette.third_background[:rgb])
      tagline("Iniciar prueba").style(align: 'center', stroke: @@palette.third_color[:rgb])
      hover {
        @init_stack_button.clear {
          background(@@palette.fourth_background[:rgb])
          tagline("Iniciar prueba").style(align: 'center', stroke: @@palette.fourth_color[:rgb])
        }
      }
      leave {
        @init_stack_button.clear {
          background(@@palette.third_background[:rgb])
          tagline("Iniciar prueba").style(align: 'center', stroke: @@palette.third_color[:rgb])
        }
      }
      click {
        @init_stack_button.clear {
          background(@@palette.third_color[:rgb])
          border(@@palette.third_background[:rgb])
          tagline("Iniciar prueba").style(align: 'center', stroke: @@palette.third_background[:rgb])
        }
        timer(1) {
          @login_stack.hide
          @test_name_tag.text = @selected_test.test_name
          @patient_name_para.text = @@test_control.get_patient_name
          @patient_age_para.text = "EDAD: #{@@test_control.get_age}"
          @test_date_para.text = "FECHA: #{@@test_control.get_date}"
          @test_instructions_para.text = @selected_test.instructions
          @selected_test.entries.each_with_index do |entry, entry_stack_index|
            @entries_stack.append {
              stack do
                stack(hidden: @@hide_entry_labels) do
                  background(@@palette.fourth_background[:rgb])
                  para(entry.entry_label).style(stroke: @@palette.fourth_color[:rgb])
                end
                stack(hidden: entry.entry_question) do
                  caption(entry.entry_question).style(margin: 10)
                end
              end
            }
            entry.reactives.each do |reactive|
              @entries_stack.contents[entry_stack_index].append {
                flow(margin: 15) do
                  radio.click {
                    @@test_control.get_psych_test_answer.update_answer(entry.entry_label, reactive.value, reactive.text)
                    @entries_stack.contents[entry_stack_index].contents.last.contents.first.show
                  }
                  para(reactive.text)
                end
              }
            end
            @entries_stack.contents[entry_stack_index].append {
              stack do
                next_btn_stack = stack(margin_left: "75%", hidden: true) do
                  background(@@palette.fourth_background[:rgb])
                  para("Siguiente ❱").style(stroke: @@palette.fourth_color[:rgb], align: 'center', margin_top: 5)
                  hover {
                    next_btn_stack.clear {
                      background(@@palette.third_background[:rgb])
                      para("Siguiente ❱").style(stroke: @@palette.third_color[:rgb], align: 'center', margin_top: 5)
                    }
                  }
                  leave {
                    next_btn_stack.clear {
                      background(@@palette.fourth_background[:rgb])
                      para("Siguiente ❱").style(stroke: @@palette.fourth_color[:rgb], align: 'center', margin_top: 5)
                    }
                  }
                  click {
                    next_btn_stack.clear {
                      background(@@palette.fourth_color[:rgb])
                      border(@@palette.fourth_background[:rgb])
                      para("Siguiente ❱").style(stroke: @@palette.fourth_background[:rgb], align: 'center', margin_top: 5)
                    }
                    if @entries_stack.contents[entry_stack_index + 1]
                      @entries_stack.contents[entry_stack_index].hide
                      @entries_stack.contents[entry_stack_index + 1].show
                    else
                      @entries_stack.hide
                      @finalized_test_stack.show
                      repot_file_name = "#{@@test_control.get_patient_name}_#{@selected_test.test_name}_#{@@test_control.get_date.gsub('/','-').gsub("\n",' ').gsub(':','-')}"
                      TestReportGenerator.new("#{@@test_control.get_reports_dir_path}\\#{repot_file_name}").generate_test_report(@@test_control.get_psych_test_answer, @@palette) if @@test_control.get_reports_dir_path
                    end
                  }
                end
              end
            }
            @entries_stack.contents[entry_stack_index].hide
          end
          @entries_stack.contents.first.show
          @test_stack.show
        }
      }
    end
  end #-------------------------------------------------------------------------

  @test_stack = stack(hidden: true) do #----------------------------------------
    stack do
      background(@@palette.first_background[:rgb])
      @test_name_tag =  tagline(stroke: @@palette.first_color[:rgb])
    end
    flow do
      background(@@palette.second_background[:rgb])
      flow(width: '33%') do
        para("NOMBRE:").style(stroke: @@palette.second_color[:rgb])
        stack(width: '70%') do
          @patient_name_para = para(stroke: @@palette.second_color[:rgb])
        end
      end
      stack(width: '33%') do
        @patient_age_para = para(stroke: @@palette.second_color[:rgb], align: 'center')
      end
      stack(width: '33%') do
        @test_date_para = para(stroke: @@palette.second_color[:rgb], align: 'right')
      end
    end
    flow do
      background(@@palette.third_background[:rgb])
      para("INSTRUCCIONES").style(stroke: @@palette.third_color[:rgb])
      show_hide_instructions_ins = inscription("").style(fill: @@palette.third_color[:rgb], margin_left: 20)
      hide_link = link(" Ocultar ", underline: 'none', stroke: @@palette.third_background[:rgb]).click {}
      show_link = link("   Ver   ", underline: 'none', stroke: @@palette.third_background[:rgb]).click {}
      hide_link.click {
        show_hide_instructions_ins.text = show_link
        @test_instructions_stack.hide
      }
      show_link.click {
        show_hide_instructions_ins.text = hide_link
        @test_instructions_stack.show
      }
      show_hide_instructions_ins.text = hide_link
    end
    @test_instructions_stack = stack do
      background(@@palette.third_background[:rgb])
      @test_instructions_para = para(stroke: @@palette.third_color[:rgb])
    end

    @entries_stack = stack {}
  end #-------------------------------------------------------------------------

  @finalized_test_stack = stack(hidden: true) do #------------------------------
    stack do
      subtitle("✔ Prueba finalizada").style(stroke: @@palette.fourth_background[:rgb], align: 'center', margin_top: 40)
    end
    @generate_test_report_stack = stack do
      generate_btn_flow = flow(width: '80%', margin_left: '20%') do
        background(@@palette.third_background[:rgb])
        tagline("💾 Generar reporte").style(stroke: @@palette.third_color[:rgb], align: 'center')
        hover {
          generate_btn_flow.clear {
            background(@@palette.fourth_background[:rgb])
            tagline("💾 Generar reporte").style(stroke: @@palette.fourth_color[:rgb], align: 'center')
          }
        }
        leave {
          generate_btn_flow.clear {
            background(@@palette.third_background[:rgb])
            tagline("💾 Generar reporte").style(stroke: @@palette.third_color[:rgb], align: 'center')
          }
        }
        click {
          generate_btn_flow.clear {
            background(@@palette.third_color[:rgb])
            border(@@palette.third_background[:rgb])
            tagline("💾 Generar reporte").style(stroke: @@palette.third_background[:rgb], align: 'center')
          }
          timer(1) {
            report_path = ask_save_file
            TestReportGenerator.new(report_path).generate_test_report(@@test_control.get_psych_test_answer, @@palette) if report_path
            @close_app_btn_stack.show if report_path
          }
        }
      end
    end
    @close_app_btn_stack = stack(hidden: true, margin_top: 40) do
      close_btn_flow = flow(width: '80%', margin_left: '20%') do
        background(@@palette.fourth_color[:rgb])
        border(@@palette.fourth_background[:rgb])
        tagline("✖ Salir").style(stroke: @@palette.fourth_background[:rgb], align: 'center')
        hover {
          close_btn_flow.clear {
            background(@@palette.third_color[:rgb])
            border(@@palette.third_background[:rgb])
            tagline("✖ Salir").style(stroke: @@palette.third_background[:rgb], align: 'center')
          }
        }
        leave {
          close_btn_flow.clear {
            background(@@palette.fourth_color[:rgb])
            border(@@palette.fourth_background[:rgb])
            tagline("✖ Salir").style(stroke: @@palette.fourth_background[:rgb], align: 'center')
          }
        }
        click {
          close_btn_flow.clear {
            background(@@palette.fourth_background[:rgb])
            tagline("✖ Salir").style(stroke: @@palette.fourth_color[:rgb], align: 'center')
          }
          timer(1) {
            close
          }
        }
      end
    end
  end #-------------------------------------------------------------------------
end

end

require_relative '..\slotstrap\Slotstrap'
require_relative '..\color_schemes\ColorSchemes'
include ColorSchemes

@@palette = ColorSchemes.palette(ColorSchemes::Modern_and_Clean)

Shoes.app do
  @slotstrap = Slotstrap.new(app)

  stack do
    background(@@palette.first_background[:rgb])
    tagline("Basic Buid-in methods (just a few ones)").stroke = @@palette.first_color[:rgb]
  end

  stack do
    flow do
      flow(width: @slotstrap.col_4) do
        background(@@palette.second_background[:rgb])
        # One way to build a button element
        button("OK!").style(width: @slotstrap.col_4, margin: 6).click do
          @btn_ok_para.replace("Well okay then.")
        end
      end
      flow(width: @slotstrap.col_8) do
        background(@@palette.third_background[:rgb])
        @btn_ok_para = para("...").style(stroke: @@palette.third_color[:rgb])
        @btn_ok_para.style(width: @slotstrap.col_8, margin: 6)
      end
    end

    flow do
      flow(width: @slotstrap.col_4) do
        background(@@palette.second_background[:rgb])
        # Another way to build a button element
        button("Are you sure?").style(width: @slotstrap.col_4, margin: 6).click {
          @btn_are_you_sure_para.replace("Your confidence is inspiring.")
        }
      end
      flow(width: @slotstrap.col_8) do
        background(@@palette.third_background[:rgb])
        @btn_are_you_sure_para = para("...").style(stroke: @@palette.third_color[:rgb])
        @btn_are_you_sure_para.style(width: @slotstrap.col_8, margin: 6)
      end
    end

    flow do
      flow(width: @slotstrap.col_4) do
        background(@@palette.second_background[:rgb])
        # Show alert
        button("Show alert").style(width: @slotstrap.col_4, margin: 6).click { alert "This is an alert" }
      end
      flow(width: @slotstrap.col_8) do
        background(@@palette.third_background[:rgb])
        inscription("Only shows an alert message").style(stroke: gray, width: @slotstrap.col_8, margin: 6)
      end
    end

    flow do
      flow(width: @slotstrap.col_4) do
        background(@@palette.second_background[:rgb])
        # Ask a question
        button("Ask a question").style(width: @slotstrap.col_4, margin: 6).click {
          response = ask "Please, enter a value"
          @ask_a_question_para.replace("#{response}")
        }
      end
      flow(width: @slotstrap.col_8) do
        background(@@palette.third_background[:rgb])
        @ask_a_question_para = para("...").style(stroke: @@palette.third_color[:rgb])
        @ask_a_question_para.style(width: @slotstrap.col_8, margin: 6)
      end
    end

    flow do
      flow(width: @slotstrap.col_4) do
        background(@@palette.second_background[:rgb])
        # Color chooser
        button("Ask color").style(width: @slotstrap.col_4, margin: 6).click {
          selected_color = ask_color "Select color"
          @ask_color_para.replace("Color: #{selected_color}")
          @ask_color_para.style(fill: selected_color)
        }
      end
      flow(width: @slotstrap.col_8) do
        background(@@palette.third_background[:rgb])
        @ask_color_para = para("...").style(stroke: @@palette.third_color[:rgb])
        @ask_color_para.style(width: @slotstrap.col_8, margin: 6)
      end
    end

    flow do
      flow(width: @slotstrap.col_4) do
        background(@@palette.second_background[:rgb])
        # Open a file chooser
        button("Open a file").style(width: @slotstrap.col_4, height: 142, margin: 6).click {
          file_name = ask_open_file()
          @open_file_para.replace("#{file_name}")
          @file_content_insc.replace(File.read(file_name))
          @file_content_insc.style(stroke: @@palette.third_color[:rgb])
        }
      end
      flow(width: @slotstrap.col_8) do
        background(@@palette.third_background[:rgb])
        @open_file_para = para("...").style(stroke: @@palette.third_color[:rgb])
        @open_file_para.style(width: @slotstrap.col_8, margin: 6)
        @file_content_insc = inscription("File content will show here.").style(stroke: gray, height: 30)
        @file_content_insc.style(width: @slotstrap.col_8, margin: 6)
      end
    end

    flow do
      flow(width: @slotstrap.col_4) do
        background(@@palette.second_background[:rgb])
        # Save a file
        button("Save as").style(width: @slotstrap.col_4, margin: 6).click {
          file_name = ask_save_file()
          @save_file_para.replace(file_name)
        }
      end
      flow(width: @slotstrap.col_8) do
        background(@@palette.third_background[:rgb])
        @save_file_para = para("...").style(stroke: @@palette.third_color[:rgb])
        @save_file_para.style(width: @slotstrap.col_8, margin: 6)
      end
    end
  end
end

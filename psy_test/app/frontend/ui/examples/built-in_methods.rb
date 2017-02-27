Shoes.app do
  stack do
    # One way to build a button element
    button("OK!") do
      append { para "Well okay then." }
    end

    # Another way to build a button element
    button("Are you sure?").click { para "Your confidence is inspiring." }

    # Show alert
    button("Show alert").click { alert "This is an alert" }

    # Ask a question
    @ask_a_question = ""
    button("Ask a question").click {
      @ask_a_question = ask "Please, enter a value"
      para "Value: #{@ask_a_question}"
    }

    # Color chooser
    @ask_color = ""
    button("Ask color").click {
      @ask_color = ask_color "Select color"
      para "Color: #{@ask_color}"
    }

    # Open a file chooser
    @file_name = ""
    button("Open a file").click {
      @file_name = ask_open_file()
      para "File name selected: #{@file_name}"
      para File.read(@file_name)
    }

    # Save a file
    @save_as = ""
    button("Save as").click {
      ask_save_file()
    }

    # Open directory
    @folder = ""
    button("Open directory").click {
      @folder = ask_open_folder()
    }

    # Save directory
    @save_to = ""
    button("Save directory").click {
      @save_to = ask_save_folder()
    }

    # Confirm question
    @confirm_answer= false
    button("Confirm question").click {
      @confirm_answer = confirm("Dou you want to continue?")
      para "You confirm: #{@confirm_answer}"
    }

    # Warning message
    button("Warning message").click {
      warn("This is a Warning message")
    }

  end
end

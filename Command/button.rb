class Button
  def initialize(&command)
    @command = command
  end

  def on_click
    @command.() if @command
  end
end

open_button = Button.new { p 'open file' }
open_button.send :on_click

save_button = Button.new { p 'save file' }
save_button.send :on_click

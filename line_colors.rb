# frozen_string_literal: true

# Module to set colors for the last choice in the whole problem
module LineColors
  def blue
    "\e[34m#{self}\e[0m"
  end

  def red
    "\e[31m#{self}\e[0m"
  end
end

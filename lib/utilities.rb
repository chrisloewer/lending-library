def sanitize_text(input)
  output = input.gsub(/'/){ %q() }
  output = output.gsub(/"/){ %q() }
  return output
end

def valid_name(string_text)
  return false if string_text.empty?
  return /^[ÁÉÍÓÚáéíóúñÑa-zA-Z\s]*$/ === string_text.force_encoding('UTF-8')
end

def valid_age(string_text)
  return false if string_text.empty?
  if /^[0-9]*$/ === string_text
    return string_text.to_i < 120
  else
    return false
  end
end

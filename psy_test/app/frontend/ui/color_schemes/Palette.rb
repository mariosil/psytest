class Palette
  @first_color = { hex: "DCDCDC", rgb: Shoes.rgb(220, 220, 220) }
  @first_background = { hex: "000000", rgb: Shoes.rgb(0, 0, 0) }

  @second_color = { hex: "DCDCDC", rgb: Shoes.rgb(220, 220, 220) }
  @second_background = { hex: "808080", rgb: Shoes.rgb(128, 128, 128) }

  @third_color = { hex: "696969", rgb: Shoes.rgb(105, 105, 105) }
  @third_background = { hex: "A9A9A9", rgb: Shoes.rgb(169, 169, 169) }

  @fourth_color = { hex: "696969", rgb: Shoes.rgb(105, 105, 105) }
  @fourth_background = { hex: "D3D3D3", rgb: Shoes.rgb(211, 211, 211) }

  def initialize(*colors)
    @first_color = colors[0] || @first_color
    @first_background = colors[1] || @first_background
    @second_color = colors[2] || @second_color
    @second_background = colors[3] || @second_background
    @third_color = colors[4] || @third_color
    @third_background = colors[5] || @third_background
    @fourth_color = colors[6] || @fourth_color
    @fourth_background = colors[7] || @fourth_background
    @ok_color = { hex: "#22BB22", rgb: Shoes.rgb(34, 187, 34) }
    @error_color = { hex: "#DD2222", rgb: Shoes.rgb(221, 34, 34) }
  end

  def first_color
    return @first_color
  end
  def first_background
    return @first_background
  end
  def second_color
    return @second_color
  end
  def second_background
    return @second_background
  end
  def third_color
    return @third_color
  end
  def third_background
    return @third_background
  end
  def fourth_color
    return @fourth_color
  end
  def fourth_background
    return @fourth_background
  end
  def ok_color
    return @ok_color
  end
  def error_color
    return @error_color
  end
end

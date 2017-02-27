require_relative 'Palette'

module ColorSchemes
  Modern_and_Clean, Elegant_and_Sophisticated, Clean_Gradients_and_Fresh_Blues, Unexpected_Color_Combinations = 1, 2, 3, 4

  def palette(schema_name)
    @palette = Palette.new

    case schema_name
    when Modern_and_Clean
      colors = []
      colors.push( { hex: 'FFFFFF', rgb: Shoes.rgb(255, 255, 255) } )
      colors.push( { hex: 'E37222', rgb: Shoes.rgb(227, 114, 34) } )
      colors.push( { hex: 'FFFFFF', rgb: Shoes.rgb(255, 255, 255) } )
      colors.push( { hex: '07889B', rgb: Shoes.rgb(7, 136, 155) } )
      colors.push( { hex: 'FFFFFF', rgb: Shoes.rgb(255, 255, 255) } )
      colors.push( { hex: '66B9BF', rgb: Shoes.rgb(102, 185, 191) } )
      colors.push( { hex: 'FFFFFF', rgb: Shoes.rgb(255, 255, 255) } )
      colors.push( { hex: 'EEAA78', rgb: Shoes.rgb(238, 170, 120) } )
      @palette = Palette.new(*colors)
    when Elegant_and_Sophisticated
      colors = []
      colors.push( { hex: 'FFFFFF', rgb: Shoes.rgb(255, 255, 255) } )
      colors.push( { hex: '0B3C5D', rgb: Shoes.rgb(11, 60, 93) } )
      colors.push( { hex: 'FFFFFF', rgb: Shoes.rgb(255, 255, 255) } )
      colors.push( { hex: '328CC1', rgb: Shoes.rgb(50, 140, 193) } )
      colors.push( { hex: 'FFFFFF', rgb: Shoes.rgb(255, 255, 255) } )
      colors.push( { hex: 'D9B310', rgb: Shoes.rgb(217, 179, 16) } )
      colors.push( { hex: 'FFFFFF', rgb: Shoes.rgb(255, 255, 255) } )
      colors.push( { hex: '1D2731', rgb: Shoes.rgb(29, 39, 49) } )
      @palette = Palette.new(*colors)
    when Clean_Gradients_and_Fresh_Blues
      colors = []
      colors.push( { hex: 'FFFFFF', rgb: Shoes.rgb(255, 255, 255) } )
      colors.push( { hex: '77C9D4', rgb: Shoes.rgb(119, 201, 212) } )
      colors.push( { hex: 'FFFFFF', rgb: Shoes.rgb(255, 255, 255) } )
      colors.push( { hex: '57BC90', rgb: Shoes.rgb(87, 188, 144) } )
      colors.push( { hex: 'FFFFFF', rgb: Shoes.rgb(255, 255, 255) } )
      colors.push( { hex: '015249', rgb: Shoes.rgb(1, 82, 73) } )
      colors.push( { hex: 'FFFFFF', rgb: Shoes.rgb(255, 255, 255) } )
      colors.push( { hex: 'A5A5AF', rgb: Shoes.rgb(165, 165, 175) } )
      @palette = Palette.new(*colors)
    when Unexpected_Color_Combinations
      colors = []
      colors.push( { hex: 'FFFFFF', rgb: Shoes.rgb(255, 255, 255) } )
      colors.push( { hex: '6E3667', rgb: Shoes.rgb(110, 54, 103) } )
      colors.push( { hex: 'FFFFFF', rgb: Shoes.rgb(255, 255, 255) } )
      colors.push( { hex: '88D317', rgb: Shoes.rgb(136, 211, 23) } )
      colors.push( { hex: 'FFFFFF', rgb: Shoes.rgb(255, 255, 255) } )
      colors.push( { hex: '1A0315', rgb: Shoes.rgb(26, 3, 21) } )
      colors.push( { hex: 'FFFFFF', rgb: Shoes.rgb(255, 255, 255) } )
      colors.push( { hex: '535353', rgb: Shoes.rgb(83, 83, 83) } )
      @palette = Palette.new(*colors)
    end

    return @palette
  end

end

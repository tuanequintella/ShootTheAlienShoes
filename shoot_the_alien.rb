Shoes.app height: 400, width: 800 do
  background "#0099FF".."#CC9900"
  flow do
    @alien = image "./alien.png"
    @alien.style height: 150
    @alien.move 650, 200
    @alien_direction = -1
    animate do |i|
      @alien.displace(0, (Math.sin(i) * 6).to_i)
    end

    @hint = para "bla"
    @hint.move 620, 90
    @hint.hide
    fill red
    @shot = oval(left: 0, top: 0, radius: 7)
    @shot.hide
    
    @down = button "<<" 
    @angle = edit_line width: 30, text: '0'
    @previous_angle = @angle.text.to_i
    @up = button ">>"
    @fire = button "FIRE!"

    @down.move 12, 365
    @angle.move 60, 365
    @up.move 90, 365
    @fire.move 137, 365

    @gun = image "./gun.png"
    @gun.style width: 130
    @gun.move 35, 230

    @up.click do
      @angle.text = (@angle.text.to_i + 1).to_s
      @gun.rotate -(@previous_angle - @angle.text.to_i)
      @previous_angle = @angle.text.to_i
    end
    @down.click do
      @angle.text = (@angle.text.to_i - 1).to_s
      @gun.rotate -(@previous_angle - @angle.text.to_i)
      @previous_angle = @angle.text.to_i
    end

    @fire.click do
      @gun.rotate -(@previous_angle - @angle.text.to_i)
      @previous_angle = @angle.text.to_i
      @x_impact = 600 + (2 * Math.cos(@angle.text.to_i) * Math.sin(@angle.text.to_i) * 1500)/9.81
      #animation?
      
      @shot.move @x_impact, 240
      @shot.show
      if(@x_impact >= @alien.left && @x_impact <= @alien.left + 92)
        @hint.text = "YOU WIN!"
        @hint.show
      else
        @hint.text = "Try again..."
        @hint.show
        timer(1) do
          @shot.hide
        end
        timer(1) do
          @alien.move(@alien.left + (rand(80..200) * @alien_direction), @alien.top)
          @alien_direction = -1 * @alien_direction
          @hint.hide
        end
      end
    end
  end
end
class Player

  def play_turn(warrior)
    @warrior = warrior
    @health? @health = @health : @health = 0
    @direction ? @direction = @direction : @direction = :backward

      if alone? 
        if hpdrop? || hpfull? 
          warrior.walk!(@direction)
        else
          warrior.rest!
        end
      else
        if feel_captive?
          warrior.rescue!(@direction)
        else
          if hpdrop? && hurt?
            warrior.pivot!
          else
            warrior.attack!(@direction)
          end
        end
      end

    @health = warrior.health
  end
  
  def flip_directions
    if @direction.to_s == "backward" then
      @direction = :forward
    elsif @direction.to_s == "forward" then
      @direction = :backward 
    end
  end

  def alone?
    if @warrior.feel(@direction).wall? then
     flip_directions
     return true
   end
   @warrior.feel(@direction).empty?
  end

  def feel_captive?
    @warrior.feel(@direction).captive?
  end

  def hurt?
    @warrior.health < 6
  end

  def hpfull?
    @warrior.health == 20
  end

  def hpdrop?
    @health > @warrior.health
  end

end

class Player
  attr_accessor :last_turns_health, :direction

  def initialize
    @last_turns_health = 0
    @direction = :backward
  end


  def play_turn(warrior)
    @warrior = warrior

      if alone? 
        react_to_being_alone
      else
        react_to_present_stuff
      end

    @last_turns_health = warrior.health
  end

  def react_to_present_stuff
    if feel_captive?
      @warrior.rescue!(@direction)
    else
      if hpdrop? && hurt?
        @direction = :backward
        @warrior.walk!(@direction)
      else
        @warrior.attack!(@direction)
      end
    end
  end

  def react_to_being_alone
    if hpdrop? || hpfull? 
      @warrior.walk!(@direction)
    else
      flip_directions
      @warrior.rest!
    end
  end
  
  def flip_directions
    if @direction.to_s == "backward" then
      @direction = :forward
    elsif @direction.to_s == "forward" then
      @direction = :backward 
    end
  end

  def alone?
    if @warrior.feel(@direction).to_s == "wall" then
     flip_directions
     return true
   end
   @warrior.feel(@direction).empty?
  end

  def feel_captive?
    @warrior.feel(@direction).captive?
  end

  def hurt?
    @warrior.health < 8
  end

  def hpfull?
    @warrior.health == 20
  end

  def hpdrop?
    @last_turns_health > @warrior.health
  end

end

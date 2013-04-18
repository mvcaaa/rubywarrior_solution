class Player
  attr_accessor  :last_turn_health

  def initialize
    @last_turn_health = 0
  end

  def play_turn(warrior)
    @warrior = warrior
    @direction ? @direction = @direction : @direction = :forward

    look_captive_direction?

    if alone?
      if hpdrop? || hpfull? || !look_enemy?
        if !warrior.look.to_s.include?('Captive') && feel_ranger? && !hurt?
          warrior.shoot!
        else
          warrior.walk!(@direction)
        end
      else
        if !warrior.look.to_s.include?('Captive') && feel_ranger?
          warrior.shoot!
        else
          warrior.rest!
        end
      end
    else
      if feel_captive?
        warrior.rescue!(@direction)
      else
        if hpdrop? && hurt?
          flip_directions
          warrior.walk!
        else
          warrior.attack!(@direction)
        end
      end
    end

    @last_turn_health = warrior.health
  end

  def flip_directions
    if @direction.to_s == 'backward' then
      @direction = :forward
    elsif @direction.to_s == 'forward' then
      @direction = :backward
    end
  end

  def alone?
    if @warrior.feel(@direction).wall?
      flip_directions
      return true
    end
    @warrior.feel(@direction).empty?
  end

  def feel_ranger?
    @warrior.look.to_s.include?('Wizard') || @warrior.look.to_s.include?('Archer')
  end

  def feel_sludge?
    @warrior.look.to_s.include?('Sludge')
  end

  def feel_captive?
    @warrior.feel(@direction).captive?
  end

  def hurt?
    @warrior.health < 5
  end

  def hpfull?
    @warrior.health == 20
  end

  def hpdrop?
    @last_turn_health > @warrior.health
  end

  def look_captive_direction?
    i = 0
    loop do
      flip_directions
      i+=1
      break if @warrior.look(@direction).to_s.include?('Captive') || i > 1
    end
  end

  def look_enemy?
    feel_ranger? || feel_sludge? || hurt?
  end

end

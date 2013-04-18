class Player
  def play_turn(warrior)
    @warrior = warrior
    @health? @health = @health : @health = 0

    if alone? 
      if hpdrop? || hpfull? 
        warrior.walk!
      else
        warrior.rest!
      end
    else
      warrior.attack!
    end

    @health = warrior.health
  end

  def alone?
    @warrior.feel.empty?
  end

  def hurt?
    @warrior.health < 20
  end

  def hpfull?
    @warrior.health == 20
  end

  def hpdrop?
    @health > @warrior.health
  end

end

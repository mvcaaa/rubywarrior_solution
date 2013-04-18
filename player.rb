class Player
  def play_turn(warrior)
    @warrior = warrior
    if alone? 
      if hurt?
        warrior.rest!
      else
        warrior.walk!
      end
    else
      warrior.attack!
    end
  end

  def alone?
    @warrior.feel.empty?
  end

  def hurt?
    @warrior.health < 20
  end


end

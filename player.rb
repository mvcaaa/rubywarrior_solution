class Player
  def play_turn(warrior)
    @warrior = warrior
    if alone? 
      warrior.walk!
    else
      warrior.attack!
    end
  end

  def alone?
    @warrior.feel.empty?
  end

end

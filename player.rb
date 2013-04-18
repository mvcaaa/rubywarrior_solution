class Player

  def play_turn(warrior)
    @health? @health = @health : @health = 0

    if warrior.feel.empty? then 
      if @health > warrior.health || warrior.health == 20 then
        warrior.walk!
      else
        warrior.rest!
      end
    else 
        warrior.attack! 
    end

      @health = warrior.health
  end

end

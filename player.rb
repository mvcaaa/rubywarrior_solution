class Player
  def play_turn(warrior)
    @warrior = warrior
    if alone?
      do_stuff_when_alone?
    else
      warrior.attack!
    end
  end

  def do_stuff_when_alone?
    if hurt?
      @warrior.rest!
    else
      @warrior.walk!
    end
  end

  def alone?
    @warrior.feel.empty?
  end

  def hurt?
    @warrior.health < 20
  end


end

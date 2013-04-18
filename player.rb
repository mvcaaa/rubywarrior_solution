class Player
  attr_accessor :last_turns_health

  def initialize
    @last_turns_health = 0
  end

  def play_turn(warrior)
    @warrior = warrior

    if alone?
      do_stuff_when_alone?
    else
      warrior.attack!
    end

    @last_turns_health = warrior.health
  end

  def do_stuff_when_alone?
    if hpdrop? || hpfull?
      @warrior.walk!
    else
      @warrior.rest!
    end
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
    @last_turns_health > @warrior.health
  end

end

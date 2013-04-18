class Player
  attr_accessor :last_turns_health

  def initialize
    @last_turns_health = 0
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
    if @warrior.feel.captive?
      @warrior.rescue!
    else
      @warrior.attack!
    end
  end

  def react_to_being_alone
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

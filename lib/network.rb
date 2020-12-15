require './lib/character'
require './lib/show'

class Network
  attr_reader :name,
              :shows

  def initialize(name)
    @name = name
    @shows = []
  end

  def add_show(show)
    @shows << show unless @shows.include? show
  end

  def main_characters
    all_main_characters = []

    @shows.each do |show|
      show_main_characters = show.characters.select do |character|
        character.salary > 500_000 && character.name == character.name.upcase
      end

      all_main_characters.concat(show_main_characters) if show_main_characters.length > 0
    end

    all_main_characters
  end

  def actors_by_show
    actors_by_show = Hash.new

    @shows.each do |show|
      actors_by_show[show] = show.actors
    end

    actors_by_show
  end

  def shows_by_actor
    shows_by_actor = Hash.new

    # Get unique list of actors
    actors = []
    @shows.each do |show|
      actors.concat(show.actors)
    end
    actors.uniq!

    actors.each do |actor|
      # TODO ran out of time here
      # Create list of Shows on which `actor` acted
      # Shows_by_actor[actor_name] = list_from_above
    end

    shows_by_actor
  end
end

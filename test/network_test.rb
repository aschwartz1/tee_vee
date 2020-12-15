
require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require './lib/network'

class NetworkTest < Minitest::Test
  def setup
    # Create characters
    @kitt = mock
    add_character_stubs(@kitt, "KITT", "William Daniels", 600_000)
    @michael_knight = mock
    add_character_stubs(@michael_knight, "Michael Knight", "David Hasselhoff", 2)

    # Create show
    @knight_rider = mock
    add_show_stubs(@knight_rider, "Knight Rider", "Glen Larson", [@kitt, @michael_knight])

    # Create network
    @network = Network.new("NBC")
  end

  def add_show_stubs(object, name, creator, characters)
    object.stubs(:name).returns(name)
    object.stubs(:creator).returns(creator)
    object.stubs(:characters).returns(characters)
  end

  def add_character_stubs(object, name, actor, salary)
    object.stubs(:name).returns(name)
    object.stubs(:actor).returns(actor)
    object.stubs(:salary).returns(salary)
  end

  def test_it_exists
    assert_instance_of Network, @network
  end

  def test_readable_attributes
    assert_equal "NBC", @network.name
    assert_equal [], @network.shows
  end

  def test_can_add_shows
    @network.add_show(@knight_rider)

    assert_equal [@knight_rider], @network.shows
  end

  def test_knows_main_characters
    @network.add_show(@knight_rider)
    assert_equal [@kitt], @network.main_characters
  end

  def test_knows_actors_by_show
    # Set up show's `actors` stub
    @knight_rider.stubs(:actors).returns(["William Daniels", "David Hasselhoff"])

    @network.add_show(@knight_rider)

    expected = {
      @knight_rider => ["William Daniels", "David Hasselhoff"]
    }

    assert_equal expected, @network.actors_by_show
  end
end

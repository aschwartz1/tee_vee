require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require './lib/show'

class ShowTest < Minitest::Test
  def setup
    @kitt = mock
    # I'd guess it's bad to pass an instance var into a method, but I wanted to see if I could make this  a b s t r a c t
    create_character_stub(@kitt, "KITT", "William Daniels", 1)

    @michael_knight = mock
    create_character_stub(@michael_knight, "Michael Knight", "David Hasselhoff", 2)

    @show = Show.new("Knight Rider", "Glen Larson", [@kitt, @michael_knight])
  end

  def create_character_stub(object, name, actor, salary)
    object.stubs(:name).returns(name)
    object.stubs(:actor).returns(actor)
    object.stubs(:salary).returns(salary)
  end

  def test_it_exists
    assert_instance_of Show, @show
  end

  def test_readable_attributes
    assert_equal "Knight Rider", @show.name
    assert_equal "Glen Larson", @show.creator
    assert_equal [@kitt, @michael_knight], @show.characters
  end

  def test_calculates_total_salary
    assert_equal 3, @show.total_salary
  end

  def test_knows_highest_paid_actor
    assert_equal "David Hasselhoff", @show.highest_paid_actor
  end

  def test_knows_actors
    expected_actors = ["William Daniels", "David Hasselhoff"]

    assert_equal expected_actors, @show.actors
  end
end

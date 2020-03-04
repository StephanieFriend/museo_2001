require 'minitest/autorun'
require 'minitest/pride'
require './lib/photograph'
require './lib/artist'
require './lib/curator'

class CuratorTest < Minitest::Test

  def setup
    curator = Curator.new
    photo_file_path = './data/photographs.csv'
    @photo_csv = curator.load_photographs(photo_file_path)
  end

  def test_it_exists
    curator = Curator.new

    assert_instance_of Curator, curator
  end

  def test_it_has_attributes
    curator = Curator.new

    assert_equal [], curator.photographs
    assert_equal [], curator.artists
  end

  def test_it_can_add_photographs
    curator = Curator.new
    photo_1 = Photograph.new({
                                        id: "1",
                                        name: "Rue Mouffetard, Paris (Boy with Bottles)",
                                        artist_id: "1",
                                        year: "1954"
                                    })
    photo_2 = Photograph.new({
                                        id: "2",
                                        name: "Moonrise, Hernandez",
                                        artist_id: "2",
                                        year: "1941"
                                    })

    curator.add_photograph(photo_1)
    curator.add_photograph(photo_2)

    assert_equal [photo_1, photo_2], curator.photographs
  end

  def test_it_can_add_artists
    curator = Curator.new
    artist_1 = Artist.new({
                                     id: "1",
                                     name: "Henri Cartier-Bresson",
                                     born: "1908",
                                     died: "2004",
                                     country: "France"
                                 })
    artist_2 = Artist.new({
                                     id: "2",
                                     name: "Ansel Adams",
                                     born: "1902",
                                     died: "1984",
                                     country: "United States"
                                 })

    curator.add_artist(artist_1)
    curator.add_artist(artist_2)

    assert_equal [artist_1, artist_2], curator.artists
  end

  def test_it_can_find_artist_by_id
    curator = Curator.new
    artist_1 = Artist.new({
                              id: "1",
                              name: "Henri Cartier-Bresson",
                              born: "1908",
                              died: "2004",
                              country: "France"
                          })
    artist_2 = Artist.new({
                              id: "2",
                              name: "Ansel Adams",
                              born: "1902",
                              died: "1984",
                              country: "United States"
                          })

    curator.add_artist(artist_1)
    curator.add_artist(artist_2)

    assert_equal artist_1, curator.find_artist_by_id("1")
    assert_equal artist_2, curator.find_artist_by_id("2")
  end

  def test_it_can_return_photographs_by_artists
    curator = Curator.new
    photo_1 = Photograph.new({
                                        id: "1",
                                        name: "Rue Mouffetard, Paris (Boy with Bottles)",
                                        artist_id: "1",
                                        year: "1954"
                                    })
    photo_2 = Photograph.new({
                                        id: "2",
                                        name: "Moonrise, Hernandez",
                                        artist_id: "2",
                                        year: "1941"
                                    })
    photo_3 = Photograph.new({
                                        id: "3",
                                        name: "Identical Twins, Roselle, New Jersey",
                                        artist_id: "3",
                                        year: "1967"
                                    })
    photo_4 = Photograph.new({
                                        id: "4",
                                        name: "Monolith, The Face of Half Dome",
                                        artist_id: "3",
                                        year: "1927"
                                    })
    artist_1 = Artist.new({
                                     id: "1",
                                     name: "Henri Cartier-Bresson",
                                     born: "1908",
                                     died: "2004",
                                     country: "France"
                                 })
    artist_2 = Artist.new({
                                     id: "2",
                                     name: "Ansel Adams",
                                     born: "1902",
                                     died: "1984",
                                     country: "United States"
                                 })
    artist_3 = Artist.new({
                                     id: "3",
                                     name: "Diane Arbus",
                                     born: "1923",
                                     died: "1971",
                                     country: "United States"
                                 })

    curator.add_artist(artist_1)
    curator.add_artist(artist_2)
    curator.add_artist(artist_3)
    curator.add_photograph(photo_1)
    curator.add_photograph(photo_2)
    curator.add_photograph(photo_3)
    curator.add_photograph(photo_4)

    expected = {
        artist_1 => [photo_1],
        artist_2 => [photo_2],
        artist_3 => [photo_3, photo_4]
    }

    assert_equal expected, curator.photographs_by_artist
  end

  def test_it_can_return_artists_with_multiple_photographs
    curator = Curator.new
    photo_1 = Photograph.new({
                                 id: "1",
                                 name: "Rue Mouffetard, Paris (Boy with Bottles)",
                                 artist_id: "1",
                                 year: "1954"
                             })
    photo_2 = Photograph.new({
                                 id: "2",
                                 name: "Moonrise, Hernandez",
                                 artist_id: "2",
                                 year: "1941"
                             })
    photo_3 = Photograph.new({
                                 id: "3",
                                 name: "Identical Twins, Roselle, New Jersey",
                                 artist_id: "3",
                                 year: "1967"
                             })
    photo_4 = Photograph.new({
                                 id: "4",
                                 name: "Monolith, The Face of Half Dome",
                                 artist_id: "3",
                                 year: "1927"
                             })
    photo_5 = Photograph.new({
                                 id: "5",
                                 name: "Blah",
                                 artist_id: "2",
                                 year: "1923"
                             })
    artist_1 = Artist.new({
                              id: "1",
                              name: "Henri Cartier-Bresson",
                              born: "1908",
                              died: "2004",
                              country: "France"
                          })
    artist_2 = Artist.new({
                              id: "2",
                              name: "Ansel Adams",
                              born: "1902",
                              died: "1984",
                              country: "United States"
                          })
    artist_3 = Artist.new({
                              id: "3",
                              name: "Diane Arbus",
                              born: "1923",
                              died: "1971",
                              country: "United States"
                          })

    curator.add_artist(artist_1)
    curator.add_artist(artist_2)
    curator.add_artist(artist_3)
    curator.add_photograph(photo_1)
    curator.add_photograph(photo_2)
    curator.add_photograph(photo_3)
    curator.add_photograph(photo_4)

    assert_equal ["Diane Arbus"], curator.artists_with_multiple_photographs

    curator.add_photograph(photo_5)

    assert_equal ["Ansel Adams", "Diane Arbus"], curator.artists_with_multiple_photographs
  end

  def test_it_can_return_photographs_taken_from_a_specific_country
    curator = Curator.new
    photo_1 = Photograph.new({
                                 id: "1",
                                 name: "Rue Mouffetard, Paris (Boy with Bottles)",
                                 artist_id: "1",
                                 year: "1954"
                             })
    photo_2 = Photograph.new({
                                 id: "2",
                                 name: "Moonrise, Hernandez",
                                 artist_id: "2",
                                 year: "1941"
                             })
    photo_3 = Photograph.new({
                                 id: "3",
                                 name: "Identical Twins, Roselle, New Jersey",
                                 artist_id: "3",
                                 year: "1967"
                             })
    photo_4 = Photograph.new({
                                 id: "4",
                                 name: "Monolith, The Face of Half Dome",
                                 artist_id: "3",
                                 year: "1927"
                             })
    artist_1 = Artist.new({
                              id: "1",
                              name: "Henri Cartier-Bresson",
                              born: "1908",
                              died: "2004",
                              country: "France"
                          })
    artist_2 = Artist.new({
                              id: "2",
                              name: "Ansel Adams",
                              born: "1902",
                              died: "1984",
                              country: "United States"
                          })
    artist_3 = Artist.new({
                              id: "3",
                              name: "Diane Arbus",
                              born: "1923",
                              died: "1971",
                              country: "United States"
                          })

    curator.add_artist(artist_1)
    curator.add_artist(artist_2)
    curator.add_artist(artist_3)
    curator.add_photograph(photo_1)
    curator.add_photograph(photo_2)
    curator.add_photograph(photo_3)
    curator.add_photograph(photo_4)

    assert_equal [photo_2, photo_3, photo_4], curator.photographs_taken_by_artist_from("United States")
    assert_equal [],  curator.photographs_taken_by_artist_from("Argentina")
  end

  # def test_it_can_load_csv_photographs
  #   curator = Curator.new
  #
  #
  # end
end


# pry(main)> require './lib/curator'
#
# pry(main)> curator = Curator.new
# #=> #<Curator:0x00007fd98685b2b0...>
#
# pry(main)> curator.load_photographs('./data/photographs.csv')
#
# pry(main)> curator.load_artists('./data/artists.csv')
#
# pry(main)> curator.photographs_taken_between(1950..1965)
# #=> [#<Photograph:0x00007fd986254740...>, #<Photograph:0x00007fd986254678...>]
#
# pry(main)> diane_arbus = curator.find_artist_by_id("3")
#
# pry(main)> curator.artists_photographs_by_age(diane_arbus)
# => {44=>"Identical Twins, Roselle, New Jersey", 39=>"Child with Toy Hand Grenade in Central Park"}
# ```

<<-WELCOME

This is a straight up Ruby excercise used to both demonstrate the use of the Proof library as well as to explore some
design concepts

Some of the constraints for the excercise are as follows:

- Favour composition over monkey patching

- Enumerable (Limited to use of just the following methods)
  - each
  - sort
  - count
  - include?

- Array (Limited to use of just the following methods)
  - dup
  - <<

- lib/genres.rb and lib/studios.rb cannot be modified
  - You also cannot monkey patch these modules

WELCOME

require_relative '../proofs_init'

title 'General [MovieLibrary] functionality'

module MovieLibraryProofs
  module Builder
    extend self

    def library(movies=[])
      list = movies.dup
      return ::Movies::MovieLibrary.new(list), list
    end

    def movie(details={})
      ::Movies::Movie.new(details)
    end
  end
end

def build 
  MovieLibraryProofs::Builder
end

heading 'General Movie Functionality' do
  proof 'Returns a list of all its movies that is not its internal data' do
    sut, movie_list = build.library

    result = sut.all

    result.prove { object_id != movie_list.object_id }
  end

  proof 'Can return a list of all of its movies' do
    sut, movie_list = build.library

    first_movie = build.movie
    second_movie = build.movie

    movie_list.push(first_movie)
    movie_list.push(second_movie)

    results = sut.all

    results.prove { only_contains?(first_movie, second_movie) }
  end

  proof 'Movie can be added to its list of movies' do
    sut, movie_list = build.library

    movie = build.movie

    sut.add(movie)

    movie_list.prove { include?(movie) }
  end

  proof 'Cannot add multiple copies of the same movie' do
    sut, movie_list = build.library

    movie = build.movie
    movie_list << movie

    sut.add(movie) 

    movie_list.prove { count == 1 }
  end

  proof 'Cannot add two movies that have the same title (logically the same)' do
    sut, movie_list = build.library

    another_copy_of_speed_racer = build.movie(:title => 'Speed Racer')
    speed_racer = build.movie(:title => 'Speed Racer')

    movie_list.push(speed_racer)

    sut.add(another_copy_of_speed_racer)

    movie_list.prove { count == 1 }
  end

  heading 'searching and sorting' do
    indiana_jones_and_the_temple_of_doom = build.movie ({ 
      :title => "Indiana Jones And The Temple Of Doom", 
      :release_date => Time.new(1982, 1, 1), 
      :genre => Movies::Genres::ACTION, 
      :studio => Movies::Studios::UNIVERSAL, 
      :rating => 10
    })

    cars = build.movie({
      :title => "Cars", 
      :release_date => Time.new(2004, 1, 1), 
      :genre => Movies::Genres::KIDS, 
      :studio => Movies::Studios::PIXAR, 
      :rating => 10
    })

    your_mine_and_ours = build.movie({
      :title => "Yours, Mine and Ours", 
      :release_date => Time.new(2005, 1, 1), 
      :genre => Movies::Genres::COMEDY, 
      :studio => Movies::Studios::MGM, 
      :rating => 7
    })

    shrek = build.movie({
      :title => "Shrek", 
      :release_date => Time.new(2006, 5, 10), 
      :genre => Movies::Genres::KIDS, 
      :studio => Movies::Studios::DREAMWORKS, 
      :rating => 10
    })

    a_bugs_life = build.movie({
      :title => "A Bugs Life", 
      :release_date => Time.new(2000, 6, 20), 
      :genre => Movies::Genres::KIDS, 
      :studio => Movies::Studios::PIXAR, 
      :rating => 10
    })

    theres_something_about_mary = build.movie({
      :title => "There's Something About Mary", 
      :release_date => Time.new(2007, 1, 1), 
      :genre => Movies::Genres::COMEDY, 
      :studio => Movies::Studios::MGM, 
      :rating => 5
    })

    pirates_of_the_carribean = build.movie({
      :title => "Pirates of the Carribean",
      :release_date => Time.new(2003, 1, 1), 
      :genre => Movies::Genres::ACTION, 
      :studio => Movies::Studios::DISNEY, 
      :rating => 10
    })

    original_movies = [indiana_jones_and_the_temple_of_doom, cars,a_bugs_life,theres_something_about_mary,pirates_of_the_carribean,your_mine_and_ours,shrek]

    heading 'Searching for movies' do
      proof 'Can find all pixar movies' do
        sut, movie_list = build.library(original_movies)

        results = sut.all_movies_published_by_pixar

        results.to_a.prove { eql?([ cars, a_bugs_life])}
      end

      proof 'Can find all movies published by pixar or disney' do
        sut, movie_list = build.library(original_movies)

        results = sut.all_movies_published_by_pixar_or_disney

        results.prove { contains?(cars, a_bugs_life, pirates_of_the_carribean)}
      end

      proof 'Can find all movies not published by pixar' do
        sut, movie_list = build.library(original_movies)

        results = sut.all_movies_not_published_by_pixar

        [cars,a_bugs_life].each do |item|
          results.prove { ! contains?(item) }
        end

        results.prove { ! contains?(cars, a_bugs_life)}
      end

      proof 'Can find all movies released after 2004' do
        sut, movie_list = build.library(original_movies)

        results = sut.all_movies_published_after_year(2004)

        results.prove { contains?(your_mine_and_ours, shrek, theres_something_about_mary) }
      end

      proof 'Can find all movies released between 1982 and 2003 - Inclusive' do
        sut, movie_list = build.library(original_movies)

        results = sut.all_movies_published_between_years(1982, 2003)

        results.prove { contains?(indiana_jones_and_the_temple_of_doom, a_bugs_life, pirates_of_the_carribean) }
      end
    end

    heading 'Sorting movies' do
      proof 'Sorts all movies by descending title' do
        sut, movie_list = build.library(original_movies)
        comparer = Compare.by_descending.key(:title)

        results = sut.all.filter_using(comparer)

        results = sut.sort_all_movies_by_title_descending

        results.prove { eql? [theres_something_about_mary, your_mine_and_ours, shrek, pirates_of_the_carribean, indiana_jones_and_the_temple_of_doom, cars, a_bugs_life] }
      end

      proof 'Sorts all movies by ascending title' do
        comparer = Compare.by.key(:title)

        results = sut.all.filter_using(comparer)


        results.prove { eql? [a_bugs_life, cars, indiana_jones_and_the_temple_of_doom, pirates_of_the_carribean, shrek, your_mine_and_ours, theres_something_about_mary] }
      end

      proof 'Sorts all movies by descending release date' do
        sut, movie_list = build.library(original_movies)

        results = sut.sort_all_movies_by_release_date_descending

        results.prove { eql? [theres_something_about_mary, shrek, your_mine_and_ours, cars, pirates_of_the_carribean, a_bugs_life, indiana_jones_and_the_temple_of_doom] }
      end

      proof 'Sorts all movies by ascending release date' do
        sut, movie_list = build.library(original_movies)

        results = sut.sort_all_movies_by_release_date_ascending

        results.prove { eql? [indiana_jones_and_the_temple_of_doom, a_bugs_life, pirates_of_the_carribean, cars, your_mine_and_ours, shrek, theres_something_about_mary] }
      end

      proof 'Sorts all movies by preferred studios and release date ascending' do
<<-SPEC
 In this proof the results of the movies should be sorted as follows:
  MGM Movies
   - By ascending release date
  Pixar Movies
   - By ascending release date
  Dreamworks Movies
   - By ascending release date
  Universal Movies
   - By ascending release date
  Disney Movies
   - By ascending release date

SPEC
        
        compound_comparison = Compare.by.key(:studio,
                                         Movies::Studios::MGM,
                                         Movies::Studios::MGM,
                                         Movies::Studios::MGM,
                                         Movies::Studios::MGM,
                                         Movies::Studios::MGM,
                                        ).then.by.map do |movie|
          movie.release_date
        end


        sut, movie_list = build.library(original_movies)

        results = sut.all.filter_using(compound_comparison)

        results.prove { eql? [your_mine_and_ours, theres_something_about_mary, a_bugs_life, cars, shrek, indiana_jones_and_the_temple_of_doom, pirates_of_the_carribean] }
      end
    end
  end
end

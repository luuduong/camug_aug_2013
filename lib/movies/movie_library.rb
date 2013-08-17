module Movies
  class MovieLibrary
    include ::Filtering
    attr_reader :movies

    def initialize(movies)
      @movies = movies
    end

    def add(movie)
      movies.push(movie) unless movies.include? movie
    end

    def all
      movies.dup
    end

    def each(&block)
      movies.each(&block)
    end

    def all_movies_published_by_pixar
      filter do |movie|
        movie.studio == Studios::PIXAR
      end
    end

    def all_movies_published_by_pixar_or_disney
      filter do |movie|
        [Studios::PIXAR, Studios::DISNEY].include?(movie.studio)
      end
    end

    def all_movies_not_published_by_pixar
      filter do |movie|
        movie.studio != Studios::PIXAR
      end
    end

    def all_movies_published_after_year(year)
      filter do |movie|
        movie.release_date.year > year
      end
    end

    def all_movies_published_between_years(start_year, end_year)
      filter do |movie|
        year = movie.release_date.year
        year >= start_year && year <= end_year
      end
    end

    def all_kid_movies
      filter do |movie|
        movie.genre == Genres::KIDS
      end
    end

    def all_action_movies
      filter do |movie|
        movie.genre == Genres::ACTION
      end
    end

    def sort_all_movies_by_title_ascending
      raise NotImplementedError
    end

    def sort_all_movies_by_title_descending
      raise NotImplementedError
    end

    def sort_all_movies_by_release_date_ascending
      raise NotImplementedError
    end

    def sort_all_movies_by_release_date_descending
      raise NotImplementedError
    end

    def sort_all_movies_by_studio_preference_and_year_published
      raise NotImplementedError
    end
  end
end

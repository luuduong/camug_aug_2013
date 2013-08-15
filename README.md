#Camug Presentation - August 2013

##Presenter: Jean-Paul S. Boodhoo
##[Develop With Passion®](http://www.developwithpassion.com)


#Getting Started

##Requirements

* Recommend the use of a ruby version manager (such as [RVM](https://rvm.io/))
* Clone this repository (I recommend cloning it to a path without spaces)
* Navigate to the cloned repo folder in your shell
* Run the following commands:
  - . ./cenv
  - ./run_first
  - ./start_new_exercise

* Verify that everything is working by running the tests:
  - bundle exec ruby proofs/suite.rb 
  - You should see output similar to the following:
    <pre>
    <code>
    GENERAL [MOVIELIBRARY] FUNCTIONALITY

    General Movie Functionality
    Pass: Returns a list of all its movies that is not its internal data
    Pass: Can return a list of all of its movies
    Pass: Movie can be added to its list of movies
    Pass: Cannot add multiple copies of the same movie
    Pass: Cannot add two movies that have the same title (logically the same)

    searching and sorting

    Searching for movies
    /Volumes/machd/to_backup/repositories/presentations/camug_aug_2013/lib/movies/movie_library.rb:18:in `all_movies_published_by_pixar': undefined method `filter' for #<Array:0x007f966aa00a70> (NoMethodError)
            from /Volumes/machd/to_backup/repositories/presentations/camug_aug_2013/proofs/lib/movie_library.rb:168:in `block (4 levels) in <top (required)>'
            f
    </code>
    </pre>




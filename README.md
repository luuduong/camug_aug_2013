#Camug Presentation - August 2013 test edit

##Presenter: Jean-Paul S. Boodhoo
##[Develop With Passion®](http://www.developwithpassion.com)


#Getting Started

##Send me your github username (create an account if you don't have one) - <mailto:jp@developwithpassion.com>

##Requirements

* Recommend the use of a ruby version manager (such as [RVM](https://rvm.io/))
* Fork this repository (using the github account your provided me by email)
* Clone your fork of this repository (I recommend cloning it to a path without spaces)
* Navigate to the cloned repo folder in your shell
* Run the following commands:

  ```bash
   . ./cenv
   ./run_first
   ./start_new_exercise
  ```

* Verify that everything is working by running the tests:

  ```bash
   bundle exec ruby proofs/suite.rb 
  ```
  - You should see output similar to the following:

    ```bash
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
    ```


We'll pick up everything else once at the beginning of the session.


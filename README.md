# Samuel O'Donnell T1A3 - Terminal Application: - Apprenos 

### Table of Contents
```
- Links
  - Github repo
  - Trello Board
  - Control Flow Diagram
- Software Development Plan
  - Application description
  - The Why
  - Reason for Development
  - Target Audience
  - Use
- Features
  - Login system with username and password requirements
  - Data persistence
  - Dyanmic Content / Add Your Own Flashcard Modules
  - Flash Card Display
  - Profile Page
- User Interaction and Experience
  - Controls
  - How Each Feature is used
  - Error Handling
- Implementation Plan
  - Roadmap
  - MVP
  - The 'Sprinkes'
- Documentation
  - Installation
  - How to use the App
  - Dependencies
  - System / Hardware Requirements
- Tests
- Change logs

```

## Links

### Github Repo
https://github.com/PotatoBaron89/T1A3_Terminal_App

---

### Trello Board

https://trello.com/b/VfMGtHVd/t1a3-terminal-app

---

### Control Flow Diagram

[Control Flow Diagram](https://viewer.diagrams.net/?tags=%7B%7D&highlight=0000ff&edit=_blank&layers=1&nav=1&title=T1A3_Samuel_ODonnell_Flow_Chart#Uhttps%3A%2F%2Fdrive.google.com%2Fuc%3Fid%3D1-uXS5uDvh4fZRWFyCV8ZCBZFDszmmXYX%26export%3Ddownload)

---

## Software Development Plan

### Application Description

This terminal app is designed to serve as the foundations to a larger language learning application.  For now, it is built around learning French, although this can be easily exampled.  It allows users to create an account, have their session progress and relevant information cached.

Through it, they will be able to use the different tools to help them in their quest to learn and master French.

The application allows the user to load in any compatible json module which will be interpreted by the app and provide learning content.

### The Why

Language learning is a difficult process, but through the use of technology we can help create tools to make it less painful.  Whilst applications like this aren't useful for learning pronunciation they can provide a very useful tool for learning, recognising and remembering new vocabulary.

So ultimately, the goal of this application is to try and make the process of learning more efficent and enjoyable.


### - Reason for Development

There are several reasons why I have undergo this project.


- It serves a real world purpose; that of providing a tool to help others to learn and improve. Further, in my eyes providing tools to help others learn is incredibly satisfying.
- I've long wanted to create a fully-featured application that is free for anyone to use and can assist in the learning of others.  This is step one in that direction and will provide a lot of useful experience and information as to what I should expect with a larger scale version of this, and things I ought to take into account.

### Target Audience

- The target audience is anyone who wishes to learn French, and is looking for a tool to help them learn and master vocabulary in French.
- Anyone looking to use flashcards can easily create their own and have the application parse and present them.

### Use

As mentioned, the main mechanic at this stage is that of flashcards. The underlying point being to learn and master new vocabulary.  Moreover, the application seeks to provide useful tools to assist them with this process.

The application is designed to be run with a reasonably large console size.  If you are experience issues with content displaying strangely, try to increase the window size.

Once the user logs in, they will be created with the main menu where they can choose what they would like to do.  This including choosing a topic to study based on the content they have.  From there they can study vocabulary through flashcards.

Alternatively, they have the option to view the profile page, where they can view their username, change their password and / or display name.  Furthermore, they can view a list of all the previous words they have studied here.

---
## Features

### Feature 1 |    Flashcards

As mentioned above, the applications primary feature is that of flash cards.  Each card will be randomly pulled based on the chosen options (lesson and subcatagory).  There are plans to add more features, such as multiple choice but they are still under development.

### Feature 2 |    User Accounts
Anyone can easily setup their own accounts and begin using the application.  The inclusion of accounts allows the application to track a user's progress and relevant stats between sessions.

### Feature 3 | Dynamic Content System
Allows anyone to quickly make their own flashcard modules to use within the application.  Provided it follows the style mentioned in the documentation below, the application will parse it and present all of its contents for use.  Each file will be given its own menu option, using that files Title key as the description.

### Feature 4 | Module Selection
In addition to the above, the application will list each each subcategory listed within the flashcard module.  For example, you may have a flashcard.json file listing animals.  Then you may have sections on domestic animals, farm animals, zoo animals, sea creatures etc.  This allows the user to quickly hone in on the content they wish to learn.

### Feature 5 | Profile
The profile form allows the user to quickly access stored information, such as their username, display name, words learnt (listed in both English and French).  This form also provides a means of updating their Display name.  Finally, they can change their password here, which will require that they verify their current password.

### Feature 6 | Security

Because user security is paramount, we take the handling of your senstive data seriously.  For this reason all passwords are hashed using `bcrypt`, so that your senstive data is kept sured.

---
## User Interaction

### Controls

At every step, the goal has been to keep the application easily understandable and as much as possible, consistent. This

**Menus**

↑ Arrow will move the selection upwards

↓ Will move the selection downwards.

Space / Enter will select an option

**Prompts**

Space / Enter will allow you to move through prompts / messages or anywhere else.

**Flash Cards**

Note that the options for flashcards are also displayed at the top of the console when in flashcard mode. This allows

`C`: Back - Returns to the subcategory you came from

`M`: Menu - Returns you to the main menu

`H`: Help - Displays further information

`↑`: Correct - Marks your result as being correct.

`↓`: Incorrect - Marks your result as incorrect.

`Q`: Quit - Quits the application, no data will be lost.

``` ` ```: Debug-mode (Dev mode only).  Currently only works in flashcard mode, as it is not hooked into the gem that controls the menus. 


### How each feature is used



### Error Handling
User related errors will provide clear response to the user.

- Registration
  - Will provide error message if the username is < 3 characters long, letting them know that it must be at least 3 characters.  They will then be another attempt.
  - Will provide error message if password is < 6 characters, letting them know of these requirements and giving them another chance to input their password.

- Change Password
  - Similar to registration, new password must be 6 or more characters. If a shorter input is given, the user is given an error message informing them of the minimum requirements for a valid password.  They will be given an attempt to try again or cancel.
  - Option to abort process is given after entering incorrect current password.
  - Option to abort process is given after entering invalid new password.

- Change Display Name
  - If a display name of 0 characters is given, user is informed that display name must be at least 1 character long.  They will be given the option to try again or return.

- Dependencies
  - When the application can't find required files, it will throw a Load error and give the information on how to resolve the issue `bundle install`
- Loading user_data, error is given to the user if invalid json is found in their save.  It will inform them and will reset the file.  Unfortunately, all previous data is lost.
---
## Implementation Plan

### MVP

Features are to be implemented in blocks in the order as follows.

First we need to setup our sign-in system, save / load functionality and session data.

 - handling login, registration, appending new users, hashing passwords, checking a username already exists.
 - This section requires
    - **Membership Module**
      - `authenticate_user(username, password` responsible for checking provided username and password against database.
      - `verify_hash_digest(password)` used to check given password against the encrypted version.
      - `login` used to handle login logic. It makes a call to `authenticate_user` to verify.
      - `register` method to handle registration. Makes calls to `Utils.request_username`, `Utilities.append_data` and `Utilities.salt_data` amonsgt others. Provide all checks are passed, returns an authenticated session.
      - `setup_db` responsible for checking our pseudo-db exists, and creating one if it does not.
      - Nested **Utils Modlule**
        - `request_username` Since this will likely be reused, have a function to handle gettign and retreiving of username, requiring validation (3 or more characters)
        - `request_password` same as above but will hide user input with `Utilities.hide_req_input`.  Also responsible for validation. Returns password once validated.
        - `user_exists?(username)` checks if the given username exists in the database.
        
    - **Session class** to handle the users session information.  Session class is a critical component used through the entire application.  It is used to handle temporary user information and session details necessary to the operation of the app.
      - `change_display_name` this method gives the user the ability to change their current username.
      - `sign_out` handles logic of signing the user out.  Done by changing `is_authenticated` to false.
      - `change_password` handles the logic, input and display of letting the user change their password.
      - `USER` object, containing procs:
        - `setup_user_cache` creates a local save file for the user, if one does not already exist.
        - `user_data_path` returns the path to the users save file in string form.
        - `user_dir_path` returns a path the `dir` where saves are stored.
        - `word_add_to_vocab(session, word)` adds new vocab the user has seen to their session cache.
        - `save_session(session)` responsible  for saving pertinent data to the users local save.
        - `load_session(session)` responsible for loading local save if one exists. Uses existing session data to find the link.
        - `get_diff_vocab(session, save_path)` will compare vocab from session and save and return unique.
    - **Utility module** which provides access to methods such as:
        - `get_lesson_links` (filepath to lessons): Automatically finds lessons by searching specified directory and looking for files with a .json extension. Not responsible for verifying if they are valid json files.
        - `get flashcards_links` (filepath to flashcards): Same as above, but looking in a different directory for flashcards.  Not responsible for validating the json files.
        - `user_db_link` which stores a link to the psuedo_db for later use. `'../cache/place_holder_db/users.json'
        - `user_db_get`, opens, parses and returns the contents of the pseudodb.
        - `load_json(file)` handles single links and arrays of links.  Will parse all given links and returns each of them.
        - `hide_req_input` custom method to get userinput, but hide what they are typing.  Returns the users input.  Used for passwords.
        - `check_args` - responsible for checking and processing args given in command prompt.
        - NESTED: Data Module
          - `append_data`: Used to add new data to given json file.

This is used to allow the user to create an account, have their saves loaded and saved and more.  Will setup session information to use throughout the app as mentioned earlier.

  
2. Since most menus require pulling data to populate them.  We need to create some sample flashcard.json files.
   - **Curriculum Class**: 
     - Child class, ***FlashcardContent***
     - Child class, ***Lesson***
   - Curriculum class is responsible for storing arrays of its two child classes.
   - `FlashcardContent` caches metadata about the flashcard module upon initialization.
     - Has a method `load_flashcard(sect_index)` which is responsible for loading specific section of content for use.
   - `Lessons` caches metadata about the lesson upon initialization.
     - Has a method `load_lesson(sect_index)` which is responsible for loading specific section of content for use.


Next we need to create and setup our menus and other displays which is handled with `DisplayMenus` module.
1. `display_splash` prints the splashscreen.
2. Sign-in is handled with `sign_in`
3. Main Menu: handled with `main_menu`, links to the following
   - Study (devmode only, as it is under development.) -> calls `study_menu`
   - Flashcards -> calls `flash_card_menu`
   - Profile -> calls `show_profile`
   - About -> calls anon proc
   - Logout -> set `session.is_authenticated = false`
   - Exit -> run `quit`
4. Flashcard menu:
    - List every compatible json module found.  Should only pull metadata from each lesson at this stage, not have all information from all lessons in system memory!
    - Back -> `main_menu`
5. Profile Menu:
    - Username -> Not clickable
    - Change Display Name -> calls `session.change_display_name`
    - Change Password -> calls `session.change_password`
    - Known Words [qty: 10] -> calls `list_known_words`

From here we need to setup the handling of our main feature.

6. Setup flashcard system.

When a selection is made, pass the `index` (of file) `sect_index` (module within file) and `session` info and call `flash_card_controller` which is responsible for core loop of flashcards.

Load Content then begin a loop `active`, whislt active:
- Generate random number between 0 and number of flashcards in the loaded module.
- Check this word != last word, generate new number if it is.
- Call `word_add_to_vocab` and `save_session`
- Call `DisplayMenus.prompt_flashcard(word_en, word_fr)`
  - prompt_flashcard listens for users response
  - Return true / false, which is passed to `active` based on user response.



### The 'Sprinkles' / Roadmap

Learning Tools:
- Study Module: Which allows you to practice sentences in a controlled manner.  To be built after MPV is completed. EG.

Start with:
```
{ "It is [:adj :desc]":  "c'est [:adj :desc]"}
```
Then:
```
{ "It isn't [:adj :desc]":  "Ce n'est pas [:adj :desc]"}
```
Then: 
```
{ "It is a [:noun :c]":  "Ce n'est pas [:noun :c]"},
{ "It isn't a [:noun :c]":  "Ce n'est pas [:noun :c]"}
```

Then:
```
{ "It is a [:adj] [:noun :c]":  "C'est [:un] [:noun]"},
{ "It is a [:adj] [:noun :c]":  "C'est [:un] [:noun] [:adj]"},
{ "It is not a [:adj] [:noun :c]":  "Ce n'est pas [:un] [:noun] [:adj]"},
{ "It is not a [:adj] [:noun :c]":  "Ce n'est pas [:un] [:noun] [:adj]"}
```

Where marked worked (eg `[:adj :desc]`) are replaced with matching words from the users known vocabulary.  Every lesson has its built in vocab so that if the user has no matching words, there is still some that can be subbed in too.



Profile:
   - Change display name
   - Change password


---
## Documentation

### Installation

You can run this application by cloning this Git Repo.  Then, dependencies will need to be installed, which can be done by using `bundle install`.

A simpler way is to run the `run.sh` script found in `./bin` which will handle this for you.

`run.sh` will lead you through a set of options allowing you to set up the application to your needs.

N.B. Crashes are likely if you are **not** in WSL.

### How to use the app

Next, go into the `app` directory using `cd app` from the root directory.  Next, type `ruby index.rb` a long with any arguments you want to pass (listed below.)

**Valid Arguments**


  - `-d` for dev mode
  - `-h` or `-help` for help (lists different options)
  - `-login user123 password123` to log on
  - `-splash` to skip the splash screen.

Commands can be in any order, although username and password must directly follow -login.

Eg: `ruby index.rb -d -login user123 password123 -splash`


### Dependencies

- colorize (~> 0.8.1)
- columnize (~> 0.9.0)
- dotenv (~> 2.7)
- json (~> 2.5)
- remedy (~> 0.3.0)
- tty-box (~> 0.7.0)
- tty-font (~> 0.5.0)
- tty-prompt (~> 0.23.1)

Development:
- bcrypt (~> 3.1)
- byebug
- capybara
- mutant-rspec
- rspec-core

### System / Hardware Requirements

Since TTY-Prompt is used to display menus, there is functionality loss when running on Windows using `git bash`. 

For more help with getting the application to work in bash, see [here](https://github.com/piotrmurach/tty-prompt#windows-support).

`WSL` will work correctly.

## Tests

There are currently two tests that can be run.  
- One checks the membership module, and that is properly returns sessions as expected.
- The second checks the Curriculum class and its two subclasses, which is were all the core content is stored.

1. `rspec spec/unit/Membership_spec.rb` when run from the root dir will check the following:
   - That a session with a return session where is_authenticated is set to false will properly yield a false value to prevent a session without valid authentication from proceeding.  The membership class is essential for handling user authentication and establlishing sessions.
   - The second is the inverse of the above.
   - The fourth will check that we can properly check a string input against a stored hashed password and determine if they match.

2. `rspec Curriculum_spec.rb` is the second test, which will check the following:
   - That `Curriculum.setup_flashcard_lists` and `Curriculum.setup_flashcard_lists` will setup an array, and that these arrays will contain Lessons (class) and FlashcardContent (class) as expected.  The Curriculum class is essential to the app's ability to properly store and serve content to the user.

---
## Change Logs

### Change Log: 0.020

- Added a bash script `run.sh` which can be found in `./bin/`.  It will handle installation of dependencies and setting up the application.
- Fixed bug where pushing `h` whilst in flashcard mode would return the user back to the main menu.
- Updated Documentation.

### Change Log: 0.019

- Updated readme / documentation.
- Fixed bug with the `Curriculum` test caused by a require_relative pointing to the wrong location.


### Change Log: 0.018
- Added ability to change password
- Change username and password is more robust. Will now handle invalid inputs and give the user options to abort.
- Fixed memory leak associated with leaving flashcard mode using `c` or `m` and corresponding incorrect behavior whilst navigating after leaving flashcard mode.
- Removed unused methods
- Modified only_listen method to no longer loop, but return the first keypress.

- Additional Error handling
  - Reset corrupted save files and reload.
  - Change password.
  - Change display name.
  - Loading external gems

 ### Change Log: 0.017

- Added testings for:
  - Membership modules: can be run with `rspec Membership_spec.rb` which will check that valid and invalid sessions are returned based on input.
  - Curriculum and its subclasses: run with `rspec Curriculum_spec.rb` which will test that went initialized, it should generate arrays of `Lessons` and `FlashcardContent`.

- Removed deprecated functions.

### Change Log: 0.016

- Added word count to modules, eg

`Animals    Words: 54
 Articles menagers   Words: 47`
- Added checks before loading content, will validate that lessons / flashcards json files have the correct formatting before pushing them to list.
- Removed unnecessary comments and cleaned up files somewhat.


### Change Log: 0.015

- Began adding proper documentation.
- Implemented Command args
  - -d for dev mode
  - -h or -help for help (lists different options)
  - -login user123 password123 to log on
  - -splash to skip the splash screen.
  - Commands can be in any order, although username and password must directly follow -login.

* Fixed bug with flashcards when in dev mode
* Fixed bug with displaying known words
* Fixed a bug with return to main menu from About
* Fixed bug where data was incorrectly stored as object, not array
* Fixed bug when selecting a known word in profile

### Change Log: 0.014
* Under-development features and tools disabled when not in dev-mode.

* Fixed issue with profile not displaying correctly
* Fixed issue with displaying known words not displaying incorrectly
* Fixed issue with logout not behaving correctly.
* Fixed an issue with an incorrect login attempt resulting in an infinite loop.
* Fixed an issue with the back option returning to the incorrect page.

### Change Log: 0.013
* Finished implementing dedicated flashcard system, which takes it's content from `fr_vocab` with its own file structure.
* Study method is due for an overhaul but primary goal is to tidy up the current program.
* Added ability to check words known, works correctly, displaying both the english and french words now.
* Added an about section, provides basic information about the app.


* Improved file structure of save, less redundancy and easier to work with.
* Finished ensuring that all keys are hashed, had an issue where some loaded content was in string form.
* Fixed issue where duplicate words were being saved both to local memory and to disk.

**Known Issues**
- Pressing back takes you to the wrong place when in Flashcard menu.
- Navigation incorrect after concluding with about section.
- Navigation incorrect after concluding with profile section.
- Logout behavior incorrect



  **Flashcard Content Style**

```
{
  "Module": {
    "Title": "Animals" ,
    "Author": "Sam O'Donnell",
    "Last Last_Updated": "29/09/2021"
  },
  "Content": [
    {
      "Title": "Animaux Domestiques",
      "Vocab": [
        { "english" : "tortoise" , "translation" : ["tortue"] , "type" : ":noun :countable" , "gender" : "feminine" } ,
        { "english" : "canary" , "translation" : ["canari"] , "type" : ":noun :countable" , "gender" : "masculine" }
        ]
      },
      {
        "Title": "Animaux Domestiques",
      "Vocab": [
        ...
```

### Change Log: 0.012

* Restructured lesson files again to make them more performant and readable.  
* Added a settings.env so if keys change for any reason, they can be easily updated.
* Full conversion of Keys to symbols, had a lot of strings previously.
* Added dedicated flashcard content.  Will add more content after the system to handle it is implemented (slightly different to pulling vocab from lesson.jsons)
* Removed some unnecessary files. There are more that can be cut down in the futre.


* Fixed another bug with the log in system.

### Change Log: 0.011


* Added profile page, contains basic information for now
* Integrated 'Remedy' gem and made changes to make it suite my purposes.
* Remedy has been intregrated with the flash cards to allow for handling of user response.
* Major impovements made to the flash card system.
  * Different controls no supported, can now finally return to study menu or main menu from flash cards.
* First steps taken into intregrating further stats about the user.  Not quite integrated yet.
* Added ability to change Display name.  Does not save to disk yet however.


* Fixed bugs related to menu not behaving correctly.
* Major refactor, moved a lot of procs into their own definitions.  Still needs a lot of further work to bring to a high standard.


**Known Issues:**
* Can't call lesson.title from a tty-prompt menu without it bugging out.  Haven't been able to figure it out so I'm working around it for the time being.


### Change Log: 0.010
**Slew of critical bug fixes related to previous changes**
* Fixed issue with login system behaving incorrectly
  * Fixed issue with going to registration after a failed login attempt.
  * Fixed issue with registration not properly setting up session files.
* Fixed issue with merging system creating duplicates.
* Fixed issue with merging throwing crashes if file did not contain vocab already.
* Fixed an issue with logging in not finding existing users, related to change from string based keys to symbol based keys.
* Minor reformatting, moving some procs to methods.

Things seem stable again now, ***touchwood***.


### Change Log: 0.09
* Fixed a bug with logging in, previously added symbolize_names = true when loading json files which broke the system.
* Fixed a bug where the first letter of the english word was being used as the key when being stored into json.
* Fixed an issue where english key was being stored within an array unnecessarily.
* Storage IO updated
  * New words are now appended to the users vocabularly list and are saved locally for use between sessions.
  * Now loads stored data upon successful login / authentication.
  * Fixed several bugs related to file IO, eg new files being instantiated as an invalid json (blank).
  * Fixed an issue where when appending data it wasn't correctly nested.

**File Structure For Vocab**

This was changed in the previous patch but wasn't reflected in the change log.
New method is as follows, unnecessary nesting removed. 
```
 {
        "big": {"type": ":adj :desc", "translation": ["gros" , "grosse"], "gender": "none"},
        "small": {"type": ":adj :desc", "translation": ["petit" , "petite"], "gender": "none"},
        "old": {"type": ":adj :desc", "translation": ["ancien" , "ancienne"], "gender": "none"},
        "tree": {"type": ":adj :desc", "translation": ["arbre"], "gender": "masculine"}
      },
   ```

### Change Log: 0.08
* Added system for logging users learnt words and storing them in local.
* Minor changes to flash cards presentation
* Updated Splash screen
* Fixed performance issues related to recursvely opening and retreiving lesson information.
* Very heavy refactor of lesson structure.  New style makes it far more human readable when accessing necessary sections than the old mess.
    * File structure is far easier to understand now, and thus more maintanable.
    * Removed unnecessary structure from the json files.
    * Reworked the application to handle these changes.

**Dev Notes**
* Have an issue where keys are being stored as strings despite my attempts to retreive them as symbols.  It is on the backburner for now.

**New Lesson Structure For JSON**

```
{
  ":Module": {
    ":Title": "Template" ,
    ":Difficulty": "Beginner",
    ":Author": "Sam O'Donnell",
    ":Last Updated": "27/09/2021",
    ":Description": "Template Lesson File."
  },
  ":Lessons" : [
    {
      ":LessonTitle": "1. It's / c'est" ,
      ":Description": "Template Description" ,
      ":Vocab":
      [
        {"good": [ {"type": ":adj :desc"}, {"translation": ["bon" , "bonne"]}, {"gender": "none"}]},
        {"bad": [ {"type": ":adj :desc"}, {"translation": ["mauvais" , "mauvaise"]}, {"gender": "none"}]}
      ],
      ":Sentences": [
        { "It is [adj]":  "c'est [adj]"}
      ]
    },

    {
      ":LessonTitle": "2. Template 2 Lesson" ,
      ":Description": "Placeholder" ,
      ":Vocab":
      [
        {"yellow": [ {"type": ":adj :desc"}, {"translation": ["jaune"]}, {"gender": "none"}]},
        {"white": [ {"type": ":adj :desc"}, {"translation": ["blanc" , "blanche"]}, {"gender": "none"}]},
        {"black": [ {"type": ":adj :desc"}, {"translation": ["noir" , "noire"]}, {"gender": "none"}]}
      ],
      ":Sentences": [
        { "It isn't [:adj :desc]":  "Ce n'est pas [:adj :desc]"}
      ]
    }
```

### Change Log: 0.07
* Added **strings** gem, used to align, truncate and wrap strings.  Needed due to the length of some strings that come with a language learning application.
* Added **columnize** to use to help tidy up the interface.
* Added more or less fully featured flash cards.  For now, they pull the vocab from the associated lessons only, and do not take into account what the user has already learnt.
  * This is high on the todo list, adding a system to account for what the user has learnt and sub in other words.
* Now have the functionality to pull any words needed and store them in short term memory
  * this can be achieved with:
    * words_fr << returns object, `{ type: [:noun], translation: ['masc', 'fem'], gender: 'masculine'`
    * words_en << returns string containing the English word

** Dev Notes **

* Still need to refactor at some point but it's low on the list.
* Need to make further passes to tidy the interface but it's not looking too bad.
* More error handling is still on the backlog.


### Change Log: 0.06
* Added rudimentary flash card functionality and necessary methods to pull vocab lists from lessons.
  * User interface needs refinement
  * Need to add session stats to keep track of user progress.

### Change Log: 0.05
* Fixed flaws with lesson json files, inconsistent formatting.
* Have yet to update style guide for lesson content.
* On load, app will automatically find any json file and parse it (assuming it is a valid lesson.json).  Error handling NOT yet added.
  * Cache metadata from each lesson, core content will be loaded upon request to save system memory.
* Added Study Menu and **Flashcard menu**.  Flashcard menu is entirely placeholder, **Study** menu list all lessons found.
  * Selecting a lesson will display additional information about the course and its subject matter.
  * Does NOT yet lead to a way to study, that's next.


**Dev Notes**

* Added Curriculum singleton which handles lesson metadata.
* Added Lesson class which initializes with lesson metadata.
  * Have yet to add a method to load course material.
* Need to add a lot of error handling and figure out how to effectively test the code soon, but first goal is to get a working product out.

### Change Log: 0.04
* Added more information to lesson.json format, in the form of module information.  The rest is the same.
```
[
  {
    "Module": "It's / c'est" ,
    "Difficulty": "Beginner" ,
    "Author": "Sam O'Donnell" ,
    "Last Updated": "26/09/2021"
  },
  [  #Lesson block
      { Lesson Info: 
        { 
          Title: This is a title,
          Description: This is a description
        }
  ...
        ```




### Change Log: 0.04
* Puzzled out and implemented a content system that should work well and allow for reasonably dynamic content that is also structured enough to not leave learner's lost or out of their depth.  In early prototype stages but hopeful.  Content structure described below.
* Removed outdated lessons to be replaced with the new structure.

**Todo**
* Add a system to cache vocab the user has covered.  Have yet to lock in how I want this data to be structured and organised.
* Create a system to parse strings and replace relevent sections (eg [:noun :c]) with words in the user's study material.
* Create a system to parse json lessons and store relevant information in system memory.
  * Probably two separate files
    * User profile info including all relevant user info and vocab (no further information on the words)
    * dict.json, json with hash of each entry, key always matches the word
  * to find appropriate lists, would need to parse every word, map matching data to system memory.
  * New vocab would be << to dict.json and appended to system memory cache (instead of appending to dict then re-parsing and re-initializing them into system memory)


**Content Structure**

To facilitate dynamic content words have been ascribed necessary information.
Type: :type :sub-type,

  Legend:

      :un           parse and replace with 'un/une' according to gender of subject

      :noun :c      common noun
      :noun :p      noun proper
      :noun :con    noun concrete
      :noun :a      noun abstract
      :noun :col    noun collective

      :adj :comp      adjective comparative
      :adj :super     adjective superlative
      :adj :pred      adjective predicate
      :adj :compound  adjective compound
      :adj :pos       adjective possessive
      :adj :dem       adjective demonstrative
      :adj :proper    adjective proper
      :adj :part      adjective participial 
      :adj :lim       adjective limiting
      :adj :desc      adjective descriptive
      :adj :i         adjective interrogative
      :adj :adj       adjective attributive
      :adj :dist      adjective distributive
```
More will be added in the future, documentation will be updated accordingly.

```

[
  [  #Lesson block
      { Lesson Info: 
        { 
          Title: This is a title,
          Description: This is a description
        }
      },
      [   # Vocab Block
          {"good": [ { "type": ":adj :desc" },
                      { "translation": ["bon", "bonne"] },
                      { "gender": "masculine" }
                    ]
          }
      ],
      [   # sentence structure to practice this lesson
          { 
            "It is not [:adj], but it is [:adj]":
            "Ce n'est pas [:adj] mais c'est [:adj]" 
          },
          { 
            "It is not [:adj], but it is a [:noun :c]":
            "Ce n'est pas [:adj] mais c'est [:un] [:noun :c]" 
          }
      ]
  ],
  [     # next lesson Block
      ...
  ]
]

```
**Dev Notes**

* Think I finally have a grasp on how to order and relate information in an 
* Each lesson has associated vocab, this vocab will be added to the users vocab list automatically.
* Definitions will be added to words on different variations. E.G. house can be a verb and a noun etc.  The structure above allows us to make sure we only pull in appropriate words that are symantically correct.
* Algorithm will heavily favour placing in new words that the user hasn't had much exposure too.
* Algorithm will some what heavily favour words that are 'stale' to the user (hasn't seen much recently), or that the user has a low 'rating' with, eg if they have trouble remembering a particular word.
* Considering adding an option to allow more words of the same type to be fed in if the users 'rating' for all matching vocab is very high.


* **Format** will initially just be flash cards. Other methods on the backlog include:
  * Single word
    * Multiple-choice
    * Written
  * Sentences
    * Multiple-choice
    * Written (might be too much)
    * Place words in the correct order


### Change Log: 0.03
* Implemented an API lookup to a multilingual dictionary.  It is functional but not plugged into the application proper yet.
* Added a simple splash screen, may try to make something better later.
* Menus are now all working properly, dead options are coloured black until functionality is implemented.
* Setup Dotenv for storing API keys, tempted to move session info into Dotenv, haven't decided if it is a good idea.
* Began setting up json files handling lesson content.  Still undecided on the layout I want to go with.

**Notes**
* New dependencies: tty-table, dotenv

### Change Log: 0.02
* Greatly simplified codebase for logging in
* Removed many now unnecessary files
  * removed default_user_opts.rb
  * removed flashcards_form.rb
  * removed help_form.rb
  * removed login_form.rb
  * removed menu_form.rb
  * removed print_options.rb
  * removed session_controller.rb
  * removed settings_form.rb
  * removed views.rb
* Added Main Menu
* Added Flash Card Menu
* Better accessibility, keywords highlighted

**Notes**
- user_controller needs to change now that users can no longer type their own inputs to navigate.
- Flash Card menu wish list
  * Would like to add a feature showing what % of words they know later
  * Would like to add a feature recommending a list to study
  * Would like to add a feature displaying if the list is |Fresh| |Stale| |Unlearnt| so they can better decide what to study.

###Change Log: 0.01
- Started an active devlog within README.md to provide better communication of changes.
- TTY-Prompt replacing old menus where user would have to type the response. Provides better user experience.  Allows for a simpler and easier to understand codebase.
- Colorize integrated, using it to increase accessibility and convey information more clearly.

**Dev Notes**

* Need to increase testing coverage.  Need to learn RSPec in more depth to do so.
* Views folder likely deprecated. Will remove after all functionality is handled elsewhere.


**Codebase Maintenance**

* Consolidate exceptions, too many unnecessary files.
* Should be able to simplify code considerably, it's on the backlog.
  * Default user options probably redundant
  * Everything within views likely redundant
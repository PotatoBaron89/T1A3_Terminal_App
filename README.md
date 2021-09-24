#Readme:

###Change Log: 0.02
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
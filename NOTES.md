# NOTES 
This is a place for stuff that doesn't fit under README

## NAMING CONVENTIONS
* variables are "lowercase_with_hyphens"
* methods are "camelCased()"...
* programming classes should be capitalized, and always have the filename exactly match the class name (so the "Config" class is "Config.dart", for instance)
  + But, CSS classes will be "lowercase_with_hyphens"
* REALLY_IMPORTANT variables can be all caps and underscored
   + but there should only be 1 or 2 "really important" variables in an app

## GOALS
I wanted to make a simple, open source App that can demonstrate my Flutter development skills, but without needing a bunch of packages.

## DETAILED DETAILS

### STORIES
Each story has a key (like "A7YT4") and that key is used to fetch story assets. (like images and JSON).  If no story_keyis provided, the App will use:   
Config.story_key = 'DEFAULT' (from Config.dart)

If a story key is matched up (it can be found on a server) then "story.json" is returned, which includes stuff like:
* "key" : "8888-9999"	
* "title" : "The Dark Castle of Murwyche",
*	"author" : "M.R.Garvin",
*	"url" : "",	
It will be expected to have an image which is always:
"book_cover.png" (under an assets folder)

### PASSAGES
Each passage has a key, too.  These "passages" are the blocks of text (like "pages") that tell the story.  In a traditional gamebook each passage has a unique number, and you flip through the book as you choose-your-own adventure.  The same idea happens heir, but the passage_keys automate the jumping around.   

Some of these passage_keys are mandatory, like:
* "START" - always the first passage in a Story
* "END" - for when a story ends, with a "RESTART" button
* "OOPS" - a 404 error (passage not found)
* "RESTART" - a special key described below

"RESTART" has no JSON associated with it.  It is a keyword that tells the App to go to the Title Page of the App.

The other mandatory keys -- START, END, OOPS -- all have corresponding JSON files. (That is: "START.json" is always the first passage of a story.)

Other key names are unique to the story, and user-created.

### LIFECYCLE	
In a nutshell: Stories use passage_keys to display stories, passage-by-passage.  In each passage there will be choices, each of which has a passage_key, to advance the story.  

All Choices should have a passage key!  If they don't, the story halts.  

If the App can'r find a passage, it means:
* that passage does not exist, or
* there is an App error, or
* there is a network error

If this happens it should use the OOPS.JSON page, and indicate which passage_Key failed. (WILLFIX: I haven't done this yet.)I 

## RESOURCES
https://fonts.google.com/icons
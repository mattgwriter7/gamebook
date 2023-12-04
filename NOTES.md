# NOTES 
This is a place for stuff that doesn't fit under [README](https://github.com/mattgwriter7/gamebook/blob/main/README.md) 

## GOALS
I wanted to make a simple, open source App that can demonstrate my Flutter development skills, but without needing a bunch of packages, or anything too complicated. (I use Provider for most of my Apps, but this App is simple enough so that it was'nt even necessary.)   

## CHOSEN PROJECT
This is a choose-your-own adventure style App.  But the App itself is just a wrapper for the stories, meaning it can load an infinite amount of stories, as long as they are in the required format. (See "STORIES" below.)

## DETAILED DETAILS

### NAMING CONVENTIONS
* variables are "lowercase_with_hyphens"
* methods are "camelCased()"...
* programming classes are capitalized, and always have the filename exactly matching the class name (so the "Config" class is "Config.dart", for instance)
  + But, CSS classes will be "lowercase_with_hyphens" (like variables, above)
* REALLY_IMPORTANT variables can be all caps and underscored
   + but there should only be 1 or 2 "really important" variables in an app
   + in this App there are: STORY_KEY, and PASSAGE_KEY (both in Config.dart)

### STORIES
Each story has a key (like "A7YT4") and that key is used to fetch story assets. (like images and JSON).  If no story_keyis provided, the App will use:   
Config.story_key = 'DEFAULT' (from Config.dart)

If a story key is matched up (it can be found on a server) then "story.json" is returned, which includes stuff like:
* "key" : "DEFAULT"	
* "title" : "The Dark Castle of Murwyche",
*	"author" : "M.R.Garvin",
*	"url" : "",	
It will be expected to have an image which is always:
"book_cover.png" (under an assets folder)

### PASSAGES
Each passage has a key, too.  These "passages" are the blocks of text (like "pages") that tell the story.  In a traditional gamebook each passage has a unique number, and you flip through the book as you choose-your-own adventure.  The same idea happens heir, but the passage_keys automate the jumping around.   

Some of these PASSAGE_KEYs are mandatory, like:
* "START" - always the first passage in a Story
* "END" - for when a story ends, with a "RESTART" button
* "OOPS" - a 404 error (passage not found)
* "RESTART" - a special key described below
* "MORE" - a special key described below

"RESTART" has no JSON associated with it.  It is a keyword that tells the App to go to the Title Page of the App.

"MORE" also has no JSON.  It is for "More options" which is tacked on to the other choices, appearing at the bottom of a passage in the UI.  It leads to "More_Page.dart" which is for internal actions like quitting, or seeing Story credits.

The other mandatory keys -- START, END, OOPS -- all have corresponding JSON files. (For instance: "START.json" is always the first passage of a story.)

Other key names are unique to the story, and user-created. They do not have to be capitalized. (But the must be letters, numbers, hyphens, or underscores, only.  No punctuation or spaces will be allowed. This goes for STORY_KEYs and PASSAGE_KEYs.)

### LIFECYCLE	
In a nutshell: Stories use PASSAGE_KEYs to display stories, passage-by-passage.  In each passage there will be choices, each of which has a PASSAGE_KEY, to advance the story.  

All Choices should have a PASSAGE_KEY!  If they don't, the story halts.  

If the App can't find a passage, it means:
* that passage does not exist, or
* there is an App error, or
* there is a network error

If this happens I am still thinking on how to handle it. (Perhaps an Oops_Page.dart?)


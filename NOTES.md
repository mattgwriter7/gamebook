# NOTES 
This is a place for stuff that doesn't fit under README

## NAMING CONVENTIONS
* variables are "lowercase_with_hyphens"
* methods are "camelCased()"...
* programming classes should be capitalized, and always have the filename exactly match the class name (so the "Config" class is "Config.dart", for instance)
  + But, CSS classes will be "lowercase_with_hyphens"
* REALLY_IMPORTANT variables can be all caps and underscored
   + but there should only be 1 or 2 "really important" variables in an app

## LEFT OFF
Basic Pages are in place

## NEXT 
* add error page (to put over Fetches, both story and passage)
  + to get popped off

## PAGES
Start_Page
This page accepts keys.  Those keys are used to fetch stories.
By default, the Default Story is used.

Title_Page
Simple stateless page just for showing Title and Author

Passage_Page
This is meat of the page where passages are displayed.

Fetch_Page
It fetches a passage

## CONSIDERATIONS
* what to do when choice is made? 
  + fullscreen spinner?
  + "fetching passage" in AppBar?
* should I have ItemBuilder always be:
  + 0 is title
  + 1 is image (if not image use SizedBox with 0 height)
  + 2 is image caption (null is 0 height)
  + 3 is "Pompt" (if none use default)
  + then... add the number of choices to the mix
* Make Choice class
  + String text
  + String key
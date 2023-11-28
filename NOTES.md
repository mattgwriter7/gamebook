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

## IDEAS
FETCH STORY
* returns JSON
  + title
  + author
  + image
* "begin" button always uses "START" as fetch key


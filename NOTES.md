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
I have the basic UI started. I am not sure how to handle when there are UI elements that are not used (like images, image captions, etc.)
## NEXT 
* ?

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
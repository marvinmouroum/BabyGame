# BabyGame
This is a small game for babies to fit shapes into forms developed for the iPhone 11.

![](Image/video.gif)

This iOS project is used to drag ImageViews into place. Once it hits the correct place a haptic success response is triggered using the UINotificationFeedbackGenerator class. In case the child missed the target, a negative response is shown and the object will jump back to it's original position.

To move the objects a UIPanGestureRecognizer is used and the initial position is stored as the start:CGPoint variable. To check for the target point every view has an assigned position in the screen dedicated to it. This is based on the screens width and height and is calculated with a hard coded percentage on where the target is thought to be.

This approach has been tested for iPhone 11 and iPhone 11 Pro resolutions.

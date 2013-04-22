#define kPrefpath "/var/mobile/Library/Preferences/com.gviridis.definei.plist"

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#include <notify.h>

// Required

BOOL isCapable()
{
	return YES;
}

BOOL isEnabled()
{
	NSMutableDictionary *prefs;
    BOOL enable = YES;
	if([[NSFileManager defaultManager]fileExistsAtPath:@kPrefpath]){
		prefs = [[NSMutableDictionary alloc]initWithContentsOfFile:@kPrefpath];
        id enableValueInDictionary = [prefs objectForKey:@"enable"];
        if (enableValueInDictionary) {
            enable = [enableValueInDictionary boolValue];
        }
    }
    return enable;
}

void setState(BOOL enabled)
{
	NSMutableDictionary *prefs;
	if([[NSFileManager defaultManager]fileExistsAtPath:@kPrefpath]){
		prefs = [[NSMutableDictionary alloc]initWithContentsOfFile:@kPrefpath];
        [prefs setObject:[NSNumber numberWithBool:enabled] forKey:@"enable"];
    } else {
        prefs = [NSMutableDictionary dictionary];
        [prefs setObject:[NSNumber numberWithBool:enabled] forKey:@"enable"];
    }
    [prefs writeToFile:@kPrefpath atomically:YES];
    notify_post("com.gviridis.definei/ReloadPrefs");
}

float getDelayTime()
{
	return 0.1;
}

/* Optional

BOOL getStateFast()
{
	
}

void invokeHoldAction()
{
	
}

void closeWindow()
{
	
}

// Convenience method to get the SBSettings window

UIWindow *getAppWindow()
{
	for (UIWindow *window in [[UIApplication sharedApplication] windows])
	{
		if ([window respondsToSelector:@selector(getCurrentTheme)])
			return window;
	}

	return nil;
}

*/


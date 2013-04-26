#import <Preferences/Preferences.h>
#define kPrefpath "/var/mobile/Library/Preferences/com.gviridis.definei.plist"

@interface defineisettingsListController: PSListController {
}
@end

@implementation defineisettingsListController
- (id)specifiers {
	if(_specifiers == nil) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"defineisettings" target:self] retain];
	}
	return _specifiers;
}
- (void)jumpToAppSlideInCydia:(id)params {
    if([[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:@"cydia:"]]){
		[[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"cydia://package/com.chpwn.appslide"]];
    }
}
@end

// vim:ft=objc

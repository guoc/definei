#define kPrefpath "/var/mobile/Library/Preferences/com.gviridis.definei.plist"

@interface UITextContentView
- (id)selectedText;
- (void)copy:(id)arg1;
@end

@interface UITextField()
- (id)selectedText;
- (void)copy:(id)arg1;
@end

@interface UITextView()
- (id)selectedText;
- (void)copy:(id)arg1;
@end

@interface UIWebDocumentView
- (id)textInRange:(id)arg1;
- (id)selectedTextRange;
- (void)copy:(id)arg1;
@end

static BOOL enable;
static NSString *customURL;
static BOOL needCopyToPasteboard = NO;
static BOOL alwaysShowDefine = NO;
static BOOL addPercentEscapes = YES;

%hook UITextContentView
- (void)_define:(id)arg1 {
	if (!enable)
		return %orig;
	if (!customURL || [customURL length]==0)
		return %orig;
	NSString *word = [self selectedText];
	if(word) {
		if (needCopyToPasteboard)
			[self copy:arg1];
		NSString *url = [customURL stringByReplacingOccurrencesOfString:@"@s" withString:word];
		if (addPercentEscapes)
			url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
// 		NSString *url = [[@"ldoce://" stringByAppendingString:word] stringByAppendingString:@"?exact=off"];
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
	}
}
%end

%hook UITextField
- (void)_define:(id)arg1 {
	if (!enable)
		return %orig;
	if (!customURL || [customURL length]==0)
		return %orig;
	NSString *word = [self selectedText];
	if(word) {
		if (needCopyToPasteboard)
			[self copy:arg1];
		NSString *url = [customURL stringByReplacingOccurrencesOfString:@"@s" withString:word];
		if (addPercentEscapes)
			url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
// 		NSString *url = [[@"ldoce://" stringByAppendingString:word] stringByAppendingString:@"?exact=off"];
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
	}
}
%end

%hook UITextView
- (void)_define:(id)arg1 {
	if (!enable)
		return %orig;
	if (!customURL || [customURL length]==0)
		return %orig;
	NSString *word = [self selectedText];
	if(word) {
		if (needCopyToPasteboard)
			[self copy:arg1];
		NSString *url = [customURL stringByReplacingOccurrencesOfString:@"@s" withString:word];
		if (addPercentEscapes)
			url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
// 		NSString *url = [[@"ldoce://" stringByAppendingString:word] stringByAppendingString:@"?exact=off"];
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
	}
}
%end

%hook UIWebDocumentView
- (void)_define:(id)arg1 {
	if (!enable)
		return %orig;
	if (!customURL || [customURL length]==0)
		return %orig;
	NSString *word = [self textInRange:[self selectedTextRange]];
	if(word) {
		if (needCopyToPasteboard)
			[self copy:arg1];
		NSString *url = [customURL stringByReplacingOccurrencesOfString:@"@s" withString:word];
		if (addPercentEscapes)
			url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
// 		NSString *url = [[@"ldoce://" stringByAppendingString:word] stringByAppendingString:@"?exact=off"];
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
	}
}
%end

%hook _UIDefinitionService
- (BOOL)hasMarkupForString:(id)arg1 {
	BOOL r = %orig;
	if (alwaysShowDefine) {
		return YES;
	} else {
		return r;
	}
}
%end

static void prefsLoad() {
	NSMutableDictionary *prefs;
	if([[NSFileManager defaultManager]fileExistsAtPath:@kPrefpath]){
		prefs = [[NSMutableDictionary alloc]initWithContentsOfFile:@kPrefpath];
		if ([prefs objectForKey:@"enable"]) {
			enable = [[prefs objectForKey:@"enable"] boolValue];
		} else {
			enable = YES;
		}
		if ([prefs objectForKey:@"customURL"]) {
			customURL = [prefs objectForKey:@"customURL"];
		} else {
			customURL = nil;
		}
		if ([prefs objectForKey:@"copyWhenDefine"]) {
			needCopyToPasteboard = [[prefs objectForKey:@"copyWhenDefine"] boolValue];
		} else {
			needCopyToPasteboard = NO;
		}
		if ([prefs objectForKey:@"alwaysShowDefine"]) {
			alwaysShowDefine = [[prefs objectForKey:@"alwaysShowDefine"] boolValue];
		} else {
			alwaysShowDefine = NO;
		}
		if ([prefs objectForKey:@"addPercentEscapes"]) {
			addPercentEscapes = [[prefs objectForKey:@"addPercentEscapes"] boolValue];
		} else {
			addPercentEscapes = YES;
		}
    } else{
    	customURL = nil;
    	needCopyToPasteboard = NO;
    	alwaysShowDefine = NO;
    	enable = YES;
    	addPercentEscapes = YES;
        NSMutableDictionary *prefs = [NSMutableDictionary dictionary];
        [prefs writeToFile:@kPrefpath atomically:YES];
    }
}

static void prefsUpdate(CFNotificationCenterRef center,void *observer,CFStringRef name,const void *object,CFDictionaryRef userInfo){
	prefsLoad();
}

%ctor {
	%init;
	prefsLoad();
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(),NULL,&prefsUpdate,CFSTR("com.gviridis.definei/ReloadPrefs"),NULL,0);
}



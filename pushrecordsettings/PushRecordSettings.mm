#import <Preferences/Preferences.h>

#define prefsPath @"/var/mobile/Library/Preferences/com.gviridis.pushrecord.plist"

@interface PushRecordSettingsListController: PSListController {
}
@end

@implementation PushRecordSettingsListController

- (id)specifiers {
	if(_specifiers == nil) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"PushRecordSettings" target:self] retain];
	}
	return _specifiers;
}

-(id) readPreferenceValue:(PSSpecifier*)specifier {
	NSDictionary *settings = [NSDictionary dictionaryWithContentsOfFile:prefsPath];
	if (!settings[specifier.properties[@"key"]]) {
		return specifier.properties[@"default"];
	}
	return settings[specifier.properties[@"key"]];
}

-(void) setPreferenceValue:(id)value specifier:(PSSpecifier*)specifier {
	NSMutableDictionary *defaults = [NSMutableDictionary dictionary];
	[defaults addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefsPath]];
	[defaults setObject:value forKey:specifier.properties[@"key"]];
	[defaults writeToFile:prefsPath atomically:YES];
	CFStringRef toPost = (CFStringRef)specifier.properties[@"PostNotification"];
	if(toPost) CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), toPost, NULL, NULL, YES);
}

// https://gist.github.com/vhbit/958738
- (BOOL)openTwitterClientForUserName:(NSString*)userName {
    NSArray *urls = [NSArray arrayWithObjects: @"twitter:@{username}", // Twitter
							                   @"tweetbot:///user_profile/{username}", // TweetBot
										    //    @"twitterrific:///profile?screen_name={username}", // Twitterrific
                                               @"echofon:///user_timeline?{username}", // Echofon
                    						//    @"tweetings:///user?screen_name={username}", // Tweetings
						                       @"http://twitter.com/{username}", // Web fallback,
                                               nil];

    UIApplication *application = [UIApplication sharedApplication];
    for (NSString *candidate in urls) {
        candidate = [candidate stringByReplacingOccurrencesOfString:@"{username}" withString:userName];
        NSURL *url = [NSURL URLWithString:candidate];
        if ([application canOpenURL:url]) {
            [application openURL:url];
            return YES;
        }
    }
    return NO;
}

- (void)followOnTwitter: (PSSpecifier *)specifier {
	NSString *twitterID = [specifier propertyForKey: @"twitterID"];
	[self openTwitterClientForUserName: twitterID];
}

@end

// vim:ft=objc

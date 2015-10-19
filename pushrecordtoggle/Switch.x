#import "FSSwitchDataSource.h"
#import "FSSwitchPanel.h"

#define prefsPath @"/var/mobile/Library/Preferences/com.gviridis.pushrecord.plist"

@interface PushRecordToggleSwitch : NSObject <FSSwitchDataSource>
@end

@implementation PushRecordToggleSwitch

- (FSSwitchState)stateForSwitchIdentifier:(NSString *)switchIdentifier
{
	NSDictionary *settings = [NSDictionary dictionaryWithContentsOfFile:prefsPath];
	BOOL enabled = settings[@"Enable"] ? [settings[@"Enable"] boolValue] : YES;
	return enabled ? FSSwitchStateOn : FSSwitchStateOff;
}

- (void)applyState:(FSSwitchState)newState forSwitchIdentifier:(NSString *)switchIdentifier
{
	if (newState == FSSwitchStateIndeterminate)
		return;

	NSMutableDictionary *settings = [NSMutableDictionary dictionaryWithContentsOfFile:prefsPath];
	BOOL enabled = newState == FSSwitchStateOn ? YES : NO;
	settings[@"Enable"] = [NSNumber numberWithBool: enabled];
	[settings writeToFile:prefsPath atomically:YES];
	CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), CFSTR("com.gviridis.pushrecord.prefschanged"), NULL, NULL, YES);
}

@end

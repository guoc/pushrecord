include theos/makefiles/common.mk

BUNDLE_NAME = PushRecordSettings
PushRecordSettings_FILES = PushRecordSettings.mm
PushRecordSettings_INSTALL_PATH = /Library/PreferenceBundles
PushRecordSettings_FRAMEWORKS = UIKit
PushRecordSettings_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/PushRecordSettings.plist$(ECHO_END)

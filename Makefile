TARGET = iphone:clang:latest

include theos/makefiles/common.mk

TWEAK_NAME = PushRecord
PushRecord_FILES = Tweak.xmi

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += pushrecordsettings
SUBPROJECTS += pushrecordtoggle
include $(THEOS_MAKE_PATH)/aggregate.mk

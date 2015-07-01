export ARCHS = armv7 arm64

include theos/makefiles/common.mk

TWEAK_NAME = definei
definei_FILES = Tweak.xm
definei_FRAMEWORKS = UIKit

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"

SUBPROJECTS += defineisettings
SUBPROJECTS += defineitoggle
include $(THEOS_MAKE_PATH)/aggregate.mk

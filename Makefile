#THEOS_DEVICE_IP=iphone
THEOS_DEVICE_IP=127.0.0.1
THEOS_DEVICE_PORT=2222

export ARCHS = armv7

include theos/makefiles/common.mk

TWEAK_NAME = definei
definei_FILES = Tweak.xm
definei_FRAMEWORKS = UIKit

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += defineisettings
SUBPROJECTS += defineitoggle
include $(THEOS_MAKE_PATH)/aggregate.mk

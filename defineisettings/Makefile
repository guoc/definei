include theos/makefiles/common.mk

BUNDLE_NAME = defineisettings
defineisettings_FILES = defineisettings.mm
defineisettings_INSTALL_PATH = /Library/PreferenceBundles
defineisettings_FRAMEWORKS = UIKit
defineisettings_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/defineisettings.plist$(ECHO_END)

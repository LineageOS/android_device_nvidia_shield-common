LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)
LOCAL_SRC_FILES := TouchRotate.cpp
LOCAL_C_INCLUDES := frameworks/native/services/inputflinger \
                    system/core/init \
                    system/core/base/include
ifneq ($(ZYGOTE_WHITELIST_PATH_EXTRA),)
    LOCAL_CFLAGS += -DPATH_WHITELIST_EXTRA=$(ZYGOTE_WHITELIST_PATH_EXTRA)
endif
LOCAL_SHARED_LIBRARIES := liblog libbase
LOCAL_MODULE := libshim_inputhooks_touch
LOCAL_MODULE_TAGS := optional
include $(BUILD_SHARED_LIBRARY)

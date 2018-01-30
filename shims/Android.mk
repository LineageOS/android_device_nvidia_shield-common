LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)
LOCAL_SRC_FILES := icu_shim.c
LOCAL_SHARED_LIBRARIES := libicuuc libicui18n
LOCAL_MULTILIB := 32
LOCAL_MODULE := libicu_shim
LOCAL_MODULE_TAGS := optional
include $(BUILD_SHARED_LIBRARY)

include $(CLEAR_VARS)
LOCAL_SRC_FILES := socket_loopback_client.c
LOCAL_SHARED_LIBRARIES := libcutils
LOCAL_MODULE := libcutils_shim
LOCAL_MODULE_TAGS := optional
include $(BUILD_SHARED_LIBRARY)

include $(CLEAR_VARS)
LOCAL_SRC_FILES := stdio_vsnprintf.cpp
LOCAL_C_INCLUDES := bionic/libc/stdio
LOCAL_SHARED_LIBRARIES := liblog
LOCAL_MODULE := libs
LOCAL_MODULE_TAGS := optional
include $(BUILD_SHARED_LIBRARY)

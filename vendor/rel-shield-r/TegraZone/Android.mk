# Copyright (C) 2020 The LineageOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

ifeq ($(TARGET_TEGRA_DEFAULT_BRANCH),rel-shield-r)
LOCAL_PATH := $(call my-dir)
SHIELD_TEGRAZONE_PATH := ../../../../../../vendor/nvidia/shield/rel-shield-r/TegraZone

include $(CLEAR_VARS)
LOCAL_MODULE                  := TegraZone_Next
LOCAL_MODULE_TAGS             := optional
LOCAL_SRC_FILES               := $(SHIELD_TEGRAZONE_PATH)/app/TegraZone_Next.apk
LOCAL_CERTIFICATE             := PRESIGNED
LOCAL_MODULE_CLASS            := APPS
LOCAL_MODULE_SUFFIX           := $(COMMON_ANDROID_PACKAGE_SUFFIX)
LOCAL_VENDOR_MODULE           := true
LOCAL_DEX_PREOPT              := false
LOCAL_OPTIONAL_USES_LIBRARIES := org.apache.http.legacy
include $(BUILD_NVIDIA_COMMON_PREBUILT)
endif

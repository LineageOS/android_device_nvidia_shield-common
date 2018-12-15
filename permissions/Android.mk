#
# Copyright (C) 2019 The LineageOS Project
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
#
LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)
LOCAL_MODULE               := com.nvidia.doze.xml
LOCAL_SRC_FILES            := com.nvidia.doze.xml
LOCAL_MODULE_TAGS          := optional
LOCAL_MODULE_CLASS         := ETC
LOCAL_VENDOR_MODULE        := true
LOCAL_MODULE_RELATIVE_PATH := sysconfig
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE               := com.nvidia.shield.xml
LOCAL_SRC_FILES            := com.nvidia.shield.xml
LOCAL_MODULE_TAGS          := optional
LOCAL_MODULE_CLASS         := ETC
LOCAL_VENDOR_MODULE        := true
LOCAL_MODULE_RELATIVE_PATH := permissions
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE               := com.nvidia.shieldnext.xml
LOCAL_SRC_FILES            := com.nvidia.shieldnext.xml
LOCAL_MODULE_TAGS          := optional
LOCAL_MODULE_CLASS         := ETC
LOCAL_PRODUCT_MODULE       := true
LOCAL_MODULE_RELATIVE_PATH := permissions
include $(BUILD_PREBUILT)

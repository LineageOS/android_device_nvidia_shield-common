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

LOCAL_PATH := device/nvidia/shield-common/vendor

ifeq ($(NV_ANDROID_SHIELDTECH_ENHANCEMENTS),true)
ifneq ("$(wildcard $(LOCAL_PATH)/$(TARGET_TEGRA_DEFAULT_BRANCH)/shieldtech/shieldtech.mk)","")
$(call inherit-product, $(LOCAL_PATH)/$(TARGET_TEGRA_DEFAULT_BRANCH)/shieldtech/shieldtech.mk)
endif
endif

ifeq ($(NV_ANDROID_BEYONDER_ENHANCEMENTS),true)
ifneq ("$(wildcard $(LOCAL_PATH)/$(TARGET_TEGRA_DEFAULT_BRANCH)/beyonder/beyonder.mk)","")
$(call inherit-product, $(LOCAL_PATH)/$(TARGET_TEGRA_DEFAULT_BRANCH)/beyonder/beyonder.mk)
endif
endif

ifeq ($(NV_ANDROID_SHIELDTECH_ENHANCEMENTS),true)
ifneq ("$(wildcard $(LOCAL_PATH)/$(TARGET_TEGRA_DEFAULT_BRANCH)/accessories/nvaccessories.mk)","")
$(call inherit-product, $(LOCAL_PATH)/$(TARGET_TEGRA_DEFAULT_BRANCH)/accessories/nvaccessories.mk)
endif
endif

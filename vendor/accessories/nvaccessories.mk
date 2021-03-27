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

SHIELD_ACC_PATH := vendor/nvidia/shield/accessories

PRODUCT_PACKAGES += \
                    NvAccessories \
                    NvAccProxy \
                    privapp-permissions-nvidia-nvaccessories.xml

ifeq ($(TARGET_TEGRA_VARIANT),shield)
ifeq ($(PRODUCT_IS_ATV),true)
PRODUCT_PACKAGES += AccessoryUiTv
endif
endif

# Controller and remote firmware updates
PRODUCT_COPY_FILES += \
    $(foreach f,$(wildcard $(SHIELD_ACC_PATH)/firmware/Blake/*),$(f):$(TARGET_COPY_OUT_VENDOR)/oem/firmware/$(notdir $(f))) \
    $(foreach f,$(wildcard $(SHIELD_ACC_PATH)/firmware/Thunderstrike/*),$(f):$(TARGET_COPY_OUT_VENDOR)/oem/firmware/$(notdir $(f)))

ifeq ($(PRODUCT_IS_ATV),true)
PRODUCT_COPY_FILES += \
    $(foreach f,$(wildcard $(SHIELD_ACC_PATH)/firmware/Jarvis/*),$(f):$(TARGET_COPY_OUT_VENDOR)/oem/firmware/$(notdir $(f))) \
    $(foreach f,$(wildcard $(SHIELD_ACC_PATH)/firmware/Pepper/*),$(f):$(TARGET_COPY_OUT_VENDOR)/oem/firmware/$(notdir $(f))) \
    $(foreach f,$(wildcard $(SHIELD_ACC_PATH)/firmware/Friday/*),$(f):$(TARGET_COPY_OUT_VENDOR)/oem/firmware/$(notdir $(f)))
endif

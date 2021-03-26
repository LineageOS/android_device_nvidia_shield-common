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

PRODUCT_PACKAGES += \
                    NvShieldTech \
                    vendor.nvidia.hardware.shieldtech.rpx@1.0-service \
                    com.nvidia.shieldtech.xml \
                    privapp-permissions-nvidia-shieldtech.xml

# Allow shieldtech override
ifeq ($(TARGET_SHIELDTECH_INPUTFLINGER),nvidia)
PRODUCT_PACKAGES += \
                    vendor.nvidia.hardware.shieldtech.inputflinger@2.0-service
endif

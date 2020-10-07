#
# Copyright (C) 2018 The LineageOS Project
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

TARGET_TEGRA_VARIANT := shield

# Overlay
DEVICE_PACKAGE_OVERLAYS += \
    device/nvidia/shield-common/overlay/lineage

# Input Device Configuration
PRODUCT_PACKAGES += \
    gpio_ir_recv.idc \
    virtual-remote.idc \
    Vendor_0955_Product_7210.idc

# Key layouts
PRODUCT_PACKAGES += \
    gpio-keys.kl \
    tegra-kbc.kl \
    Vendor_0955_Product_7202.kl \
    Vendor_0955_Product_7203.kl \
    Vendor_0955_Product_7205.kl \
    Vendor_0955_Product_7210.kl

# Shield Specific Permission files
PRODUCT_PACKAGES += \
    com.nvidia.doze.xml \
    com.nvidia.shield.xml \
    com.nvidia.shieldnext.xml

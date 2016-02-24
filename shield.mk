#
# Copyright (C) 2016 The CyanogenMod Project
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

# Overlay
DEVICE_PACKAGE_OVERLAYS += \
    device/nvidia/shield-common/overlay/common \
    device/nvidia/shield-common/overlay/tablet-do

# System properties
-include $(LOCAL_PATH)/system_prop.mk

# Ramdisk
PRODUCT_PACKAGES += \
    init.comms.rc \
    init.dualwifi.rc \
    init.hdcp.rc \
    init.nv_dev_board.usb.rc \
    init.none.rc \
    init.tegra.rc \
    init.tegra_emmc.rc \
    init.tegra_sata.rc \
    init.tlk.rc \
    init.ussrd.rc

ifneq ($(filter $(TARGET_TEGRA_VERSION),t124),)
        PRODUCT_PACKAGES += init.t124.rc
else ifneq ($(filter $(TARGET_TEGRA_VERSION),t210),)
        PRODUCT_PACKAGES += \
            init.t210.rc \
            init.t210_common.rc
endif

ifneq ($(filter $(TARGET_TEGRA_TOUCH),nvtouch),)
        PRODUCT_PACKAGES += init.nv_touch.rc
else ifneq ($(filter $(TARGET_TEGRA_TOUCH),raydium),)
        PRODUCT_PACKAGES += init.ray_touch.rc
else ifneq ($(filter $(TARGET_TEGRA_TOUCH),sharp),)
        PRODUCT_PACKAGES += init.sharp_touch.rc
endif

# idc
ifneq ($(TARGET_TEGRA_TOUCH),)
        PRODUCT_PACKAGES += \
            touch.idc \
            sensor00fn11.idc
endif

ifneq ($(filter $(TARGET_TEGRA_MODEM),icera),)
        PRODUCT_PACKAGES += init.icera.rc
endif

# keylayout
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/keylayout/tegra-kbc.kl:system/usr/keylayout/tegra-kbc.kl \
    $(LOCAL_PATH)/keylayout/gpio-keys.kl:system/usr/keylayout/gpio-keys.kl \
    $(LOCAL_PATH)/keylayout/Vendor_0955_Product_7210.kl:system/usr/keylayout/Vendor_0955_Product_7202.kl \
    $(LOCAL_PATH)/keylayout/Vendor_0955_Product_7210.kl:system/usr/keylayout/Vendor_0955_Product_7203.kl \
    $(LOCAL_PATH)/keylayout/Vendor_0955_Product_7210.kl:system/usr/keylayout/Vendor_0955_Product_7210.kl \
    $(LOCAL_PATH)/keylayout/Vendor_0955_Product_7210.kl:system/usr/keylayout/Vendor_0955_Product_7212.kl

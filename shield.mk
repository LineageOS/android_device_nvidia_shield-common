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
ifneq ($(TARGET_TEGRA_DISABLE_OVERLAY),true)
    DEVICE_PACKAGE_OVERLAYS += \
         device/nvidia/shield-common/overlay/common

    ifeq ($(PRODUCT_IS_ATV),true)
        DEVICE_PACKAGE_OVERLAYS += \
            device/nvidia/shield-common/overlay/tv
    else
        DEVICE_PACKAGE_OVERLAYS += \
            device/nvidia/shield-common/overlay/tablet-do
    endif
endif

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
    init.tegra_sata.rc

ifeq ($(TARGET_TEGRA_VERSION),t114)
	PRODUCT_PACKAGES += init.tf.rc
else
	PRODUCT_PACKAGES += init.tlk.rc
endif

ifeq ($(TARGET_TEGRA_VERSION),t114)
        PRODUCT_PACKAGES += init.t114.rc
else ifeq ($(TARGET_TEGRA_VERSION),t124)
        PRODUCT_PACKAGES += init.t124.rc
else ifeq ($(TARGET_TEGRA_VERSION),t210)
        PRODUCT_PACKAGES += \
            init.t210.rc \
            init.t210_common.rc
endif

ifeq ($(TARGET_TEGRA_TOUCH),nvtouch)
        PRODUCT_PACKAGES += init.nv_touch.rc
else ifeq ($(TARGET_TEGRA_TOUCH),raydium)
        PRODUCT_PACKAGES += init.ray_touch.rc
else ifeq ($(TARGET_TEGRA_TOUCH),sharp)
        PRODUCT_PACKAGES += init.sharp_touch.rc
endif

ifeq ($(TARGET_TEGRA_MODEM),icera)
        PRODUCT_PACKAGES += init.icera.rc
endif

ifeq ($(AB_OTA_UPDATER),true)
	PRODUCT_PACKAGES += init.update_engine.rc
endif

# Permissions
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.bluetooth.xml:system/etc/permissions/android.hardware.bluetooth.xml \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:system/etc/permissions/android.hardware.bluetooth_le.xml \
    frameworks/native/data/etc/android.hardware.ethernet.xml:system/etc/permissions/android.hardware.ethernet.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
    frameworks/native/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml

ifneq ($(TARGET_TEGRA_VERSION),t114)
	PRODUCT_COPY_FILES += frameworks/native/data/etc/android.hardware.opengles.aep.xml:system/etc/permissions/android.hardware.opengles.aep.xml \
	                      frameworks/native/data/etc/android.hardware.vulkan.level-1.xml:system/etc/permissions/android.hardware.vulkan.level.xml \
	                      frameworks/native/data/etc/android.hardware.vulkan.version-1_0_3.xml:system/etc/permissions/android.hardware.vulkan.version.xml
endif

# Audio
PRODUCT_PACKAGES += \
    audio.a2dp.default \
    audio.usb.default \
    audio.r_submix.default \
    libaudio-resampler \
    libaudiospdif \
    libtinyalsa \
    tinycap \
    tinymix \
    tinyplay \
    xaplay \
    libstagefrighthw

ifneq ($(TARGET_TEGRA_VERSION),t114)
	PRODUCT_PACKAGES += libtinycompress
endif

# HALs
PRODUCT_PACKAGES += power.tegra \
                    thermal.tegra

# idc
ifneq ($(TARGET_TEGRA_TOUCH),)
        PRODUCT_PACKAGES += \
            init.cal.rc \
            raydium_ts.idc \
            touch.idc \
            sensor00fn11.idc
endif

# keylayout
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/keylayout/tegra-kbc.kl:system/usr/keylayout/tegra-kbc.kl \
    $(LOCAL_PATH)/keylayout/gpio-keys.kl:system/usr/keylayout/gpio-keys.kl \
    $(LOCAL_PATH)/keylayout/Vendor_0955_Product_7202.kl:system/usr/keylayout/Vendor_0955_Product_7202.kl \
    $(LOCAL_PATH)/keylayout/Vendor_0955_Product_7203.kl:system/usr/keylayout/Vendor_0955_Product_7203.kl \
    $(LOCAL_PATH)/keylayout/Vendor_0955_Product_7205.kl:system/usr/keylayout/Vendor_0955_Product_7205.kl \
    $(LOCAL_PATH)/keylayout/Vendor_0955_Product_7210.kl:system/usr/keylayout/Vendor_0955_Product_7210.kl \
    $(LOCAL_PATH)/keylayout/Vendor_0955_Product_7212.kl:system/usr/keylayout/Vendor_0955_Product_7212.kl \
    $(LOCAL_PATH)/keylayout/Vendor_0955_Product_7214.kl:system/usr/keylayout/Vendor_0955_Product_7214.kl

# Widevine shim
PRODUCT_PACKAGES += libwvm_shim

# Wifi
# All Shield devices xurrently use broadcom wifi / bluetooth modules
$(call inherit-product-if-exists, hardware/broadcom/wlan/bcmdhd/config/config-bcm.mk)
PRODUCT_PACKAGES += \
    hostapd \
    wpa_supplicant \
    wpa_supplicant.conf

# USB
PRODUCT_PACKAGES += \
    com.android.future.usb.accessory

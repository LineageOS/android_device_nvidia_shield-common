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
    init.recovery.nv_dev_board.usb.rc \
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
        PRODUCT_PACKAGES += \
			    init.ray_touch.rc \
			    init.recovery.ray_touch.rc

	TARGET_RECOVERY_DEVICE_MODULES := rm-wrapper

	# Raydium userspace is 32-bit, need to explicitly include the libs for recovery when 64-bit (only t210 atm)
        ifeq ($(TARGET_TEGRA_VERSION),t210)
		PRODUCT_COPY_FILES += \
                                      $(OUT)/system/bin/linker:recovery/root/system/bin/linker \
                                      $(OUT)/system/lib/libc.so:recovery/root/system/lib/libc.so \
                                      $(OUT)/system/lib/libdl.so:recovery/root/system/lib/libdl.so \
                                      $(OUT)/system/lib/liblog.so:recovery/root/system/lib/liblog.so \
                                      $(OUT)/system/lib/libm.so:recovery/root/system/lib/libm.so \
                                      $(OUT)/system/lib/libc++.so:recovery/root/system/lib/libc++.so \
                                      $(OUT)/system/lib/libstdc++.so:recovery/root/system/lib/libstdc++.so
	endif
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
    android.hardware.audio@2.0-impl \
    android.hardware.audio.effect@2.0-impl \
    libaudio-resampler \
    libaudiospdif \
    libtinyalsa \
    libtinycompress \
    tinycap \
    tinymix \
    tinyplay \
    xaplay \
    libstagefrighthw \
    enctune.conf

# Audio shim
PRODUCT_PACKAGES += libicu_shim

# Bluetooth
PRODUCT_PACKAGES += \
    libbt-vendor \
    android.hardware.bluetooth@1.0-impl

# DRM HAL
PRODUCT_PACKAGES += \
    android.hardware.drm@1.0-impl

# Gatekeeper HAL
ifeq ($(TARGET_TEGRA_VERSION),t210)
	PRODUCT_PACKAGES += \
	    android.hardware.gatekeeper@1.0-impl \
	    android.hardware.gatekeeper@1.0-service
endif

# Graphics
PRODUCT_PACKAGES += \
    android.hardware.graphics.allocator@2.0-impl \
    android.hardware.graphics.allocator@2.0-service \
    android.hardware.graphics.composer@2.1-impl \
    android.hardware.graphics.mapper@2.0-impl

# Graphics shim
PRODUCT_PACKAGES += libs \
                    libshim_zw

# Health HAL
PRODUCT_PACKAGES += \
    android.hardware.health@1.0-impl

# idc
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/idc/Vendor_0955_Product_7210.idc:system/usr/idc/Vendor_0955_Product_7210.idc \
    $(LOCAL_PATH)/idc/Vendor_0955_Product_7212.idc:system/usr/idc/Vendor_0955_Product_7212.idc \
    $(LOCAL_PATH)/idc/Vendor_0955_Product_7213.idc:system/usr/idc/Vendor_0955_Product_7213.idc \
    $(LOCAL_PATH)/idc/Vendor_0955_Product_7214.idc:system/usr/idc/Vendor_0955_Product_7214.idc

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
    $(LOCAL_PATH)/keylayout/Vendor_0955_Product_7213.kl:system/usr/keylayout/Vendor_0955_Product_7213.kl \
    $(LOCAL_PATH)/keylayout/Vendor_0955_Product_7214.kl:system/usr/keylayout/Vendor_0955_Product_7214.kl

# Steam controller keylayouts
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/keylayout/Vendor_28de_Product_1102.kl:system/usr/keylayout/Vendor_28de_Product_1102.kl \
    $(LOCAL_PATH)/keylayout/Vendor_28de_Product_1142.kl:system/usr/keylayout/Vendor_28de_Product_1142.kl

# Leanback apps
ifeq ($(PRODUCT_IS_ATV),true)
    $(call inherit-product-if-exists, vendor/google/atv/atv-common.mk)
endif

# Keymaster
PRODUCT_PACKAGES += \
    android.hardware.keymaster@3.0-impl \
    android.hardware.keymaster@3.0-service

# Memtrack
PRODUCT_PACKAGES += \
    android.hardware.memtrack@1.0-impl

# PBC
ifeq ($(TARGET_TEGRA_VERSION),t210)
	PRODUCT_PACKAGES += pbc.conf
endif

# Power
PRODUCT_PACKAGES += \
    android.hardware.power@1.0-impl \
    power.tegra

# Renderscript
PRODUCT_PACKAGES += \
    android.hardware.renderscript@1.0-impl

# RIL shim
PRODUCT_PACKAGES += libcutils_shim

# Vendor seccomp policy files for media components:
PRODUCT_COPY_FILES += \
    device/nvidia/shield-common/seccomp/mediacodec.policy:$(TARGET_COPY_OUT_VENDOR)/etc/seccomp_policy/mediacodec.policy \
    device/nvidia/shield-common/seccomp/mediaextractor.policy:$(TARGET_COPY_OUT_VENDOR)/etc/seccomp_policy/mediaextractor.policy

# Sensors
PRODUCT_PACKAGES += \
    android.hardware.sensors@1.0-impl

# Thermal
PRODUCT_PACKAGES += \
    android.hardware.thermal@1.0-impl \
    thermal.tegra

# TV specific hals
ifeq ($(PRODUCT_IS_ATV),true)
    PRODUCT_PACKAGES += \
        android.hardware.tv.cec@1.0-impl \
        android.hardware.tv.input@1.0-impl
endif

# Wifi
# All Shield devices currently use broadcom wifi / bluetooth modules
$(call inherit-product-if-exists, hardware/broadcom/wlan/bcmdhd/config/config-bcm.mk)

PRODUCT_PACKAGES += \
    android.hardware.wifi@1.0-service \
    hostapd \
    wificond \
    wpa_supplicant \
    wpa_supplicant.conf

# Unified scaling
ifneq ($(TARGET_TEGRA_VERSION),t114)
	PRODUCT_PACKAGES += \
	    ussr_setup \
	    init.ussrd.rc \
	    ussrd.conf
endif

# USB
PRODUCT_PACKAGES += \
    android.hardware.usb@1.0-service \
    com.android.future.usb.accessory

# Only set if framework modifications for nvcpl and shieldtech are available.
# Can be overridden per device.
NV_ANDROID_FRAMEWORK_ENHANCEMENTS := TRUE

# Only set if framework modifications for blakepairing are available.
NV_ANDROID_FRAMEWORK_ENHANCEMENTS_BLAKE := FALSE

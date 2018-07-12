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

# SELinux
BOARD_SEPOLICY_DIRS += device/nvidia/shield-common/sepolicy/common \
                       device/nvidia/shield-common/sepolicy/lineage-common

ifneq ($(filter $(TARGET_TEGRA_MODEM),icera),)
	BOARD_SEPOLICY_DIRS += device/nvidia/shield-common/sepolicy/icera
endif

ifneq ($(filter $(TARGET_TEGRA_TOUCH),nvtouch),)
	BOARD_SEPOLICY_DIRS += device/nvidia/shield-common/sepolicy/maxim
else ifneq ($(filter $(TARGET_TEGRA_TOUCH),raydium),)
	BOARD_SEPOLICY_DIRS += device/nvidia/shield-common/sepolicy/raydium \
	                       device/nvidia/shield-common/sepolicy/lineage-raydium
else ifneq ($(filter $(TARGET_TEGRA_TOUCH),sharp),)
	BOARD_SEPOLICY_DIRS += device/nvidia/shield-common/sepolicy/sharp
endif

# HALs
TARGET_POWERHAL_VARIANT := tegra
TARGET_THERMALHAL_VARIANT := tegra

# Release tools for bootloader assertion
TARGET_RELEASETOOLS_EXTENSIONS := device/nvidia/shield-common/releasetools

# Use unified vendor
TARGET_TEGRA_VARIANT := shield

# TWRP Support
ifeq ($(WITH_TWRP),true)
-include device/nvidia/shield-common/twrp.mk
endif

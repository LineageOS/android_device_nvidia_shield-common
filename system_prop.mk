# Audio
PRODUCT_PROPERTY_OVERRIDES += \
    af.resampler.quality=7 \
    af.fast_downmix=1 \
    af.thread.throttle=0

# Display
PRODUCT_PROPERTY_OVERRIDES += \
    ro.sf.override_lcd_density=1 \
    persist.tegra.compositor=glcomposer \
    persist.tegra.decompression=cde-client

# Input
PRODUCT_PROPERTY_OVERRIDES += \
    ro.input.noresample=1

# Nvmm
PRODUCT_PROPERTY_OVERRIDES += \
    persist.tegra.nvmmlite=1

# USB
PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.usb.config=mtp

# WiFi
PRODUCT_PROPERTY_OVERRIDES += \
    wifi.interface=wlan0 \
    wifi.Xinterface=xlan0 \
    ap.interface=wlan0 \
    persist.wlan.ti.calibrated=0

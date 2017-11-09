#define _REALLY_INCLUDE_SYS__SYSTEM_PROPERTIES_H_
#include <sys/_system_properties.h>

#include "init_shield.h"
#include "init.h"
#include "vendor_init.h"
#include "property_service.h"
#include "log.h"
#include "util.h"

#include <unistd.h>

#include <fstream>
#include <sstream>

void property_override(char const prop[], char const value[])
{
    prop_info *pi;

    pi = (prop_info*) __system_property_find(prop);
    if (pi)
        __system_property_update(pi, value, strlen(value));
    else
        __system_property_add(prop, strlen(prop), value, strlen(value));
}

void shield_init::gsm_properties()
{
    property_set("cm.icera.enabled", "1");
    property_set("ril.icera-config-args", "notifier:ON,datastall:ON,lwaactivate");
    property_set("gsm.modem.power.device", "/sys/devices/platform/tegra_usb_modem_power/modem_reset/value,0,1");
    property_set("gsm.modem.edp.device", "/sys/power/sysedp");
    property_set("gsm.modem.edp.state", "/sys/devices/platform/sysedp_modem/sysedp_state");
    property_set("ro.ril.devicename", "/dev/ttyACM0");
    property_set("mdc_initial_max_retry", "10");
    property_set("rild.libpath", "libril-icera.so");
    property_set("rild.libargs", "-e rmnet0 -e rmnet0:0 -e rmnet0:1 -n");
    property_set("gsm.modem.crashlogs.directory", "/data/rfs/data/debug");
    property_set("ril.maxretries", "15");
    property_set("gsm.modem.powercontrol", "enabled");
    property_set("ro.ril.wake_lock_timeout", "200000");
    property_set("ro.telephony.default_network", "9");
}

bool shield_init::detect_model_override()
{
    std::string lmodel;

    std::ifstream file("/data/property/persist.lineage.shield.model");
    if (getline(file, lmodel)) {
        for (auto & device : shield_devices) {
            if (!device.name.compare(lmodel))
                chosen_device = &device;
        }
    }

    return chosen_device != NULL;
}

void shield_init::detect_model_devicetree()
{
    std::string hardware = property_get("ro.hardware");

    for (auto & device : shield_devices) {
        if (!device.name.compare(hardware)) {
            chosen_device = &device;
            break;
        }
    }
}

void shield_init::detect_model_boardinfo()
{
    std::string line, boardinfo, devid;

    // Get model from /proc/cmdline
    std::ifstream file("/proc/cmdline");
    if (!file.is_open())
        return;

    if (!std::getline(file, line))
        return;

    std::stringstream linestream(line);
    while (std::getline(linestream, boardinfo, ' ')) {
        if (boardinfo.find("board_info") != std::string::npos)
            break;
    }

    std::stringstream bistream(boardinfo);
    std::getline(bistream, devid, ':');
    if (!std::getline(bistream, devid, ':'))
        return;

    for (auto & device : shield_devices) {
        if (!device.dev_id.compare(devid)) {
            chosen_device = &device;
            break;
        }
    }
}

bool shield_init::detect_model()
{
    if (!detect_model_override()) {
        if (dt_detect)
             detect_model_devicetree();
        else
             detect_model_boardinfo();
    }

    return chosen_device != NULL;
}

void shield_init::set_fingerprints()
{
    property_override("ro.build.fingerprint", ("NVIDIA/" + chosen_device->name + "/" + 
                                               chosen_device->device + ":" + 
                                               fp_version.android_version + "/" +
                                               fp_version.android_release + "/" +
                                               fp_version.nvidia_version +
                                               ":user/release-keys").c_str());
    property_override("ro.build.description", (chosen_device->name + "-user " +
                                               fp_version.android_version + " " +
                                               fp_version.android_release + " " +
                                               fp_version.nvidia_version +
                                               " release-keys").c_str());
}

void shield_init::recovery_links()
{
    std::string int_path;

    switch (chosen_device->boot_dev) {
        case boot_dev_type::EMMC:
            symlink("/etc/twrp.fstab.emmc", "/etc/twrp.fstab");
	    int_path = "sdhci-tegra.3";
	    break;

	case boot_dev_type::SATA:
            symlink("/etc/twrp.fstab.sata", "/etc/twrp.fstab");
	    int_path = "tegra-sata.0";
	    break;
    }

    // Symlink paths for unified ROM installs.
    for(auto const& part: parts)
        symlink(("/dev/block/platform/" + int_path + "/by-name/" + part).c_str(), ("/dev/block/" + part).c_str());
}

void shield_init::set_properties()
{
    std::string platform = property_get("ro.board.platform");

    // If device is not what this was compiled for, bail
    if (platform.compare(ANDROID_TARGET))
        return;

    if (!detect_model()) {
        ERROR("Failed to get model\n");
        return;
    }

    switch (chosen_device->gsm_support) {
        case gsm_support_type::NONE:
            property_set("ro.radio.noril", "true");
            break;

        case gsm_support_type::DATA_ONLY:
            gsm_properties();
            property_set("ro.modem.do", "1");
            break;

        case gsm_support_type::VOICE:
            gsm_properties();
            property_set("ro.modem.vc", "1");
            break;
    }

    property_set("ro.product.first_api_level", std::to_string(chosen_device->first_api).c_str());

    if (chosen_device->dpi)
        property_set("ro.sf.lcd_density", std::to_string(chosen_device->dpi).c_str());

    property_override("ro.product.name",   chosen_device->name.c_str());
    property_override("ro.build.product",  chosen_device->device.c_str());
    property_override("ro.product.device", chosen_device->device.c_str());
    property_override("ro.product.model",  chosen_device->model.c_str());

    set_fingerprints();

    if (parts.size())
	    recovery_links();

    ERROR("Setting build properties for %s model\n", chosen_device->name.c_str());
}

#ifndef __INIT_SHIELD__H__
#define __INIT_SHIELD__H__

#include <string>
#include <vector>

class shield_init {

    public:
        enum class gsm_support_type {
            NONE,
            DATA_ONLY,
            VOICE
	} typedef gsm_support_type;

        enum class boot_dev_type {
            EMMC,
            SATA
        } typedef boot_dev_type;

        struct devices {
            std::string device;
            std::string name;
            std::string model;
            std::string dev_id; // Device ID used in board_info lookup
            gsm_support_type gsm_support;
            boot_dev_type boot_dev;
            uint8_t first_api;
            uint16_t dpi;
        } typedef devices;

        struct build_version {
            std::string android_version;
            std::string android_release;
            std::string nvidia_version;
        } typedef build_version;

        shield_init(std::vector<devices> devicelist, bool dtdetect, build_version buildversion, std::vector<std::string> recdevs) :
            dt_detect(dtdetect), parts(recdevs), shield_devices(devicelist), fp_version(buildversion)
            { chosen_device = NULL; }
        void set_properties();

    private:
        bool dt_detect;     // Use ro.hardware to detect model
        std::vector<std::string> parts;
        std::vector<devices> shield_devices;
        devices *chosen_device;
        build_version fp_version;

        bool detect_model();
        bool detect_model_override();
        void detect_model_devicetree();
        void detect_model_boardinfo();

        void gsm_properties();
        void set_fingerprints();
        void recovery_links();
};

#endif /* __INIT_SHIELD__H__ */

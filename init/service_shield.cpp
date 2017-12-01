#include <errno.h>
#include "service.h"

#include "service_shield.h"

int shield_handle_control_message(const std::string &msg, const std::string &arg)
{
    android::init::Service *sf_svc = NULL;
    android::init::Service *zg_svc = NULL;

    if (!msg.compare("restart") && !arg.compare("consolemode")) {
        sf_svc = android::init::ServiceManager::GetInstance().FindServiceByName("surfaceflinger");
        zg_svc = android::init::ServiceManager::GetInstance().FindServiceByName("zygote");

        if (sf_svc && zg_svc) {
            zg_svc->Stop();
            sf_svc->Stop();
            sf_svc->Start();
            zg_svc->Start();
        }

        return 0;
    }

    return -EINVAL;
}

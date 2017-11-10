#define LOG_TAG "NvInputHook_Host"

#include <cutils/log.h>
#include <dlfcn.h>

#include "NvInputHook_Host.h"

android::InputHook *android::InputHook::instance = nullptr;

void android::NvEventHubInterface::addDevice(int deviceId) {
    InputHook::getInstance()->addDevice(deviceId);
}

void android::NvEventHubInterface::registerDevice(android::NEW_DEVICE *device) {
    InputHook::getInstance()->registerDevice(device);
}

void android::NvEventHubInterface::removeDevice(int deviceId) {
    InputHook::getInstance()->removeDevice(deviceId);
}

android::InputHook::InputHook(EventHub *eventHub) : eventHub(eventHub) {
    instance = this;

    libHandle = dlopen("nvshieldtech.so", 0);
    if (libHandle) {
        NvInputHook::InitFunc initFunc = reinterpret_cast<NvInputHook::InitFunc>(
            dlsym(libHandle, "InputHook_Init"));
        if (initFunc) {
            auto eventHub = new NvEventHubInterface;
            nvInputHook = initFunc(eventHub);
        }
    }

    if (nvInputHook) {
        ALOGI("ShieldTech loaded (%p)", nvInputHook);
    } else {
        ALOGW("Unable to load ShieldTech support features");
    }
}

int android::InputHook::addDevice(int deviceId) {
#if 0
    AutoMutex _l(eventHub->mLock);

    char path[4096];
    snprintf(path, sizeof(path), "/dev/input/event%d", deviceId);
    return eventHub->openDeviceLocked(path) == 0;
#else
    return 0;
#endif
}

void android::InputHook::registerDevice(android::NEW_DEVICE *newDev) {
#if 0
    eventHub->assignDescriptorLocked(*newDev->id);
    EventHub::Device *device = new EventHub::Device(newDev->fd, newDev->deviceId, String8(newDev->path), *newDev->id);
    device->classes |= newDev->classes;
    memcpy(device->keyBitmask, newDev->keyBitmask, sizeof(device->keyBitmask));
    memcpy(device->absBitmask, newDev->absBitmask, sizeof(device->absBitmask));
    memcpy(device->relBitmask, newDev->relBitmask, sizeof(device->relBitmask));
    eventHub->loadKeyMapLocked(device);

    epoll_event event = {};
    event.events = 1;
    event.data.u64 = newDev->deviceId;
    if (!epoll_ctl(eventHub->mEpollFd, 1, newDev->fd, &event)) {
        eventHub->addDeviceLocked(device);
        ALOGD("Device \"%s\" added", newDev->path);
    } else {
        ALOGE("Could not add device fd to epoll instance.  errno=%d", errno);
        delete device;
    }
#endif
}

int android::InputHook::removeDevice(int deviceId) {
#if 0
    AutoMutex _l(eventHub->mLock);

    char path[4096];
    snprintf(path, sizeof(path), "/dev/input/event%d", deviceId);
    return eventHub->closeDeviceByPathLocked(path) == 0;
#else
    return 0;
#endif
}

void android::InputHook::filterCloseDevice(int deviceId) {
    if (!nvInputHook)
        return;

    nvInputHook->filterCloseDevice(deviceId);
}

int android::InputHook::filterEvent(input_event *event, int *x) {
    if (!nvInputHook)
        return 0;

    return nvInputHook->filterEvent(event, x);
}

int android::InputHook::filterNewDevice(int a, int b, const android::String8 &s, android::InputDeviceIdentifier &id) {
    if (!nvInputHook)
        return 1;

    return nvInputHook->filterNewDevice(a, b, s, id);
}

int android::InputHook::notifyKeyState(int a, int b, bool c) {
    if (!nvInputHook)
        return 0;

    return nvInputHook->notifyKeyState(a, b, c);
}

int android::InputHook::notifyMotionState(int a, android::PointerCoords *coords, bool b) {
    if (!nvInputHook)
        return 0;

    return nvInputHook->notifyMotionState(a, coords, b);
}

void android::InputHook::registerDevices() {
    if (!nvInputHook)
        return;

    nvInputHook->registerDevices();
}

int android::InputHook::treatMouseAsTouch() {
    if (!nvInputHook)
        return 0;

    return nvInputHook->treatMouseAsTouch();
}

android::InputHook *android::InputHook::getInstance() {
    return instance;
}

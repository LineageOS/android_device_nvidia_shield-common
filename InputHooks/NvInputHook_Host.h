#ifndef _NVINPUTHOOK_HOST_H
#define _NVINPUTHOOK_HOST_H

#include "EventHub.h"

namespace android {

struct NEW_DEVICE {
    android::InputDeviceIdentifier *id;
    int fd;
    int deviceId;
    const char *path;
    uint32_t classes;
    uint8_t keyBitmask[(KEY_MAX + 1) / 8];
    uint8_t absBitmask[2 /* wat */];
    uint8_t relBitmask[(REL_MAX + 1) / 8];
};

class NvEventHubInterface {
public:
    virtual ~NvEventHubInterface() {}

    virtual void addDevice(int deviceId);
    virtual void registerDevice(android::NEW_DEVICE *device);
    virtual void removeDevice(int deviceId);
};

class NvInputHook {
public:
    virtual ~NvInputHook() = 0;

    virtual int filterNewDevice(int, int, const android::String8 &, android::InputDeviceIdentifier &) = 0;
    virtual void filterCloseDevice(int) = 0;
    virtual int filterEvent(input_event *, int *) = 0;
    virtual int notifyKeyState(int, int, bool) = 0;
    virtual int notifyMotionState(int, android::PointerCoords *, bool) = 0;
    virtual void registerDevices() = 0;
    virtual int treatMouseAsTouch() = 0;

    typedef NvInputHook *(*InitFunc)(NvEventHubInterface *);
};

class InputHook {
public:
    InputHook(EventHub *eventHub);

    int addDevice(int deviceId);
    void registerDevice(android::NEW_DEVICE *newDev);
    int removeDevice(int deviceId);

    void filterCloseDevice(int deviceId);
    int filterEvent(input_event *event, int *x);
    int filterNewDevice(int a, int b, const android::String8 &s, android::InputDeviceIdentifier &id);
    int notifyKeyState(int a, int b, bool c);
    int notifyMotionState(int a, android::PointerCoords *coords, bool b);
    void registerDevices();
    int treatMouseAsTouch();

    static InputHook *getInstance();

private:
    EventHub *eventHub;
    void *libHandle;
    NvInputHook *nvInputHook = nullptr;

    static InputHook *instance;
};

}

#endif // _NVINPUTHOOK_HOST_H

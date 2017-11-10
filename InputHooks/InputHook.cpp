#include "NvInputHook_Host.h"

static android::InputHook *inputHook;

void inputhook_vendor_init(android::EventHub *ehub)
{
    inputHook = new android::InputHook(ehub);
}

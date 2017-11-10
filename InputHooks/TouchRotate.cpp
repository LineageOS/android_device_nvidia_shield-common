#include <cutils/properties.h>
#include <string>

void inputhook_vendor_touchrotate(int32_t *width, int32_t *height, int32_t *orientation)
{
    int32_t tmp = 0;
    char stbMode[PROP_VALUE_MAX];

    property_get("persist.tegra.stb.mode", stbMode, "0");
    if (stbMode[0] != '0') {
        tmp = *width;
        *width = *height;
        *height = tmp;
        *orientation = (*orientation + 1) % 4;
    }
}

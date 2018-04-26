#include <stdlib.h>
#include <dlfcn.h>

#include <android-base/properties.h>
#include <cutils/log.h>

#include "InputReader.h"

void android::TouchInputMapper::configureSurface(nsecs_t when, bool* outResetNeeded) {
  void (*configureSurface_real)(const TouchInputMapper*, nsecs_t, bool*);
  int32_t tmp = 0;

  if (!configureSurface_real)
    configureSurface_real = (typeof(configureSurface_real))dlsym(RTLD_NEXT, "_ZN7android16TouchInputMapper16configureSurfaceExPb");

  if (configureSurface_real)
    configureSurface_real(this, when, outResetNeeded);
  else {
    ALOGE("Could not find configureSurface, aborting");
    abort();
  }

  if (android::base::GetProperty("persist.tegra.stb.mode", "0") != "0") {
    tmp = mSurfaceWidth;
    mSurfaceWidth = mSurfaceHeight;
    mSurfaceHeight = tmp;
    mSurfaceOrientation = (mSurfaceOrientation + 1) % 4;
  }
}

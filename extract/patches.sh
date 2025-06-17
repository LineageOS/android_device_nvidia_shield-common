# Copyright (C) 2025 The LineageOS Project
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

function patch_hidl() {
  echo -n "Patching hidl services to remove hidltransport and hwbinder deps...";

  ${PATCHELF} --remove-needed libhidltransport.so --remove-needed libhwbinder.so ${LINEAGE_ROOT}/${OUTDIR}/shield/rel-shield-r/shieldtech/bin32/hw/vendor.nvidia.hardware.shieldtech.inputflinger@2.0-service
  ${PATCHELF} --remove-needed libhidltransport.so --remove-needed libhwbinder.so ${LINEAGE_ROOT}/${OUTDIR}/shield/rel-shield-r/shieldtech/bin64/hw/vendor.nvidia.hardware.shieldtech.inputflinger@2.0-service

  ${PATCHELF} --remove-needed libhidltransport.so --remove-needed libhwbinder.so ${LINEAGE_ROOT}/${OUTDIR}/shield/rel-shield-r/shieldtech/bin32/hw/vendor.nvidia.hardware.shieldtech.rpx@1.0-service
  ${PATCHELF} --remove-needed libhidltransport.so --remove-needed libhwbinder.so ${LINEAGE_ROOT}/${OUTDIR}/shield/rel-shield-r/shieldtech/bin64/hw/vendor.nvidia.hardware.shieldtech.rpx@1.0-service

  echo "";
}

patch_hidl;

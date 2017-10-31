# Copyright (C) 2017 The LineageOS Project
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

import re
import os

TARGET_DIR = os.getenv('OUT')
BLOB_NAME = 'blob'
STAGING_PART = '/dev/block/platform/sdhci-tegra.3/by-name/USP'

def FullOTA_Assertions(info):
  if 'INSTALL/' + BLOB_NAME in info.input_zip.namelist():
    AddBootloaderFlash(info, info.input_zip)
  else:
    AddBootloaderAssertion(info, info.input_zip)


def IncrementalOTA_Assertions(info):
  FullOTA_Assertions(info)


def AddBootloaderAssertion(info, input_zip):
  android_info = input_zip.read("OTA/android-info.txt")
  m = re.search(r"require\s+version-bootloader\s*=\s*(\S+)", android_info)
  if m:
    bootloaders = m.group(1).split("|")
    if "*" not in bootloaders:
      info.script.AssertSomeBootloader(*bootloaders)
    info.metadata["pre-bootloader"] = m.group(1)


def AddBootloaderFlash(info, input_zip):
  android_info = input_zip.read("OTA/android-info.txt")
  m = re.search(r"require\s+version-bootloader\s*=\s*(\S+)", android_info)
  if m:
    bootloaders = m.group(1).split("|")
    info.metadata["pre-bootloader"] = m.group(1)
    if "*" not in bootloaders:
      info.script.AppendExtra('ifelse(')
      info.script.AppendExtra('  ' + ' || '.join(['getprop("ro.bootloader") == "%s"' % (b,) for b in bootloaders]) + ',')
      info.script.AppendExtra('  (')
      info.script.AppendExtra('    ui_print("Correct bootloader already installed");')
      info.script.AppendExtra('  ),')
      info.script.AppendExtra('  (')
      info.script.AppendExtra('    ui_print("Flashing updated bootloader");')
      info.script.AppendExtra('    package_extract_file("install/' + BLOB_NAME + '", "' + STAGING_PART + '");')
      info.script.AppendExtra('  )')
      info.script.AppendExtra(');')

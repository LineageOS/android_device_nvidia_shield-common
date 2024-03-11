# Copyright (C) 2021 The LineageOS Project
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

# Recovery image copy of tegrazone has invalid signature format
function fetch_tegrazone() {
  echo -n "Fetching TegraZone from Archive.org...";

  mkdir -p ${LINEAGE_ROOT}/${OUTDIR}/shield/external/TegraZone/app
  wget -q 'https://archive.org/download/com.nvidia.tegrazone3_5.51.31668050/com.nvidia.tegrazone3_5.51.31668050.apk' -O ${LINEAGE_ROOT}/${OUTDIR}/shield/external/TegraZone/app/TegraZone_Next.apk

  echo "";
}
fetch_tegrazone;

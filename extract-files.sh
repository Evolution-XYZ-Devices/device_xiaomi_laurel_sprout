#!/bin/bash
#
# Copyright (C) 2018-2019 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

set -e

DEVICE=laurel_sprout
VENDOR=xiaomi

# Load extract_utils and do some sanity checks
MY_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "${MY_DIR}" ]]; then MY_DIR="${PWD}"; fi

EVOLUTION_ROOT="${MY_DIR}/../../.."

HELPER="${EVOLUTION_ROOT}/vendor/evolution/build/tools/extract_utils.sh"
if [ ! -f "${HELPER}" ]; then
    echo "Unable to find helper script at ${HELPER}"
    exit 1
fi
source "${HELPER}"

# Default to sanitizing the vendor folder before extraction
CLEAN_VENDOR=true
SECTION=
KANG=

while [ "$1" != "" ]; do
    case "$1" in
        -n | --no-cleanup )     CLEAN_VENDOR=false
                                ;;
        -k | --kang)            KANG="--kang"
                                ;;
        -s | --section )        shift
                                SECTION="$1"
                                CLEAN_VENDOR=false
                                ;;
        * )                     SRC="$1"
                                ;;
    esac
    shift
done

if [ -z "${SRC}" ]; then
    SRC=adb
fi

function blob_fixup() {
    case "${1}" in
    vendor/bin/hw/vendor.qti.hardware.scve.panorama@1.0-service | vendor/bin/hw/vendor.qti.hardware.scve.objecttracker@1.0-service | vendor/lib/hw/camera.trinket.so | lib64/libwfdnative.so | vendor/lib/vendor.qti.hardware.scve.objecttracker@1.0-halimpl.so | vendor/lib/vendor.qti.hardware.scve.panorama@1.0-halimpl.so | vendor/bin/hw/vendor.display.color@1.0-service )
		sed -i "s/android.hidl.base@1.0.so/libhidlbase.so\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00/" "${2}"
        ;;
        
    # Shim
    product/lib64/libdpmframework.so)
        patchelf --add-needed libdpmframework_shim.so "${2}"
        ;;
    esac
}

# Initialize the helper
setup_vendor "${DEVICE}" "${VENDOR}" "${EVOLUTION_ROOT}" false "${CLEAN_VENDOR}"

extract "${MY_DIR}/proprietary-files.txt" "${SRC}" ${KANG} --section "${SECTION}"

"${MY_DIR}/setup-makefiles.sh"

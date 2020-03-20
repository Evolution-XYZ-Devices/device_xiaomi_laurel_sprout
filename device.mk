#
# Copyright 2018 - 2020 The Android Open Source Project
# Copyright 2019 - 2020 The PixelExperience Project
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
#

# Get non-open-source specific aspects
$(call inherit-product-if-exists, vendor/xiaomi/laurel_sprout/laurel_sprout-vendor.mk)

# Enable updating of APEXes
$(call inherit-product, $(SRC_TARGET_DIR)/product/updatable_apex.mk)

# Dalvik heap configuration for a 4GB phone
$(call inherit-product, frameworks/native/build/phone-xhdpi-4096-dalvik-heap.mk)

$(call inherit-product-if-exists, vendor/MiuiCamera/config.mk)

PRODUCT_COMPATIBLE_PROPERTY_OVERRIDE := true

# Permissions
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/handheld_core_hardware.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/handheld_core_hardware.xml \
    $(LOCAL_PATH)/permissions/android.hardware.fingerprint.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.hardware.fingerprint.xml

# A/B
AB_OTA_UPDATER := true

AB_OTA_PARTITIONS += \
    boot \
    dtbo \
    system \
    vbmeta

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

PRODUCT_PACKAGES += \
    otapreopt_script

PRODUCT_PACKAGES += \
     bootctrl.trinket \
     bootctrl.trinket.recovery

# Update engine
PRODUCT_PACKAGES += \
    bootctrl.trinket.recovery \
    update_engine \
    update_engine_sideload \
    update_verifier

PRODUCT_PACKAGES_DEBUG += \
    update_engine_client

# Boot control
PRODUCT_PACKAGES_DEBUG += \
    android.hardware.boot@1.0-impl.recovery \
    bootctl

PRODUCT_PACKAGES += \
    Updater

# Bluetooth
PRODUCT_PACKAGES += \
    BluetoothResCommon

# Boot animation
TARGET_SCREEN_HEIGHT := 1560
TARGET_SCREEN_WIDTH := 720

# Some GSI builds enable dexpreopt, whitelist these preopt files
PRODUCT_ARTIFACT_PATH_REQUIREMENT_WHITELIST += %.odex %.vdex %.art

# Exclude GSI specific files
PRODUCT_ARTIFACT_PATH_REQUIREMENT_WHITELIST += \
    system/etc/init/config/skip_mount.cfg

# Exclude all files under system/product and system/product_services
PRODUCT_ARTIFACT_PATH_REQUIREMENT_WHITELIST += \
    system/product/% \
    system/product_services/%

# GSI specific tasks on boot
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/skip_mount.cfg:$(TARGET_COPY_OUT_SYSTEM)/etc/init/config/skip_mount.cfg

# Overlays
DEVICE_PACKAGE_OVERLAYS += \
    $(LOCAL_PATH)/overlay \

# Dalvik heap configuration for a 4GB phone
$(call inherit-product, frameworks/native/build/phone-xhdpi-4096-dalvik-heap.mk)

# Device uses high-density artwork where available
PRODUCT_AAPT_CONFIG := normal
PRODUCT_AAPT_PREF_CONFIG := xxhdpi

# Audio
PRODUCT_PACKAGES += \
    audio.a2dp.default \
    libaacwrapper

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/audio/audio_policy_configuration.xml:system/etc/audio_policy_configuration.xml

# ANT+
PRODUCT_PACKAGES += \
    AntHalService

# Device-specific settings
PRODUCT_PACKAGES += \
    XiaomiParts

# Display
PRODUCT_PACKAGES += \
    libdisplayconfig \
    libqdMetaData.system \
    libvulkan

# Fingerprint
PRODUCT_COPY_FILES += \
    vendor/aosp/config/permissions/vendor.lineage.biometrics.fingerprint.inscreen.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/vendor.lineage.biometrics.fingerprint.inscreen.xml

PRODUCT_PACKAGES += \
    lineage.biometrics.fingerprint.inscreen@1.0-service.xiaomi_trinket

#Hotspot
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/hostapd.accept:$(TARGET_COPY_OUT_SYSTEM)/etc/hostapd/hostapd.accept \
    $(LOCAL_PATH)/configs/hostapd_default.conf:$(TARGET_COPY_OUT_SYSTEM)/etc/hostapd/hostapd_default.conf \
    $(LOCAL_PATH)/configs/hostapd.deny:$(TARGET_COPY_OUT_SYSTEM)/etc/hostapd/hostapd.deny

# Init
PRODUCT_PACKAGES += \
    init.qcom.rc \
    init.recovery.qcom.rc \
    ueventd.qcom.rc

# IMS
PRODUCT_PACKAGES += \
    ims-ext-common_system \
    ims_ext_common.xml

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.telephony.ims.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.hardware.telephony.ims.xml

# Keylayouts
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/keylayout/gpio-keys.kl:$(TARGET_COPY_OUT_SYSTEM)/usr/keylayout/gpio-keys.kl

# Lights
PRODUCT_PACKAGES += \
    android.hardware.light@2.0-service.xiaomi_trinket

# Media
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/media_profiles_vendor.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/media_profiles_vendor.xml

# Net
PRODUCT_PACKAGES += \
    netutils-wrapper-1.0

# Placeholder
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/placeholder:$(TARGET_COPY_OUT_SYSTEM)/etc/placeholder

# Power
PRODUCT_PACKAGES += \
    power.qcom:64

# Soong
PRODUCT_SOONG_NAMESPACES += \
    device/xiaomi/laurel_sprout

# Telephony
PRODUCT_PACKAGES += \
    telephony-ext \
    qti-telephony-utils \
    qti_telephony_utils.xml \
    qti-telephony-hidl-wrapper \
    qti_telephony_hidl_wrapper.xml

# Boot control HAL
 PRODUCT_PACKAGES += \
     android.hardware.boot@1.0-impl.recovery:64 \

# Wallpapers
PRODUCT_PACKAGES += \
    WallpapersBReel2019


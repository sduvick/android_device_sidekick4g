#
# Copyright (C) 2009 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)

# Inherit some common Samsung stuff.
#$(call inherit-product, device/samsung/common/galaxys.mk)

$(call inherit-product, build/target/product/full.mk)

## (1) First, the most specific values, i.e. the aspects that are specific to GSM
PRODUCT_COPY_FILES += \
    device/samsung/sidekick/init.smdkc110.rc:root/init.smdkc110.rc

PRODUCT_PROPERTY_OVERRIDES += \
    ro.sf.lcd_density=240 \
#   rild.libpath=/system/lib/librilswitch.so \
    rilswitch.vendorlibpath=/system/lib/libsec-ril.so \
    rilswitch.ganlibpath=/system/lib/libganril.so \
    rild.libargs="-d /dev/ttyS0" \
    wifi.interface=eth0 \
    wifi.supplicant_scan_interval=15 \
    mobiledata.interfaces=gannet0,rmnet0,rmnet1,rmnet2 ,ppp0,ppp1,ppp2 \
    ro.wifi.channels=11

## (2) Also get non-open-source GSM-specific aspects if available
$(call inherit-product-if-exists, vendor/samsung/sidekick/sidekick-vendor.mk)

## (3) Finally, the least specific parts, i.e. the non-GSM-specific aspects

# The OpenGL ES API level that is natively supported by this device.
# This is a 16.16 fixed point number
PRODUCT_PROPERTY_OVERRIDES += \
    ro.opengles.version=131072

# we have enough storage space to hold precise GC data
PRODUCT_TAGS += dalvik.gc.type-precise
PRODUCT_PROPERTY_OVERRIDES += \
    ro.phone_storage=1 \
    ro.additionalmounts=/mnt/emmc \
    dalvik.vm.startheapsize=8m \
    dalvik.vm.heapsize=48m \
    dalvik.vm.execution-mode=int:jit \
    dalvik.vm.dexopt-data-only=1 \
    media.stagefright.enable-player=true \
    media.stagefright.enable-meta=true \
    media.stagefright.enable-scan=true \
    media.stagefright.enable-http=true \
    keyguard.no_require_sim=true 

DEVICE_PACKAGE_OVERLAYS += device/samsung/sidekick/overlay

# Misc other modules
PRODUCT_PACKAGES += \
    overlay.s5pc110 

# Keylayout / Keychars
PRODUCT_COPY_FILES += \
    device/samsung/sidekick/prebuilt/keylayout/s3c-keypad.kl:system/usr/keylayout/s3c-keypad.kl \
    device/samsung/sidekick/prebuilt/keylayout/sec_jack.kl:system/usr/keylayout/sec_jack.kl \
    device/samsung/sidekick/prebuilt/keylayout/qt602240_ts_input.kl:system/usr/keylayout/qt602240_ts_input.kl \
    device/samsung/sidekick/prebuilt/keylayout/qwerty.kl:system/usr/keylayout/qwerty.kl \
    device/samsung/sidekick/prebuilt/keychars/sec_jack.kcm.bin:system/usr/keychars/sec_jack.kcm.bin \
    device/samsung/sidekick/prebuilt/keychars/melfas-touchkey.kcm.bin:system/usr/keychars/melfas-touchkey.kcm.bin \
    device/samsung/sidekick/prebuilt/keychars/qwerty.kcm.bin:system/usr/keychars/qwerty.kcm.bin \
    device/samsung/sidekick/prebuilt/keychars/s3c-keypad.kcm.bin:system/usr/keychars/s3c-keypad.kcm.bin \
    device/samsung/sidekick/prebuilt/keychars/qt602240_ts_input.kcm.bin:system/usr/keychars/qt602240_ts_input.kcm.bin \
    device/samsung/sidekick/prebuilt/keychars/qwerty2.kcm.bin:system/usr/keychars/qwerty2.kcm.bin 
	


PRODUCT_COPY_FILES += \
#    device/samsung/sidekick/prebuilt/cameradata/datapattern_420sp.yuv:system/cameradata/datapattern_420sp.yuv  \
#    device/samsung/sidekick/prebuilt/cameradata/datapattern_front_420sp.yuv:system/cameradata/datapattern_front_420sp.yuv \
    device/samsung/sidekick/prebuilt/etc/asound.conf:system/etc/asound.conf \
    device/samsung/sidekick/prebuilt/etc/vold.fstab:system/etc/vold.fstab \
    device/samsung/sidekick/prebuilt/lib/egl/egl.cfg:system/lib/egl/egl.cfg


# Kernel
ifeq ($(TARGET_PREBUILT_KERNEL),)
LOCAL_KERNEL := device/samsung/sidekick/kernel
else
LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
endif
PRODUCT_COPY_FILES += \
    $(LOCAL_KERNEL):kernel

PRODUCT_NAME := cm_sidekick
PRODUCT_DEVICE := sidekick
PRODUCT_MODEL := SGH-T839
PRODUCT_BRAND := Samsung
PRODUCT_MANUFACTURER := Samsung
TARGET_IS_GALAXYS := true

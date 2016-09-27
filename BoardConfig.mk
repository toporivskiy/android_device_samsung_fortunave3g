# inherit from qcom-common
-include device/samsung/qcom-common/BoardConfigCommon.mk

# Inherit from the proprietary version
-include vendor/samsung/fortunave3g/BoardConfigVendor.mk

LOCAL_PATH := device/samsung/fortunave3g

#BLOCK_BASED_OTA := false

# Assert
TARGET_OTA_ASSERT_DEVICE := samsung_sm_g530h,fortunave3g,fortuna3g

# Platform
TARGET_BOARD_PLATFORM           := msm8916
TARGET_BOARD_PLATFORM_GPU       := qcom-adreno306
TARGET_BOOTLOADER_BOARD_NAME    := MSM8916

# Arch
TARGET_GLOBAL_CFLAGS            += -mfpu=neon -mfloat-abi=softfp
TARGET_GLOBAL_CPPFLAGS          += -mfpu=neon -mfloat-abi=softfp
TARGET_CPU_VARIANT              := cortex-a53
TARGET_CPU_CORTEX_A53           := true
ARCH_ARM_HAVE_TLS_REGISTER      := true

# Board CFLAGS
COMMON_GLOBAL_CFLAGS += -DQCOM_BSP

# Qcom
TARGET_PLATFORM_DEVICE_BASE          := /devices/soc.0/
HAVE_SYNAPTICS_I2C_RMI4_FW_UPGRADE   := true
USE_DEVICE_SPECIFIC_QCOM_PROPRIETARY := true
TARGET_USES_QCOM_BSP                 := true
TARGET_USES_NEW_ION_API              :=true

TARGET_SPECIFIC_HEADER_PATH := $(LOCAL_PATH)/include

# Kernel
BOARD_CUSTOM_BOOTIMG_MK      := $(LOCAL_PATH)/mkbootimg.mk
BOARD_KERNEL_BASE            := 0x80000000
BOARD_KERNEL_CMDLINE         := console=ttyHSL0,115200,n8 androidboot.console=ttyHSL0 androidboot.hardware=qcom msm_rtb.filter=0x3F ehci-hcd.park=3 androidboot.bootdevice=7824900.sdhci androidboot.selinux=permissive
BOARD_KERNEL_TAGS_OFFSET     := 0x81E00000
BOARD_RAMDISK_OFFSET         := 0x82000000
BOARD_KERNEL_PAGESIZE        := 2048
BOARD_KERNEL_SEPARATED_DT    := true
TARGET_KERNEL_SOURCE         := kernel/samsung/fortunaxx3g
#TARGET_KERNEL_CUSTOM_TOOLCHAIN  := arm-eabi-4.7
TARGET_KERNEL_CONFIG             := msm8916_fortunave3g_eur_defconfig

# Partition sizes
TARGET_USERIMAGES_USE_EXT4          := true
BOARD_BOOTIMAGE_PARTITION_SIZE      := 13631488
BOARD_RECOVERYIMAGE_PARTITION_SIZE  := 15728640
BOARD_SYSTEMIMAGE_PARTITION_SIZE    := 1568669696
BOARD_CACHEIMAGE_PARTITION_SIZE     := 314572800
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE   := ext4
BOARD_PERSISTIMAGE_PARTITION_SIZE   := 8388608
BOARD_PERSISTIMAGE_FILE_SYSTEM_TYPE := ext4
# (5731495936 - 16384)
BOARD_USERDATAIMAGE_PARTITION_SIZE  := 5731479552
BOARD_FLASH_BLOCK_SIZE              := 131072

# Wifi
BOARD_HAS_QCOM_WLAN              := true
BOARD_HAS_QCOM_WLAN_SDK          := true
BOARD_WLAN_DEVICE                := qcwcn
BOARD_HOSTAPD_DRIVER             := NL80211
BOARD_HOSTAPD_PRIVATE_LIB        := lib_driver_cmd_$(BOARD_WLAN_DEVICE)
BOARD_WPA_SUPPLICANT_DRIVER      := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_$(BOARD_WLAN_DEVICE)
TARGET_PROVIDES_WCNSS_QMI        := true
TARGET_USES_QCOM_WCNSS_QMI       := true
TARGET_USES_WCNSS_CTRL           := true
WPA_SUPPLICANT_VERSION           := VER_0_8_X
WIFI_DRIVER_FW_PATH_STA          := "sta"
WIFI_DRIVER_FW_PATH_AP           := "ap"
WIFI_DRIVER_MODULE_PATH          := "/system/lib/modules/wlan.ko"
WIFI_DRIVER_MODULE_NAME          := "wlan"

WLAN_MODULES:
	mkdir -p $(KERNEL_MODULES_OUT)/pronto
	mv $(KERNEL_MODULES_OUT)/wlan.ko $(KERNEL_MODULES_OUT)/pronto/pronto_wlan.ko
	ln -sf /system/lib/modules/pronto/pronto_wlan.ko $(TARGET_OUT)/lib/modules/wlan.ko

TARGET_KERNEL_MODULES += WLAN_MODULES

# Bluetooth
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := $(LOCAL_PATH)/bluetooth
BOARD_HAVE_BLUETOOTH                        := true
BOARD_HAVE_BLUETOOTH_QCOM                   := true
BLUETOOTH_HCI_USE_MCT                       := true

# Custom RIL class
BOARD_RIL_CLASS                     := ../../../device/samsung/fortunave3g/ril/
PROTOBUF_SUPPORTED                  := true

# Fonts
EXTENDED_FONT_FOOTPRINT             := true

# malloc implementation
MALLOC_IMPL                         := jemalloc

# Vendor Init
TARGET_UNIFIED_DEVICE               := true
TARGET_INIT_VENDOR_LIB              := libinit_msm
TARGET_LIBINIT_DEFINES_FILE         := $(LOCAL_PATH)/init/init_fortunave3g.c

# Audio
TARGET_QCOM_AUDIO_VARIANT            := caf
BOARD_USES_ALSA_AUDIO                := true

# Charger
BOARD_CHARGER_SHOW_PERCENTAGE        := true
BOARD_CHARGER_ENABLE_SUSPEND         := true
BOARD_CHARGING_MODE_BOOTING_LPM      := /sys/class/power_supply/battery/batt_lp_charging

# Enable QCOM FM feature
AUDIO_FEATURE_ENABLED_FM             := true

# Enable HW based full disk encryption
TARGET_HW_DISK_ENCRYPTION            := true

# Build our own PowerHAL
TARGET_POWERHAL_VARIANT              := qcom
CM_POWERHAL_EXTENSION                := qcom

# Vold
TARGET_USE_CUSTOM_LUN_FILE_PATH      := /sys/devices/platform/msm_hsusb/gadget/lun%d/file
BOARD_VOLD_DISC_HAS_MULTIPLE_MAJORS  := true
BOARD_VOLD_MAX_PARTITIONS            := 65

# Camera
TARGET_PROVIDES_CAMERA_HAL           := true
USE_DEVICE_SPECIFIC_CAMERA           := true

# CMHW
BOARD_HARDWARE_CLASS += $(LOCAL_PATH)/cmhw

# Workaround to avoid issues with legacy liblights on QCOM platforms
TARGET_PROVIDES_LIBLIGHT            := true

# Media
TARGET_QCOM_MEDIA_VARIANT           := caf
TARGET_ENABLE_QC_AV_ENHANCEMENTS    := true

# Display
TARGET_CONTINUOUS_SPLASH_ENABLED      := true
TARGET_USES_OVERLAY 		          := true
TARGET_HARDWARE_3D		              := false
TARGET_HAVE_HDMI_OUT 		          := false
USE_OPENGL_RENDERER                   := true
NUM_FRAMEBUFFER_SURFACE_BUFFERS       := 3
MAX_EGL_CACHE_KEY_SIZE                := 12*1024
MAX_EGL_CACHE_SIZE                    := 2048*1024
OVERRIDE_RS_DRIVER                    := libRSDriver.so

# Boot animation
TARGET_SCREEN_WIDTH                 := 540
TARGET_SCREEN_HEIGHT                := 960

# Recovery
TARGET_RECOVERY_FSTAB 				:= $(LOCAL_PATH)/rootdir/fstab.qcom
TARGET_USERIMAGES_USE_EXT4 			:= true
BOARD_HAS_LARGE_FILESYSTEM			:= true
TARGET_RECOVERY_DENSITY 			:= hdpi
BOARD_HAS_NO_MISC_PARTITION 		:= true
BOARD_HAS_NO_SELECT_BUTTON 			:= true
BOARD_RECOVERY_SWIPE 				:= true
BOARD_USE_CUSTOM_RECOVERY_FONT 	    := \"roboto_23x41.h\"
BOARD_USES_MMCUTILS 				:= true
#RECOVERY_VARIANT				    := cm

# Logging
TARGET_USES_LOGD                    := false
	
# Misc.
TARGET_SYSTEM_PROP                  := $(LOCAL_PATH)/system.prop

# Releasetools
TARGET_RELEASETOOLS_EXTENSIONS      := $(LOCAL_PATH)

# SELinux
include device/qcom/sepolicy/sepolicy.mk

BOARD_SEPOLICY_DIRS += \
   device/samsung/fortunave3g/sepolicy

BOARD_SEPOLICY_UNION += \
    bluetooth_loader.te \
    file_contexts \
    mediaserver.te \
    property_contexts \
    system_app.te \
    time_daemon.te \
    vold.te \
    bluetooth.te \
    file.te \
    kernel.te \
    mm-qcamerad.te \
    property.te \
    rild.te \
    system_server.te \
    ueventd.te \
    wcnss_service.te

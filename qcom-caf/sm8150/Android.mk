LOCAL_PATH := $(call my-dir)
HAL_PLATFORM := sm8150
HAL_PATH := hardware/qcom-caf/$(HAL_PLATFORM)

include $(call all-makefiles-under,$(LOCAL_PATH))
include $(call all-makefiles-under,$(HAL_PATH)/audio)
include $(call all-makefiles-under,$(HAL_PATH)/media)

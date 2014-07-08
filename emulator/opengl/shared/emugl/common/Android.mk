# This build script corresponds to a library containing many definitions
# common to both the guest and the host. They relate to
#
LOCAL_PATH := $(call my-dir)

### emugl_common host library ###########################################

commonSources := \
        id_to_object_map.cpp \
        lazy_instance.cpp \
        pod_vector.cpp \
        shared_library.cpp \
        smart_ptr.cpp \
        sockets.cpp \
        thread_store.cpp \

host_commonSources := $(commonSources)

host_commonLdLibs := -lstdc++
ifneq (windows,$(HOST_OS))
    host_commonLdLibs += -ldl
endif

$(call emugl-begin-host-static-library,libemugl_common)
LOCAL_SRC_FILES := $(host_commonSources)
$(call emugl-export,C_INCLUDES,$(EMUGL_PATH)/shared)
$(call emugl-export,LDLIBS,$(host_commonLdLibs))
$(call emugl-end-module)

ifdef EMUGL_BUILD_64BITS
    $(call emugl-begin-host64-static-library,lib64emugl_common)
    LOCAL_SRC_FILES := $(host_commonSources)
    $(call emugl-export,CFLAGS,-m64 -fPIC)
    $(call emugl-export,C_INCLUDES,$(EMUGL_PATH)/shared)
    $(call emugl-export,LDLIBS,$(host_commonLdLibs))
    $(call emugl-end-module)
endif


### emugl_common_unittests ##############################################

host_commonSources := \
    id_to_object_map_unittest.cpp \
    lazy_instance_unittest.cpp \
    pod_vector_unittest.cpp \
    mutex_unittest.cpp \
    shared_library_unittest.cpp \
    smart_ptr_unittest.cpp \
    thread_store_unittest.cpp \

$(call emugl-begin-host-executable,emugl_common_host_unittests)
LOCAL_SRC_FILES := $(host_commonSources)
$(call emugl-import,libemugl_common libemugl_gtest)
$(call emugl-end-module)

ifdef EMUGL_BUILD_64BITS
    $(call emugl-begin-host64-executable,emugl64_common_host_unittests)
    LOCAL_SRC_FILES := $(host_commonSources)
    $(call emugl-import,lib64emugl_common lib64emugl_gtest)
    $(call emugl-end-module)
endif

$(call emugl-begin-host-shared-library,libemugl_test_shared_library)
LOCAL_SRC_FILES := testing/test_shared_library.cpp
$(call emugl-end-module)

ifdef EMUGL_BUILD_64BITS
    $(call emugl-begin-host64-shared-library,lib64emugl_test_shared_library)
    LOCAL_SRC_FILES := testing/test_shared_library.cpp
    $(call emugl-end-module)
endif

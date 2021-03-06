# Copyright 2007 The Android Open Source Project
#
# Copies files into the directory structure described by a manifest

# This tool is prebuilt if we're doing an app-only build.
ifeq ($(TARGET_BUILD_APPS)$(filter true,$(TARGET_BUILD_PDK)),)

LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

LOCAL_CLANG_CFLAGS := -Wall -Werror
# Tragically, the code is riddled with unused parameters.
LOCAL_CLANG_CFLAGS += -Wno-unused-parameter
# yacc dumps a lot of code *just in case*.
LOCAL_CLANG_CFLAGS += -Wno-unused-function
LOCAL_CLANG_CFLAGS += -Wno-unneeded-internal-declaration
# yacc is a tool from a more civilized age.
LOCAL_CLANG_CFLAGS += -Wno-deprecated-register
# yacc also has a habit of using char* over const char*.
LOCAL_CLANG_CFLAGS += -Wno-writable-strings

LOCAL_SRC_FILES := \
	aidl_language_l.l \
	aidl_language_y.y \
	aidl.cpp \
	aidl_language.cpp \
	options.cpp \
	search_path.cpp \
	AST.cpp \
	Type.cpp \
	generate_java.cpp \
	generate_java_binder.cpp \
	generate_java_rpc.cpp

LOCAL_MODULE := aidl

include $(BUILD_HOST_EXECUTABLE)

endif # No TARGET_BUILD_APPS or TARGET_BUILD_PDK

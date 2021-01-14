################################################################################
#
# minetest
#
################################################################################

MINETEST_VERSION = 5.2.0
MINETEST_SITE = $(call github,minetest,minetest,$(MINETEST_VERSION))
MINETEST_LICENSE = LGPL-2.1+ (code), CC-BY-SA-3.0 (textures and sounds)
MINETEST_LICENSE_FILES = LICENSE.txt

MINETEST_DEPENDENCIES = gmp irrlicht jsoncpp luajit sqlite zlib

MINETEST_CONF_OPTS = \
	-DDEFAULT_RUN_IN_PLACE=OFF \
	-DENABLE_GLES=OFF \
	-DENABLE_LUAJIT=ON \
	-DENABLE_CURSES=OFF \
	-DAPPLY_LOCALE_BLACKLIST=OFF \
	-DENABLE_SYSTEM_GMP=ON \
	-DENABLE_SYSTEM_JSONCPP=ON

ifeq ($(BR2_PACKAGE_MINETEST_CLIENT),y)
MINETEST_DEPENDENCIES += bzip2 jpeg libgl libpng xlib_libXxf86vm
MINETEST_CONF_OPTS += -DBUILD_CLIENT=ON
else
MINETEST_CONF_OPTS += -DBUILD_CLIENT=OFF
endif

ifeq ($(BR2_PACKAGE_MINETEST_SERVER),y)
MINETEST_CONF_OPTS += -DBUILD_SERVER=ON
else
MINETEST_CONF_OPTS += -DBUILD_SERVER=OFF
endif

ifeq ($(BR2_PACKAGE_MINETEST_SOUND),y)
MINETEST_DEPENDENCIES += libvorbis openal
MINETEST_CONF_OPTS += -DENABLE_SOUND=ON
else
MINETEST_CONF_OPTS += -DENABLE_SOUND=OFF
endif

ifeq ($(BR2_PACKAGE_FREETYPE),y)
MINETEST_DEPENDENCIES += freetype
MINETEST_CONF_OPTS += -DENABLE_FREETYPE=ON
else
MINETEST_CONF_OPTS += -DENABLE_FREETYPE=OFF
endif

ifeq ($(BR2_PACKAGE_HIREDIS),y)
MINETEST_DEPENDENCIES += hiredis
MINETEST_CONF_OPTS += -DENABLE_REDIS=ON
else
MINETEST_CONF_OPTS += -DENABLE_REDIS=OFF
endif

ifeq ($(BR2_PACKAGE_LEVELDB),y)
MINETEST_DEPENDENCIES += leveldb
MINETEST_CONF_OPTS += -DENABLE_LEVELDB=ON
else
MINETEST_CONF_OPTS += -DENABLE_LEVELDB=OFF
endif

ifeq ($(BR2_PACKAGE_LIBCURL),y)
MINETEST_DEPENDENCIES += libcurl
MINETEST_CONF_OPTS += -DENABLE_CURL=ON
else
MINETEST_CONF_OPTS += -DENABLE_CURL=OFF
endif

ifeq ($(BR2_PACKAGE_LIBSPATIALINDEX),y)
MINETEST_DEPENDENCIES += libspatialindex
MINETEST_CONF_OPTS += -DENABLE_SPATIAL=ON
else
MINETEST_CONF_OPTS += -DENABLE_SPATIAL=OFF
endif

ifeq ($(BR2_PACKAGE_POSTGRESQL),y)
MINETEST_DEPENDENCIES += postgresql
MINETEST_CONF_OPTS += -DENABLE_POSTGRESQL=ON
else
MINETEST_CONF_OPTS += -DENABLE_POSTGRESQL=OFF
endif

ifeq ($(BR2_SYSTEM_ENABLE_NLS),y)
MINETEST_DEPENDENCIES += $(TARGET_NLS_DEPENDENCIES)
MINETEST_CONF_OPTS += -DENABLE_GETTEXT=ON
else
MINETEST_CONF_OPTS += -DENABLE_GETTEXT=OFF
endif

$(eval $(cmake-package))

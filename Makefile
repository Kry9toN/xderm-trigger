#
# Copyright (C) 2014 OpenWrt-dist
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=xderm-trigger
PKG_VERSION:=1.1.1
PKG_RELEASE:=1

PKG_LICENSE:=GPL-3.0
PKG_LICENSE_FILES:=LICENSE

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/Kry9toN/xderm-trigger
PKG_SOURCE_VERSION:=37f6ba62735f05ba54c0ea96a344a58476af9335

PKG_FIXUP:=autoreconf
PKG_FIXUP:=patch-libtool
PKG_FIXUP:=gettext-version

include $(INCLUDE_DIR)/package.mk

define Package/xderm-trigger
	SECTION:=net
	CATEGORY:=Network
	TITLE:=Trigger xderm for no internet and have internet
	MAINTAINER:=Kry9toN
	URL:=https://github.com/Kry9toN/xderm-trigger
	DEPENDS:=curl
endef

define Package/xderm-trigger/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/out/xderm-trigger $(1)/usr/bin
endef

CONFIGURE_ARGS += \
	--disable-documentation \
	--disable-ssp \
	--disable-assert \
	--enable-system-shared-lib

TARGET_CFLAGS += -lcurl

$(eval $(call BuildPackage,xderm-trigger))

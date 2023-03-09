#!/bin/bash
# Copyright (c) 2022-2023 Curious <https://www.curious.host>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
# 
# https://github.com/Curious-r/OpenWrtBuildWorkflows
# Description: Automatically check OpenWrt source code update and build it. No additional keys are required.
#-------------------------------------------------------------------------------------------------------
#
#
# This script will run before feeds update, something you want to do at that moment should be written here.
# A common function of this script is to modify the cloned OpenWrt source code. 
#
# For instance, you can edit the feeds.conf.default to induct packages you need.
# This is followed by some editing examples.
# # Clear the feeds.conf.default and append the feed sources you need one by one:
#cat /dev/null > a.txt
#echo 'src-git-full packages https://git.openwrt.org/feed/packages.git;openwrt-22.03' >> feeds.conf.default
#echo 'src-git-full luci https://git.openwrt.org/project/luci.git;openwrt-22.03' >> feeds.conf.default
#echo 'src-git-full routing https://git.openwrt.org/feed/routing.git;openwrt-22.03' >> feeds.conf.default
#echo 'src-git-full telephony https://git.openwrt.org/feed/telephony.git;openwrt-22.03' >> feeds.conf.default
# # Replace a feed source with what you want:
#sed '/feeds-name/'d feeds.conf.default
#echo 'method feed-name path/URL' >> feeds.conf.default
# # Uncomment a feed source:
#sed -i 's/^#\(.*feed-name\)/\1/' feeds.conf.default
#
# You can also modify the source code by patching.
# # Here's a template for patching:
#touch example.patch
#cat>example.patch<<EOF
#patch content
#EOF
#git apply example.patch

cd ./feeds/kenzo/
touch 0001-Update-header.htm.patch
cat>0001-Update-header.htm.patch<<EOF
Subject: [PATCH] Update header.htm
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

使底栏小飞机图标指向openclash
---
 luci-theme-neobird/luasrc/view/themes/neobird/header.htm | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/luci-theme-neobird/luasrc/view/themes/neobird/header.htm b/luci-theme-neobird/luasrc/view/themes/neobird/header.htm
index 5ce8f20..fe728f8 100644
--- a/luci-theme-neobird/luasrc/view/themes/neobird/header.htm
+++ b/luci-theme-neobird/luasrc/view/themes/neobird/header.htm
@@ -154,7 +154,7 @@
 
 <div class="navbar">
   <a href="/cgi-bin/luci/admin/status/overview"><img src="<%=media%>/images/home.png" /></a>
-  <a href="/cgi-bin/luci/admin/services/shadowsocksr"><img src="<%=media%>/images/ssr.png" /></a>
+  <a href="/cgi-bin/luci/admin/services/openclash"><img src="<%=media%>/images/ssr.png" /></a>
   <a href="/cgi-bin/luci/admin/network/network"><img src="<%=media%>/images/link.png" /></a>
   <a href="/cgi-bin/luci/admin/status/realtime"><img src="<%=media%>/images/rank.png" /></a>
   <a href="/cgi-bin/luci/admin/system/admin"><img src="<%=media%>/images/user.png" /></a>
-- 
EOF
git apply 0001-Update-header.htm.patch

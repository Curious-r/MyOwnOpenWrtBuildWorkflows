#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# Modify default IP
#sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate
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

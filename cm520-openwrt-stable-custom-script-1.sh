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

touch 0001-opboot.patch
cat>0001-opboot.patch<<EOF
Subject: [PATCH] =?UTF-8?q?=E9=80=82=E9=85=8Dopboot?=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

修改nand分区以适配opboot
---
 .../arm/boot/dts/qcom-ipq4019-cm520-79f.dts   | 64 +------------------
 1 file changed, 3 insertions(+), 61 deletions(-)

diff --git a/target/linux/ipq40xx/files/arch/arm/boot/dts/qcom-ipq4019-cm520-79f.dts b/target/linux/ipq40xx/files/arch/arm/boot/dts/qcom-ipq4019-cm520-79f.dts
index 1dde17e293..669fd5a784 100644
--- a/target/linux/ipq40xx/files/arch/arm/boot/dts/qcom-ipq4019-cm520-79f.dts
+++ b/target/linux/ipq40xx/files/arch/arm/boot/dts/qcom-ipq4019-cm520-79f.dts
@@ -196,66 +196,8 @@
 			#size-cells = <1>;
 
 			partition@0 {
-				label = "SBL1";
-				reg = <0x0 0x100000>;
-				read-only;
-			};
-
-			partition@100000 {
-				label = "MIBIB";
-				reg = <0x100000 0x100000>;
-				read-only;
-			};
-
-			partition@200000 {
-				label = "BOOTCONFIG";
-				reg = <0x200000 0x100000>;
-			};
-
-			partition@300000 {
-				label = "QSEE";
-				reg = <0x300000 0x100000>;
-				read-only;
-			};
-
-			partition@400000 {
-				label = "QSEE_1";
-				reg = <0x400000 0x100000>;
-				read-only;
-			};
-
-			partition@500000 {
-				label = "CDT";
-				reg = <0x500000 0x80000>;
-				read-only;
-			};
-
-			partition@580000 {
-				label = "CDT_1";
-				reg = <0x580000 0x80000>;
-				read-only;
-			};
-
-			partition@600000 {
-				label = "BOOTCONFIG1";
-				reg = <0x600000 0x80000>;
-			};
-
-			partition@680000 {
-				label = "APPSBLENV";
-				reg = <0x680000 0x80000>;
-			};
-
-			partition@700000 {
-				label = "APPSBL";
-				reg = <0x700000 0x200000>;
-				read-only;
-			};
-
-			partition@900000 {
-				label = "APPSBL_1";
-				reg = <0x900000 0x200000>;
-				read-only;
+				label = "Bootloader";
+				reg = <0x0 0xb00000>;
 			};
 
 			art: partition@b00000 {
@@ -284,7 +226,7 @@
 			};
 
 			partition@b80000 {
-				label = "ubi";
+				label = "rootfs";
 				reg = <0xb80000 0x7480000>;
 			};
 		};
-- 
EOF
git apply 0001-opboot.patch

echo 'src-git design https://github.com/gngpp/luci-theme-design.git;js' >> feeds.conf.default
echo 'src-git ddns_go https://github.com/sirpdboy/luci-app-ddns-go.git' >> feeds.conf.default
echo 'src-svn openclash https://github.com/vernesong/OpenClash/trunk/luci-app-openclash' >> feeds.conf.default

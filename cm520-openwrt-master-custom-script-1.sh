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
# # Replace src-git-full with src-git to reduce the depth of cloning:
#sed -i 's/src-git-full/src-git/g' feeds.conf.default
#
# You can also modify the source code by patching.
# # Here's a template for patching:
#touch example.patch
#cat>example.patch<<EOF
#patch content
#EOF
#git apply example.patch

touch opboot.patch
cat>opboot.patch<<EOF
From 0003ff9e977f675b03c2a472c98b3fba634b15c1 Mon Sep 17 00:00:00 2001
From: Curious <Curious@curious.host>
Date: Wed, 15 Mar 2023 14:32:33 +0800
Subject: [PATCH] ipq40xx: adapt the DTS of MobiPromo CM520-79F to opboot

---
 .../arm/boot/dts/qcom-ipq4019-cm520-79f.dts   | 68 ++-----------------
 1 file changed, 7 insertions(+), 61 deletions(-)

diff --git a/target/linux/ipq40xx/files/arch/arm/boot/dts/qcom-ipq4019-cm520-79f.dts b/target/linux/ipq40xx/files/arch/arm/boot/dts/qcom-ipq4019-cm520-79f.dts
index 1dde17e293..1224a0cb9e 100644
--- a/target/linux/ipq40xx/files/arch/arm/boot/dts/qcom-ipq4019-cm520-79f.dts
+++ b/target/linux/ipq40xx/files/arch/arm/boot/dts/qcom-ipq4019-cm520-79f.dts
@@ -16,6 +16,10 @@
 		led-upgrade = &led_sys;
 	};
 
+	chosen {
+		bootargs-append = " ubi.block=0,1 root=/dev/ubiblock0_1";
+	};
+
 	soc {
 		rng@22000 {
 			status = "okay";
@@ -196,66 +200,8 @@
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
@@ -284,7 +230,7 @@
 			};
 
 			partition@b80000 {
-				label = "ubi";
+				label = "rootfs";
 				reg = <0xb80000 0x7480000>;
 			};
 		};
-- 
2.30.2


EOF
git config --global user.email "Curious@curious.host"
git config --global user.name "Curious"
git am opboot.patch

sed -i 's/src-git-full/src-git/g' feeds.conf.default
git clone --depth 1 --branch js  --single-branch https://github.com/gngpp/luci-theme-design.git package/luci-theme-design/
git clone --depth 1 https://github.com/sirpdboy/luci-app-ddns-go.git package/ddns-go/
svn co https://github.com/vernesong/OpenClash/trunk/luci-app-openclash package/luci-app-openclash/

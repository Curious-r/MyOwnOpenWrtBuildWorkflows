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

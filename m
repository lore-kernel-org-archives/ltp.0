From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Date: Wed, 23 Jun 2021 17:30:02 +0200
Subject: [LTP] [PATCH v2 1/2] lib: Add tst_virt_hyperv
Message-ID: <20210623153003.94404-1-krzysztof.kozlowski@canonical.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Move the Microsoft Hyper-V detection to lib/ so it can be reused in
further tests.  Add it also to the newlib.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

---

Changes since v1:
1. New patch.
---
 .../include/cpuhotplug_testsuite.sh            | 15 ---------------
 testcases/lib/test.sh                          | 16 ++++++++++++++++
 testcases/lib/tst_test.sh                      | 18 ++++++++++++++++++
 3 files changed, 34 insertions(+), 15 deletions(-)

diff --git a/testcases/kernel/hotplug/cpu_hotplug/include/cpuhotplug_testsuite.sh b/testcases/kernel/hotplug/cpu_hotplug/include/cpuhotplug_testsuite.sh
index 291dc5ab2b7e..7dd0ebaae069 100644
--- a/testcases/kernel/hotplug/cpu_hotplug/include/cpuhotplug_testsuite.sh
+++ b/testcases/kernel/hotplug/cpu_hotplug/include/cpuhotplug_testsuite.sh
@@ -50,21 +50,6 @@ assert ()                 #  If condition false,
   fi
 }
 
-# Detect whether running under hypervisor: Microsoft Hyper-V
-# Return 0: running under Hyper-V
-# Return 1: not running under Hyper-V (bare metal, other hypervisor or
-#           failure of detection)
-tst_virt_hyperv()
-{
-	local v="$(systemd-detect-virt)"
-	# TODO: once converted to newlib, use tst_cmd_available
-
-	[ $? -eq 0 ] || return 1
-	[ "$v" = "microsoft" ] || return 1
-
-	return 0
-}
-
 ############################################################
 ## Process management                                     ##
 ############################################################
diff --git a/testcases/lib/test.sh b/testcases/lib/test.sh
index a15fb0540d3e..3facb7fd1f9d 100644
--- a/testcases/lib/test.sh
+++ b/testcases/lib/test.sh
@@ -321,6 +321,22 @@ tst_mkfs()
 	ROD_SILENT mkfs.$fs_type $fs_opts $device
 }
 
+# Detect whether running under hypervisor: Microsoft Hyper-V
+# Return 0: running under Hyper-V
+# Return 1: not running under Hyper-V (bare metal, other hypervisor or
+#           failure of detection)
+tst_virt_hyperv()
+{
+	local v
+	
+	v="$(systemd-detect-virt)"
+
+	[ $? -eq 0 ] || return 1
+	[ "$v" = "microsoft" ] || return 1
+
+	return 0
+}
+
 tst_umount()
 {
 	local device="$1"
diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 8b4e9cb6007b..f0b47e2d6e2c 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -326,6 +326,24 @@ tst_mkfs()
 	ROD_SILENT mkfs.$fs_type $fs_opts $device
 }
 
+# Detect whether running under hypervisor: Microsoft Hyper-V
+# Return 0: running under Hyper-V
+# Return 1: not running under Hyper-V (bare metal, other hypervisor or
+#           failure of detection)
+tst_virt_hyperv()
+{
+	local v
+	
+	tst_cmd_available systemd-detect-virt || return 1
+
+	v="$(systemd-detect-virt)"
+
+	[ $? -eq 0 ] || return 1
+	[ "$v" = "microsoft" ] || return 1
+
+	return 0
+}
+
 tst_cmd_available()
 {
 	if type command > /dev/null 2>&1; then
-- 
2.27.0


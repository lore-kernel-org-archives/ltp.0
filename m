From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Date: Wed,  9 Jun 2021 10:03:13 +0200
Subject: [LTP] [PATCH] hotplug/cpu_hotplug: skip unsupported Microsoft
 Hyper-V
Message-ID: <20210609080313.15359-1-krzysztof.kozlowski@canonical.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Microsoft Hyper-V with Linux guests does not support CPU hotplug, even
if enabled in kernel configuration.  Quoting Ubuntu bug report from
June 2018: "While Hyper-V may present all potential CPUs via ACPI MADT,
CPU add/remove is not supported.". [1]

Detect the Hyper-V with systemd and if it succeeds, skip the test.
This of course does not support all possible cases, e.g. running tests
under Hyper-V without systemd will still fail, but it's a easy way to
avoid test failure in common configuration.

Ideally the newly introduced tst_virt_hyperv should be added to
testcases/lib but first the CPU hotplug tests would have to be converted
to newlib.

[1] https://bugs.launchpad.net/ubuntu/+source/linux-azure/+bug/1776293

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../cpu_hotplug/functional/cpuhotplug01.sh        |  4 ++++
 .../cpu_hotplug/functional/cpuhotplug02.sh        |  4 ++++
 .../cpu_hotplug/functional/cpuhotplug03.sh        |  4 ++++
 .../cpu_hotplug/functional/cpuhotplug04.sh        |  4 ++++
 .../cpu_hotplug/functional/cpuhotplug05.sh        |  4 ++++
 .../cpu_hotplug/functional/cpuhotplug06.sh        |  4 ++++
 .../cpu_hotplug/functional/cpuhotplug07.sh        |  4 ++++
 .../cpu_hotplug/include/cpuhotplug_testsuite.sh   | 15 +++++++++++++++
 8 files changed, 43 insertions(+)

diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug01.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug01.sh
index 1ba937cc763b..1dc26e9d484f 100755
--- a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug01.sh
+++ b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug01.sh
@@ -111,6 +111,10 @@ LOOP_COUNT=1
 
 tst_require_cmds perl
 
+if tst_virt_hyperv ; then
+	tst_brkm TCONF "Microsoft Hyper-V detected, no support for CPU hotplug"
+fi
+
 if [ $(get_present_cpus_num) -lt 2 ]; then
 	tst_brkm TCONF "system doesn't have required CPU hotplug support"
 fi
diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug02.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug02.sh
index 792f8cd730a6..8b57b4f4039f 100755
--- a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug02.sh
+++ b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug02.sh
@@ -54,6 +54,10 @@ done
 
 LOOP_COUNT=1
 
+if tst_virt_hyperv ; then
+	tst_brkm TCONF "Microsoft Hyper-V detected, no support for CPU hotplug"
+fi
+
 if [ $(get_present_cpus_num) -lt 2 ]; then
 	tst_brkm TCONF "system doesn't have required CPU hotplug support"
 fi
diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug03.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug03.sh
index 9ea49f0e1646..bd2221d46c7f 100755
--- a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug03.sh
+++ b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug03.sh
@@ -63,6 +63,10 @@ done
 
 LOOP_COUNT=1
 
+if tst_virt_hyperv ; then
+	tst_brkm TCONF "Microsoft Hyper-V detected, no support for CPU hotplug"
+fi
+
 cpus_num=$(get_present_cpus_num)
 if [ $cpus_num -lt 2 ]; then
 	tst_brkm TCONF "system doesn't have required CPU hotplug support"
diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug04.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug04.sh
index fa4e247f96b2..ca8a94496bb3 100755
--- a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug04.sh
+++ b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug04.sh
@@ -48,6 +48,10 @@ done
 
 LOOP_COUNT=1
 
+if tst_virt_hyperv ; then
+	tst_brkm TCONF "Microsoft Hyper-V detected, no support for CPU hotplug"
+fi
+
 cpus_num=$(get_present_cpus_num)
 if [ $cpus_num -lt 2 ]; then
 	tst_brkm TCONF "system doesn't have required CPU hotplug support"
diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug05.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug05.sh
index 95a8f4a2dd83..95ff413dc3a5 100755
--- a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug05.sh
+++ b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug05.sh
@@ -61,6 +61,10 @@ LOOP_COUNT=1
 
 tst_require_cmds sar
 
+if tst_virt_hyperv ; then
+	tst_brkm TCONF "Microsoft Hyper-V detected, no support for CPU hotplug"
+fi
+
 if [ $(get_present_cpus_num) -lt 2 ]; then
 	tst_brkm TCONF "system doesn't have required CPU hotplug support"
 fi
diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug06.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug06.sh
index 2a62225c76dd..074fb15dd5a7 100755
--- a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug06.sh
+++ b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug06.sh
@@ -49,6 +49,10 @@ done
 
 LOOP_COUNT=1
 
+if tst_virt_hyperv ; then
+	tst_brkm TCONF "Microsoft Hyper-V detected, no support for CPU hotplug"
+fi
+
 if top -v | grep -q htop; then
 	tst_brkm TCONF "htop is used instead of top (workaround: alias top='/path/to/real/top')"
 fi
diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug07.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug07.sh
index 2783046189fa..b07d4dc0c073 100755
--- a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug07.sh
+++ b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug07.sh
@@ -55,6 +55,10 @@ done
 
 LOOP_COUNT=1
 
+if tst_virt_hyperv ; then
+	tst_brkm TCONF "Microsoft Hyper-V detected, no support for CPU hotplug"
+fi
+
 if [ $(get_present_cpus_num) -lt 2 ]; then
 	tst_brkm TCONF "system doesn't have required CPU hotplug support"
 fi
diff --git a/testcases/kernel/hotplug/cpu_hotplug/include/cpuhotplug_testsuite.sh b/testcases/kernel/hotplug/cpu_hotplug/include/cpuhotplug_testsuite.sh
index 7dd0ebaae069..291dc5ab2b7e 100644
--- a/testcases/kernel/hotplug/cpu_hotplug/include/cpuhotplug_testsuite.sh
+++ b/testcases/kernel/hotplug/cpu_hotplug/include/cpuhotplug_testsuite.sh
@@ -50,6 +50,21 @@ assert ()                 #  If condition false,
   fi
 }
 
+# Detect whether running under hypervisor: Microsoft Hyper-V
+# Return 0: running under Hyper-V
+# Return 1: not running under Hyper-V (bare metal, other hypervisor or
+#           failure of detection)
+tst_virt_hyperv()
+{
+	local v="$(systemd-detect-virt)"
+	# TODO: once converted to newlib, use tst_cmd_available
+
+	[ $? -eq 0 ] || return 1
+	[ "$v" = "microsoft" ] || return 1
+
+	return 0
+}
+
 ############################################################
 ## Process management                                     ##
 ############################################################
-- 
2.27.0


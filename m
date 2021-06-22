From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Date: Tue, 22 Jun 2021 16:59:38 +0200
Subject: [LTP] [PATCH] controllers/cpuset_hotplug: skip unsupported
 Microsoft Hyper-V
Message-ID: <20210622145938.106477-1-krzysztof.kozlowski@canonical.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Microsoft Hyper-V with Linux guests does not support CPU hotplug, even
if enabled in kernel configuration.  Quoting Ubuntu bug report from
June 2018: "While Hyper-V may present all potential CPUs via ACPI MADT,
CPU add/remove is not supported.". [1]

The test fails on Azure clouds with:

    cpuset_hotplug 1 TINFO: /bin/echo: write error: Device or resource busy
    cpuset_hotplug 1 TFAIL:  CPU#1 failed.
    cpuset_hotplug 3 TINFO: /bin/echo: write error: Device or resource busy
    cpuset_hotplug 3 TFAIL: setup test environment(offline CPU#1) failed
    cpuset_hotplug 5 TINFO: /bin/echo: write error: Device or resource busy
    cpuset_hotplug 5 TFAIL:  CPU#1 failed.
    cpuset_hotplug 7 TINFO: /bin/echo: write error: Device or resource busy
    cpuset_hotplug 7 TFAIL:  CPU#1 failed.
    cpuset_hotplug 9 TINFO: /bin/echo: write error: Device or resource busy
    cpuset_hotplug 9 TFAIL:  CPU#1 failed.
    cpuset_hotplug 11 TINFO: /bin/echo: write error: Device or resource busy
    cpuset_hotplug 11 TFAIL: setup test environment(offline CPU#1) failed

Detect the Hyper-V with systemd and if it succeeds, skip the test.
This of course does not support all possible cases, e.g. running tests
under Hyper-V without systemd will still fail, but it's a easy way to
avoid test failure in common configuration.

Ideally the newly introduced tst_virt_hyperv should be added to
testcases/lib but first the tests would have to be converted to newlib.

[1] https://bugs.launchpad.net/ubuntu/+source/linux-azure/+bug/1776293

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../kernel/controllers/cpuset/cpuset_funcs.sh | 25 +++++++++++++++++++
 .../include/cpuhotplug_testsuite.sh           |  2 ++
 2 files changed, 27 insertions(+)

diff --git a/testcases/kernel/controllers/cpuset/cpuset_funcs.sh b/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
index f3ba1d5ca931..397784a3f2ac 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
@@ -63,6 +63,23 @@ HOTPLUG_CPU="1"
 SCHED_LB="/dev/cpuset/cpuset.sched_load_balance"
 SCHED_LB_VALUE="0"
 
+# Detect whether running under hypervisor: Microsoft Hyper-V
+# Return 0: running under Hyper-V
+# Return 1: not running under Hyper-V (bare metal, other hypervisor or
+#           failure of detection)
+# TODO: move to newlib and remove duplication with:
+#       testcases/kernel/hotplug/cpu_hotplug/include/cpuhotplug_testsuite.sh
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
 cpuset_log()
 {
 	tst_resm TINFO "$*"
@@ -134,6 +151,13 @@ cpuset_check()
 	tst_brkm TCONF "Cpuset is not supported"
 }
 
+machine_check()
+{
+	if tst_virt_hyperv; then
+		tst_brkm TCONF "Microsoft Hyper-V detected, no support for CPU hotplug"
+	fi
+}
+
 # optional parameters (pass both or none of them):
 # $1 - required number of cpus (default 2)
 # $2 - required number of memory nodes (default 2)
@@ -149,6 +173,7 @@ check()
 
 	nnodes_check ${2:-2}
 
+	machine_check
 }
 
 # Create /dev/cpuset & mount the cgroup file system with cpuset
diff --git a/testcases/kernel/hotplug/cpu_hotplug/include/cpuhotplug_testsuite.sh b/testcases/kernel/hotplug/cpu_hotplug/include/cpuhotplug_testsuite.sh
index 291dc5ab2b7e..561b7cf85370 100644
--- a/testcases/kernel/hotplug/cpu_hotplug/include/cpuhotplug_testsuite.sh
+++ b/testcases/kernel/hotplug/cpu_hotplug/include/cpuhotplug_testsuite.sh
@@ -54,6 +54,8 @@ assert ()                 #  If condition false,
 # Return 0: running under Hyper-V
 # Return 1: not running under Hyper-V (bare metal, other hypervisor or
 #           failure of detection)
+# TODO: move to newlib and remove duplication with:
+#       testcases/kernel/controllers/cpuset/cpuset_funcs.sh
 tst_virt_hyperv()
 {
 	local v="$(systemd-detect-virt)"
-- 
2.27.0


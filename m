From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Date: Wed, 23 Jun 2021 17:30:03 +0200
Subject: [LTP] [PATCH v2 2/2] controllers/cpuset: skip unsupported Microsoft
 Hyper-V
In-Reply-To: <20210623153003.94404-1-krzysztof.kozlowski@canonical.com>
References: <20210623153003.94404-1-krzysztof.kozlowski@canonical.com>
Message-ID: <20210623153003.94404-2-krzysztof.kozlowski@canonical.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Microsoft Hyper-V with Linux guests does not support CPU hotplug, even
if enabled in kernel configuration.  Quoting Ubuntu bug report from
June 2018: "While Hyper-V may present all potential CPUs via ACPI MADT,
CPU add/remove is not supported.". [1]

The cpuset_hotplug, cpuset_memory_spread, cpuset_sched_domains,
cpuset_memory_pressure abd cpuset_load_balance fail on Azure clouds with:

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

[1] https://bugs.launchpad.net/ubuntu/+source/linux-azure/+bug/1776293

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

---

Changes since v1:
1. tst_virt_hyperv moved to patch #1.
---
 testcases/kernel/controllers/cpuset/cpuset_funcs.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/testcases/kernel/controllers/cpuset/cpuset_funcs.sh b/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
index f3ba1d5ca931..9939f13a3218 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
@@ -134,6 +134,13 @@ cpuset_check()
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
@@ -149,6 +156,7 @@ check()
 
 	nnodes_check ${2:-2}
 
+	machine_check
 }
 
 # Create /dev/cpuset & mount the cgroup file system with cpuset
-- 
2.27.0


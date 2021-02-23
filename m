From: Zhao Gongyi <zhaogongyi@huawei.com>
Date: Tue, 23 Feb 2021 11:37:38 +0800
Subject: [LTP] [PATCH] cpu_hotplug: Add executable file's path
Message-ID: <20210223033738.22666-1-zhaogongyi@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

When env PATH is not include current path, run cpuhotplug_do_disk_write_loop/
cpuhotplug_do_spin_loop/cpuhotplug_do_kcompile_loop/
cpuhotplug_report_proc_interrupts will fail.

For those:
	testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug01.sh
	testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug02.sh
	testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug03.sh
	testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug07.sh

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
 .../kernel/hotplug/cpu_hotplug/functional/cpuhotplug01.sh     | 4 ++--
 .../kernel/hotplug/cpu_hotplug/functional/cpuhotplug02.sh     | 2 +-
 .../kernel/hotplug/cpu_hotplug/functional/cpuhotplug03.sh     | 2 +-
 .../kernel/hotplug/cpu_hotplug/functional/cpuhotplug07.sh     | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug01.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug01.sh
index 1ba937cc7..b1c8a9b97 100755
--- a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug01.sh
+++ b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug01.sh
@@ -137,7 +137,7 @@ cpu_states=$(get_all_cpu_states)
 CPU_COUNT=0

 # Start up a process that writes to disk; keep track of its PID
-cpuhotplug_do_disk_write_loop > /dev/null 2>&1 &
+./cpuhotplug_do_disk_write_loop > /dev/null 2>&1 &
 WRL_ID=$!

 until [ $LOOP_COUNT -gt $HOTPLUG01_LOOPS ]
@@ -181,7 +181,7 @@ do
 	# Print out a report showing the changes in IRQs
 	echo
 	echo
-	cpuhotplug_report_proc_interrupts "$IRQ_START" "$IRQ_END"
+	./cpuhotplug_report_proc_interrupts "$IRQ_START" "$IRQ_END"
 	echo

 	sleep $TM_DLY
diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug02.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug02.sh
index 792f8cd73..f8a1395c1 100755
--- a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug02.sh
+++ b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug02.sh
@@ -77,7 +77,7 @@ fi
 TST_CLEANUP=do_clean

 # Start up a process that just uses CPU cycles
-cpuhotplug_do_spin_loop > /dev/null&
+./cpuhotplug_do_spin_loop > /dev/null&
 SPIN_LOOP_PID=$!

 sleep 5
diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug03.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug03.sh
index 9ea49f0e1..75a05a3c9 100755
--- a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug03.sh
+++ b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug03.sh
@@ -102,7 +102,7 @@ until [ $LOOP_COUNT -gt $HOTPLUG03_LOOPS ]; do
 	# so we can kill them later.
 	number_of_procs=$((cpus_num*2))
 	until [ $number_of_procs -eq 0 ]; do
-		cpuhotplug_do_spin_loop > /dev/null 2>&1 &
+		./cpuhotplug_do_spin_loop > /dev/null 2>&1 &
 		echo $! >> /var/run/hotplug4_$$.pid
 		number_of_procs=$((number_of_procs-1))
 	done
diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug07.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug07.sh
index 278304618..e8ab78e8c 100755
--- a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug07.sh
+++ b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug07.sh
@@ -81,7 +81,7 @@ fi

 TST_CLEANUP=do_clean

-cpuhotplug_do_kcompile_loop $KERNEL_DIR > /dev/null 2>&1 &
+./cpuhotplug_do_kcompile_loop $KERNEL_DIR > /dev/null 2>&1 &
 KCOMPILE_LOOP_PID=$!

 tst_resm TINFO "initial CPU affinity for kernel compile is: \
--
2.17.1


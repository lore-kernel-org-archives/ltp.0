From: Chuyu Hu <chuhu@redhat.com>
Date: Thu, 24 Dec 2015 13:22:03 +0800
Subject: [LTP] [PATCH] ftrace_stress_test: check if tracing_enabled is
	supported
Message-ID: <1450934523-69837-1-git-send-email-chuhu@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

When running the tests on RHEL7, got message as below:
---------
/mnt/testarea/ltp/testcases/bin/ftrace_stress/ftrace_tracing_enabled.sh: line 25: /mnt/testarea/ltp/testcases/bin/debugfs/tracing/tracing_enabled: Permission denied
/mnt/testarea/ltp/testcases/bin/ftrace_stress/ftrace_tracing_enabled.sh: line 26: /mnt/testarea/ltp/testcases/bin/debugfs/tracing/tracing_enabled: Permission denied
---------

The reason is that the tracing_enabled file has been removed
since kernel v3.8 by commits:

02404ba tracing: Remove deprecated tracing_enabled file
0fb9656 tracing: Make tracing_enabled be equal to tracing_on
6752ab4 tracing: Deprecate tracing_enabled for tracing_on

This workaround fix just uses a similar way of the original author:
1. check if the tracing_enabled is supported when save/restore the value of the file.
2. check if the tracing_enabled is supported in the trace_tracing_enabled.sh

Signed-off-by: Chuyu Hu <chuhu@redhat.com>
---
 .../ftrace_stress/ftrace_tracing_enabled.sh                   | 11 +++++++++++
 .../kernel/tracing/ftrace_stress_test/ftrace_stress_test.sh   | 10 ++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_tracing_enabled.sh b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_tracing_enabled.sh
index 69f2ae6..af83b19 100755
--- a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_tracing_enabled.sh
+++ b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_tracing_enabled.sh
@@ -16,8 +16,19 @@
 MAX_LOOP=1500
 count=0
 
+if [ ! -e $TRACING_PATH/tracing_enabled ]; then
+	should_skip=1
+else
+	should_skip=0
+fi
+
 for ((; ;))
 {
+	if [ $should_skip -eq 1 ]; then
+		sleep 2
+		continue
+	fi
+
 	count=$(( $count + 1 ))
 
 	for ((i = 0; i < $MAX_LOOP; i++))
diff --git a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress_test.sh b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress_test.sh
index 6a111e9..f36c835 100755
--- a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress_test.sh
+++ b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress_test.sh
@@ -42,13 +42,16 @@ save_old_setting()
 
 	old_trace_options=( `cat trace_options` )
 	old_tracing_on=`cat tracing_on`
-	old_tracing_enabled=`cat tracing_enabled`
 	old_buffer_size=`cat buffer_size_kb`
 
 	if [ -e stack_max_size ]; then
 		old_stack_tracer_enabled=`cat /proc/sys/kernel/stack_tracer_enabled`
 	fi
 
+	if [ -e tracing_enabled ]; then
+		old_tracing_enabled=`cat tracing_enabled`
+	fi
+
 	if [ -e "/proc/sys/kernel/ftrace_enabled" ]; then
 		old_ftrace_enabled=`cat /proc/sys/kernel/ftrace_enabled`
 	fi
@@ -85,9 +88,12 @@ restore_old_setting()
 		echo 0 > stack_max_size
 	fi
 
+	if [ -e tracing_enabled ]; then
+		echo $old_tracing_enabled > tracing_enabled
+	fi
+
 	echo $old_buffer_size > buffer_size_kb
 	echo $old_tracing_on > tracing_on
-	echo $old_tracing_enabled > tracing_enabled
 
 	for option in $old_trace_options
 	do
-- 
1.8.3.1


From: Chuyu Hu <chuhu@redhat.com>
Date: Tue, 22 Dec 2015 19:45:30 +0800
Subject: [LTP] [PATCH] ftrace_stress_test.sh: remove the tracing_enabled
	file tests
Message-ID: <1450784730-43354-1-git-send-email-chuhu@redhat.com>
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

Signed-off-by: Chuyu Hu <chuhu@redhat.com>
---
 .../ftrace_stress/ftrace_tracing_enabled.sh        | 39 ----------------------
 .../ftrace_stress_test/ftrace_stress_test.sh       | 20 +++++------
 2 files changed, 8 insertions(+), 51 deletions(-)
 delete mode 100755 testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_tracing_enabled.sh

diff --git a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_tracing_enabled.sh b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_tracing_enabled.sh
deleted file mode 100755
index 69f2ae6..0000000
--- a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_tracing_enabled.sh
+++ /dev/null
@@ -1,39 +0,0 @@
-#! /bin/sh
-
-###############################################################################
-#                                                                             #
-# Copyright (c) 2010 FUJITSU LIMITED                                          #
-#                                                                             #
-# This program is free software; you can redistribute it and/or modify it     #
-# under the terms of the GNU General Public License as published by the Free  #
-# Software Foundation; either version 2 of the License, or (at your option)   #
-# any later version.                                                          #
-#                                                                             #
-# Author: Li Zefan <lizf@cn.fujitsu.com>                                      #
-#                                                                             #
-###############################################################################
-
-MAX_LOOP=1500
-count=0
-
-for ((; ;))
-{
-	count=$(( $count + 1 ))
-
-	for ((i = 0; i < $MAX_LOOP; i++))
-	{
-		echo 0 > "$TRACING_PATH"/tracing_enabled
-		echo 1 > "$TRACING_PATH"/tracing_enabled
-	}
-
-	enable=$(( $count % 3 ))
-
-	if [ $enable -eq 0 ]; then
-		echo 0 > "$TRACING_PATH"/tracing_enabled
-	else
-		echo 1 > "$TRACING_PATH"/tracing_enabled
-	fi
-
-	sleep 1
-}
-
diff --git a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress_test.sh b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress_test.sh
index 6a111e9..24bb3ab 100755
--- a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress_test.sh
+++ b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress_test.sh
@@ -42,7 +42,6 @@ save_old_setting()
 
 	old_trace_options=( `cat trace_options` )
 	old_tracing_on=`cat tracing_on`
-	old_tracing_enabled=`cat tracing_enabled`
 	old_buffer_size=`cat buffer_size_kb`
 
 	if [ -e stack_max_size ]; then
@@ -87,7 +86,6 @@ restore_old_setting()
 
 	echo $old_buffer_size > buffer_size_kb
 	echo $old_tracing_on > tracing_on
-	echo $old_tracing_enabled > tracing_enabled
 
 	for option in $old_trace_options
 	do
@@ -207,24 +205,22 @@ $SPATH/ftrace_stack_max_size.sh &
 pid6=$!
 $SPATH/ftrace_tracing_on.sh &
 pid7=$!
-$SPATH/ftrace_tracing_enabled.sh &
-pid8=$!
 $SPATH/ftrace_set_event.sh &
-pid9=$!
+pid8=$!
 $SPATH/ftrace_buffer_size.sh &
-pid10=$!
+pid9=$!
 $SPATH/ftrace_trace.sh &
-pid11=$!
+pid10=$!
 $SPATH/ftrace_trace_pipe.sh &
-pid12=$!
+pid11=$!
 $SPATH/ftrace_ftrace_enabled.sh &
-pid13=$!
+pid12=$!
 $SPATH/ftrace_set_ftrace_pid.sh &
-pid14=$!
+pid13=$!
 $SPATH/ftrace_profile_enabled.sh &
-pid15=$!
+pid14=$!
 $SPATH/ftrace_trace_stat.sh &
-pid16=$!
+pid15=$!
 
 export_pids
 
-- 
1.8.3.1


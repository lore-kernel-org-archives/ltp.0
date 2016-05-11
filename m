From: Chunyu Hu <chuhu@redhat.com>
Date: Wed, 11 May 2016 19:36:23 +0800
Subject: [LTP] [PATCH V3-2 1/9] tracing: reorganize ftrace-stress tests to
	general tests
In-Reply-To: <1462966591-3895-1-git-send-email-chuhu@redhat.com>
References: <1462966591-3895-1-git-send-email-chuhu@redhat.com>
Message-ID: <1462966591-3895-2-git-send-email-chuhu@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Li Wang <liwang@redhat.com>

This commit is just preparing for the upcoming patch set.
So do rename work, not changing anything of the content.

Changs:
  - renamed:   ftrace_stress_test/  --> ftrace_test/
  - extracted: ftrace_stress_test.sh --> ftrace_lib.sh
  - modified:  ftrace_stress_test.sh

Signed-off-by: Li Wang <liwang@redhat.com>
---
 .../kernel/tracing/ftrace_stress_test/Makefile     |   7 -
 .../ftrace_stress/ftrace_buffer_size.sh            |  45 ----
 .../ftrace_stress/ftrace_current_tracer.sh         |  34 ---
 .../ftrace_stress/ftrace_ftrace_enabled.sh         |  39 ----
 .../ftrace_stress/ftrace_profile_enabled.sh        |  50 -----
 .../ftrace_stress/ftrace_set_event.sh              |  44 ----
 .../ftrace_stress/ftrace_set_ftrace_pid.sh         |  49 -----
 .../ftrace_stress/ftrace_stack_max_size.sh         |  39 ----
 .../ftrace_stress/ftrace_stack_trace.sh            |  46 ----
 .../ftrace_stress/ftrace_trace.sh                  |  27 ---
 .../ftrace_stress/ftrace_trace_clock.sh            |  46 ----
 .../ftrace_stress/ftrace_trace_options.sh          |  42 ----
 .../ftrace_stress/ftrace_trace_pipe.sh             |  52 -----
 .../ftrace_stress/ftrace_trace_stat.sh             |  45 ----
 .../ftrace_stress/ftrace_tracing_enabled.sh        |  39 ----
 .../ftrace_stress/ftrace_tracing_max_latency.sh    |  38 ----
 .../ftrace_stress/ftrace_tracing_on.sh             |  39 ----
 .../ftrace_stress_test/ftrace_stress_test.sh       | 243 ---------------------
 testcases/kernel/tracing/ftrace_test/Makefile      |   7 +
 testcases/kernel/tracing/ftrace_test/ftrace_lib.sh | 156 +++++++++++++
 .../ftrace_stress/ftrace_buffer_size.sh            |  45 ++++
 .../ftrace_stress/ftrace_current_tracer.sh         |  34 +++
 .../ftrace_stress/ftrace_ftrace_enabled.sh         |  39 ++++
 .../ftrace_stress/ftrace_profile_enabled.sh        |  50 +++++
 .../ftrace_test/ftrace_stress/ftrace_set_event.sh  |  44 ++++
 .../ftrace_stress/ftrace_set_ftrace_pid.sh         |  49 +++++
 .../ftrace_stress/ftrace_stack_max_size.sh         |  39 ++++
 .../ftrace_stress/ftrace_stack_trace.sh            |  46 ++++
 .../ftrace_test/ftrace_stress/ftrace_trace.sh      |  27 +++
 .../ftrace_stress/ftrace_trace_clock.sh            |  46 ++++
 .../ftrace_stress/ftrace_trace_options.sh          |  42 ++++
 .../ftrace_test/ftrace_stress/ftrace_trace_pipe.sh |  52 +++++
 .../ftrace_test/ftrace_stress/ftrace_trace_stat.sh |  45 ++++
 .../ftrace_stress/ftrace_tracing_enabled.sh        |  39 ++++
 .../ftrace_stress/ftrace_tracing_max_latency.sh    |  38 ++++
 .../ftrace_test/ftrace_stress/ftrace_tracing_on.sh |  39 ++++
 .../tracing/ftrace_test/ftrace_stress_test.sh      | 123 +++++++++++
 37 files changed, 960 insertions(+), 924 deletions(-)
 delete mode 100644 testcases/kernel/tracing/ftrace_stress_test/Makefile
 delete mode 100755 testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_buffer_size.sh
 delete mode 100755 testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_current_tracer.sh
 delete mode 100755 testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_ftrace_enabled.sh
 delete mode 100755 testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_profile_enabled.sh
 delete mode 100755 testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_set_event.sh
 delete mode 100755 testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_set_ftrace_pid.sh
 delete mode 100755 testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_stack_max_size.sh
 delete mode 100755 testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_stack_trace.sh
 delete mode 100755 testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_trace.sh
 delete mode 100755 testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_trace_clock.sh
 delete mode 100755 testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_trace_options.sh
 delete mode 100755 testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_trace_pipe.sh
 delete mode 100755 testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_trace_stat.sh
 delete mode 100755 testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_tracing_enabled.sh
 delete mode 100755 testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_tracing_max_latency.sh
 delete mode 100755 testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_tracing_on.sh
 delete mode 100755 testcases/kernel/tracing/ftrace_stress_test/ftrace_stress_test.sh
 create mode 100644 testcases/kernel/tracing/ftrace_test/Makefile
 create mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_lib.sh
 create mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_buffer_size.sh
 create mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_current_tracer.sh
 create mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_ftrace_enabled.sh
 create mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_profile_enabled.sh
 create mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_set_event.sh
 create mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_set_ftrace_pid.sh
 create mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_stack_max_size.sh
 create mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_stack_trace.sh
 create mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace.sh
 create mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_clock.sh
 create mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_options.sh
 create mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_pipe.sh
 create mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_stat.sh
 create mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_tracing_enabled.sh
 create mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_tracing_max_latency.sh
 create mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_tracing_on.sh
 create mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_stress_test.sh

diff --git a/testcases/kernel/tracing/ftrace_stress_test/Makefile b/testcases/kernel/tracing/ftrace_stress_test/Makefile
deleted file mode 100644
index e4a913a..0000000
--- a/testcases/kernel/tracing/ftrace_stress_test/Makefile
+++ /dev/null
@@ -1,7 +0,0 @@
-top_srcdir              ?= ../../../..
-
-include $(top_srcdir)/include/mk/testcases.mk
-
-INSTALL_TARGETS         := *.sh ftrace_stress/*
-
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_buffer_size.sh b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_buffer_size.sh
deleted file mode 100755
index bd7dcc4..0000000
--- a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_buffer_size.sh
+++ /dev/null
@@ -1,45 +0,0 @@
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
-LOOP=200
-
-# Use up to 10% of free memory
-free_mem=`cat /proc/meminfo | grep '^MemFree' | awk '{ print $2 }'`
-cpus=`tst_ncpus`
-
-step=$(( $free_mem / 10 / $LOOP / $cpus ))
-
-if [ $step -eq 0 ]; then
-	step=1
-	LOOP=50
-fi
-
-for ((; ;))
-{
-	new_size=1
-	for ((i = 0; i < $LOOP; i++))
-	{
-		echo $new_size > "$TRACING_PATH"/buffer_size_kb
-		new_size=$(( $new_size + $step ))
-	}
-
-	for ((i = 0; i < $LOOP; i++))
-	{
-		new_size=$(( $new_size - $step ))
-		echo $new_size > "$TRACING_PATH"/buffer_size_kb
-	}
-
-	sleep 1
-}
diff --git a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_current_tracer.sh b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_current_tracer.sh
deleted file mode 100755
index 88d576f..0000000
--- a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_current_tracer.sh
+++ /dev/null
@@ -1,34 +0,0 @@
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
-LOOP=200
-
-for ((; ;))
-{
-	for ((i = 0; i < $LOOP; i++))
-	{
-		for tracer in `cat "$TRACING_PATH"/available_tracers`
-		do
-			if [ "$tracer" = mmiotrace ]; then
-				continue
-			fi
-
-			echo $tracer > "$TRACING_PATH"/current_tracer 2> /dev/null
-		done
-	}
-
-	sleep 1
-}
-
diff --git a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_ftrace_enabled.sh b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_ftrace_enabled.sh
deleted file mode 100755
index 20bb234..0000000
--- a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_ftrace_enabled.sh
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
-		echo 0 > /proc/sys/kernel/ftrace_enabled
-		echo 1 > /proc/sys/kernel/ftrace_enabled
-	}
-
-	enable=$(( $count % 3 ))
-
-	if [ $enable -eq 0 ]; then
-		echo 1 > /proc/sys/kernel/ftrace_enabled
-	else
-		echo 0 > /proc/sys/kernel/ftrace_enabled
-	fi
-
-	sleep 1
-}
-
diff --git a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_profile_enabled.sh b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_profile_enabled.sh
deleted file mode 100755
index 9c6162a..0000000
--- a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_profile_enabled.sh
+++ /dev/null
@@ -1,50 +0,0 @@
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
-if [ ! -e "$TRACING_PATH"/function_profile_enabled ]; then
-	should_skip=1
-else
-	should_skip=0
-fi
-
-for ((; ;))
-{
-	if [ $should_skip -eq 1 ]; then
-		sleep 2
-		continue
-	fi
-
-	count=$(( $count + 1 ))
-
-	for ((i = 0; i < $MAX_LOOP; i++))
-	{
-		echo 0 > "$TRACING_PATH"/function_profile_enabled 2> /dev/null
-		echo 1 > "$TRACING_PATH"/function_profile_enabled 2> /dev/null
-	}
-
-	enable=$(( $count % 3 ))
-
-	if [ $enable -eq 0 ]; then
-		echo 1 > "$TRACING_PATH"/function_profile_enabled 2> /dev/null
-	else
-		echo 0 > "$TRACING_PATH"/function_profile_enabled 2> /dev/null
-	fi
-
-	sleep 1
-}
-
diff --git a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_set_event.sh b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_set_event.sh
deleted file mode 100755
index d7efdd4..0000000
--- a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_set_event.sh
+++ /dev/null
@@ -1,44 +0,0 @@
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
-for ((; ;))
-{
-	for ((i = 0; i < 100; i++))
-	{
-		echo 1 > "$TRACING_PATH"/events/enable
-		echo 0 > "$TRACING_PATH"/events/enable
-	}
-
-	for dir in `ls $TRACING_PATH/events/`
-	do
-		if [ ! -d $dir -o "$dir" = ftrace ]; then
-			continue;
-		fi
-
-		for ((i = 0; i < 20; i++))
-		{
-			echo 1 > "$TRACING_PATH"/events/$dir/enable
-			echo 0 > "$TRACING_PATH"/events/$dir/enable
-		}
-	done
-
-	for event in `cat $TRACING_PATH/available_events`;
-	do
-		echo $event >> "$TRACING_PATH"/set_event
-	done
-
-	sleep 1
-}
-
diff --git a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_set_ftrace_pid.sh b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_set_ftrace_pid.sh
deleted file mode 100755
index 7bc76d9..0000000
--- a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_set_ftrace_pid.sh
+++ /dev/null
@@ -1,49 +0,0 @@
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
-LOOP=300
-
-if [ ! -e "$TRACING_PATH"/set_ftrace_pid ]; then
-	should_skip=1
-else
-	should_skip=0
-fi
-
-for ((; ; ))
-{
-	if [ $should_skip -eq 1 ]; then
-		sleep 2
-		continue
-	fi
-
-	for ((j = 0; j < $LOOP; j++))
-	{
-		for ((k = 1; k <= NR_PIDS; k++))
-		{
-			str="\$pid$k"
-			eval echo $str >> "$TRACING_PATH"/set_ftrace_pid
-		}
-
-		if ! echo > "$TRACING_PATH"/set_ftrace_pid >/dev/null 2>&1; then
-			if ! echo -1 > "$TRACING_PATH"/set_ftrace_pid >/dev/null 2>&1; then
-				tst_resm TBROK "Cannot disable set_ftrace_pid!"
-				exit 1
-			fi
-		fi
-	}
-
-	sleep 1
-}
-
diff --git a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_stack_max_size.sh b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_stack_max_size.sh
deleted file mode 100755
index 682d05e..0000000
--- a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_stack_max_size.sh
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
-MAX_STACK_SIZE=8192
-
-if [ ! -e /proc/sys/kernel/stack_tracer_enabled ]; then
-	should_skip=1
-else
-	should_skip=0
-fi
-
-for ((; ;))
-{
-	if [ $should_skip -eq 1 ]; then
-		sleep 2
-		continue
-	fi
-
-	for ((i = 0; i < $MAX_STACK_SIZE; i += 70))
-	{
-		echo $i > "$TRACING_PATH"/stack_max_size
-		cat "$TRACING_PATH"/stack_max_size > /dev/null
-	}
-
-	sleep 1
-}
-
diff --git a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_stack_trace.sh b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_stack_trace.sh
deleted file mode 100755
index a406c51..0000000
--- a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_stack_trace.sh
+++ /dev/null
@@ -1,46 +0,0 @@
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
-LOOP=400
-
-if [ ! -e /proc/sys/kernel/stack_tracer_enabled ]; then
-	should_skip=1
-else
-	should_skip=0
-fi
-
-for ((; ;))
-{
-	if [ $should_skip -eq 1 ]; then
-		sleep 2
-		continue
-	fi
-
-	for ((i = 0; i < $LOOP; i++))
-	{
-		cat "$TRACING_PATH"/stack_trace > /dev/null
-	}
-
-	sleep 1
-
-	for ((i = 0; i < $LOOP; i++))
-	{
-		echo 0 > /proc/sys/kernel/stack_tracer_enabled
-		echo 1 > /proc/sys/kernel/stack_tracer_enabled
-	}
-
-	sleep 1
-}
-
diff --git a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_trace.sh b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_trace.sh
deleted file mode 100755
index e36712b..0000000
--- a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_trace.sh
+++ /dev/null
@@ -1,27 +0,0 @@
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
-LOOP=200
-
-for ((; ;))
-{
-	for ((i = 0; i < $LOOP; i++))
-	{
-		cat "$TRACING_PATH"/trace > /dev/null
-	}
-
-	sleep 1
-}
-
diff --git a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_trace_clock.sh b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_trace_clock.sh
deleted file mode 100755
index de6bbea..0000000
--- a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_trace_clock.sh
+++ /dev/null
@@ -1,46 +0,0 @@
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
-LOOP=400
-
-# In kernel which is older than 2.6.32, we set global clock
-# via trace_options.
-tst_kvercmp 2 6 32
-if [ $? -eq 0 ]; then
-        old_kernel=1
-else
-        old_kernel=0
-fi
-
-for ((; ;))
-{
-	if [ $old_kernel -eq 1 ];
-	then
-		for ((i = 0; i < $LOOP; i++))
-		{
-			echo 1 > "$TRACING_PATH"/options/global-clock
-			echo 0 > "$TRACING_PATH"/options/global-clock
-		}
-	else
-		for ((i = 0; i < $LOOP; i++))
-		{
-			echo local > "$TRACING_PATH"/trace_clock
-			echo global > "$TRACING_PATH"/trace_clock
-		}
-	fi
-
-	sleep 1
-}
-
diff --git a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_trace_options.sh b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_trace_options.sh
deleted file mode 100755
index 47d2a62..0000000
--- a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_trace_options.sh
+++ /dev/null
@@ -1,42 +0,0 @@
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
-LOOP=200
-
-trace_options=(print-parent sym-offset sym-addr verbose raw hex bin block trace_printk ftrace_preempt branch annotate userstacktrace sym-userobj printk-msg-only context-info latency-format sleep-time graph-time)
-
-NR_TRACE_OPTIONS=19
-
-for ((; ; ))
-{
-	for ((j = 0; j < $LOOP; j++))
-	{
-		num=`date +%N`
-		num=`printf 1%s $num`
-
-		for ((i = 0; i < $NR_TRACE_OPTIONS; i++))
-		{
-			n=$(( ( $num >> $i ) % 2 ))
-			if [ $n -eq 0 ]; then
-				echo 0 > "$TRACING_PATH"/options/${trace_options[$i]}
-			else
-				echo 1 > "$TRACING_PATH"/options/${trace_options[$i]}
-			fi
-		}
-	}
-
-	sleep 1
-}
-
diff --git a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_trace_pipe.sh b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_trace_pipe.sh
deleted file mode 100755
index 47d42bc..0000000
--- a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_trace_pipe.sh
+++ /dev/null
@@ -1,52 +0,0 @@
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
-ftrace_sleep()
-{
-	# usleep is not a standard command?
-	usleep 200000 2> /dev/null
-	if [ $? -ne 0 ]; then
-		sleep 1
-	fi
-}
-
-kill_this_pid()
-{
-	/bin/kill -SIGKILL $this_pid
-	wait $this_pid
-	exit 0
-}
-
-trap kill_this_pid SIGUSR1
-
-LOOP=20
-
-for ((; ;))
-{
-	for ((i = 0; i < $LOOP; i++))
-	{
-		cat "$TRACING_PATH"/trace_pipe > /dev/null &
-
-		this_pid=$!
-		ftrace_sleep
-		/bin/kill -SIGINT $this_pid
-		wait $this_pid
-		this_pid=0
-		ftrace_sleep
-	}
-
-	sleep 2
-}
-
diff --git a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_trace_stat.sh b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_trace_stat.sh
deleted file mode 100755
index d7e6fd3..0000000
--- a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_trace_stat.sh
+++ /dev/null
@@ -1,45 +0,0 @@
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
-LOOP=200
-
-should_skip=0
-
-if [ ! -e "$TRACING_PATH"/function_profile_enabled ]; then
-        should_skip=1
-fi
-
-# For kernels older than 2.6.36, this testcase can result in
-# divide-by-zero kernel bug
-tst_kvercmp 2 6 36
-if [ $? -eq 0 ]; then
-	should_skip=1
-fi
-
-for ((; ;))
-{
-	if [ $should_skip -eq 1 ]; then
-		sleep 2
-		continue
-	fi
-
-	for ((i = 0; i < $LOOP; i++))
-	{
-		cat "$TRACING_PATH"/trace_stat/function0 > /dev/null 2>&1
-	}
-
-	sleep 1
-}
-
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
diff --git a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_tracing_max_latency.sh b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_tracing_max_latency.sh
deleted file mode 100755
index f19d734..0000000
--- a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_tracing_max_latency.sh
+++ /dev/null
@@ -1,38 +0,0 @@
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
-MAX_LATENCY=100000
-
-if [ ! -e "$TRACING_PATH"/tracing_max_latency ]; then
-        should_skip=1
-else
-        should_skip=0
-fi
-
-for ((; ;))
-{
-        if [ $should_skip -eq 1 ]; then
-                sleep 2
-                continue
-        fi
-
-	for ((i = 0; i < $MAX_LATENCY; i += 400))
-	{
-		echo $i > "$TRACING_PATH"/tracing_max_latency
-	}
-
-	sleep 1
-}
-
diff --git a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_tracing_on.sh b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_tracing_on.sh
deleted file mode 100755
index 672c223..0000000
--- a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_tracing_on.sh
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
-		echo 0 > "$TRACING_PATH"/tracing_on
-		echo 1 > "$TRACING_PATH"/tracing_on
-	}
-
-	enable=$(( $count % 3 ))
-
-	if [ $enable -eq 0 ]; then
-		echo 0 > "$TRACING_PATH"/tracing_on
-	else
-		echo 1 > "$TRACING_PATH"/tracing_on
-	fi
-
-	sleep 1
-}
-
diff --git a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress_test.sh b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress_test.sh
deleted file mode 100755
index 6a111e9..0000000
--- a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress_test.sh
+++ /dev/null
@@ -1,243 +0,0 @@
-#! /bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) 2010 FUJITSU LIMITED                                         ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-## Author: Li Zefan <lizf@cn.fujitsu.com>                                     ##
-##                                                                            ##
-################################################################################
-
-cd $LTPROOT/testcases/bin
-
-export TCID="ftrace-stress-test"
-export TST_TOTAL=1
-export TST_COUNT=1
-
-export TPATH="$PWD"
-export DEBUGFS_PATH="$PWD/debugfs"
-export TRACING_PATH="$PWD/debugfs/tracing"
-export SPATH="$TPATH/ftrace_stress"
-
-test_interval=$1
-test_success=true
-
-save_old_setting()
-{
-	cd $TRACING_PATH
-
-	old_trace_options=( `cat trace_options` )
-	old_tracing_on=`cat tracing_on`
-	old_tracing_enabled=`cat tracing_enabled`
-	old_buffer_size=`cat buffer_size_kb`
-
-	if [ -e stack_max_size ]; then
-		old_stack_tracer_enabled=`cat /proc/sys/kernel/stack_tracer_enabled`
-	fi
-
-	if [ -e "/proc/sys/kernel/ftrace_enabled" ]; then
-		old_ftrace_enabled=`cat /proc/sys/kernel/ftrace_enabled`
-	fi
-
-	if [ -e "function_profile_enabled" ]; then
-		old_profile_enabled=`cat function_profile_enabled`
-	fi
-
-	cd - > /dev/null
-}
-
-restore_old_setting()
-{
-	cd $TRACING_PATH
-
-	echo nop > current_tracer
-	echo 0 > events/enable
-	echo 0 > tracing_max_latency 2> /dev/null
-
-	if [ -e trace_clock ]; then
-		echo local > trace_clock
-	fi
-
-	if [ -e "function_pofile_enabled" ]; then
-		echo $old_profile_enabled > function_profile_enabled
-	fi
-
-	if [ -e "/proc/sys/kernel/ftrace_enabled" ]; then
-		echo $old_ftrace_enabled > /proc/sys/kernel/ftrace_enabled
-	fi
-
-	if [ -e stack_max_size ]; then
-		echo $old_stack_tracer_enabled > /proc/sys/kernel/stack_tracer_enabled
-		echo 0 > stack_max_size
-	fi
-
-	echo $old_buffer_size > buffer_size_kb
-	echo $old_tracing_on > tracing_on
-	echo $old_tracing_enabled > tracing_enabled
-
-	for option in $old_trace_options
-	do
-		echo $option > trace_options 2> /dev/null
-	done
-
-	echo > trace
-
-	cd - > /dev/null
-}
-
-clean_up()
-{
-	kill -KILL $pid1 || test_success=false
-	kill -KILL $pid2 || test_success=false
-	kill -KILL $pid3 || test_success=false
-	kill -KILL $pid4 || test_success=false
-	kill -KILL $pid5 || test_success=false
-	kill -KILL $pid6 || test_success=false
-	kill -KILL $pid7 || test_success=false
-	kill -KILL $pid8 || test_success=false
-	kill -KILL $pid9 || test_success=false
-	kill -KILL $pid10 || test_success=false
-	kill -KILL $pid11 || test_success=false
-	kill -USR1 $pid12 || test_success=false
-	kill -KILL $pid13 || test_success=false
-	kill -KILL $pid14 || test_success=false
-	kill -KILL $pid15 || test_success=false
-	kill -KILL $pid16 || test_success=false
-
-	sleep 2
-	restore_old_setting
-
-	umount $DEBUGFS_PATH
-	rmdir $DEBUGFS_PATH
-}
-
-clean_up_exit()
-{
-	clean_up
-	exit 1
-}
-
-export_pids()
-{
-	export pid1 pid2 pid3 pid4 pid5 pid6 pid7 pid8 pid9 pid10 pid11 pid12 \
-		pid13 pid14 pid15 pid16
-
-	export NR_PIDS=16
-}
-
-test_begin()
-{
-	start_time=`date +%s`
-}
-
-test_wait()
-{
-	for ((; ;))
-	{
-		sleep 2
-
-		cur_time=`date +%s`
-		elapsed=$(( $cur_time - $start_time ))
-
-		# run the stress test for $test_interval secs
-		if [ $elapsed -ge $test_interval ]; then
-			break
-		fi
-	}
-}
-
-trap clean_up_exit INT
-
-# Should be run by root user
-if [ `id -ru` != 0 ]; then
-	tst_brkm TCONF ignored "The test should be run by root user. Skip the test..."
-	exit 0
-fi
-
-# Don't run the test on kernels older than 2.6.34, otherwise
-# it can crash the system if the kernel is not latest-stable
-tst_kvercmp 2 6 34
-if [ $? -eq 0 ]; then
-	tst_brkm TCONF ignored "The test should be run in kernels >= 2.6.34. Skip the test..."
-	exit 0
-fi
-
-mkdir $DEBUGFS_PATH
-mount -t debugfs xxx $DEBUGFS_PATH
-
-# Check to see tracing feature is supported or not
-if [ ! -d $TRACING_PATH ]; then
-	tst_brkm TCONF ignored "Tracing is not supported. Skip the test..."
-	umount $DEBUGFS_PATH
-	rmdir $DEBUGFS_PATH
-	exit 0
-fi
-
-echo "Ftrace Stress Test Begin"
-
-save_old_setting
-
-test_begin
-
-$SPATH/ftrace_trace_clock.sh &
-pid1=$!
-$SPATH/ftrace_current_tracer.sh &
-pid2=$!
-$SPATH/ftrace_trace_options.sh &
-pid3=$!
-$SPATH/ftrace_tracing_max_latency.sh &
-pid4=$!
-$SPATH/ftrace_stack_trace.sh &
-pid5=$!
-$SPATH/ftrace_stack_max_size.sh &
-pid6=$!
-$SPATH/ftrace_tracing_on.sh &
-pid7=$!
-$SPATH/ftrace_tracing_enabled.sh &
-pid8=$!
-$SPATH/ftrace_set_event.sh &
-pid9=$!
-$SPATH/ftrace_buffer_size.sh &
-pid10=$!
-$SPATH/ftrace_trace.sh &
-pid11=$!
-$SPATH/ftrace_trace_pipe.sh &
-pid12=$!
-$SPATH/ftrace_ftrace_enabled.sh &
-pid13=$!
-$SPATH/ftrace_set_ftrace_pid.sh &
-pid14=$!
-$SPATH/ftrace_profile_enabled.sh &
-pid15=$!
-$SPATH/ftrace_trace_stat.sh &
-pid16=$!
-
-export_pids
-
-test_wait
-
-clean_up
-
-echo "Ftrace Stress Test End"
-
-if $test_success; then
-	tst_resm TPASS "finished running the test. Run dmesg to double-check for bugs"
-else
-	tst_resm TFAIL "please check log message."
-	exit 1
-fi
-
diff --git a/testcases/kernel/tracing/ftrace_test/Makefile b/testcases/kernel/tracing/ftrace_test/Makefile
new file mode 100644
index 0000000..e4a913a
--- /dev/null
+++ b/testcases/kernel/tracing/ftrace_test/Makefile
@@ -0,0 +1,7 @@
+top_srcdir              ?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+INSTALL_TARGETS         := *.sh ftrace_stress/*
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_lib.sh b/testcases/kernel/tracing/ftrace_test/ftrace_lib.sh
new file mode 100755
index 0000000..ea082dc
--- /dev/null
+++ b/testcases/kernel/tracing/ftrace_test/ftrace_lib.sh
@@ -0,0 +1,156 @@
+#! /bin/sh
+
+###########################################################################
+##                                                                       ##
+## Copyright (c) 2010 FUJITSU LIMITED                                    ##
+##                                                                       ##
+## This program is free software: you can redistribute it and/or modify  ##
+## it under the terms of the GNU General Public License as published by  ##
+## the Free Software Foundation, either version 3 of the License, or     ##
+## (at your option) any later version.                                   ##
+##                                                                       ##
+## This program is distributed in the hope that it will be useful,       ##
+## but WITHOUT ANY WARRANTY; without even the implied warranty of        ##
+## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the          ##
+## GNU General Public License for more details.                          ##
+##                                                                       ##
+## You should have received a copy of the GNU General Public License     ##
+## along with this program. If not, see <http://www.gnu.org/licenses/>.  ##
+##                                                                       ##
+## Author: Li Zefan <lizf@cn.fujitsu.com>                                ##
+##                                                                       ##
+###########################################################################
+
+cd $LTPROOT/testcases/bin
+
+export TPATH="$PWD"
+export DEBUGFS_PATH="$PWD/debugfs"
+export TRACING_PATH="$PWD/debugfs/tracing"
+export FPATH="$TPATH/ftrace_function"
+export RPATH="$TPATH/ftrace_regression"
+export SPATH="$TPATH/ftrace_stress"
+
+. test.sh
+
+test_interval=$1
+
+save_old_setting()
+{
+	cd $TRACING_PATH
+
+	old_trace_options=( `cat trace_options` )
+	old_tracing_on=`cat tracing_on`
+	old_tracing_enabled=`cat tracing_enabled`
+	old_buffer_size=`cat buffer_size_kb`
+
+	if [ -e stack_max_size ]; then
+		old_stack_tracer_enabled=`cat /proc/sys/kernel/stack_tracer_enabled`
+	fi
+
+	if [ -e "/proc/sys/kernel/ftrace_enabled" ]; then
+		old_ftrace_enabled=`cat /proc/sys/kernel/ftrace_enabled`
+	fi
+
+	if [ -e "function_profile_enabled" ]; then
+		old_profile_enabled=`cat function_profile_enabled`
+	fi
+
+	cd - > /dev/null
+}
+
+restore_old_setting()
+{
+	cd $TRACING_PATH
+
+	echo nop > current_tracer
+	echo 0 > events/enable
+	echo 0 > tracing_max_latency 2> /dev/null
+
+	if [ -e trace_clock ]; then
+		echo local > trace_clock
+	fi
+
+	if [ -e "function_pofile_enabled" ]; then
+		echo $old_profile_enabled > function_profile_enabled
+	fi
+
+	if [ -e "/proc/sys/kernel/ftrace_enabled" ]; then
+		echo $old_ftrace_enabled > /proc/sys/kernel/ftrace_enabled
+	fi
+
+	if [ -e stack_max_size ]; then
+		echo $old_stack_tracer_enabled > /proc/sys/kernel/stack_tracer_enabled
+		echo 0 > stack_max_size
+	fi
+
+	echo $old_buffer_size > buffer_size_kb
+	echo $old_tracing_on > tracing_on
+	echo $old_tracing_enabled > tracing_enabled
+
+	for option in $old_trace_options
+	do
+		echo $option > trace_options 2> /dev/null
+	done
+
+	echo > trace
+
+	cd - > /dev/null
+}
+
+clean_up()
+{
+	restore_old_setting
+
+	umount $DEBUGFS_PATH
+	rmdir $DEBUGFS_PATH
+}
+
+clean_up_exit()
+{
+	clean_up
+	exit 1
+}
+
+test_begin()
+{
+	start_time=`date +%s`
+}
+
+test_wait()
+{
+	for ((; ;))
+	{
+		sleep 2
+
+		cur_time=`date +%s`
+		elapsed=$(( $cur_time - $start_time ))
+
+		# run the test for $test_interval secs
+		if [ $elapsed -ge $test_interval ]; then
+			break
+		fi
+	}
+}
+
+trap clean_up_exit INT
+
+tst_require_root
+
+# Don't run the test on kernels older than 2.6.34, otherwise
+# it can crash the system if the kernel is not latest-stable
+tst_kvercmp 2 6 34
+if [ $? -eq 0 ]; then
+	tst_brkm TCONF ignored "The test should be run in kernels >= 2.6.34. Skip the test..."
+	exit 0
+fi
+
+mkdir $DEBUGFS_PATH
+mount -t debugfs xxx $DEBUGFS_PATH
+
+# Check to see tracing feature is supported or not
+if [ ! -d $TRACING_PATH ]; then
+	tst_brkm TCONF ignored "Tracing is not supported. Skip the test..."
+	umount $DEBUGFS_PATH
+	rmdir $DEBUGFS_PATH
+	exit 0
+fi
diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_buffer_size.sh b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_buffer_size.sh
new file mode 100755
index 0000000..bd7dcc4
--- /dev/null
+++ b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_buffer_size.sh
@@ -0,0 +1,45 @@
+#! /bin/sh
+
+###############################################################################
+#                                                                             #
+# Copyright (c) 2010 FUJITSU LIMITED                                          #
+#                                                                             #
+# This program is free software; you can redistribute it and/or modify it     #
+# under the terms of the GNU General Public License as published by the Free  #
+# Software Foundation; either version 2 of the License, or (at your option)   #
+# any later version.                                                          #
+#                                                                             #
+# Author: Li Zefan <lizf@cn.fujitsu.com>                                      #
+#                                                                             #
+###############################################################################
+
+LOOP=200
+
+# Use up to 10% of free memory
+free_mem=`cat /proc/meminfo | grep '^MemFree' | awk '{ print $2 }'`
+cpus=`tst_ncpus`
+
+step=$(( $free_mem / 10 / $LOOP / $cpus ))
+
+if [ $step -eq 0 ]; then
+	step=1
+	LOOP=50
+fi
+
+for ((; ;))
+{
+	new_size=1
+	for ((i = 0; i < $LOOP; i++))
+	{
+		echo $new_size > "$TRACING_PATH"/buffer_size_kb
+		new_size=$(( $new_size + $step ))
+	}
+
+	for ((i = 0; i < $LOOP; i++))
+	{
+		new_size=$(( $new_size - $step ))
+		echo $new_size > "$TRACING_PATH"/buffer_size_kb
+	}
+
+	sleep 1
+}
diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_current_tracer.sh b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_current_tracer.sh
new file mode 100755
index 0000000..88d576f
--- /dev/null
+++ b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_current_tracer.sh
@@ -0,0 +1,34 @@
+#! /bin/sh
+
+###############################################################################
+#                                                                             #
+# Copyright (c) 2010 FUJITSU LIMITED                                          #
+#                                                                             #
+# This program is free software; you can redistribute it and/or modify it     #
+# under the terms of the GNU General Public License as published by the Free  #
+# Software Foundation; either version 2 of the License, or (at your option)   #
+# any later version.                                                          #
+#                                                                             #
+# Author: Li Zefan <lizf@cn.fujitsu.com>                                      #
+#                                                                             #
+###############################################################################
+
+LOOP=200
+
+for ((; ;))
+{
+	for ((i = 0; i < $LOOP; i++))
+	{
+		for tracer in `cat "$TRACING_PATH"/available_tracers`
+		do
+			if [ "$tracer" = mmiotrace ]; then
+				continue
+			fi
+
+			echo $tracer > "$TRACING_PATH"/current_tracer 2> /dev/null
+		done
+	}
+
+	sleep 1
+}
+
diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_ftrace_enabled.sh b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_ftrace_enabled.sh
new file mode 100755
index 0000000..20bb234
--- /dev/null
+++ b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_ftrace_enabled.sh
@@ -0,0 +1,39 @@
+#! /bin/sh
+
+###############################################################################
+#                                                                             #
+# Copyright (c) 2010 FUJITSU LIMITED                                          #
+#                                                                             #
+# This program is free software; you can redistribute it and/or modify it     #
+# under the terms of the GNU General Public License as published by the Free  #
+# Software Foundation; either version 2 of the License, or (at your option)   #
+# any later version.                                                          #
+#                                                                             #
+# Author: Li Zefan <lizf@cn.fujitsu.com>                                      #
+#                                                                             #
+###############################################################################
+
+MAX_LOOP=1500
+count=0
+
+for ((; ;))
+{
+	count=$(( $count + 1 ))
+
+	for ((i = 0; i < $MAX_LOOP; i++))
+	{
+		echo 0 > /proc/sys/kernel/ftrace_enabled
+		echo 1 > /proc/sys/kernel/ftrace_enabled
+	}
+
+	enable=$(( $count % 3 ))
+
+	if [ $enable -eq 0 ]; then
+		echo 1 > /proc/sys/kernel/ftrace_enabled
+	else
+		echo 0 > /proc/sys/kernel/ftrace_enabled
+	fi
+
+	sleep 1
+}
+
diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_profile_enabled.sh b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_profile_enabled.sh
new file mode 100755
index 0000000..9c6162a
--- /dev/null
+++ b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_profile_enabled.sh
@@ -0,0 +1,50 @@
+#! /bin/sh
+
+###############################################################################
+#                                                                             #
+# Copyright (c) 2010 FUJITSU LIMITED                                          #
+#                                                                             #
+# This program is free software; you can redistribute it and/or modify it     #
+# under the terms of the GNU General Public License as published by the Free  #
+# Software Foundation; either version 2 of the License, or (at your option)   #
+# any later version.                                                          #
+#                                                                             #
+# Author: Li Zefan <lizf@cn.fujitsu.com>                                      #
+#                                                                             #
+###############################################################################
+
+MAX_LOOP=1500
+count=0
+
+if [ ! -e "$TRACING_PATH"/function_profile_enabled ]; then
+	should_skip=1
+else
+	should_skip=0
+fi
+
+for ((; ;))
+{
+	if [ $should_skip -eq 1 ]; then
+		sleep 2
+		continue
+	fi
+
+	count=$(( $count + 1 ))
+
+	for ((i = 0; i < $MAX_LOOP; i++))
+	{
+		echo 0 > "$TRACING_PATH"/function_profile_enabled 2> /dev/null
+		echo 1 > "$TRACING_PATH"/function_profile_enabled 2> /dev/null
+	}
+
+	enable=$(( $count % 3 ))
+
+	if [ $enable -eq 0 ]; then
+		echo 1 > "$TRACING_PATH"/function_profile_enabled 2> /dev/null
+	else
+		echo 0 > "$TRACING_PATH"/function_profile_enabled 2> /dev/null
+	fi
+
+	sleep 1
+}
+
diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_set_event.sh b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_set_event.sh
new file mode 100755
index 0000000..d7efdd4
--- /dev/null
+++ b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_set_event.sh
@@ -0,0 +1,44 @@
+#! /bin/sh
+
+###############################################################################
+#                                                                             #
+# Copyright (c) 2010 FUJITSU LIMITED                                          #
+#                                                                             #
+# This program is free software; you can redistribute it and/or modify it     #
+# under the terms of the GNU General Public License as published by the Free  #
+# Software Foundation; either version 2 of the License, or (at your option)   #
+# any later version.                                                          #
+#                                                                             #
+# Author: Li Zefan <lizf@cn.fujitsu.com>                                      #
+#                                                                             #
+###############################################################################
+
+for ((; ;))
+{
+	for ((i = 0; i < 100; i++))
+	{
+		echo 1 > "$TRACING_PATH"/events/enable
+		echo 0 > "$TRACING_PATH"/events/enable
+	}
+
+	for dir in `ls $TRACING_PATH/events/`
+	do
+		if [ ! -d $dir -o "$dir" = ftrace ]; then
+			continue;
+		fi
+
+		for ((i = 0; i < 20; i++))
+		{
+			echo 1 > "$TRACING_PATH"/events/$dir/enable
+			echo 0 > "$TRACING_PATH"/events/$dir/enable
+		}
+	done
+
+	for event in `cat $TRACING_PATH/available_events`;
+	do
+		echo $event >> "$TRACING_PATH"/set_event
+	done
+
+	sleep 1
+}
+
diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_set_ftrace_pid.sh b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_set_ftrace_pid.sh
new file mode 100755
index 0000000..7bc76d9
--- /dev/null
+++ b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_set_ftrace_pid.sh
@@ -0,0 +1,49 @@
+#! /bin/sh
+
+###############################################################################
+#                                                                             #
+# Copyright (c) 2010 FUJITSU LIMITED                                          #
+#                                                                             #
+# This program is free software; you can redistribute it and/or modify it     #
+# under the terms of the GNU General Public License as published by the Free  #
+# Software Foundation; either version 2 of the License, or (at your option)   #
+# any later version.                                                          #
+#                                                                             #
+# Author: Li Zefan <lizf@cn.fujitsu.com>                                      #
+#                                                                             #
+###############################################################################
+
+LOOP=300
+
+if [ ! -e "$TRACING_PATH"/set_ftrace_pid ]; then
+	should_skip=1
+else
+	should_skip=0
+fi
+
+for ((; ; ))
+{
+	if [ $should_skip -eq 1 ]; then
+		sleep 2
+		continue
+	fi
+
+	for ((j = 0; j < $LOOP; j++))
+	{
+		for ((k = 1; k <= NR_PIDS; k++))
+		{
+			str="\$pid$k"
+			eval echo $str >> "$TRACING_PATH"/set_ftrace_pid
+		}
+
+		if ! echo > "$TRACING_PATH"/set_ftrace_pid >/dev/null 2>&1; then
+			if ! echo -1 > "$TRACING_PATH"/set_ftrace_pid >/dev/null 2>&1; then
+				tst_resm TBROK "Cannot disable set_ftrace_pid!"
+				exit 1
+			fi
+		fi
+	}
+
+	sleep 1
+}
+
diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_stack_max_size.sh b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_stack_max_size.sh
new file mode 100755
index 0000000..682d05e
--- /dev/null
+++ b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_stack_max_size.sh
@@ -0,0 +1,39 @@
+#! /bin/sh
+
+###############################################################################
+#                                                                             #
+# Copyright (c) 2010 FUJITSU LIMITED                                          #
+#                                                                             #
+# This program is free software; you can redistribute it and/or modify it     #
+# under the terms of the GNU General Public License as published by the Free  #
+# Software Foundation; either version 2 of the License, or (at your option)   #
+# any later version.                                                          #
+#                                                                             #
+# Author: Li Zefan <lizf@cn.fujitsu.com>                                      #
+#                                                                             #
+###############################################################################
+
+MAX_STACK_SIZE=8192
+
+if [ ! -e /proc/sys/kernel/stack_tracer_enabled ]; then
+	should_skip=1
+else
+	should_skip=0
+fi
+
+for ((; ;))
+{
+	if [ $should_skip -eq 1 ]; then
+		sleep 2
+		continue
+	fi
+
+	for ((i = 0; i < $MAX_STACK_SIZE; i += 70))
+	{
+		echo $i > "$TRACING_PATH"/stack_max_size
+		cat "$TRACING_PATH"/stack_max_size > /dev/null
+	}
+
+	sleep 1
+}
+
diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_stack_trace.sh b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_stack_trace.sh
new file mode 100755
index 0000000..a406c51
--- /dev/null
+++ b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_stack_trace.sh
@@ -0,0 +1,46 @@
+#! /bin/sh
+
+###############################################################################
+#                                                                             #
+# Copyright (c) 2010 FUJITSU LIMITED                                          #
+#                                                                             #
+# This program is free software; you can redistribute it and/or modify it     #
+# under the terms of the GNU General Public License as published by the Free  #
+# Software Foundation; either version 2 of the License, or (at your option)   #
+# any later version.                                                          #
+#                                                                             #
+# Author: Li Zefan <lizf@cn.fujitsu.com>                                      #
+#                                                                             #
+###############################################################################
+
+LOOP=400
+
+if [ ! -e /proc/sys/kernel/stack_tracer_enabled ]; then
+	should_skip=1
+else
+	should_skip=0
+fi
+
+for ((; ;))
+{
+	if [ $should_skip -eq 1 ]; then
+		sleep 2
+		continue
+	fi
+
+	for ((i = 0; i < $LOOP; i++))
+	{
+		cat "$TRACING_PATH"/stack_trace > /dev/null
+	}
+
+	sleep 1
+
+	for ((i = 0; i < $LOOP; i++))
+	{
+		echo 0 > /proc/sys/kernel/stack_tracer_enabled
+		echo 1 > /proc/sys/kernel/stack_tracer_enabled
+	}
+
+	sleep 1
+}
+
diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace.sh b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace.sh
new file mode 100755
index 0000000..e36712b
--- /dev/null
+++ b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace.sh
@@ -0,0 +1,27 @@
+#! /bin/sh
+
+###############################################################################
+#                                                                             #
+# Copyright (c) 2010 FUJITSU LIMITED                                          #
+#                                                                             #
+# This program is free software; you can redistribute it and/or modify it     #
+# under the terms of the GNU General Public License as published by the Free  #
+# Software Foundation; either version 2 of the License, or (at your option)   #
+# any later version.                                                          #
+#                                                                             #
+# Author: Li Zefan <lizf@cn.fujitsu.com>                                      #
+#                                                                             #
+###############################################################################
+
+LOOP=200
+
+for ((; ;))
+{
+	for ((i = 0; i < $LOOP; i++))
+	{
+		cat "$TRACING_PATH"/trace > /dev/null
+	}
+
+	sleep 1
+}
+
diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_clock.sh b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_clock.sh
new file mode 100755
index 0000000..de6bbea
--- /dev/null
+++ b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_clock.sh
@@ -0,0 +1,46 @@
+#! /bin/sh
+
+###############################################################################
+#                                                                             #
+# Copyright (c) 2010 FUJITSU LIMITED                                          #
+#                                                                             #
+# This program is free software; you can redistribute it and/or modify it     #
+# under the terms of the GNU General Public License as published by the Free  #
+# Software Foundation; either version 2 of the License, or (at your option)   #
+# any later version.                                                          #
+#                                                                             #
+# Author: Li Zefan <lizf@cn.fujitsu.com>                                      #
+#                                                                             #
+###############################################################################
+
+LOOP=400
+
+# In kernel which is older than 2.6.32, we set global clock
+# via trace_options.
+tst_kvercmp 2 6 32
+if [ $? -eq 0 ]; then
+        old_kernel=1
+else
+        old_kernel=0
+fi
+
+for ((; ;))
+{
+	if [ $old_kernel -eq 1 ];
+	then
+		for ((i = 0; i < $LOOP; i++))
+		{
+			echo 1 > "$TRACING_PATH"/options/global-clock
+			echo 0 > "$TRACING_PATH"/options/global-clock
+		}
+	else
+		for ((i = 0; i < $LOOP; i++))
+		{
+			echo local > "$TRACING_PATH"/trace_clock
+			echo global > "$TRACING_PATH"/trace_clock
+		}
+	fi
+
+	sleep 1
+}
+
diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_options.sh b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_options.sh
new file mode 100755
index 0000000..47d2a62
--- /dev/null
+++ b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_options.sh
@@ -0,0 +1,42 @@
+#! /bin/sh
+
+###############################################################################
+#                                                                             #
+# Copyright (c) 2010 FUJITSU LIMITED                                          #
+#                                                                             #
+# This program is free software; you can redistribute it and/or modify it     #
+# under the terms of the GNU General Public License as published by the Free  #
+# Software Foundation; either version 2 of the License, or (at your option)   #
+# any later version.                                                          #
+#                                                                             #
+# Author: Li Zefan <lizf@cn.fujitsu.com>                                      #
+#                                                                             #
+###############################################################################
+
+LOOP=200
+
+trace_options=(print-parent sym-offset sym-addr verbose raw hex bin block trace_printk ftrace_preempt branch annotate userstacktrace sym-userobj printk-msg-only context-info latency-format sleep-time graph-time)
+
+NR_TRACE_OPTIONS=19
+
+for ((; ; ))
+{
+	for ((j = 0; j < $LOOP; j++))
+	{
+		num=`date +%N`
+		num=`printf 1%s $num`
+
+		for ((i = 0; i < $NR_TRACE_OPTIONS; i++))
+		{
+			n=$(( ( $num >> $i ) % 2 ))
+			if [ $n -eq 0 ]; then
+				echo 0 > "$TRACING_PATH"/options/${trace_options[$i]}
+			else
+				echo 1 > "$TRACING_PATH"/options/${trace_options[$i]}
+			fi
+		}
+	}
+
+	sleep 1
+}
+
diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_pipe.sh b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_pipe.sh
new file mode 100755
index 0000000..47d42bc
--- /dev/null
+++ b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_pipe.sh
@@ -0,0 +1,52 @@
+#! /bin/sh
+
+###############################################################################
+#                                                                             #
+# Copyright (c) 2010 FUJITSU LIMITED                                          #
+#                                                                             #
+# This program is free software; you can redistribute it and/or modify it     #
+# under the terms of the GNU General Public License as published by the Free  #
+# Software Foundation; either version 2 of the License, or (at your option)   #
+# any later version.                                                          #
+#                                                                             #
+# Author: Li Zefan <lizf@cn.fujitsu.com>                                      #
+#                                                                             #
+###############################################################################
+
+ftrace_sleep()
+{
+	# usleep is not a standard command?
+	usleep 200000 2> /dev/null
+	if [ $? -ne 0 ]; then
+		sleep 1
+	fi
+}
+
+kill_this_pid()
+{
+	/bin/kill -SIGKILL $this_pid
+	wait $this_pid
+	exit 0
+}
+
+trap kill_this_pid SIGUSR1
+
+LOOP=20
+
+for ((; ;))
+{
+	for ((i = 0; i < $LOOP; i++))
+	{
+		cat "$TRACING_PATH"/trace_pipe > /dev/null &
+
+		this_pid=$!
+		ftrace_sleep
+		/bin/kill -SIGINT $this_pid
+		wait $this_pid
+		this_pid=0
+		ftrace_sleep
+	}
+
+	sleep 2
+}
+
diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_stat.sh b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_stat.sh
new file mode 100755
index 0000000..d7e6fd3
--- /dev/null
+++ b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_stat.sh
@@ -0,0 +1,45 @@
+#! /bin/sh
+
+###############################################################################
+#                                                                             #
+# Copyright (c) 2010 FUJITSU LIMITED                                          #
+#                                                                             #
+# This program is free software; you can redistribute it and/or modify it     #
+# under the terms of the GNU General Public License as published by the Free  #
+# Software Foundation; either version 2 of the License, or (at your option)   #
+# any later version.                                                          #
+#                                                                             #
+# Author: Li Zefan <lizf@cn.fujitsu.com>                                      #
+#                                                                             #
+###############################################################################
+
+LOOP=200
+
+should_skip=0
+
+if [ ! -e "$TRACING_PATH"/function_profile_enabled ]; then
+        should_skip=1
+fi
+
+# For kernels older than 2.6.36, this testcase can result in
+# divide-by-zero kernel bug
+tst_kvercmp 2 6 36
+if [ $? -eq 0 ]; then
+	should_skip=1
+fi
+
+for ((; ;))
+{
+	if [ $should_skip -eq 1 ]; then
+		sleep 2
+		continue
+	fi
+
+	for ((i = 0; i < $LOOP; i++))
+	{
+		cat "$TRACING_PATH"/trace_stat/function0 > /dev/null 2>&1
+	}
+
+	sleep 1
+}
+
diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_tracing_enabled.sh b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_tracing_enabled.sh
new file mode 100755
index 0000000..69f2ae6
--- /dev/null
+++ b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_tracing_enabled.sh
@@ -0,0 +1,39 @@
+#! /bin/sh
+
+###############################################################################
+#                                                                             #
+# Copyright (c) 2010 FUJITSU LIMITED                                          #
+#                                                                             #
+# This program is free software; you can redistribute it and/or modify it     #
+# under the terms of the GNU General Public License as published by the Free  #
+# Software Foundation; either version 2 of the License, or (at your option)   #
+# any later version.                                                          #
+#                                                                             #
+# Author: Li Zefan <lizf@cn.fujitsu.com>                                      #
+#                                                                             #
+###############################################################################
+
+MAX_LOOP=1500
+count=0
+
+for ((; ;))
+{
+	count=$(( $count + 1 ))
+
+	for ((i = 0; i < $MAX_LOOP; i++))
+	{
+		echo 0 > "$TRACING_PATH"/tracing_enabled
+		echo 1 > "$TRACING_PATH"/tracing_enabled
+	}
+
+	enable=$(( $count % 3 ))
+
+	if [ $enable -eq 0 ]; then
+		echo 0 > "$TRACING_PATH"/tracing_enabled
+	else
+		echo 1 > "$TRACING_PATH"/tracing_enabled
+	fi
+
+	sleep 1
+}
+
diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_tracing_max_latency.sh b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_tracing_max_latency.sh
new file mode 100755
index 0000000..f19d734
--- /dev/null
+++ b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_tracing_max_latency.sh
@@ -0,0 +1,38 @@
+#! /bin/sh
+
+###############################################################################
+#                                                                             #
+# Copyright (c) 2010 FUJITSU LIMITED                                          #
+#                                                                             #
+# This program is free software; you can redistribute it and/or modify it     #
+# under the terms of the GNU General Public License as published by the Free  #
+# Software Foundation; either version 2 of the License, or (at your option)   #
+# any later version.                                                          #
+#                                                                             #
+# Author: Li Zefan <lizf@cn.fujitsu.com>                                      #
+#                                                                             #
+###############################################################################
+
+MAX_LATENCY=100000
+
+if [ ! -e "$TRACING_PATH"/tracing_max_latency ]; then
+        should_skip=1
+else
+        should_skip=0
+fi
+
+for ((; ;))
+{
+        if [ $should_skip -eq 1 ]; then
+                sleep 2
+                continue
+        fi
+
+	for ((i = 0; i < $MAX_LATENCY; i += 400))
+	{
+		echo $i > "$TRACING_PATH"/tracing_max_latency
+	}
+
+	sleep 1
+}
+
diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_tracing_on.sh b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_tracing_on.sh
new file mode 100755
index 0000000..672c223
--- /dev/null
+++ b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_tracing_on.sh
@@ -0,0 +1,39 @@
+#! /bin/sh
+
+###############################################################################
+#                                                                             #
+# Copyright (c) 2010 FUJITSU LIMITED                                          #
+#                                                                             #
+# This program is free software; you can redistribute it and/or modify it     #
+# under the terms of the GNU General Public License as published by the Free  #
+# Software Foundation; either version 2 of the License, or (at your option)   #
+# any later version.                                                          #
+#                                                                             #
+# Author: Li Zefan <lizf@cn.fujitsu.com>                                      #
+#                                                                             #
+###############################################################################
+
+MAX_LOOP=1500
+count=0
+
+for ((; ;))
+{
+	count=$(( $count + 1 ))
+
+	for ((i = 0; i < $MAX_LOOP; i++))
+	{
+		echo 0 > "$TRACING_PATH"/tracing_on
+		echo 1 > "$TRACING_PATH"/tracing_on
+	}
+
+	enable=$(( $count % 3 ))
+
+	if [ $enable -eq 0 ]; then
+		echo 0 > "$TRACING_PATH"/tracing_on
+	else
+		echo 1 > "$TRACING_PATH"/tracing_on
+	fi
+
+	sleep 1
+}
+
diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_stress_test.sh b/testcases/kernel/tracing/ftrace_test/ftrace_stress_test.sh
new file mode 100755
index 0000000..d9f7f8b
--- /dev/null
+++ b/testcases/kernel/tracing/ftrace_test/ftrace_stress_test.sh
@@ -0,0 +1,123 @@
+#! /bin/sh
+
+###########################################################################
+##                                                                       ##
+## Copyright (c) 2010 FUJITSU LIMITED                                    ##
+##                                                                       ##
+## This program is free software: you can redistribute it and/or modify  ##
+## it under the terms of the GNU General Public License as published by  ##
+## the Free Software Foundation, either version 3 of the License, or     ##
+## (at your option) any later version.                                   ##
+##                                                                       ##
+## This program is distributed in the hope that it will be useful,       ##
+## but WITHOUT ANY WARRANTY; without even the implied warranty of        ##
+## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the          ##
+## GNU General Public License for more details.                          ##
+##                                                                       ##
+## You should have received a copy of the GNU General Public License     ##
+## along with this program. If not, see <http://www.gnu.org/licenses/>.  ##
+##                                                                       ##
+## Author: Li Zefan <lizf@cn.fujitsu.com>                                ##
+##                                                                       ##
+###########################################################################
+
+
+export TCID="ftrace-stress-test"
+export TST_TOTAL=1
+export TST_COUNT=1
+
+. ftrace_lib.sh
+
+test_success=true
+
+export_pids()
+{
+	export pid1 pid2 pid3 pid4 pid5 pid6 pid7 pid8 pid9 pid10 pid11 pid12 \
+		pid13 pid14 pid15 pid16
+
+	export NR_PIDS=16
+}
+
+test_stress()
+{
+	export_pids
+
+	$SPATH/ftrace_trace_clock.sh &
+	pid1=$!
+	$SPATH/ftrace_current_tracer.sh &
+	pid2=$!
+	$SPATH/ftrace_trace_options.sh &
+	pid3=$!
+	$SPATH/ftrace_tracing_max_latency.sh &
+	pid4=$!
+	$SPATH/ftrace_stack_trace.sh &
+	pid5=$!
+	$SPATH/ftrace_stack_max_size.sh &
+	pid6=$!
+	$SPATH/ftrace_tracing_on.sh &
+	pid7=$!
+	$SPATH/ftrace_tracing_enabled.sh &
+	pid8=$!
+	$SPATH/ftrace_set_event.sh &
+	pid9=$!
+	$SPATH/ftrace_buffer_size.sh &
+	pid10=$!
+	$SPATH/ftrace_trace.sh &
+	pid11=$!
+	$SPATH/ftrace_trace_pipe.sh &
+	pid12=$!
+	$SPATH/ftrace_ftrace_enabled.sh &
+	pid13=$!
+	$SPATH/ftrace_set_ftrace_pid.sh &
+	pid14=$!
+	$SPATH/ftrace_profile_enabled.sh &
+	pid15=$!
+	$SPATH/ftrace_trace_stat.sh &
+	pid16=$!
+}
+
+test_kill()
+{
+	kill -KILL $pid1 || test_success=false
+	kill -KILL $pid2 || test_success=false
+	kill -KILL $pid3 || test_success=false
+	kill -KILL $pid4 || test_success=false
+	kill -KILL $pid5 || test_success=false
+	kill -KILL $pid6 || test_success=false
+	kill -KILL $pid7 || test_success=false
+	kill -KILL $pid8 || test_success=false
+	kill -KILL $pid9 || test_success=false
+	kill -KILL $pid10 || test_success=false
+	kill -KILL $pid11 || test_success=false
+	kill -USR1 $pid12 || test_success=false
+	kill -KILL $pid13 || test_success=false
+	kill -KILL $pid14 || test_success=false
+	kill -KILL $pid15 || test_success=false
+	kill -KILL $pid16 || test_success=false
+
+	sleep 2
+	clean_up
+}
+
+
+# ----------------------------
+echo "Ftrace Stress Test Begin"
+
+save_old_setting
+
+test_begin
+
+test_stress
+
+test_wait
+
+test_kill
+
+echo "Ftrace Stress Test End"
+
+if $test_success; then
+	tst_resm TPASS "finished running the test. Run dmesg to double-check for bugs"
+else
+	tst_resm TFAIL "please check log message."
+	exit 1
+fi
-- 
1.8.3.1


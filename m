Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <anders.roxell@linaro.org>) id 1V08B1-0002lF-BJ
	for ltp-list@lists.sourceforge.net; Fri, 19 Jul 2013 10:44:43 +0000
Received: from mail-la0-f45.google.com ([209.85.215.45])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1V08Ax-00019h-QC
	for ltp-list@lists.sourceforge.net; Fri, 19 Jul 2013 10:44:43 +0000
Received: by mail-la0-f45.google.com with SMTP id ev20so1572896lab.32
	for <ltp-list@lists.sourceforge.net>;
	Fri, 19 Jul 2013 03:44:33 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
Date: Fri, 19 Jul 2013 12:44:19 +0200
Message-Id: <1374230659-21101-2-git-send-email-anders.roxell@linaro.org>
In-Reply-To: <1374230659-21101-1-git-send-email-anders.roxell@linaro.org>
References: <1374230659-21101-1-git-send-email-anders.roxell@linaro.org>
Subject: [LTP] [PATCH] realtime-testsuite: update the install rule
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: patches@linaro.org

func/*/Makefile: added INSTALL_TARGETS
func/*/run.sh -> func/*/run_auto.sh to autorun those tests when running
    the test_realtime.sh script.
run.sh scripts/run_c_files.sh: if installed no need to rebuild tests
testscritps/test_realtime.sh: remove java from the "all" target and
    do not rebuild lib if running from installed path

New files, needed to run the realtime-testsuite from a installed path
profiles/Makefile and scripts/Makefile

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 testcases/realtime/func/async_handler/Makefile     |  1 +
 testcases/realtime/func/gtod_latency/Makefile      |  1 +
 testcases/realtime/func/hrtimer-prio/Makefile      |  1 +
 testcases/realtime/func/hrtimer-prio/run.sh        | 12 ----------
 testcases/realtime/func/hrtimer-prio/run_auto.sh   | 10 +++++++++
 testcases/realtime/func/matrix_mult/Makefile       |  1 +
 testcases/realtime/func/measurement/Makefile       |  1 +
 testcases/realtime/func/measurement/run.sh         | 19 ----------------
 testcases/realtime/func/measurement/run_auto.sh    | 19 ++++++++++++++++
 testcases/realtime/func/periodic_cpu_load/Makefile |  1 +
 testcases/realtime/func/pi-tests/Makefile          |  1 +
 testcases/realtime/func/pi_perf/Makefile           |  1 +
 testcases/realtime/func/prio-preempt/Makefile      |  1 +
 testcases/realtime/func/prio-wake/Makefile         |  1 +
 .../realtime/func/pthread_kill_latency/Makefile    |  1 +
 testcases/realtime/func/rt-migrate/Makefile        |  1 +
 testcases/realtime/func/sched_football/Makefile    |  1 +
 testcases/realtime/func/sched_jitter/Makefile      |  1 +
 testcases/realtime/func/sched_latency/Makefile     |  1 +
 testcases/realtime/func/thread_clock/Makefile      |  1 +
 testcases/realtime/perf/latency/Makefile           |  1 +
 testcases/realtime/profiles/Makefile               | 26 ++++++++++++++++++++++
 testcases/realtime/run.sh                          | 16 ++++++++-----
 testcases/realtime/scripts/Makefile                | 26 ++++++++++++++++++++++
 testcases/realtime/scripts/run_c_files.sh          |  7 ++++--
 testscripts/test_realtime.sh                       | 18 +++++++++------
 26 files changed, 124 insertions(+), 46 deletions(-)
 delete mode 100644 testcases/realtime/func/hrtimer-prio/run.sh
 create mode 100644 testcases/realtime/func/hrtimer-prio/run_auto.sh
 delete mode 100644 testcases/realtime/func/measurement/run.sh
 create mode 100644 testcases/realtime/func/measurement/run_auto.sh
 create mode 100644 testcases/realtime/profiles/Makefile
 create mode 100644 testcases/realtime/scripts/Makefile

diff --git a/testcases/realtime/func/async_handler/Makefile b/testcases/realtime/func/async_handler/Makefile
index faf4fa9..f334cfa 100644
--- a/testcases/realtime/func/async_handler/Makefile
+++ b/testcases/realtime/func/async_handler/Makefile
@@ -22,6 +22,7 @@
 
 top_srcdir		?= ../../../..
 
+INSTALL_TARGETS		:= run_auto.sh
 include $(top_srcdir)/include/mk/env_pre.mk
 include $(abs_srcdir)/../../config.mk
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/realtime/func/gtod_latency/Makefile b/testcases/realtime/func/gtod_latency/Makefile
index bd67ed6..89d82c9 100644
--- a/testcases/realtime/func/gtod_latency/Makefile
+++ b/testcases/realtime/func/gtod_latency/Makefile
@@ -22,6 +22,7 @@
 
 top_srcdir		?= ../../../..
 
+INSTALL_TARGETS		:= run_auto.sh
 include $(top_srcdir)/include/mk/env_pre.mk
 include $(abs_srcdir)/../../config.mk
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/realtime/func/hrtimer-prio/Makefile b/testcases/realtime/func/hrtimer-prio/Makefile
index 0a1872c..d294ee2 100644
--- a/testcases/realtime/func/hrtimer-prio/Makefile
+++ b/testcases/realtime/func/hrtimer-prio/Makefile
@@ -22,6 +22,7 @@
 
 top_srcdir		?= ../../../..
 
+INSTALL_TARGETS		:= run_auto.sh
 include $(top_srcdir)/include/mk/env_pre.mk
 include $(abs_srcdir)/../../config.mk
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/realtime/func/hrtimer-prio/run.sh b/testcases/realtime/func/hrtimer-prio/run.sh
deleted file mode 100644
index b45e76b..0000000
--- a/testcases/realtime/func/hrtimer-prio/run.sh
+++ /dev/null
@@ -1,12 +0,0 @@
-#! /bin/bash
-
-if [ ! $SCRIPTS_DIR ]; then
-        # assume we're running standalone
-        export SCRIPTS_DIR=../../scripts/
-fi
-
-source $SCRIPTS_DIR/setenv.sh
-
-$SCRIPTS_DIR/run_c_files.sh "hrtimer-prio"
-
-
diff --git a/testcases/realtime/func/hrtimer-prio/run_auto.sh b/testcases/realtime/func/hrtimer-prio/run_auto.sh
new file mode 100644
index 0000000..366e746
--- /dev/null
+++ b/testcases/realtime/func/hrtimer-prio/run_auto.sh
@@ -0,0 +1,10 @@
+#! /bin/bash
+
+if [ ! $SCRIPTS_DIR ]; then
+        # assume we're running standalone
+        export SCRIPTS_DIR=../../scripts/
+fi
+
+source $SCRIPTS_DIR/setenv.sh
+
+$SCRIPTS_DIR/run_c_files.sh "hrtimer-prio"
diff --git a/testcases/realtime/func/matrix_mult/Makefile b/testcases/realtime/func/matrix_mult/Makefile
index c19cad1..3d89133 100644
--- a/testcases/realtime/func/matrix_mult/Makefile
+++ b/testcases/realtime/func/matrix_mult/Makefile
@@ -22,6 +22,7 @@
 
 top_srcdir		?= ../../../..
 
+INSTALL_TARGETS		:= run_auto.sh
 include $(top_srcdir)/include/mk/env_pre.mk
 include $(abs_srcdir)/../../config.mk
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/realtime/func/measurement/Makefile b/testcases/realtime/func/measurement/Makefile
index fdad2c5..36343e9 100644
--- a/testcases/realtime/func/measurement/Makefile
+++ b/testcases/realtime/func/measurement/Makefile
@@ -22,6 +22,7 @@
 
 top_srcdir		?= ../../../..
 
+INSTALL_TARGETS		:= run_auto.sh
 include $(top_srcdir)/include/mk/env_pre.mk
 include $(abs_srcdir)/../../config.mk
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/realtime/func/measurement/run.sh b/testcases/realtime/func/measurement/run.sh
deleted file mode 100644
index 3011964..0000000
--- a/testcases/realtime/func/measurement/run.sh
+++ /dev/null
@@ -1,19 +0,0 @@
-#! /bin/bash
-
-if [ ! $SCRIPTS_DIR ]; then
-        # assume we're running standalone
-        export SCRIPTS_DIR=../../scripts/
-fi
-
-source $SCRIPTS_DIR/setenv.sh
-
-
-# This is a temporary workaround for previous
-# loop support patch which seems to be having
-# issues right now.
-
-LOG_FILE="$LOG_DIR/$LOG_FORMAT-rdtsc-latency.log"
-$SCRIPTS_DIR/run_c_files.sh "rdtsc-latency"
-
-LOG_FILE="$LOG_DIR/$LOG_FORMAT-preempt_timing.log"
-$SCRIPTS_DIR/run_c_files.sh "preempt_timing"
diff --git a/testcases/realtime/func/measurement/run_auto.sh b/testcases/realtime/func/measurement/run_auto.sh
new file mode 100644
index 0000000..3011964
--- /dev/null
+++ b/testcases/realtime/func/measurement/run_auto.sh
@@ -0,0 +1,19 @@
+#! /bin/bash
+
+if [ ! $SCRIPTS_DIR ]; then
+        # assume we're running standalone
+        export SCRIPTS_DIR=../../scripts/
+fi
+
+source $SCRIPTS_DIR/setenv.sh
+
+
+# This is a temporary workaround for previous
+# loop support patch which seems to be having
+# issues right now.
+
+LOG_FILE="$LOG_DIR/$LOG_FORMAT-rdtsc-latency.log"
+$SCRIPTS_DIR/run_c_files.sh "rdtsc-latency"
+
+LOG_FILE="$LOG_DIR/$LOG_FORMAT-preempt_timing.log"
+$SCRIPTS_DIR/run_c_files.sh "preempt_timing"
diff --git a/testcases/realtime/func/periodic_cpu_load/Makefile b/testcases/realtime/func/periodic_cpu_load/Makefile
index 275eb06..e7ec8fc 100644
--- a/testcases/realtime/func/periodic_cpu_load/Makefile
+++ b/testcases/realtime/func/periodic_cpu_load/Makefile
@@ -22,6 +22,7 @@
 
 top_srcdir		?= ../../../..
 
+INSTALL_TARGETS		:= run_auto.sh
 include $(top_srcdir)/include/mk/env_pre.mk
 include $(abs_srcdir)/../../config.mk
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/realtime/func/pi-tests/Makefile b/testcases/realtime/func/pi-tests/Makefile
index eb9cca3..7a7a57a 100644
--- a/testcases/realtime/func/pi-tests/Makefile
+++ b/testcases/realtime/func/pi-tests/Makefile
@@ -22,6 +22,7 @@
 
 top_srcdir		?= ../../../..
 
+INSTALL_TARGETS		:= run_auto.sh parse-testpi1.py parse-testpi2.py
 include $(top_srcdir)/include/mk/env_pre.mk
 include $(abs_srcdir)/../../config.mk
 
diff --git a/testcases/realtime/func/pi_perf/Makefile b/testcases/realtime/func/pi_perf/Makefile
index fbceaba..196fca8 100644
--- a/testcases/realtime/func/pi_perf/Makefile
+++ b/testcases/realtime/func/pi_perf/Makefile
@@ -22,6 +22,7 @@
 
 top_srcdir		?= ../../../..
 
+INSTALL_TARGETS		:= run_auto.sh
 include $(top_srcdir)/include/mk/env_pre.mk
 include $(abs_srcdir)/../../config.mk
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/realtime/func/prio-preempt/Makefile b/testcases/realtime/func/prio-preempt/Makefile
index 6da3504..b4c0b2e 100644
--- a/testcases/realtime/func/prio-preempt/Makefile
+++ b/testcases/realtime/func/prio-preempt/Makefile
@@ -22,6 +22,7 @@
 
 top_srcdir		?= ../../../..
 
+INSTALL_TARGETS		:= run_auto.sh
 include $(top_srcdir)/include/mk/env_pre.mk
 include $(abs_srcdir)/../../config.mk
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/realtime/func/prio-wake/Makefile b/testcases/realtime/func/prio-wake/Makefile
index 256f5fb..6cea976 100644
--- a/testcases/realtime/func/prio-wake/Makefile
+++ b/testcases/realtime/func/prio-wake/Makefile
@@ -22,6 +22,7 @@
 
 top_srcdir		?= ../../../..
 
+INSTALL_TARGETS		:= run_auto.sh
 include $(top_srcdir)/include/mk/env_pre.mk
 include $(abs_srcdir)/../../config.mk
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/realtime/func/pthread_kill_latency/Makefile b/testcases/realtime/func/pthread_kill_latency/Makefile
index b07d8de..fd3a059 100644
--- a/testcases/realtime/func/pthread_kill_latency/Makefile
+++ b/testcases/realtime/func/pthread_kill_latency/Makefile
@@ -22,6 +22,7 @@
 
 top_srcdir		?= ../../../..
 
+INSTALL_TARGETS		:= run_auto.sh
 include $(top_srcdir)/include/mk/env_pre.mk
 include $(abs_srcdir)/../../config.mk
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/realtime/func/rt-migrate/Makefile b/testcases/realtime/func/rt-migrate/Makefile
index b48f48a..ae4f610 100644
--- a/testcases/realtime/func/rt-migrate/Makefile
+++ b/testcases/realtime/func/rt-migrate/Makefile
@@ -22,6 +22,7 @@
 
 top_srcdir		?= ../../../..
 
+INSTALL_TARGETS		:= run_auto.sh
 include $(top_srcdir)/include/mk/env_pre.mk
 include $(abs_srcdir)/../../config.mk
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/realtime/func/sched_football/Makefile b/testcases/realtime/func/sched_football/Makefile
index 1b2a480..a5117fd 100644
--- a/testcases/realtime/func/sched_football/Makefile
+++ b/testcases/realtime/func/sched_football/Makefile
@@ -22,6 +22,7 @@
 
 top_srcdir		?= ../../../..
 
+INSTALL_TARGETS		:= run_auto.sh
 include $(top_srcdir)/include/mk/env_pre.mk
 include $(abs_srcdir)/../../config.mk
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/realtime/func/sched_jitter/Makefile b/testcases/realtime/func/sched_jitter/Makefile
index 95bc9a9..827a0db 100644
--- a/testcases/realtime/func/sched_jitter/Makefile
+++ b/testcases/realtime/func/sched_jitter/Makefile
@@ -22,6 +22,7 @@
 
 top_srcdir		?= ../../../..
 
+INSTALL_TARGETS		:= run_auto.sh
 include $(top_srcdir)/include/mk/env_pre.mk
 include $(abs_srcdir)/../../config.mk
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/realtime/func/sched_latency/Makefile b/testcases/realtime/func/sched_latency/Makefile
index 564d42f..b7327df 100644
--- a/testcases/realtime/func/sched_latency/Makefile
+++ b/testcases/realtime/func/sched_latency/Makefile
@@ -22,6 +22,7 @@
 
 top_srcdir		?= ../../../..
 
+INSTALL_TARGETS		:= run_auto.sh
 include $(top_srcdir)/include/mk/env_pre.mk
 include $(abs_srcdir)/../../config.mk
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/realtime/func/thread_clock/Makefile b/testcases/realtime/func/thread_clock/Makefile
index b94b897..5cac451 100644
--- a/testcases/realtime/func/thread_clock/Makefile
+++ b/testcases/realtime/func/thread_clock/Makefile
@@ -22,6 +22,7 @@
 
 top_srcdir		?= ../../../..
 
+INSTALL_TARGETS		:= run_auto.sh
 include $(top_srcdir)/include/mk/env_pre.mk
 include $(abs_srcdir)/../../config.mk
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/realtime/perf/latency/Makefile b/testcases/realtime/perf/latency/Makefile
index 6b1ad58..0ce86a3 100644
--- a/testcases/realtime/perf/latency/Makefile
+++ b/testcases/realtime/perf/latency/Makefile
@@ -22,6 +22,7 @@
 
 top_srcdir		?= ../../../..
 
+INSTALL_TARGETS		:= cpunoise.sh cpunoise2000.sh disknoise.sh run.sh
 include $(top_srcdir)/include/mk/env_pre.mk
 include $(abs_srcdir)/../../config.mk
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/realtime/profiles/Makefile b/testcases/realtime/profiles/Makefile
new file mode 100644
index 0000000..c231f31
--- /dev/null
+++ b/testcases/realtime/profiles/Makefile
@@ -0,0 +1,26 @@
+#
+#    realtime/profiles test suite Makefile.
+#
+#    Copyright 2013 Linaro Limited
+#
+#    This program is free software; you can redistribute it and/or modify
+#    it under the terms of the GNU General Public License as published by
+#    the Free Software Foundation; either version 2 of the License, or
+#    (at your option) any later version.
+#
+#    This program is distributed in the hope that it will be useful,
+#    but WITHOUT ANY WARRANTY; without even the implied warranty of
+#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#    GNU General Public License for more details.
+#
+#    You should have received a copy of the GNU General Public License along
+#    with this program; if not, write to the Free Software Foundation, Inc.,
+#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+
+top_srcdir		?= ../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+include $(abs_srcdir)/../config.mk
+INSTALL_TARGETS		:= default
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/realtime/run.sh b/testcases/realtime/run.sh
index 77e8d68..a66e4e5 100755
--- a/testcases/realtime/run.sh
+++ b/testcases/realtime/run.sh
@@ -185,12 +185,16 @@ if [ $# -lt 1 ]; then
 fi
 pushd $TESTS_DIR >/dev/null
 
-#Only build the library, most of the tests depend upon.
-#The Individual tests will be built, just before they run.
-pushd lib
-make
-check_error make
-popd
+# if INSTALL_DIR != top_srcdir assume the individual tests are built and installed.
+# So no need to build lib
+if [[ -d lib ]]; then
+    #Only build the library, most of the tests depend upon.
+    #The Individual tests will be built, just before they run.
+    pushd lib
+    make
+    check_error make
+    popd
+fi
 
 ISLOOP=0
 index=0
diff --git a/testcases/realtime/scripts/Makefile b/testcases/realtime/scripts/Makefile
new file mode 100644
index 0000000..28bf88e
--- /dev/null
+++ b/testcases/realtime/scripts/Makefile
@@ -0,0 +1,26 @@
+#
+#    realtime/scripts test suite Makefile.
+#
+#    Copyright 2013 Linaro Limited
+#
+#    This program is free software; you can redistribute it and/or modify
+#    it under the terms of the GNU General Public License as published by
+#    the Free Software Foundation; either version 2 of the License, or
+#    (at your option) any later version.
+#
+#    This program is distributed in the hope that it will be useful,
+#    but WITHOUT ANY WARRANTY; without even the implied warranty of
+#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#    GNU General Public License for more details.
+#
+#    You should have received a copy of the GNU General Public License along
+#    with this program; if not, write to the Free Software Foundation, Inc.,
+#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+
+top_srcdir		?= ../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+include $(abs_srcdir)/../config.mk
+INSTALL_TARGETS		:= run_c_files.sh setenv.sh __init__.py parser.py
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/realtime/scripts/run_c_files.sh b/testcases/realtime/scripts/run_c_files.sh
index 3ab52ec..6e73f38 100755
--- a/testcases/realtime/scripts/run_c_files.sh
+++ b/testcases/realtime/scripts/run_c_files.sh
@@ -20,8 +20,11 @@ profile_path=$PROFILES_DIR/$profile
 # Does profile exist?
 [ ! -f "$profile_path" ] && { echo >&2 "$0: Could not find profile ($profile_path)" ; exit 1 ; }
 
-# Compile the test cases to support stand alone runs.
-make
+# if INSTALL_DIR != top_srcdir assume the individual tests are built and installed.
+if [[ -f Makefile ]]; then
+    # Compile the test cases to support stand alone runs.
+    make
+fi
 
 
 # Run the test case
diff --git a/testscripts/test_realtime.sh b/testscripts/test_realtime.sh
index 22c3692..0d424fc 100755
--- a/testscripts/test_realtime.sh
+++ b/testscripts/test_realtime.sh
@@ -128,7 +128,7 @@ find_test()
             ;;
         all)
         # Run all tests which have run_auto.sh
-            TESTLIST="func stress java perf"
+            TESTLIST="func stress perf"
             ;;
         list)
         # This will only display subdirs which have run_auto.sh
@@ -176,12 +176,16 @@ if [ ! -e "logs" ]; then
         chmod -R 775 logs
 fi
 
-#Only build the library, most of the tests depend upon.
-#The Individual tests will be built, just before they run.
-pushd lib
-make
-check_error make
-popd
+# if INSTALL_DIR != top_srcdir assume the individual tests are built and installed.
+# So no need to build lib
+if [[ -d lib ]]; then
+    #Only build the library, most of the tests depend upon.
+    #The Individual tests will be built, just before they run.
+    pushd lib
+    make
+    check_error make
+    popd
+fi
 
 ISLOOP=0
 index=0
-- 
1.8.1.2


------------------------------------------------------------------------------
See everything from the browser to the database with AppDynamics
Get end-to-end visibility with application monitoring from AppDynamics
Isolate bottlenecks and diagnose root cause in seconds.
Start your free trial of AppDynamics Pro today!
http://pubads.g.doubleclick.net/gampad/clk?id=48808831&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

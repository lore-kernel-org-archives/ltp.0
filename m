Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <anders.roxell@linaro.org>) id 1V6Q3p-0001YS-Cw
	for ltp-list@lists.sourceforge.net; Mon, 05 Aug 2013 19:03:17 +0000
Received: from mail-la0-f51.google.com ([209.85.215.51])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1V6Q3l-00076b-JM
	for ltp-list@lists.sourceforge.net; Mon, 05 Aug 2013 19:03:17 +0000
Received: by mail-la0-f51.google.com with SMTP id fp13so2365545lab.10
	for <ltp-list@lists.sourceforge.net>;
	Mon, 05 Aug 2013 12:03:07 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
Date: Mon,  5 Aug 2013 21:02:54 +0200
Message-Id: <1375729379-16469-2-git-send-email-anders.roxell@linaro.org>
In-Reply-To: <1375729379-16469-1-git-send-email-anders.roxell@linaro.org>
References: <1375729379-16469-1-git-send-email-anders.roxell@linaro.org>
Subject: [LTP] [PATCH 1/6] realtime/(func|perf)/: rename run.sh to
	run_auto.sh
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

Rename run.sh to run_auto.sh in accordance to all other func tests and
remove unnecessary whitespaces newlines at the end of file to prevent git
am warning.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 testcases/realtime/func/hrtimer-prio/run.sh      |   12 ------
 testcases/realtime/func/hrtimer-prio/run_auto.sh |   10 +++++
 testcases/realtime/func/measurement/run.sh       |   19 ---------
 testcases/realtime/func/measurement/run_auto.sh  |   19 +++++++++
 testcases/realtime/perf/latency/run.sh           |   45 ----------------------
 testcases/realtime/perf/latency/run_auto.sh      |   45 ++++++++++++++++++++++
 6 files changed, 74 insertions(+), 76 deletions(-)
 delete mode 100644 testcases/realtime/func/hrtimer-prio/run.sh
 create mode 100644 testcases/realtime/func/hrtimer-prio/run_auto.sh
 delete mode 100644 testcases/realtime/func/measurement/run.sh
 create mode 100644 testcases/realtime/func/measurement/run_auto.sh
 delete mode 100755 testcases/realtime/perf/latency/run.sh
 create mode 100755 testcases/realtime/perf/latency/run_auto.sh

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
diff --git a/testcases/realtime/perf/latency/run.sh b/testcases/realtime/perf/latency/run.sh
deleted file mode 100755
index 2c0d203..0000000
--- a/testcases/realtime/perf/latency/run.sh
+++ /dev/null
@@ -1,45 +0,0 @@
-#! /bin/bash
-
-if [ ! $SCRIPTS_DIR ]; then
-	# assume we're running standalone
-	export SCRIPTS_DIR=../../scripts/
-fi
-
-source $SCRIPTS_DIR/setenv.sh
-LOG_FILE="$LOG_DIR/$LOG_FORMAT-pthread_cond_many.log"
-
-echo -e "Logging to: " | tee -a $LOG_FILE
-echo -e "$LOG_FILE " | tee -a $LOG_FILE
-echo -e "and to local individual .out files " | tee -a $LOG_FILE
-
-#
-# make will eventually go away from here, as will the above echoes
-#
-make
-
-#
-# Test lots of threads.  Specify "--realtime" if you want the first
-# process to run realtime.  The remainder of the processes (if any)
-# will run non-realtime in any case.
-
-nthread=5000
-iter=400
-nproc=5
-
-echo -e "pthread_cond_many configuration:" | tee -a $LOG_FILE
-echo -e "number of threads = $nthread " | tee -a $LOG_FILE
-echo -e "number of iterations = $iter " | tee -a $LOG_FILE
-echo -e "number of processes = $nproc " | tee -a $LOG_FILE
-
-# Remove any existing local log files
-rm -f $nthread.$iter.$nproc.*.out
-
-i=0
-./pthread_cond_many --realtime --broadcast -i $iter -n $nthread > $nthread.$iter.$nproc.$i.out &
-i=1
-while test $i -lt $nproc
-do
-        ./pthread_cond_many --broadcast -i $iter -n $nthread > $nthread.$iter.$nproc.$i.out &
-        i=`expr $i + 1`
-done
-wait
diff --git a/testcases/realtime/perf/latency/run_auto.sh b/testcases/realtime/perf/latency/run_auto.sh
new file mode 100755
index 0000000..2c0d203
--- /dev/null
+++ b/testcases/realtime/perf/latency/run_auto.sh
@@ -0,0 +1,45 @@
+#! /bin/bash
+
+if [ ! $SCRIPTS_DIR ]; then
+	# assume we're running standalone
+	export SCRIPTS_DIR=../../scripts/
+fi
+
+source $SCRIPTS_DIR/setenv.sh
+LOG_FILE="$LOG_DIR/$LOG_FORMAT-pthread_cond_many.log"
+
+echo -e "Logging to: " | tee -a $LOG_FILE
+echo -e "$LOG_FILE " | tee -a $LOG_FILE
+echo -e "and to local individual .out files " | tee -a $LOG_FILE
+
+#
+# make will eventually go away from here, as will the above echoes
+#
+make
+
+#
+# Test lots of threads.  Specify "--realtime" if you want the first
+# process to run realtime.  The remainder of the processes (if any)
+# will run non-realtime in any case.
+
+nthread=5000
+iter=400
+nproc=5
+
+echo -e "pthread_cond_many configuration:" | tee -a $LOG_FILE
+echo -e "number of threads = $nthread " | tee -a $LOG_FILE
+echo -e "number of iterations = $iter " | tee -a $LOG_FILE
+echo -e "number of processes = $nproc " | tee -a $LOG_FILE
+
+# Remove any existing local log files
+rm -f $nthread.$iter.$nproc.*.out
+
+i=0
+./pthread_cond_many --realtime --broadcast -i $iter -n $nthread > $nthread.$iter.$nproc.$i.out &
+i=1
+while test $i -lt $nproc
+do
+        ./pthread_cond_many --broadcast -i $iter -n $nthread > $nthread.$iter.$nproc.$i.out &
+        i=`expr $i + 1`
+done
+wait
-- 
1.7.10.4


------------------------------------------------------------------------------
Get your SQL database under version control now!
Version control is standard for application code, but databases havent 
caught up. So what steps can you take to put your SQL databases under 
version control? Why should you start doing it? Read more to find out.
http://pubads.g.doubleclick.net/gampad/clk?id=49501711&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

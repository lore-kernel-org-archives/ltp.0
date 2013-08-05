Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <anders.roxell@linaro.org>) id 1V6Q3s-0006sz-0b
	for ltp-list@lists.sourceforge.net; Mon, 05 Aug 2013 19:03:20 +0000
Received: from mail-lb0-f177.google.com ([209.85.217.177])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1V6Q3o-0005mL-57
	for ltp-list@lists.sourceforge.net; Mon, 05 Aug 2013 19:03:19 +0000
Received: by mail-lb0-f177.google.com with SMTP id r11so2331176lbv.22
	for <ltp-list@lists.sourceforge.net>;
	Mon, 05 Aug 2013 12:03:09 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
Date: Mon,  5 Aug 2013 21:02:55 +0200
Message-Id: <1375729379-16469-3-git-send-email-anders.roxell@linaro.org>
In-Reply-To: <1375729379-16469-1-git-send-email-anders.roxell@linaro.org>
References: <1375729379-16469-1-git-send-email-anders.roxell@linaro.org>
Subject: [LTP] [PATCH 2/6] added run_auto.sh to install targets for realtime
	tests
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

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 testcases/realtime/func/async_handler/Makefile        |    1 +
 testcases/realtime/func/gtod_latency/Makefile         |    1 +
 testcases/realtime/func/hrtimer-prio/Makefile         |    1 +
 testcases/realtime/func/matrix_mult/Makefile          |    1 +
 testcases/realtime/func/measurement/Makefile          |    1 +
 testcases/realtime/func/periodic_cpu_load/Makefile    |    1 +
 testcases/realtime/func/pi-tests/Makefile             |    1 +
 testcases/realtime/func/pi_perf/Makefile              |    1 +
 testcases/realtime/func/prio-preempt/Makefile         |    1 +
 testcases/realtime/func/prio-wake/Makefile            |    1 +
 testcases/realtime/func/pthread_kill_latency/Makefile |    1 +
 testcases/realtime/func/rt-migrate/Makefile           |    1 +
 testcases/realtime/func/sched_football/Makefile       |    1 +
 testcases/realtime/func/sched_jitter/Makefile         |    1 +
 testcases/realtime/func/sched_latency/Makefile        |    1 +
 testcases/realtime/func/thread_clock/Makefile         |    1 +
 testcases/realtime/perf/latency/Makefile              |    1 +
 17 files changed, 17 insertions(+)

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
index eb9cca3..5273952 100644
--- a/testcases/realtime/func/pi-tests/Makefile
+++ b/testcases/realtime/func/pi-tests/Makefile
@@ -22,6 +22,7 @@
 
 top_srcdir		?= ../../../..
 
+INSTALL_TARGETS		:= run_auto.sh
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
index 6b1ad58..eea054d 100644
--- a/testcases/realtime/perf/latency/Makefile
+++ b/testcases/realtime/perf/latency/Makefile
@@ -22,6 +22,7 @@
 
 top_srcdir		?= ../../../..
 
+INSTALL_TARGETS		:= run_auto.sh
 include $(top_srcdir)/include/mk/env_pre.mk
 include $(abs_srcdir)/../../config.mk
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
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

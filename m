Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <ciprian.barbu@linaro.org>) id 1WN1tZ-0006U3-Rj
	for ltp-list@lists.sourceforge.net; Mon, 10 Mar 2014 15:13:37 +0000
Received: from mail-la0-f47.google.com ([209.85.215.47])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1WN1tZ-0000JC-3Q
	for ltp-list@lists.sourceforge.net; Mon, 10 Mar 2014 15:13:37 +0000
Received: by mail-la0-f47.google.com with SMTP id y1so4665348lam.6
	for <ltp-list@lists.sourceforge.net>;
	Mon, 10 Mar 2014 08:13:30 -0700 (PDT)
From: Ciprian Barbu <ciprian.barbu@linaro.org>
Date: Mon, 10 Mar 2014 16:06:37 +0100
Message-Id: <1394463997-14528-1-git-send-email-ciprian.barbu@linaro.org>
Subject: [LTP] [LNG][PATCH] Fix ltp realtime hrtimer-prio and measurement to
	pass default profile to run_c_files.sh
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
To: ciprian.barbu@linaro.org
Cc: ltp-list@lists.sourceforge.net, linaro-networking@linaro.org

Signed-off-by: Ciprian Barbu <ciprian.barbu@linaro.org>

Upstream-Status: Pending
---
 testcases/realtime/func/hrtimer-prio/run_auto.sh |    4 +++-
 testcases/realtime/func/measurement/run_auto.sh  |    6 ++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/testcases/realtime/func/hrtimer-prio/run_auto.sh b/testcases/realtime/func/hrtimer-prio/run_auto.sh
index 366e746..ec3d83a 100644
--- a/testcases/realtime/func/hrtimer-prio/run_auto.sh
+++ b/testcases/realtime/func/hrtimer-prio/run_auto.sh
@@ -1,5 +1,7 @@
 #! /bin/bash
 
+profile=${1:-default}
+
 if [ ! $SCRIPTS_DIR ]; then
         # assume we're running standalone
         export SCRIPTS_DIR=../../scripts/
@@ -7,4 +9,4 @@ fi
 
 source $SCRIPTS_DIR/setenv.sh
 
-$SCRIPTS_DIR/run_c_files.sh "hrtimer-prio"
+$SCRIPTS_DIR/run_c_files.sh $profile "hrtimer-prio"
diff --git a/testcases/realtime/func/measurement/run_auto.sh b/testcases/realtime/func/measurement/run_auto.sh
index 3011964..439f721 100644
--- a/testcases/realtime/func/measurement/run_auto.sh
+++ b/testcases/realtime/func/measurement/run_auto.sh
@@ -1,5 +1,7 @@
 #! /bin/bash
 
+profile=${1:-default}
+
 if [ ! $SCRIPTS_DIR ]; then
         # assume we're running standalone
         export SCRIPTS_DIR=../../scripts/
@@ -13,7 +15,7 @@ source $SCRIPTS_DIR/setenv.sh
 # issues right now.
 
 LOG_FILE="$LOG_DIR/$LOG_FORMAT-rdtsc-latency.log"
-$SCRIPTS_DIR/run_c_files.sh "rdtsc-latency"
+$SCRIPTS_DIR/run_c_files.sh $profile "rdtsc-latency"
 
 LOG_FILE="$LOG_DIR/$LOG_FORMAT-preempt_timing.log"
-$SCRIPTS_DIR/run_c_files.sh "preempt_timing"
+$SCRIPTS_DIR/run_c_files.sh $profile "preempt_timing"
-- 
1.7.9.5


------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/13534_NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

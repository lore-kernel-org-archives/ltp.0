Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <penght@cn.fujitsu.com>) id 1UwUBG-0006Og-PX
	for ltp-list@lists.sourceforge.net; Tue, 09 Jul 2013 09:25:54 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UwUBE-0004JN-IW
	for ltp-list@lists.sourceforge.net; Tue, 09 Jul 2013 09:25:54 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id r699Pic0025443
	for <ltp-list@lists.sourceforge.net>; Tue, 9 Jul 2013 17:25:44 +0800
From: Peng Haitao <penght@cn.fujitsu.com>
Date: Tue, 9 Jul 2013 17:25:27 +0800
Message-Id: <1373361927-18695-1-git-send-email-penght@cn.fujitsu.com>
Subject: [LTP] [PATCH] cron02: Use lib to restart crond service
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

Use restart_daemon() to restart crond service.

Signed-off-by: Peng Haitao <penght@cn.fujitsu.com>
---
 testcases/commands/cron/cron02 | 27 +++++----------------------
 testcases/lib/cmdlib.sh        |  8 ++++++++
 2 files changed, 13 insertions(+), 22 deletions(-)

diff --git a/testcases/commands/cron/cron02 b/testcases/commands/cron/cron02
index f8615dc..16b425d 100755
--- a/testcases/commands/cron/cron02
+++ b/testcases/commands/cron/cron02
@@ -52,29 +52,10 @@ do_setup(){
         }
         fi
 
-	# running under systemd?
-	if command -v systemctl >/dev/null 2>&1; then
-		HAVE_SYSTEMCTL=true
+	if [ -n "$CROND_DAEMON" ]; then
+		restart_daemon $CROND_DAEMON
 	else
-		HAVE_SYSTEMCTL=false
-	fi
-
-	# restart cron daemon
-	# Red Hat uses crond, SuSE/Other uses cron.
-	if [ -x /etc/init.d/crond ]; then
-		/etc/init.d/crond restart
-	elif [ -x /etc/init.d/cron ]; then
-		/etc/init.d/cron restart
-	elif $HAVE_SYSTEMCTL; then
-		for crond in "crond" "cron"; do
-			if systemctl is-enabled $crond.service >/dev/null 2>&1; then
-				systemctl restart $crond.service
-				break
-			fi
-		done
-	else
-		echo "Could not determine cron init.d script."
-		exit 1
+		tst_brkm TBROK "Couldn't find crond or cron"
 	fi
 }
 
@@ -90,6 +71,8 @@ do_cleanup(){
 #-----------------------------------------------------------------------
 # FUNCTION:  MAIN
 #-----------------------------------------------------------------------
+. cmdlib.sh
+
 do_setup
 cron_pos_tests.sh $TEST_USER
 EXIT_CODE=$?
diff --git a/testcases/lib/cmdlib.sh b/testcases/lib/cmdlib.sh
index b1ea15e..d6f43d2 100644
--- a/testcases/lib/cmdlib.sh
+++ b/testcases/lib/cmdlib.sh
@@ -168,6 +168,14 @@ elif command -v rsyslogd >/dev/null 2>&1; then
 	SYSLOG_DAEMON="rsyslog"
 fi
 
+# Check to see if cron or crond exists
+CROND_DAEMON=""
+if command -v crond >/dev/null 2>&1; then
+	CROND_DAEMON="crond"
+elif command -v cron >/dev/null 2>&1; then
+	CROND_DAEMON="cron"
+fi
+
 start_daemon()
 {
 	if [ $HAVE_SYSTEMCTL -eq 1 ]; then
-- 
1.8.3.1


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

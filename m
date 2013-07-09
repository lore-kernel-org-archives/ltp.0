Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <penght@cn.fujitsu.com>) id 1UwTmW-00029V-Hs
	for ltp-list@lists.sourceforge.net; Tue, 09 Jul 2013 09:00:20 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UwTmV-00061E-HC
	for ltp-list@lists.sourceforge.net; Tue, 09 Jul 2013 09:00:20 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id r698b0NK021859
	for <ltp-list@lists.sourceforge.net>; Tue, 9 Jul 2013 16:37:06 +0800
From: Peng Haitao <penght@cn.fujitsu.com>
Date: Tue, 9 Jul 2013 16:36:41 +0800
Message-Id: <1373359002-17618-1-git-send-email-penght@cn.fujitsu.com>
Subject: [LTP] [PATCH 1/2] sssd-lib.sh: Use lib to restart sssd service
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

Use restart_daemon() to restart sssd service.

Signed-off-by: Peng Haitao <penght@cn.fujitsu.com>
---
 testcases/commands/sssd/sssd-lib.sh | 41 +++----------------------------------
 1 file changed, 3 insertions(+), 38 deletions(-)

diff --git a/testcases/commands/sssd/sssd-lib.sh b/testcases/commands/sssd/sssd-lib.sh
index e434efe..b001904 100755
--- a/testcases/commands/sssd/sssd-lib.sh
+++ b/testcases/commands/sssd/sssd-lib.sh
@@ -39,21 +39,10 @@ readonly TRAP_SIGS="2 3 6 11 15"
 
 CONFIG_FILE="/etc/sssd/sssd.conf"
 NSS_CONFIG_FILE="/etc/nsswitch.conf"
-SSSD_INIT_SCRIPT="/etc/init.d/sssd"
-
-# Command to restart sssd daemon.
-SSSD_RESTART_CMD=
 
 # number of seconds to wait for another sssd test to complete
 WAIT_COUNT=30
 
-# running under systemd?
-if command -v systemctl >/dev/null 2>&1; then
-	HAVE_SYSTEMCTL=1
-else
-	HAVE_SYSTEMCTL=0
-fi
-
 cleanup()
 {
 	disable_traps
@@ -98,30 +87,6 @@ setup()
 		cleanup	0
 	fi
 
-	SVCNAME=$(basename $SSSD_INIT_SCRIPT)
-	if [ $HAVE_SYSTEMCTL == 1 ]; then
-		for svc in "$SVCNAME" "sssd"; do
-			if systemctl is-enabled $svc.service >/dev/null 2>&1
-			then
-				SSSD_RESTART_CMD="systemctl restart $svc.service"
-				break
-			fi
-		done
-	else
-		for SSSD_INIT_SCRIPT in "$SSSD_INIT_SCRIPT" "/etc/init.d/sssd"
-		do
-			if [ -x "$SSSD_INIT_SCRIPT" ]; then
-				SSSD_RESTART_CMD="$SSSD_INIT_SCRIPT restart"
-				break
-			fi
-		done
-	fi
-
-	if [ -z "$SSSD_RESTART_CMD" ]; then
-		tst_resm TBROK "Don't know how to restart $SVCNAME"
-		cleanup 1
-	fi
-
 	# Back up configuration file
 	if [ -f "$CONFIG_FILE" ]; then
 		# Pause if another LTP sssd test is running
@@ -163,8 +128,8 @@ restart_sssd_daemon()
 		cleanup_command=$1
 	fi
 
-	tst_resm TINFO "restarting sssd daemon via $SSSD_RESTART_CMD"
-	$SSSD_RESTART_CMD > /dev/null 2>&1
+	tst_resm TINFO "restarting sssd daemon"
+	restart_daemon sssd
 	if [ $? -eq 0 ]; then
 		# wait sssd restart success.
 		sleep 1
@@ -201,7 +166,7 @@ make_config_file
 sed -i -e "/\[domain\/LOCAL\]/ a\override_gid = error" $CONFIG_FILE
 # make sure config file is OK
 sleep 1
-$SSSD_RESTART_CMD > /dev/null 2>&1
+restart_daemon sssd
 
 if [ $? -ne 1 ]; then
 	tst_resm TCONF "override_gid does not exist. Skipping all testcases"
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

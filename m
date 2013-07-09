Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <penght@cn.fujitsu.com>) id 1UwTmU-0005Nt-IH
	for ltp-list@lists.sourceforge.net; Tue, 09 Jul 2013 09:00:18 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UwTmS-00061E-JJ
	for ltp-list@lists.sourceforge.net; Tue, 09 Jul 2013 09:00:18 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id r698b0NJ021859
	for <ltp-list@lists.sourceforge.net>; Tue, 9 Jul 2013 16:37:05 +0800
From: Peng Haitao <penght@cn.fujitsu.com>
Date: Tue, 9 Jul 2013 16:36:42 +0800
Message-Id: <1373359002-17618-2-git-send-email-penght@cn.fujitsu.com>
In-Reply-To: <1373359002-17618-1-git-send-email-penght@cn.fujitsu.com>
References: <1373359002-17618-1-git-send-email-penght@cn.fujitsu.com>
Subject: [LTP] [PATCH 2/2] sssd-lib.sh: fix a bug of sssd daemon is not
	started
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

If sssd daemon is not started, sssd daemon should be kept stopped.

Signed-off-by: Peng Haitao <penght@cn.fujitsu.com>
---
 testcases/commands/sssd/sssd-lib.sh | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/testcases/commands/sssd/sssd-lib.sh b/testcases/commands/sssd/sssd-lib.sh
index b001904..d63ed6d 100755
--- a/testcases/commands/sssd/sssd-lib.sh
+++ b/testcases/commands/sssd/sssd-lib.sh
@@ -54,7 +54,11 @@ cleanup()
 			mv $NSS_CONFIG_FILE.ltpback $NSS_CONFIG_FILE
 			# Make sure that restart_sssd_daemon doesn't loop
 			# back to cleanup again.
-			restart_sssd_daemon "return 1"
+			if [ $SSSD_STARTED -eq 1 ]; then
+				stop_daemon sssd
+			else
+				restart_sssd_daemon "return 1"
+			fi
 			# Maintain any nonzero exit codes
 			if [ $exit_code -ne $? ]; then
 				exit_code=1
@@ -160,6 +164,12 @@ make_config_file()
 
 . cmdlib.sh
 
+SSSD_STARTED=0
+status_daemon sssd
+if [ $? -ne 0 ]; then
+	SSSD_STARTED=1
+fi
+
 # determine sssd.conf can support override_gid?
 setup
 make_config_file
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

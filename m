Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <penght@cn.fujitsu.com>) id 1UsP6s-0000ZF-GF
	for ltp-list@lists.sourceforge.net; Fri, 28 Jun 2013 03:12:30 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UsP6q-0004Ds-He
	for ltp-list@lists.sourceforge.net; Fri, 28 Jun 2013 03:12:30 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id r5S3CJLX003854
	for <ltp-list@lists.sourceforge.net>; Fri, 28 Jun 2013 11:12:19 +0800
From: Peng Haitao <penght@cn.fujitsu.com>
Date: Fri, 28 Jun 2013 11:10:39 +0800
Message-Id: <1372389039-32494-1-git-send-email-penght@cn.fujitsu.com>
Subject: [LTP] [PATCH] cron_tests.sh: fix a bug of syslog daemon is disabled
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

The case will check the /var/log/messages to see if there is a record of
any crontab activity, so make sure syslog daemon is enabld.

Signed-off-by: Peng Haitao <penght@cn.fujitsu.com>
---
 testcases/commands/cron/cron_tests.sh | 62 +++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/testcases/commands/cron/cron_tests.sh b/testcases/commands/cron/cron_tests.sh
index b53a53a..2c70d1b 100644
--- a/testcases/commands/cron/cron_tests.sh
+++ b/testcases/commands/cron/cron_tests.sh
@@ -57,6 +57,60 @@ else
     LTPBIN=$LTPROOT/testcases/bin
 fi
 
+. cmdlib.sh
+FLAG=0
+SYSLOG_NAME=""
+
+if command -v systemctl >/dev/null 2>&1; then
+	HAVE_SYSTEMCTL=1
+else
+	HAVE_SYSTEMCTL=0
+fi
+
+if command -v syslogd >/dev/null 2>&1; then
+	SYSLOG_INIT_SCRIPT="/etc/init.d/syslog"
+elif command -v syslog-ng >/dev/null 2>&1; then
+	SYSLOG_INIT_SCRIPT="/etc/init.d/syslog-ng"
+elif command -v rsyslogd >/dev/null 2>&1; then
+	SYSLOG_INIT_SCRIPT="/etc/init.d/rsyslog"
+fi
+
+# make sure syslog daemon is enabled
+SVCNAME=$(basename $SYSLOG_INIT_SCRIPT)
+if [ $HAVE_SYSTEMCTL == 1 ]; then
+	for svc in "$SVCNAME" "sysklogd"
+	do
+		if systemctl is-enabled $svc.service >/dev/null 2>&1; then
+			SYSLOG_NAME=$svc
+			break
+		fi
+	done
+else
+	for SYSLOG_INIT_SCRIPT in "$SYSLOG_INIT_SCRIPT" "/etc/init.d/sysklogd"
+	do
+		if [ -x "$SYSLOG_INIT_SCRIPT" ]; then
+			SYSLOG_NAME=$SYSLOG_INIT_SCRIPT
+			break
+		fi
+	done
+fi
+
+if [ -n "$SYSLOG_NAME" ]; then
+	if [ $HAVE_SYSTEMCTL == 1 ]; then
+		status_daemon $SYSLOG_NAME
+		if [ $? -ne 0 ]; then
+			restart_daemon $SYSLOG_NAME
+			FLAG=1
+		fi
+	else
+		$SYSLOG_NAME status >/dev/null 2>&1
+		if [ $? -ne 0 ]; then
+			$SYSLOG_NAME restart >/dev/null 2>&1
+			FLAG=1
+		fi
+	fi
+fi
+
 # Set return code RC variable to 0, it will be set with a non-zero return code
 # in case of error. Set TFAILCNT to 0, increment if there occures a failure.
 
@@ -400,4 +454,12 @@ else
 	TFAILCNT=$(( $TFAILCNT+1 ))
 fi
 
+if [ $FLAG -eq 1 ]; then
+	if [ $HAVE_SYSTEMCTL == 1 ]; then
+		stop_daemon $SYSLOG_NAME
+	else
+		$SYSLOG_NAME stop >/dev/null 2>&1
+	fi
+fi
+
 exit $TFAILCNT
-- 
1.8.1.4


------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1Rn6u5-0005k0-CT
	for ltp-list@lists.sourceforge.net; Tue, 17 Jan 2012 11:08:37 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Rn6tz-0005UQ-Eu
	for ltp-list@lists.sourceforge.net; Tue, 17 Jan 2012 11:08:37 +0000
Received: from int-mx12.intmail.prod.int.phx2.redhat.com
	(int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q0HB8PLn022176
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 17 Jan 2012 06:08:25 -0500
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx12.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with
	ESMTP id q0HB8ObB028906
	for <ltp-list@lists.sourceforge.net>; Tue, 17 Jan 2012 06:08:24 -0500
Message-ID: <4F1556A5.9010604@redhat.com>
Date: Tue, 17 Jan 2012 12:08:21 +0100
From: Jan Stancek <jstancek@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070504030101060104080000"
Subject: [LTP] [PATCH] syslog-lib: support distros running systemd
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------070504030101060104080000
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


init.d/ scripts may not be available on distros
using systemd, for example Fedora16.

This patch is using 'systemctl' to restart syslog daemon
on distros running systemd. If systemctl is not available
it falls back to directly calling init script.

Also it drops few upstart TODO comments, current code
works OK with upstart (tested on RHEL6).

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
  testcases/kernel/syscalls/syslog/syslog-lib.sh |   40 
+++++++++++++----------
  1 files changed, 23 insertions(+), 17 deletions(-)



--------------070504030101060104080000
Content-Type: text/x-patch;
	name="0001-syslog-lib-support-distros-running-systemd.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="0001-syslog-lib-support-distros-running-systemd.patch"

diff --git a/testcases/kernel/syscalls/syslog/syslog-lib.sh b/testcases/kernel/syscalls/syslog/syslog-lib.sh
index 91a2e62..3d0c189 100755
--- a/testcases/kernel/syscalls/syslog/syslog-lib.sh
+++ b/testcases/kernel/syscalls/syslog/syslog-lib.sh
@@ -29,11 +29,15 @@ CONFIG_FILE=""
 # rsyslogd .conf specific args.
 RSYSLOG_CONFIG=
 
-# Command for syslog daemon.
-SYSLOG_COMMAND=
+# Command to restart syslog daemon.
+SYSLOG_RESTART_COMMAND=
 
-# Args to pass to $SYSLOG_COMMAND when restarting the daemon.
-SYSLOG_RESTART_COMMAND_ARGS=
+# running under systemd?
+if command -v systemctl >/dev/null 2>&1; then
+	HAVE_SYSTEMCTL=1
+else
+	HAVE_SYSTEMCTL=0
+fi
 
 # number of seconds to wait for another syslog test to complete
 WAIT_COUNT=60
@@ -82,31 +86,33 @@ setup()
 		CONFIG_FILE="/etc/rsyslog.conf"
 		SYSLOG_INIT_SCRIPT="/etc/init.d/rsyslog"
 		RSYSLOG_CONFIG='$ModLoad imuxsock.so'
-	#elif <detect-upstart-jobfile-here>; then
-		# TODO: upstart
 	else
 		tst_resm TCONF "couldn't find syslogd, syslog-ng, or rsyslogd"
 		cleanup	0
 	fi
 
-	if [ -z "$SYSLOG_INIT_SCRIPT" ]; then
-		# TODO: upstart
-		:
+	SVCNAME=$(basename $SYSLOG_INIT_SCRIPT)
+	if [ $HAVE_SYSTEMCTL == 1 ]; then
+		for svc in "$SVCNAME" "syslog"; do
+			if systemctl is-enabled $svc.service >/dev/null 2>&1; then
+				SYSLOG_RESTART_COMMAND="systemctl restart $svc.service"
+				break
+			fi
+		done
 	else
 		# Fallback to /etc/init.d/syslog if $SYSLOG_INIT_SCRIPT
 		# doesn't exist.
 		for SYSLOG_INIT_SCRIPT in "$SYSLOG_INIT_SCRIPT" "/etc/init.d/syslog"; do 
 			if [ -x "$SYSLOG_INIT_SCRIPT" ]; then
+				SYSLOG_RESTART_COMMAND="$SYSLOG_INIT_SCRIPT restart"
 				break
 			fi
 		done
-		if [ ! -x "$SYSLOG_INIT_SCRIPT" ]; then
-			tst_resm TBROK "$SYSLOG_INIT_SCRIPT - no such script"
-			cleanup 1
-		fi
+	fi
 
-		SYSLOG_COMMAND=$SYSLOG_INIT_SCRIPT
-		SYSLOG_RESTART_COMMAND_ARGS=restart
+	if [ -z "$SYSLOG_RESTART_COMMAND" ]; then
+		tst_resm TBROK "Don't know how to restart $SVCNAME"
+		cleanup 1
 	fi
 
 	# Back up configuration file
@@ -146,9 +152,9 @@ restart_syslog_daemon()
 		cleanup_command=$1
 	fi
 
-	tst_resm TINFO "restarting syslog daemon via $SYSLOG_COMMAND $SYSLOG_RESTART_COMMAND_ARGS"
+	tst_resm TINFO "restarting syslog daemon via $SYSLOG_RESTART_COMMAND"
 
-	if $SYSLOG_COMMAND $SYSLOG_RESTART_COMMAND_ARGS >/dev/null 2>&1; then
+	if $SYSLOG_RESTART_COMMAND >/dev/null 2>&1; then
 		# XXX: this really shouldn't exist; if *syslogd isn't ready
 		# once the restart directive has been issued, then it needs to
 		# be fixed.


--------------070504030101060104080000
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Keep Your Developer Skills Current with LearnDevNow!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-d2d
--------------070504030101060104080000
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------070504030101060104080000--


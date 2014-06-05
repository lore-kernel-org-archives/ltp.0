Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jjaburek@redhat.com>) id 1WsYnC-00045n-Fv
	for ltp-list@lists.sourceforge.net; Thu, 05 Jun 2014 14:37:22 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WsYn8-0004kO-9D
	for ltp-list@lists.sourceforge.net; Thu, 05 Jun 2014 14:37:22 +0000
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s55EbBR9009986
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 5 Jun 2014 10:37:12 -0400
Received: from robin.brq.redhat.com (robin.brq.redhat.com [10.34.24.36])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id s55EbAej021812
	for <ltp-list@lists.sourceforge.net>; Thu, 5 Jun 2014 10:37:11 -0400
From: Jiri Jaburek <jjaburek@redhat.com>
Date: Thu,  5 Jun 2014 16:37:09 +0200
Message-Id: <1401979029-12315-1-git-send-email-jjaburek@redhat.com>
In-Reply-To: <1249145583.18329328.1401964511429.JavaMail.zimbra@redhat.com>
References: <1249145583.18329328.1401964511429.JavaMail.zimbra@redhat.com>
Subject: [LTP] [PATCH v2] syslog: rsyslog doesn't create empty log files
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

From: Jan Stancek <jstancek@redhat.com>

Newer versions of rsyslog don't create empty log files during startup -
the files are created upon first logged entry instead.
(since rsyslog git commit de77494415ae8c169949d13ed0df0af3b1949b54)

Don't check if log file gets created after service start,
only make sure it exists after test generates a new log entry.

Signed-off-by: Jiri Jaburek <jjaburek@redhat.com>
Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/syslog/syslog01 | 11 +++++------
 testcases/kernel/syscalls/syslog/syslog02 |  9 ---------
 testcases/kernel/syscalls/syslog/syslog05 | 10 +++++-----
 testcases/kernel/syscalls/syslog/syslog09 | 13 ++++++-------
 testcases/kernel/syscalls/syslog/syslog10 |  5 -----
 5 files changed, 16 insertions(+), 32 deletions(-)

diff --git a/testcases/kernel/syscalls/syslog/syslog01 b/testcases/kernel/syscalls/syslog/syslog01
index b7bcd9e..2f3aea0 100755
--- a/testcases/kernel/syscalls/syslog/syslog01
+++ b/testcases/kernel/syscalls/syslog/syslog01
@@ -66,12 +66,6 @@ syslog_case1()
 
 	restart_syslog_daemon
 
-	# check if $MAILLOG script exists
-	if [ "$CONFIG_FILE" != "/etc/syslog-ng/syslog-ng.conf" -a ! -e $MAILLOG ]; then
-		tst_resm TBROK "$MAILLOG no such log file"
-		cleanup 1
-	fi
-
 	# Grepping pattern has to be changed whenever the executable name
 	# changes, ex: syslogtst executable.
 	# This check is neccessary for syslog-ng because $MAILLOG is
@@ -87,6 +81,11 @@ syslog_case1()
 
 		sleep 2
 
+		if [ ! -e $MAILLOG ]; then
+			tst_resm TBROK "$MAILLOG no such log file"
+			cleanup 1
+		fi
+
 		newvalue1=`grep -c "syslogtst: mail info test" $MAILLOG`
 		if [ "x$(( $newvalue1 - $oldvalue1 ))" != "x1" ]; then
 			status_flag=1
diff --git a/testcases/kernel/syscalls/syslog/syslog02 b/testcases/kernel/syscalls/syslog/syslog02
index a416344..7a55a84 100755
--- a/testcases/kernel/syscalls/syslog/syslog02
+++ b/testcases/kernel/syscalls/syslog/syslog02
@@ -65,15 +65,6 @@ syslog_case2()
 
 		restart_syslog_daemon
 
-		# Grepping pattern is as follows:
-		# syslogtst: mail $level test.
-		# check if $MAILLOG script exists
-		if [ "$CONFIG_FILE" != "/etc/syslog-ng/syslog-ng.conf" -a ! -e $MAILLOG ]; then
-			tst_resm TBROK "$MAILLOG no such log file"
-			cleanup 1
-		fi
-
-
 		# Grepping pattern has to be changed whenever the executable name
 		# changes, ex: syslogtst executable.
 		# This check is neccessary for syslog-ng because $MAILLOG is
diff --git a/testcases/kernel/syscalls/syslog/syslog05 b/testcases/kernel/syscalls/syslog/syslog05
index 7836993..40dd1fa 100755
--- a/testcases/kernel/syscalls/syslog/syslog05
+++ b/testcases/kernel/syscalls/syslog/syslog05
@@ -59,12 +59,12 @@ syslog_case5()
 	restart_syslog_daemon
 
 	# check if /var/log/messages script exists
-	if [ "$CONFIG_FILE" != "/etc/syslog-ng/syslog-ng.conf" -a ! -e /var/log/messages ]
-	then
-		tst_resm TBROK "/var/log/messages no such log file"
-		cleanup 1
+	if [ -e /var/log/messages ]; then
+		oldvalue=`grep -c "syslogtst: info to console test." /var/log/messages`
+	else
+		oldvalue=0
 	fi
-	oldvalue=`grep -c "syslogtst: info to console test." /var/log/messages`
+
 	# syslogtst does the disabling of /dev/syslog, sends the message and
 	# enables /dev/syslog.
 	if ! syslogtst 5 2>/dev/null; then
diff --git a/testcases/kernel/syscalls/syslog/syslog09 b/testcases/kernel/syscalls/syslog/syslog09
index de06fb1..9cfafa8 100755
--- a/testcases/kernel/syscalls/syslog/syslog09
+++ b/testcases/kernel/syscalls/syslog/syslog09
@@ -56,15 +56,14 @@ syslog_case9()
 
 	restart_syslog_daemon
 
-	# check if /var/log/messages script exists
-	if [ "$CONFIG_FILE" != "/etc/syslog-ng/syslog-ng.conf" -a ! -e /var/log/messages ]; then
-		tst_resm TBROK "/var/log/messages no such log file"
-		cleanup 1
+	if [ -e /var/log/messages ]; then
+		allow1=`grep -c "syslogtst: error level is logged" /var/log/messages`
+		donot_allow1=`grep -c "syslogtst: warning level not to be logged" /var/log/messages`
+	else
+		allow1=0
+		donot_allow1=0
 	fi
 
-	allow1=`grep -c "syslogtst: error level is logged" /var/log/messages`
-	donot_allow1=`grep -c "syslogtst: warning level not to be logged" /var/log/messages`
-
 	if ! syslogtst 9 2>/dev/null; then
 		cleanup 1
 	fi
diff --git a/testcases/kernel/syscalls/syslog/syslog10 b/testcases/kernel/syscalls/syslog/syslog10
index 3b9796d..573ab75 100755
--- a/testcases/kernel/syscalls/syslog/syslog10
+++ b/testcases/kernel/syscalls/syslog/syslog10
@@ -57,11 +57,6 @@ syslog_case10()
 
 	restart_syslog_daemon
 
-	if [ ! -e /var/log/messages ]; then
-		tst_resm TBROK "/var/log/messages no such log file"
-		cleanup 1
-	fi
-
 	if [ -e /var/log/messages ]; then
 		allow1=`grep -c "syslogtst:10 error level is logged" /var/log/messages`
 		donot_allow1=`grep -c "syslogtst:10 warning level not to be logged" /var/log/messages`
-- 
1.8.3.1


------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their 
applications. Written by three acclaimed leaders in the field, 
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

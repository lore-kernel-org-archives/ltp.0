Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jjaburek@redhat.com>) id 1WpauP-0003z0-1O
	for ltp-list@lists.sourceforge.net; Wed, 28 May 2014 10:16:33 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WpauN-0006tG-Gz
	for ltp-list@lists.sourceforge.net; Wed, 28 May 2014 10:16:33 +0000
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s4SAGPnN030286
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 28 May 2014 06:16:25 -0400
Received: from robin.brq.redhat.com (robin.brq.redhat.com [10.34.24.36])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id s4SAGNRZ023888
	for <ltp-list@lists.sourceforge.net>; Wed, 28 May 2014 06:16:24 -0400
From: Jiri Jaburek <jjaburek@redhat.com>
Date: Wed, 28 May 2014 12:15:51 +0200
Message-Id: <1401272151-6563-1-git-send-email-jjaburek@redhat.com>
Subject: [LTP] [PATCH] syslog: rsyslog doesn't create empty log files
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

Newer versions of rsyslog don't create empty log files during startup -
the files are created upon first logged entry instead.

(since rsyslog git commit de77494415ae8c169949d13ed0df0af3b1949b54)

Signed-off-by: Jiri Jaburek <jjaburek@redhat.com>
---
 testcases/kernel/syscalls/syslog/syslog01 | 15 +++++++++++----
 testcases/kernel/syscalls/syslog/syslog02 | 16 +++++++++++-----
 testcases/kernel/syscalls/syslog/syslog09 | 15 +++++++++++----
 3 files changed, 33 insertions(+), 13 deletions(-)

diff --git a/testcases/kernel/syscalls/syslog/syslog01 b/testcases/kernel/syscalls/syslog/syslog01
index b7bcd9e..b9c7c7f 100755
--- a/testcases/kernel/syscalls/syslog/syslog01
+++ b/testcases/kernel/syscalls/syslog/syslog01
@@ -67,10 +67,17 @@ syslog_case1()
 	restart_syslog_daemon
 
 	# check if $MAILLOG script exists
-	if [ "$CONFIG_FILE" != "/etc/syslog-ng/syslog-ng.conf" -a ! -e $MAILLOG ]; then
-		tst_resm TBROK "$MAILLOG no such log file"
-		cleanup 1
-	fi
+	case "$CONFIG_FILE" in
+	/etc/syslog-ng/syslog-ng.conf|/etc/rsyslog.conf)
+		# syslog-ng and rsyslog don't create empty log files
+		;;
+	*)
+		if [ ! -e $MAILLOG ]; then
+			tst_resm TBROK "$MAILLOG no such log file"
+			cleanup 1
+		fi
+		;;
+	esac
 
 	# Grepping pattern has to be changed whenever the executable name
 	# changes, ex: syslogtst executable.
diff --git a/testcases/kernel/syscalls/syslog/syslog02 b/testcases/kernel/syscalls/syslog/syslog02
index a416344..c863daa 100755
--- a/testcases/kernel/syscalls/syslog/syslog02
+++ b/testcases/kernel/syscalls/syslog/syslog02
@@ -68,11 +68,17 @@ syslog_case2()
 		# Grepping pattern is as follows:
 		# syslogtst: mail $level test.
 		# check if $MAILLOG script exists
-		if [ "$CONFIG_FILE" != "/etc/syslog-ng/syslog-ng.conf" -a ! -e $MAILLOG ]; then
-			tst_resm TBROK "$MAILLOG no such log file"
-			cleanup 1
-		fi
-
+		case "$CONFIG_FILE" in
+		/etc/syslog-ng/syslog-ng.conf|/etc/rsyslog.conf)
+			# syslog-ng and rsyslog don't create empty log files
+			;;
+		*)
+			if [ ! -e $MAILLOG ]; then
+				tst_resm TBROK "$MAILLOG no such log file"
+				cleanup 1
+			fi
+			;;
+		esac
 
 		# Grepping pattern has to be changed whenever the executable name
 		# changes, ex: syslogtst executable.
diff --git a/testcases/kernel/syscalls/syslog/syslog09 b/testcases/kernel/syscalls/syslog/syslog09
index de06fb1..c488f43 100755
--- a/testcases/kernel/syscalls/syslog/syslog09
+++ b/testcases/kernel/syscalls/syslog/syslog09
@@ -57,10 +57,17 @@ syslog_case9()
 	restart_syslog_daemon
 
 	# check if /var/log/messages script exists
-	if [ "$CONFIG_FILE" != "/etc/syslog-ng/syslog-ng.conf" -a ! -e /var/log/messages ]; then
-		tst_resm TBROK "/var/log/messages no such log file"
-		cleanup 1
-	fi
+	case "$CONFIG_FILE" in
+	/etc/syslog-ng/syslog-ng.conf|/etc/rsyslog.conf)
+		# syslog-ng and rsyslog don't create empty log files
+		;;
+	*)
+		if [ ! -e /var/log/messages ]; then
+			tst_resm TBROK "/var/log/messages no such log file"
+			cleanup 1
+		fi
+		;;
+	esac
 
 	allow1=`grep -c "syslogtst: error level is logged" /var/log/messages`
 	donot_allow1=`grep -c "syslogtst: warning level not to be logged" /var/log/messages`
-- 
1.8.3.1


------------------------------------------------------------------------------
Time is money. Stop wasting it! Get your web API in 5 minutes.
www.restlet.com/download
http://p.sf.net/sfu/restlet
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

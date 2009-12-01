Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jpalecek@web.de>) id 1NFcUA-00089s-AO
	for ltp-list@lists.sourceforge.net; Tue, 01 Dec 2009 23:50:22 +0000
Received: from fmmailgate03.web.de ([217.72.192.234])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NFcU3-0005Ie-S4
	for ltp-list@lists.sourceforge.net; Tue, 01 Dec 2009 23:50:22 +0000
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate03.web.de (Postfix) with ESMTP id 298D6136AEA71
	for <ltp-list@lists.sourceforge.net>;
	Wed,  2 Dec 2009 00:50:10 +0100 (CET)
Received: from [90.180.172.144] (helo=debian)
	by smtp08.web.de with asmtp (WEB.DE 4.110 #314) id 1NFcTx-0003V4-00
	for ltp-list@lists.sourceforge.net; Wed, 02 Dec 2009 00:50:10 +0100
Date: Tue, 01 Dec 2009 23:30:33 +0100
From: "Jiri Palecek" <jpalecek@web.de>
MIME-Version: 1.0
Resent-To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>
Resent-Message-ID: <op.u396sv1tcfnueu@debian>
Subject: [LTP] [PATCH] Fixes of some errors discovered by "set -u"
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: ltp-list-bounces@lists.sourceforge.net
Errors-To: ltp-list-bounces@lists.sourceforge.net
Cc: ltp-list@lists.sourceforge.net
Message-ID: <20091201223033.HfOqPJADmxdx2fEaqTR_VG89pqlf50z58YKaDHje5UM@z>

Hello,

this patch fixes the following problems:

 - read of $TEST_USER before it's set in ftp03

 - remnants of the $COMMAND variable which isn't really there anymore
   in netstat01

 - probably a typo in rsh01 ($COUNT vs. $TST_COUNT)

 - $2 has to be escaped twice in rwho01, to appear in the awk script

 - when no interface is found tcpdump01, $IF is unset. Don't spit out
   an error in that case

This is a version with changes reflecting Mike's comments.

Regards
    Jiri Palecek

Signed-off-by: Jiri Palecek <jpalecek@web.de>
---
 testcases/network/tcp_cmds/ftp/ftp03         |    2 +-
 testcases/network/tcp_cmds/netstat/netstat01 |    2 +-
 testcases/network/tcp_cmds/rsh/rsh01         |    2 +-
 testcases/network/tcp_cmds/rwho/rwho01       |    8 ++++----
 testcases/network/tcp_cmds/tcpdump/tcpdump01 |    2 +-
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/testcases/network/tcp_cmds/ftp/ftp03 b/testcases/network/tcp_cmds/ftp/ftp03
index 24e30e9..e85a985 100755
--- a/testcases/network/tcp_cmds/ftp/ftp03
+++ b/testcases/network/tcp_cmds/ftp/ftp03
@@ -39,8 +39,8 @@ do_setup()
 {
 	
     RHOST="localhost"
-    TCtmp=/home/$TEST_USER
     TEST_USER="ftpuser1"
+    TCtmp=/home/$TEST_USER
     TEST_USER_PASSWD="eal"
     TEST_USER_ENCRYPTED_PASSWD="42VmxaOByKwlA"
     TEST_USER_HOMEDIR="/home/$TEST_USER"
diff --git a/testcases/network/tcp_cmds/netstat/netstat01 b/testcases/network/tcp_cmds/netstat/netstat01
index 365c142..45238dc 100755
--- a/testcases/network/tcp_cmds/netstat/netstat01
+++ b/testcases/network/tcp_cmds/netstat/netstat01
@@ -59,7 +59,7 @@ do_test() {
 
         for flag in "-s" "-rn" "-i" "-gn" "-apn"; do
             if ! netstat $flag 1>/dev/null 2>&1; then
-                end_testcase "$COMMAND failed"
+                end_testcase "netstat $flag failed"
             fi
         done
 
diff --git a/testcases/network/tcp_cmds/rsh/rsh01 b/testcases/network/tcp_cmds/rsh/rsh01
index 0a2b58f..1409cbf 100755
--- a/testcases/network/tcp_cmds/rsh/rsh01
+++ b/testcases/network/tcp_cmds/rsh/rsh01
@@ -87,7 +87,7 @@ do_test()
             tst_resm TFAIL "rsh to $RHOST failed"
             # If the first rsh failed, the likelihood that the rest will
             # succeed is low.
-            if [ "$FAIL_IMMEDIATELY" = "1" ] && [ $COUNT -eq 1 ]; then
+            if [ "$FAIL_IMMEDIATELY" = "1" ] && [ $TST_COUNT -eq 1 ]; then
                 exit 2
             fi
         fi
diff --git a/testcases/network/tcp_cmds/rwho/rwho01 b/testcases/network/tcp_cmds/rwho/rwho01
index 9967967..72fb569 100755
--- a/testcases/network/tcp_cmds/rwho/rwho01
+++ b/testcases/network/tcp_cmds/rwho/rwho01
@@ -106,15 +106,15 @@ do_test()
 
     while [ $TST_COUNT -le $NUMLOOPS ]; do
         rwho -a > $OUTFILE
-        HOST=`awk "\$2 ~ /$LHOST>/" $OUTFILE | cut -f1 -d: | sort -u`
+        HOST=`awk "\\$2 ~ /$LHOST>/" $OUTFILE | cut -f1 -d: | sort -u`
         [ "$HOST" = "$LHOST" ] || end_testcase "$LHOST is not in rwho outfile"
-        HOST=`awk "\$2 ~ /$RHOSTNAME>/" $OUTFILE | cut -f1 -d: | sort -u`
+        HOST=`awk "\\$2 ~ /$RHOSTNAME>/" $OUTFILE | cut -f1 -d: | sort -u`
         [ "$HOST" = "$RHOSTNAME" ] || end_testcase "$RHOSTNAME is not in rwho outfile"
 
         ruptime -a > $OUTFILE
-        HOST=`awk "\$1 ~ /$LHOST>/" $OUTFILE | sort -u`
+        HOST=`awk "\\$1 ~ /$LHOST>/" $OUTFILE | sort -u`
         [ "$HOST" = "$LHOST" ] || end_testcase "$LHOST is not in ruptime outfile"
-        HOST=`awk "\$1 ~ /$RHOSTNAME>/" $OUTFILE | sort -u`
+        HOST=`awk "\\$1 ~ /$RHOSTNAME>/" $OUTFILE | sort -u`
         [ "$HOST" = "$RHOSTNAME" ] || end_testcase "$RHOSTNAME is not in ruptime outfile"
 
         tst_resm TINFO "Test $COUNT of $NUMLOOPS complete"
diff --git a/testcases/network/tcp_cmds/tcpdump/tcpdump01 b/testcases/network/tcp_cmds/tcpdump/tcpdump01
index 650e97e..0f4aba7 100755
--- a/testcases/network/tcp_cmds/tcpdump/tcpdump01
+++ b/testcases/network/tcp_cmds/tcpdump/tcpdump01
@@ -59,7 +59,8 @@ do_setup()
             break
         fi
     done
-    if [ -z "${IF}" ]; then
+    # Default to empty string if unset, to avoid errors caused by set -u, which we use (see cmdlib.sh)
+    if [ -z "${IF:-}" ]; then
         end_testcase "Could not identify interface"
         exit 1
     fi
-- 
1.6.4.3




------------------------------------------------------------------------------
Join us December 9, 2009 for the Red Hat Virtual Experience,
a free event focused on virtualization and cloud computing. 
Attend in-depth sessions from your desk. Your couch. Anywhere.
http://p.sf.net/sfu/redhat-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

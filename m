Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1YDnqr-00073t-88
	for ltp-list@lists.sourceforge.net; Wed, 21 Jan 2015 05:29:13 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YDnqp-000319-Nj
	for ltp-list@lists.sourceforge.net; Wed, 21 Jan 2015 05:29:13 +0000
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Wed, 21 Jan 2015 13:28:11 +0800
Message-ID: <1421818093-24202-1-git-send-email-zenglg.jy@cn.fujitsu.com>
In-Reply-To: <54B7D920.7050402@oracle.com>
References: <54B7D920.7050402@oracle.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v2 1/3] rlogin: Cleanup
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
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: alexey.kodanev@oracle.com
Cc: ltp-list@lists.sourceforge.net

* Add 'TCID' and 'TST_TOTAL'.
* Use 'test.sh'.
* Delete some useless comment.
* Some cleanup.

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 testcases/network/tcp_cmds/rlogin/rlogin01 | 141 +++++++++++++++--------------
 1 file changed, 72 insertions(+), 69 deletions(-)

diff --git a/testcases/network/tcp_cmds/rlogin/rlogin01 b/testcases/network/tcp_cmds/rlogin/rlogin01
index ae670c9..ff3d8ed 100755
--- a/testcases/network/tcp_cmds/rlogin/rlogin01
+++ b/testcases/network/tcp_cmds/rlogin/rlogin01
@@ -1,5 +1,4 @@
-#! /usr/bin/expect -f
-#*********************************************************************
+#!/bin/sh
 #   Copyright (c) International Business Machines  Corp., 2000
 #
 #   This program is free software;  you can redistribute it and/or modify
@@ -16,87 +15,91 @@
 #   along with this program;  if not, write to the Free Software
 #   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
 #
-#
-#
-#  FILE   : rlogin
-#
-#  PURPOSE: Tests the basic functionality of `rlogin`.
-#
 #  SETUP: The program `/usr/bin/expect' MUST be installed.
 #         The home directory of root on the machine exported as "RHOST"
 #         should have a ".rhosts" file with the hostname of the machine
 #         where the test is executed, OR the "PASSWD" section below MUST
 #	  be uncommented and set.
 #
-#  HISTORY:
 #    03/01 Robbie Williamson (robbiew@us.ibm.com)
-#      -Ported
 #
-#
-# rlogin perform a rlogin session to each host in HOST_LIST with user
-#    RUSER for a count of LOOPCOUNT and does an ls -l /etc/hosts to
-#    verify that the rlogin was established.
-#
-#*********************************************************************
 
-set TC rlogin
-set TCtmp "/tmp"
-set SLEEPTIME 3
-set TESTLOG "$TCtmp"
+TCID="rlogin01"
+TST_TOTAL=1
+. test.sh
+
+setup()
+{
+	if [ -z $RUSER ]; then
+		RUSER=root
+	fi
+
+	if [ -z $PASSWD ]; then
+		tst_brkm TCONF "Please set PASSWD for $RUSER."
+	fi
 
-if [info exists env(RUSER)] {
-   set RUSER $env(RUSER)
-} else {
-   set RUSER root
+	if [ -z $RHOST ]; then
+		tst_brkm TCONF "Please set RHOST."
+	fi
+
+	if [ -z $LOOPCOUNT ]; then
+		LOOPCOUNT=25
+	fi
 }
 
-set RHOST $env(RHOST)
-set timeout 10
+do_test()
+{
+	tst_resm TINFO "Starting"
 
-if [info exists env(LOOPCOUNT)] {
-   set LOOPCOUNT $env(LOOPCOUNT)
-} else {
-   set LOOPCOUNT 25
+	for i in $(seq 1 ${LOOPCOUNT})
+	do
+		rlogin_test || return 1
+	done
 }
 
-# stty echo
-send_user " Starting\n"
-
-set count 0
-while {$count < $LOOPCOUNT} {
-   set count [expr $count+1]
-      send_user "Host: $RHOST\n"
-
-      # rlogin to the host
-      spawn rlogin $RHOST -l $RUSER
-
-      # Uncomment code below and add root's passwd if .rhosts file is not
-      # present on remote host.
-      #---------------------------------
-      #set PASSWD "<ROOT PASSWORD HERE>"
-      #expect -re "Password:"
-      #send "$PASSWD\r"
-
-      # Wait for shell prompt
-      expect -re "$RUSER@"
-
-      # Run passwd command - and respond to its prompts
-      send "LC_ALL=C ls -l /etc/hosts | wc -w > $TESTLOG/$RUSER.$RHOST \r"
-      # When shell prompt comes back, logout
-
-      expect -re "$RUSER@"
-      exp_send "logout\r"
-
-      send_user "CHECKING RLOGIN STATUS\n"
-      set nummatch [exec rsh -n -l $RUSER $RHOST "cat $TESTLOG/$RUSER.$RHOST|grep -c 9"]
-      if {$nummatch==1} {
-         send_user "$TC interactive Test Successful in LOOP $count\r"
-         exec rsh -n -l $RUSER $RHOST "rm -f $TESTLOG/$RUSER.$RHOST"
-      } else {
-         send_user "$TC interactive session FAILED\r"
-         exit 1
-      }
+rlogin_test()
+{
+	expect -c "
+		spawn rlogin $RHOST -l $RUSER
+
+		expect {
+			\"Password:\" {
+				send \"$PASSWD\r\"
+				expect -re \"$RUSER@\"
+				send \"LC_ALL=C ls -l /etc/hosts | \\
+				       wc -w > $RUSER.$RHOST\r\"
+			}
+			\"$RUSER@\" {
+				send \"LC_ALL=C ls -l /etc/hosts | \\
+				       wc -w > $RUSER.$RHOST\r\"
+			}
+		}
+
+		expect -re \"$RUSER@\"
+		send \"LC_ALL=C ls -l /etc/hosts | wc -w > $RUSER.$RHOST\r\"
+
+		expect -re \"$RUSER@\"
+		exp_send \"logout\r\"
+
+		send_user \"CHECKING RLOGIN STATUS\n\";
+
+		set nummatch [exec rsh -n -l $RUSER $RHOST \\
+			      \"grep -c 9 $RUSER.$RHOST\"]
+		if {\$nummatch==1} {
+			exec rsh -n -l $RUSER $RHOST \"rm -f $RUSER.$RHOST\"
+		} else {
+			exit 1
+		}
+	"
 }
 
-send_user "\nTest PASSES\n\n"
-exit 0
+setup
+
+do_test
+if [ $? -ne 0 ]; then
+	tst_resm TFAIL "Test $TCID failed."
+else
+	tst_resm TPASS "Test $TCID successed."
+fi
+
+tst_exit
-- 
1.9.3


------------------------------------------------------------------------------
New Year. New Location. New Benefits. New Data Center in Ashburn, VA.
GigeNET is offering a free month of service with a new server in Ashburn.
Choose from 2 high performing configs, both with 100TB of bandwidth.
Higher redundancy.Lower latency.Increased capacity.Completely compliant.
http://p.sf.net/sfu/gigenet
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

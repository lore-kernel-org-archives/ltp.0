Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1YDnqt-00022B-K9
	for ltp-list@lists.sourceforge.net; Wed, 21 Jan 2015 05:29:15 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YDnqs-000319-AM
	for ltp-list@lists.sourceforge.net; Wed, 21 Jan 2015 05:29:15 +0000
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Wed, 21 Jan 2015 13:28:12 +0800
Message-ID: <1421818093-24202-2-git-send-email-zenglg.jy@cn.fujitsu.com>
In-Reply-To: <1421818093-24202-1-git-send-email-zenglg.jy@cn.fujitsu.com>
References: <54B7D920.7050402@oracle.com>
	<1421818093-24202-1-git-send-email-zenglg.jy@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v2 2/3] telnet: Cleanup
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
 testcases/network/tcp_cmds/telnet/telnet01 | 143 ++++++++++++-----------------
 1 file changed, 58 insertions(+), 85 deletions(-)

diff --git a/testcases/network/tcp_cmds/telnet/telnet01 b/testcases/network/tcp_cmds/telnet/telnet01
index 36ebf12..b006fe9 100755
--- a/testcases/network/tcp_cmds/telnet/telnet01
+++ b/testcases/network/tcp_cmds/telnet/telnet01
@@ -1,5 +1,4 @@
-#! /usr/bin/expect -f
-#*********************************************************************
+#!/bin/bash
 #   Copyright (c) International Business Machines  Corp., 2000
 #
 #   This program is free software;  you can redistribute it and/or modify
@@ -16,102 +15,76 @@
 #   along with this program;  if not, write to the Free Software
 #   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
 #
-#
-#
-#  FILE   : telnet
-#
-#  PURPOSE: Tests the basic functionality of `telnet`.
-#
 #  SETUP: The program `/usr/bin/expect' MUST be installed.
 #	  The PASSWD and RHOST variables MUST be set prior to execution.
 #
-#  HISTORY:
 #    03/01 Robbie Williamson (robbiew@us.ibm.com)
-#      -Ported
-#
-#*********************************************************************
-#
-# telnet perform a telnet session to each host in HOST_LIST with user
-#    RUSER for a count of LOOPCOUNT and does an ls -l /etc/hosts to
-#    verify that the telnet was established.
-#
-#*********************************************************************
 
-set TC telnet
-set TCtmp "/tmp"
-set SLEEPTIME 3
-set TESTLOG "$TCtmp"
-set PROMPT "Alpha Bravo"
-
-if [info exists env(RUSER)] {
-   set RUSER $env(RUSER)
-} else {
-   set RUSER root
-}
+TCID="telnet01"
+TST_TOTAL=1
+. test.sh
 
-if [info exists env(PASSWD)] {
-   set PASSWD $env(PASSWD)
-} else {
-   set PASSWD .pasroot
-   send_user "PASSWD NOT SET:Using .pasroot as the PASSWD variable for $RUSER. \n"
-}
+setup()
+{
+	if [ -z $RUSER ]; then
+		RUSER=root
+	fi
 
-if [info exists env(RHOST)] {
-   set RHOST $env(RHOST)
-} else {
-   send_user "Please set/export the RHOST variable. \n"
-   exit 1
-}
+	if [ -z $PASSWD ]; then
+		tst_brkm TCONF "Please set PASSWD for $RUSER."
+	fi
 
-set timeout 90
+	if [ -z $RHOST ]; then
+		tst_brkm TCONF "Please set RHOST."
+	fi
 
-if [info exists env(LOOPCOUNT)] {
-   set LOOPCOUNT $env(LOOPCOUNT)
-} else {
-   set LOOPCOUNT 25
+	if [ -z $LOOPCOUNT ]; then
+		LOOTCOUNT=25
+	fi
 }
 
-# stty echo
-send_user " Starting\n"
-
-# Do foreach host on command line
-set count 0
-while {$count < $LOOPCOUNT} {
-   set count [expr $count+1]
-   foreach HOST $RHOST {
-      send_user "Host: $HOST\n"
-
-      # telnet to the host
-      spawn telnet $HOST
-      expect -re "login:"
-
-      send "$RUSER\r"
-      expect -re "Password:"
+do_test()
+{
+	tst_resm TINFO "Starting"
 
-      send "$PASSWD\r"
-
-      send "PS1=\"$PROMPT\"\r"
-      # Wait for shell prompt
-      expect "$PROMPT"
+	for i in $(seq 1 ${LOOPCOUNT})
+	do
+		telnet_test || return 1
+	done
+}
 
-      # Run passwd command - and respond to its prompts
-      send "LC_ALL=C ls -l /etc/hosts | wc -w > $TESTLOG/$RUSER.$HOST \r"
-      # When shell prompt comes back, logout
+telnet_test()
+{
+	expect -c "
+		spawn telnet $RHOST
+		expect -re \"login:\"
+		send \"$RUSER\r\"
+		expect -re \"Password:\"
+		send \"$PASSWD\r\"
+
+		send \"LC_ALL=C ls -l /etc/hosts | wc -w > $RUSER.$RHOST \r\"
+		expect \"$RUSER@\"
+		exp_send \"logout\r\"
+
+		send_user \"CHECKING TELNET STATUS\n\"
+
+		set nummatch [exec rsh -n -l $RUSER $RHOST \\
+			      \"grep -c 9 $RUSER.$RHOST\"]
+		if {\$nummatch==1} {
+			exec rsh -n -l $RUSER $RHOST \"rm -f $RUSER.$RHOST\"
+		} else {
+			exit 1
+		}
+	"
+}
 
-      expect "$PROMPT"
-      exp_send "logout\r"
+setup
 
-      send_user "CHECKING TELNET STATUS\n"
-      set nummatch [exec rsh -n -l $RUSER $HOST "cat $TESTLOG/$RUSER.$HOST|grep -c 9"]
-      if {$nummatch==1} {
-         send_user "$TC interactive Test Successful in LOOP $count\r"
-         exec rsh -n -l $RUSER $HOST "rm -f $TESTLOG/$RUSER.$HOST"
-      } else {
-         send_user "$TC interactive session failed\n"
-         exit 1
-      }
-   }
-}
+do_test
+if [ $? -ne 0 ]; then
+	tst_resm TFAIL "Test $TCID failed."
+else
+	tst_resm TPASS "Test $TCID successed."
+fi
 
-send_user "\nTest PASSES\n\n"
-exit 0
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

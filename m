Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1YGmDK-0002Pb-47
	for ltp-list@lists.sourceforge.net; Thu, 29 Jan 2015 10:20:42 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YGmDH-0000GE-Uj
	for ltp-list@lists.sourceforge.net; Thu, 29 Jan 2015 10:20:42 +0000
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Thu, 29 Jan 2015 18:19:31 +0800
Message-ID: <1422526772-27693-2-git-send-email-zenglg.jy@cn.fujitsu.com>
In-Reply-To: <1422526772-27693-1-git-send-email-zenglg.jy@cn.fujitsu.com>
References: <1422407961.13104.13.camel@G08JYZSD130126.localdomain>
	<1422526772-27693-1-git-send-email-zenglg.jy@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v3 2/3] telnet: Cleanup
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
* Use 'test.sh' and 'tst_check_cmds'.
* Use 'test_net.sh'.
* Delete some useless comment.
* Some cleanup.

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 testcases/network/tcp_cmds/telnet/telnet01 | 160 +++++++++++++----------------
 1 file changed, 72 insertions(+), 88 deletions(-)

diff --git a/testcases/network/tcp_cmds/telnet/telnet01 b/testcases/network/tcp_cmds/telnet/telnet01
index 36ebf12..3648ee2 100755
--- a/testcases/network/tcp_cmds/telnet/telnet01
+++ b/testcases/network/tcp_cmds/telnet/telnet01
@@ -1,5 +1,4 @@
-#! /usr/bin/expect -f
-#*********************************************************************
+#!/bin/sh
 #   Copyright (c) International Business Machines  Corp., 2000
 #
 #   This program is free software;  you can redistribute it and/or modify
@@ -16,102 +15,87 @@
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
-
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
 
-if [info exists env(PASSWD)] {
-   set PASSWD $env(PASSWD)
-} else {
-   set PASSWD .pasroot
-   send_user "PASSWD NOT SET:Using .pasroot as the PASSWD variable for $RUSER. \n"
-}
+TCID="telnet01"
+TST_TOTAL=1
+. test.sh
+. test_net.sh
+
+setup()
+{
+	tst_check_cmds telnet expect rsh
+
+	if [ -z $RUSER ]; then
+		RUSER=root
+	fi
+
+	if [ -z $PASSWD ]; then
+		tst_brkm TCONF "Please set PASSWD for $RUSER."
+	fi
 
-if [info exists env(RHOST)] {
-   set RHOST $env(RHOST)
-} else {
-   send_user "Please set/export the RHOST variable. \n"
-   exit 1
+	if [ -z $RHOST ]; then
+		tst_brkm TCONF "Please set RHOST."
+	fi
+
+	if [ -z $LOOPCOUNT ]; then
+		LOOPCOUNT=25
+	fi
 }
 
-set timeout 90
+do_test()
+{
+	tst_resm TINFO "Starting"
 
-if [info exists env(LOOPCOUNT)] {
-   set LOOPCOUNT $env(LOOPCOUNT)
-} else {
-   set LOOPCOUNT 25
+	for i in $(seq 1 ${LOOPCOUNT})
+	do
+		telnet_test || return 1
+	done
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
-
-      send "$PASSWD\r"
-
-      send "PS1=\"$PROMPT\"\r"
-      # Wait for shell prompt
-      expect "$PROMPT"
-
-      # Run passwd command - and respond to its prompts
-      send "LC_ALL=C ls -l /etc/hosts | wc -w > $TESTLOG/$RUSER.$HOST \r"
-      # When shell prompt comes back, logout
-
-      expect "$PROMPT"
-      exp_send "logout\r"
-
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
+telnet_test()
+{
+	tst_resm TINFO "login with telnet($i/$LOOPCOUNT)"
+
+	expect -c "
+		spawn telnet $RHOST
+
+		expect -re \"login:\"
+		send \"$RUSER\r\"
+
+		expect -re \"Password:\"
+		send \"$PASSWD\r\"
+
+		expect {
+			\"incorrect\" {
+				exit 1
+			} \"$RUSER@\" {
+				send \"LC_ALL=C ls -l /etc/hosts | \\
+				       wc -w > $RUSER.$RHOST\rexit\r\";
+				exp_continue}
+		}
+
+	" > /dev/null
+	if [ $? -ne 0 ]; then
+		return 1
+	fi
+
+	tst_resm TINFO "checking telnet status($i/$LOOPCOUNT)"
+	[ $(tst_rhost_run -s -u $RUSER -c "grep -c 9 $RUSER.$RHOST") -ne 1 ] &&\
+		return 1
+	tst_rhost_run -u $RUSER -c "rm -f $RUSER.$RHOST"
 }
 
-send_user "\nTest PASSES\n\n"
-exit 0
+setup
+
+do_test
+if [ $? -ne 0 ]; then
+	tst_resm TFAIL "Test $TCID failed."
+else
+	tst_resm TPASS "Test $TCID succeeded."
+fi
+
+tst_exit
-- 
1.9.3


------------------------------------------------------------------------------
Dive into the World of Parallel Programming. The Go Parallel Website,
sponsored by Intel and developed in partnership with Slashdot Media, is your
hub for all things parallel software development, from weekly thought
leadership blogs to news, videos, case studies, tutorials and more. Take a
look and join the conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

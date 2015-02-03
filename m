Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1YIeYq-0003d5-Sw
	for ltp-list@lists.sourceforge.net; Tue, 03 Feb 2015 14:34:40 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YIeYo-0007oD-Tg
	for ltp-list@lists.sourceforge.net; Tue, 03 Feb 2015 14:34:40 +0000
Received: from ucsinet22.oracle.com (ucsinet22.oracle.com [156.151.31.94])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id t13EYWUj028728
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 3 Feb 2015 14:34:33 GMT
Received: from aserz7022.oracle.com (aserz7022.oracle.com [141.146.126.231])
	by ucsinet22.oracle.com (8.14.5+Sun/8.14.5) with ESMTP id
	t13EYVQA003973
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Tue, 3 Feb 2015 14:34:32 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
	by aserz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	t13EYVGI023397
	for <ltp-list@lists.sourceforge.net>; Tue, 3 Feb 2015 14:34:31 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue,  3 Feb 2015 17:36:52 +0300
Message-Id: <1422974214-12517-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH 1/3] network/multicast/mc_commo: use test interface
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
Cc: vasily.isaenko@oracle.com

* make use of test_net.sh
* replace 'ps auxw | grep -v grep | ...' with 'pgrep -x ...'
* 'RHOST' doesn't support defining multiple hosts, so remove the 'for' loop
* get available port from tst_get_unused_port()

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/multicast/mc_commo/mc_commo |  166 +++++++++----------------
 1 files changed, 57 insertions(+), 109 deletions(-)

diff --git a/testcases/network/multicast/mc_commo/mc_commo b/testcases/network/multicast/mc_commo/mc_commo
index 3e8e412..0de22df 100755
--- a/testcases/network/multicast/mc_commo/mc_commo
+++ b/testcases/network/multicast/mc_commo/mc_commo
@@ -1,135 +1,79 @@
 #!/bin/sh
-unset LIBPATH
+# Copyright (c) 2015 Oracle and/or its affiliates. All Rights Reserved.
+# Copyright (c) International Business Machines  Corp., 2000
 #
-#   Copyright (c) International Business Machines  Corp., 2000
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation; either version 2 of
+# the License, or (at your option) any later version.
 #
-#   This program is free software;  you can redistribute it and/or modify
-#   it under the terms of the GNU General Public License as published by
-#   the Free Software Foundation; either version 2 of the License, or
-#   (at your option) any later version.
+# This program is distributed in the hope that it would be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
 #
-#   This program is distributed in the hope that it will be useful,
-#   but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#   the GNU General Public License for more details.
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write the Free Software Foundation,
+# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 #
-#   You should have received a copy of the GNU General Public License
-#   along with this program;  if not, write to the Free Software
-#   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+# TEST DESCRIPTION:
+#     To verify that IP Multicast can be used to send UDP datagrams
+#     between two or more nodes on the same subnetwork using
+#     a specific IP Multicast group and a specific port address.
 #
-#
-#
-#  FILE             : mc_commo
-#
-#  TEST DESCRIPTION : To verify that IP Multicast can be used to send UDP datagrams
-#                     between two or more nodes on the same subnetwork using
-#                     a specific IP Multicast group and a specific port address.
-#
-#  HISTORY:
-#    03/26/01 Robbie Williamson (robbiew@us.ibm.com)
-#      -Ported
-#    08/01/06 Michael Reed mreedltp@vnet.ibm.com
-#      - The pinging of a specific IP Multicast group has been bypassed
-#        for SLES
-#
-#******************************************************************************
+# Authors:
+#     Robbie Williamson (robbiew@us.ibm.com)
+#     Michael Reed mreedltp@vnet.ibm.com
 
-TC=mc_commo
 TTL=10
-PORT=3333
-RHOST=${RHOST:-`hostname`}
 OUTFILE=mc_commo_out
-INTERFACE=${INTERFACE:-$(mc_gethost `hostname` | grep addresses: | \
-			 awk '{print $2}')}
 
-export TCID=$TC
-export TST_TOTAL=1
-export TST_COUNT=1
+TCID=mc_commo
+TST_TOTAL=2
 
-. test.sh
+. test_net.sh
 
 do_setup()
 {
-	tst_check_cmds rsh netstat
-	if [ -z $INTERFACE ]; then
-		tst_brkm TCONF "$(hostname) is not found in /etc/hosts"
-	fi
-
-	rsh -n -l root $RHOST "pwd > /dev/null"
-	if [ $? -ne 0 ]; then
-		tst_brkm TBROK "rsh $RHOST failed."
-	fi
+	tst_check_cmds netstat pgrep
 
-	OCTET=`ps -ewf | grep [m]c_commo | wc -l | awk '{print $1}'`
+	OCTET=$(ps -ewf | grep [m]c_commo | wc -l | awk '{print $1}')
 	GROUP_ADDR=224.0.0.$OCTET
-
+	PORT=$(tst_get_unused_port ipv4 dgram)
 	tst_tmpdir
 }
 
-do_test ()
+do_test()
 {
-	tst_resm TINFO "doing test."
-
-	COUNT=1
-	while [ $COUNT -le 2 ]
-	do
-
-		# Run setsockopt/getsockopt test
-		# Start up the recv on local host
-		tst_resm TINFO "Starting mc_recv on $GROUP_ADDR $INTERFACE "\
-			       "$PORT"
-
-		mc_recv $GROUP_ADDR $INTERFACE $PORT >> $OUTFILE &
-		SERVER_PID=$!
-		sleep 5
-		ps -ewf | grep mc_recv | grep -v grep
-		if [ $? -ne 0 ]; then
-			tst_brkm TFAIL "Could NOT start mc_recv on `hostname`"
-		fi
-
-		grep -q "cannot join group" $OUTFILE
-		if [ $? -eq 0 ]; then
-			tst_brkm TFAIL "Membership NOT set"
-		fi
-
-		netstat -ng | grep -q $GROUP_ADDR
-		if [ $? -ne 0 ]; then
-			tst_brkm TFAIL "membership not set for $GROUP_ADDR"
-		fi
-
-		for HOST in $RHOST
-		do
-			tst_resm TINFO "Running on $HOST mc_send $GROUP_ADDR "\
-				       "$HOST $PORT $TTL"
-
-			rsh -n -l root $HOST PATH=$LTPROOT/testcases/bin:$PATH;\
-					     "mc_send" $GROUP_ADDR $HOST $PORT \
-					     $TTL >/dev/null &
-			sleep 10
-			rsh -n -l root $HOST "ps -ewf | grep mc_send | "\
-					     "grep -v grep"
-			if [ $? -ne 0 ]; then
-				tst_brkm TFAIL "Could NOT start mc_send on "\
-					 "$HOST"
-			fi
-		done
-
-		tst_resm TINFO "Waiting for 100 sec.! Do not interrupt."
-		sleep 100  #wait until datagrams are received in $STATUS
-		COUNT=$(( $COUNT + 1 ))
-	done
+	# Run setsockopt/getsockopt test
+	# Start up the recv on local host
+	tst_resm TINFO "Start mc_recv $GROUP_ADDR $(tst_ipaddr) $PORT"
+	mc_recv $GROUP_ADDR $(tst_ipaddr) $PORT >> $OUTFILE &
+	SERVER_PID=$!
+	sleep 5
+	pgrep -x mc_recv > /dev/null || \
+		tst_brkm TFAIL "Could NOT start mc_recv on $(tst_ipaddr)"
+
+	grep -q "cannot join group" $OUTFILE && \
+		tst_brkm TFAIL "Membership NOT set"
+
+	netstat -ng | grep -q $GROUP_ADDR || \
+		tst_brkm TFAIL "membership not set for $GROUP_ADDR"
+
+	tst_resm TINFO "Start on $RHOST mc_send $GROUP_ADDR $(tst_ipaddr rhost) $PORT $TTL"
+
+	tst_rhost_run -b -c "mc_send $GROUP_ADDR $(tst_ipaddr rhost) $PORT $TTL"
+	sleep 10
+	tst_rhost_run -s -c "pgrep -x mc_send > /dev/null"
+
+	tst_resm TINFO "Waiting for 100 sec.! Do not interrupt."
+	sleep 100  #wait until datagrams are received in $STATUS
 
 	#test if datagrams has been sent
-	for HOST in $RHOST
-	do
-		grep -q "$HOST [0-9] [0-9]" $OUTFILE
-		if [ $? -ne 0 ]; then
-			tst_brkm TFAIL "NO Datagrams received from $HOST"
-		fi
-	done
+	grep -q "$(tst_ipaddr rhost) [0-9] [0-9]" $OUTFILE || \
+		tst_brkm TFAIL "NO Datagrams received from $RHOST"
 
 	tst_resm TPASS "Test Successful"
-	tst_exit
 }
 
 do_cleanup()
@@ -145,4 +89,8 @@ do_cleanup()
 do_setup
 TST_CLEANUP=do_cleanup
 
-do_test
+for i in $(seq 1 $TST_TOTAL); do
+	do_test
+done
+
+tst_exit
-- 
1.7.1


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

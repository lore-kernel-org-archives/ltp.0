Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1YIeYs-0003G2-KE
	for ltp-list@lists.sourceforge.net; Tue, 03 Feb 2015 14:34:42 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YIeYr-0007oH-LH
	for ltp-list@lists.sourceforge.net; Tue, 03 Feb 2015 14:34:42 +0000
Received: from ucsinet22.oracle.com (ucsinet22.oracle.com [156.151.31.94])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id t13EYZMD028792
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 3 Feb 2015 14:34:36 GMT
Received: from userz7022.oracle.com (userz7022.oracle.com [156.151.31.86])
	by ucsinet22.oracle.com (8.14.5+Sun/8.14.5) with ESMTP id
	t13EYZXJ004123
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Tue, 3 Feb 2015 14:34:35 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
	by userz7022.oracle.com (8.14.5+Sun/8.14.4) with ESMTP id
	t13EYYLr004075
	for <ltp-list@lists.sourceforge.net>; Tue, 3 Feb 2015 14:34:34 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue,  3 Feb 2015 17:36:54 +0300
Message-Id: <1422974214-12517-3-git-send-email-alexey.kodanev@oracle.com>
In-Reply-To: <1422974214-12517-1-git-send-email-alexey.kodanev@oracle.com>
References: <1422974214-12517-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH 3/3] network/multicast/mc_opts: use tst_ipaddr()
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

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/multicast/mc_opts/mc_opts |   77 +++++++++------------------
 1 files changed, 26 insertions(+), 51 deletions(-)

diff --git a/testcases/network/multicast/mc_opts/mc_opts b/testcases/network/multicast/mc_opts/mc_opts
index 7d50a76..66b814b 100755
--- a/testcases/network/multicast/mc_opts/mc_opts
+++ b/testcases/network/multicast/mc_opts/mc_opts
@@ -1,26 +1,21 @@
 #! /bin/sh
-unset LIBPATH
-#******************************************************************************
-#
-#   Copyright (c) International Business Machines  Corp., 2000
-#
-#   This program is free software;  you can redistribute it and/or modify
-#   it under the terms of the GNU General Public License as published by
-#   the Free Software Foundation; either version 2 of the License, or
-#   (at your option) any later version.
-#
-#   This program is distributed in the hope that it will be useful,
-#   but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#   the GNU General Public License for more details.
-#
-#   You should have received a copy of the GNU General Public License
-#   along with this program;  if not, write to the Free Software
-#   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+
+# Copyright (c) 2015 Oracle and/or its affiliates. All Rights Reserved.
+# Copyright (c) International Business Machines  Corp., 2000
 #
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation; either version 2 of
+# the License, or (at your option) any later version.
 #
+# This program is distributed in the hope that it would be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
 #
-#  FILE   : mc_opts
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write the Free Software Foundation,
+# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 #
 #  PURPOSE: To verify that three of the new options for level IPPROTO_IP
 #           Service Interface are initially set to the default values as
@@ -30,52 +25,32 @@ unset LIBPATH
 #           generate errors while exercising the IP Multicast Service
 #           Interface options.
 #
-#  HISTORY:
-#    03/26/01 Robbie Williamson (robbiew@us.ibm.com)
-#      -Ported
 #
-#******************************************************************************
+# Robbie Williamson (robbiew@us.ibm.com)
+#  -Ported
 
-TC=mc_opts
 EXECUTABLES=${EXECUTABLES:-"mc_verify_opts mc_verify_opts_error"}
-IPADDR=${IPADDR:-$(mc_gethost `hostname`| grep address |awk '{ print $2 }')}
-
-export TCID=$TC
-export TST_TOTAL=1
-export TST_COUNT=1
-
-. test.sh
-
-if [ -z $IPADDR ]; then
-	tst_brkm TCONF "Not found $(hostname) in /etc/hosts"
-fi
+TCID=mc_opts
+TST_TOTAL=1
 
-tst_resm TINFO "doing test."
+. test_net.sh
 
 COUNT=1
-while [ $COUNT -le 10 ]
-do
+while [ $COUNT -le 10 ]; do
 	# Run setsockopt/getsockopt test
-	tst_resm TINFO "Running $EXECUTABLES on $IPADDR"
-	for i in $EXECUTABLES
-	do
-		$i $IPADDR > /dev/null 2>&1
-		if [ $? -ne 0 ]; then
-			tst_brkm TFAIL "$i $IPADDR failed"
-		fi
+	tst_resm TINFO "Running $EXECUTABLES on $(tst_ipaddr)"
+	for i in $EXECUTABLES; do
+		$i $(tst_ipaddr) > /dev/null || \
+			tst_brkm TFAIL "$i $(tst_ipaddr) failed"
 	done
 
 	tst_resm TINFO "Running ping with bad values"
-	ping -T 777 224.0.0.1 > /dev/null 2>&1
-	if [ $? -eq 0 ]; then
+	ping -T 777 224.0.0.1 > /dev/null 2>&1 && \
 		tst_brkm TFAIL "Multicast range should be out of range"
-	fi
 
 	tst_resm TINFO "Running ping on a invalid interface!"
-	ping -I 3.3.3.3 224.0.0.1 > /dev/null 2>&1
-	if [ $? -eq 0 ]; then
+	ping -I 3.3.3.3 224.0.0.1 > /dev/null 2>&1 && \
 		tst_brkm TFAIL "ping on bogus interface should fail"
-	fi
 
 	COUNT=$(( $COUNT + 1 ))
 done
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

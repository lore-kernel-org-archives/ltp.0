Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1WfOjp-0000K1-8Z
	for ltp-list@lists.sourceforge.net; Wed, 30 Apr 2014 07:15:29 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WfOjo-0005OB-1r
	for ltp-list@lists.sourceforge.net; Wed, 30 Apr 2014 07:15:29 +0000
Received: from acsinet22.oracle.com (acsinet22.oracle.com [141.146.126.238])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s3U7FKvc032749
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 30 Apr 2014 07:15:21 GMT
Received: from userz7022.oracle.com (userz7022.oracle.com [156.151.31.86])
	by acsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s3U7FJQ2016478
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Wed, 30 Apr 2014 07:15:19 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
	by userz7022.oracle.com (8.14.5+Sun/8.14.4) with ESMTP id
	s3U7FIFV010407
	for <ltp-list@lists.sourceforge.net>; Wed, 30 Apr 2014 07:15:18 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Wed, 30 Apr 2014 11:15:11 +0400
Message-Id: <1398842111-29115-1-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <5358EBCC.4070509@oracle.com>
References: <5358EBCC.4070509@oracle.com>
Subject: [LTP] [PATCH V3 08/14] rpc-tirpc: implemented a wrapper
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

Implemented a single wrapper script which can be used
to execute _most_ of the rpc-tirpc test binaries.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
Changes since V2:
* if RHOST is not set, rsh is not used
* added several comments to the script
* renamed SERVERTIMEOUT to SERVER_STARTUP_SLEEP

 testcases/network/rpc/rpc-tirpc/Makefile    |    5 +
 testcases/network/rpc/rpc-tirpc/rpc_test.sh |  119 +++++++++++++++++++++++++++
 2 files changed, 124 insertions(+), 0 deletions(-)
 create mode 100755 testcases/network/rpc/rpc-tirpc/rpc_test.sh

diff --git a/testcases/network/rpc/rpc-tirpc/Makefile b/testcases/network/rpc/rpc-tirpc/Makefile
index 1620b2c..2006616 100644
--- a/testcases/network/rpc/rpc-tirpc/Makefile
+++ b/testcases/network/rpc/rpc-tirpc/Makefile
@@ -19,4 +19,9 @@
 top_srcdir		?= ../../../..
 
 include	$(top_srcdir)/include/mk/env_pre.mk
+
+INSTALL_TARGETS		:= rpc_test.sh
+
+MAKE_TARGETS		:=
+
 include $(top_srcdir)/include/mk/generic_trunk_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/rpc_test.sh b/testcases/network/rpc/rpc-tirpc/rpc_test.sh
new file mode 100755
index 0000000..76627dd
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/rpc_test.sh
@@ -0,0 +1,119 @@
+#!/bin/sh
+#
+# Copyright (c) 2014 Oracle and/or its affiliates. All Rights Reserved.
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation; either version 2 of
+# the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it would be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write the Free Software Foundation,
+# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+#
+# This is a wrapper script to execute tests from the RPC/TI-RPC tests
+# suite (http://nfsv4.bullopensource.org/doc/rpc_testsuite.php) in LTP
+#
+# This wrapper uses the RHOST environment variable:
+#
+# If the RHOST variable is set, then the rpc server instance (if needed)
+# is started on RHOST, using rsh, and the client program is passed
+# the RHOST value.
+#
+# If the RHOST variable is not set, then the rpc server instance (if needed)
+# is started on the local host, and the client program is passed `hostname`.
+
+SERVER_HOST=${RHOST:-`hostname`}
+SERVER=""
+CLIENT=""
+CLIENT_EXTRA_OPTS=""
+CLEANER=""
+# Program number to register the services to rpcbind
+PROGNUMNOSVC=536875000
+SERVER_STARTUP_SLEEP=1
+
+run_cmd()
+{
+	if [ ! -z "$RHOST" ]; then
+		rsh -n "$RHOST" "$1"
+	else
+		$1
+	fi
+}
+
+cleanup()
+{
+	if [ ! -z "$SERVER" ]; then
+		run_cmd "killall -9 $SERVER"
+		run_cmd "$CLEANER $PROGNUMNOSVC"
+	fi
+}
+
+usage()
+{
+	echo "USAGE: $0 [-s sprog] -c clprog [ -e extra ]"
+	echo ""
+	echo "sprog   - server program binary"
+	echo "clprog  - client program binary"
+	echo "extra   - extra client options"
+	echo ""
+	echo "This scripts connects to the RHOST host by rsh and starts"
+	echo "sprog there. After that it executes clprog passing it the"
+	echo "RHOST value."
+	echo "After the test completes, this script kills sprog on RHOST"
+	echo "and performs a cleaning operation."
+	echo ""
+	echo "If RHOST is not set, the local host is used."
+
+	exit 1
+}
+
+while getopts s:c:e:h arg; do
+	case $arg in
+		s) SERVER="$LTPROOT/testcases/bin/$OPTARG" ;;
+		c) CLIENT="$OPTARG" ;;
+		e) CLIENT_EXTRA_OPTS="$OPTARG" ;;
+		h) usage ;;
+	esac
+done
+
+if [ ! -z "$SERVER" ]; then
+	if `echo "$SERVER" | grep -e '^tirpc'`; then
+		CLEANER="$LTPROOT/testcases/bin/tirpc_cleaner"
+	else
+		CLEANER="$LTPROOT/testcases/bin/rpc_cleaner"
+	fi
+fi
+
+if [ -z "$CLIENT" ]; then
+	echo "client program not set"
+	echo ""
+	usage
+fi
+
+TCID="$CLIENT"
+TST_TOTAL=1
+TST_COUNT=1
+. test.sh
+TST_CLEANUP=cleanup
+
+if [ ! -z "$SERVER" ]; then
+	run_cmd "$SERVER $PROGNUMNOSVC" &
+	sleep "$SERVER_STARTUP_SLEEP"
+fi
+
+"$CLIENT" "$SERVER_HOST" "$PROGNUMNOSVC" $CLIENT_EXTRA_OPTS
+ret=$?
+
+if [ "$ret" -eq 0 ]; then
+	tst_resm TPASS "Test passed"
+else
+	tst_resm TFAIL "Test failed"
+fi
+
+tst_exit
-- 
1.7.1


------------------------------------------------------------------------------
"Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
Instantly run your Selenium tests across 300+ browser/OS combos.  Get 
unparalleled scalability from the best Selenium testing platform available.
Simple to use. Nothing to install. Get started now for free."
http://p.sf.net/sfu/SauceLabs
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

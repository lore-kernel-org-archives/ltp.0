Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1WSSI7-00026j-Qm
	for ltp-list@lists.sourceforge.net; Tue, 25 Mar 2014 14:25:23 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WSSI6-0005wI-LP
	for ltp-list@lists.sourceforge.net; Tue, 25 Mar 2014 14:25:23 +0000
Received: from ucsinet22.oracle.com (ucsinet22.oracle.com [156.151.31.94])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s2PEPG2J030955
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 25 Mar 2014 14:25:17 GMT
Received: from aserz7021.oracle.com (aserz7021.oracle.com [141.146.126.230])
	by ucsinet22.oracle.com (8.14.5+Sun/8.14.5) with ESMTP id
	s2PEPFYK006660
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Tue, 25 Mar 2014 14:25:16 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
	by aserz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s2PEPFBv015235
	for <ltp-list@lists.sourceforge.net>; Tue, 25 Mar 2014 14:25:15 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Tue, 25 Mar 2014 18:24:34 +0400
Message-Id: <1395757480-27424-9-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <1395757480-27424-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1395757480-27424-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH V2 08/14] rpc-tirpc: implemented a wrapper
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
 testcases/network/rpc/rpc-tirpc/Makefile    |    5 ++
 testcases/network/rpc/rpc-tirpc/rpc_test.sh |  100 +++++++++++++++++++++++++++
 2 files changed, 105 insertions(+), 0 deletions(-)
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
index 0000000..3352911
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/rpc_test.sh
@@ -0,0 +1,100 @@
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
+
+RHOST=${RHOST:-`hostname`}
+SERVER=""
+CLIENT=""
+CLIENT_EXTRA_OPTS=""
+CLEANER=""
+PROGNUMNOSVC=536875000
+SERVERTIMEOUT=1
+
+cleanup()
+{
+	if [ ! -z "$SERVER" ]; then
+		rsh -n "$RHOST" "killall -9 $SERVER"
+		rsh -n "$RHOST" "$CLEANER $PROGNUMNOSVC"
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
+	rsh -n "$RHOST" "$SERVER $PROGNUMNOSVC" &
+	sleep "$SERVERTIMEOUT"
+fi
+
+"$CLIENT" "$RHOST" "$PROGNUMNOSVC" $CLIENT_EXTRA_OPTS
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
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/13534_NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

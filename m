Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <xu.simon@oracle.com>) id 1VlyYC-00066u-Ar
	for ltp-list@lists.sourceforge.net; Thu, 28 Nov 2013 10:10:24 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VlyYA-0001GJ-9Q
	for ltp-list@lists.sourceforge.net; Thu, 28 Nov 2013 10:10:24 +0000
Received: from acsinet22.oracle.com (acsinet22.oracle.com [141.146.126.238])
	by userp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id rASAAFgB029725
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 28 Nov 2013 10:10:16 GMT
Received: from aserz7021.oracle.com (aserz7021.oracle.com [141.146.126.230])
	by acsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rASAAEi4019910
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Thu, 28 Nov 2013 10:10:15 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
	by aserz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rASAAEeB003909
	for <ltp-list@lists.sourceforge.net>; Thu, 28 Nov 2013 10:10:14 GMT
From: Simon Xu <xu.simon@oracle.com>
Date: Thu, 28 Nov 2013 18:10:08 +0800
Message-Id: <1385633408-419-1-git-send-email-xu.simon@oracle.com>
In-Reply-To: <52971586.5090009@oracle.com>
References: <52971586.5090009@oracle.com>
Subject: [LTP]  [PATCH V5] rpc01: fix paths and add Makefile for datafiles
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

Signed-off-by: Simon Xu <xu.simon@oracle.com>
---
 testcases/network/rpc/basic_tests/rpc01/Makefile   |  4 ++-
 .../rpc/basic_tests/rpc01/datafiles/Makefile       | 29 ++++++++++++++++++++++
 testcases/network/rpc/basic_tests/rpc01/rpc01      | 11 ++++----
 3 files changed, 37 insertions(+), 7 deletions(-)
 create mode 100644 testcases/network/rpc/basic_tests/rpc01/datafiles/Makefile

diff --git a/testcases/network/rpc/basic_tests/rpc01/Makefile b/testcases/network/rpc/basic_tests/rpc01/Makefile
index ba3fe0a..732d816 100644
--- a/testcases/network/rpc/basic_tests/rpc01/Makefile
+++ b/testcases/network/rpc/basic_tests/rpc01/Makefile
@@ -29,4 +29,6 @@ CPPFLAGS		+= -Wno-error
 
 INSTALL_TARGETS		:= rpc01
 
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
+SUBDIRS			:= datafiles
+
+include $(top_srcdir)/include/mk/generic_trunk_target.mk
diff --git a/testcases/network/rpc/basic_tests/rpc01/datafiles/Makefile b/testcases/network/rpc/basic_tests/rpc01/datafiles/Makefile
new file mode 100644
index 0000000..7be4942
--- /dev/null
+++ b/testcases/network/rpc/basic_tests/rpc01/datafiles/Makefile
@@ -0,0 +1,29 @@
+#
+#    network/rpc/basic_tests/rpc01/datafiles Makefile.
+#
+#    This program is free software; you can redistribute it and/or modify
+#    it under the terms of the GNU General Public License as published by
+#    the Free Software Foundation; either version 2 of the License, or
+#    (at your option) any later version.
+#
+#    This program is distributed in the hope that it will be useful,
+#    but WITHOUT ANY WARRANTY; without even the implied warranty of
+#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#    GNU General Public License for more details.
+#
+#    You should have received a copy of the GNU General Public License along
+#    with this program; if not, write to the Free Software Foundation, Inc.,
+#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+#    Simon Xu <xu.simon@oracle.com> Nov 8 2013
+#
+
+top_srcdir		?= ../../../../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+
+INSTALL_DIR		:= testcases/data/rpc01
+
+INSTALL_TARGETS		:= file*
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/basic_tests/rpc01/rpc01 b/testcases/network/rpc/basic_tests/rpc01/rpc01
index fd236b1..8ed69b0 100755
--- a/testcases/network/rpc/basic_tests/rpc01/rpc01
+++ b/testcases/network/rpc/basic_tests/rpc01/rpc01
@@ -36,9 +36,8 @@
 $trace_logic
 this_file=${0##*/}
 TC=${TC:=rpc01}
-TCbin=${TCbin:=`pwd`}
-TCdat=${TCdat:=$TCbin/datafiles}
-TCtmp=${TCtmp:=$LTPROOT/testcases/bin}
+TCbin=${TCbin:=$LTPROOT/testcases/bin}
+TCdat=${TCdat:=$LTPROOT/testcases/data/rpc01}
 NUMLOOPS=${NUMLOOPS:=3}
 RHOST=${RHOST:=`hostname`}
 CLEANUP=${CLEANUP:="ON"}
@@ -71,7 +70,7 @@ do_test()
     do
       for FILE in $DATAFILES
       do
-	$TCtmp/rpc1 -s $RHOST -f $TCdat/$FILE
+	rpc1 -s $RHOST -f $TCdat/$FILE
 	[ $? -eq 0 ] || end_testcase "Fail on using $FILE"
       done
       COUNT=`expr $COUNT + 1`
@@ -93,9 +92,9 @@ do_cleanup()
     $trace_logic
 
     if [ "$CLEANUP" = "ON" ]; then
-	if [ -f $TCtmp/core ]; then
+	if [ -f $TMPDIR/core ]; then
 	   echo "Core file is saved in /tmp"
-	   mv $TCtmp/core /tmp
+	   mv $TMPDIR/core /tmp
 	fi
 
 	# Kill server
-- 
1.8.4.2


------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349351&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

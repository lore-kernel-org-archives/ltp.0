Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <xu.simon@oracle.com>) id 1Vefrw-000271-9o
	for ltp-list@lists.sourceforge.net; Fri, 08 Nov 2013 06:48:36 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Vefrv-0005Jo-EG
	for ltp-list@lists.sourceforge.net; Fri, 08 Nov 2013 06:48:36 +0000
Received: from acsinet21.oracle.com (acsinet21.oracle.com [141.146.126.237])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id rA86mT8t011128
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 8 Nov 2013 06:48:29 GMT
Received: from aserz7021.oracle.com (aserz7021.oracle.com [141.146.126.230])
	by acsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rA86mSXW009093
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Fri, 8 Nov 2013 06:48:29 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
	by aserz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rA86mSQl009088
	for <ltp-list@lists.sourceforge.net>; Fri, 8 Nov 2013 06:48:28 GMT
MIME-Version: 1.0
Message-ID: <1383891428-648-1-git-send-email-xu.simon@oracle.com>
Date: Thu, 7 Nov 2013 22:17:08 -0800 (PST)
From: Simon Xu <xu.simon@oracle.com>
References: <1383715718-507-1-git-send-email-xu.simon@oracle.com>
In-Reply-To: <1383715718-507-1-git-send-email-xu.simon@oracle.com>
Subject: [LTP] [PATCH V3] rpc01: fix $TCbin and $TCtmp and add Makefile for
 datafiles
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
To: ltp-list@lists.sourceforge.net

1) The values of TCbin and TCtmp should be swapped, and `rpc1' is in TCbin,
   not TCtmp.
2) The files in datafiles dir are needed in the test but they are not
   installed.  Create a Makefile in datafiles to install the files.

Signed-off-by: Simon Xu <xu.simon@oracle.com>
---
 testcases/network/rpc/basic_tests/rpc01/Makefile   |  4 ++-
 .../rpc/basic_tests/rpc01/datafiles/Makefile       | 29 ++++++++++++++++++++++
 testcases/network/rpc/basic_tests/rpc01/rpc01      |  6 ++---
 3 files changed, 35 insertions(+), 4 deletions(-)
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
index 0000000..92370e6
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
+INSTALL_DIR		:= testcases/bin/datafiles
+
+INSTALL_TARGETS		:= file*
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/basic_tests/rpc01/rpc01 b/testcases/network/rpc/basic_tests/rpc01/rpc01
index ef97a95..c16493c 100755
--- a/testcases/network/rpc/basic_tests/rpc01/rpc01
+++ b/testcases/network/rpc/basic_tests/rpc01/rpc01
@@ -36,9 +36,9 @@
 $trace_logic
 this_file=${0##*/}
 TC=${TC:=rpc01}
-TCbin=${TCbin:=`pwd`}
+TCbin=${TCbin:=$LTPROOT/testcases/bin}
 TCdat=${TCdat:=$TCbin/datafiles}
-TCtmp=${TCtmp:=$LTPROOT/testcases/bin}
+TCtmp=${TCtmp:=`pwd`}
 NUMLOOPS=${NUMLOOPS:=3}
 RHOST=${RHOST:=`hostname`}
 CLEANUP=${CLEANUP:="ON"}
@@ -68,7 +68,7 @@ do_test()
     do
       for FILE in $DATAFILES
       do
-	$TCtmp/rpc1 -s $RHOST -f $TCdat/$FILE
+	$TCbin/rpc1 -s $RHOST -f $TCdat/$FILE
 	[ $? -eq 0 ] || end_testcase "Fail on using $FILE"
       done
       COUNT=`expr $COUNT + 1`
-- 
1.8.4.2


------------------------------------------------------------------------------
November Webinars for C, C++, Fortran Developers
Accelerate application performance with scalable programming models. Explore
techniques for threading, error checking, porting, and tuning. Get the most 
from the latest Intel processors and coprocessors. See abstracts and register
http://pubads.g.doubleclick.net/gampad/clk?id=60136231&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

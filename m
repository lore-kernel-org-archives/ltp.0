Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <xu.simon@oracle.com>) id 1Vec72-0007lc-Vt
	for ltp-list@lists.sourceforge.net; Fri, 08 Nov 2013 02:47:57 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Vec72-0007pC-2L
	for ltp-list@lists.sourceforge.net; Fri, 08 Nov 2013 02:47:56 +0000
Received: from ucsinet21.oracle.com (ucsinet21.oracle.com [156.151.31.93])
	by userp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id rA82lnmk018957
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 8 Nov 2013 02:47:50 GMT
Received: from aserz7021.oracle.com (aserz7021.oracle.com [141.146.126.230])
	by ucsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rA82lmXs023661
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Fri, 8 Nov 2013 02:47:49 GMT
Received: from abhmt107.oracle.com (abhmt107.oracle.com [141.146.116.59])
	by aserz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rA82lmWi001818
	for <ltp-list@lists.sourceforge.net>; Fri, 8 Nov 2013 02:47:48 GMT
From: Simon Xu <xu.simon@oracle.com>
Date: Fri,  8 Nov 2013 10:47:42 +0800
Message-Id: <1383878862-620-1-git-send-email-xu.simon@oracle.com>
In-Reply-To: <20131107161950.GC9653@rei.Home>
References: <20131107161950.GC9653@rei.Home>
Subject: [LTP] [PATCH] sendfile01: rename SF_Server to sendfile01_server and
	add it into Makefile
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

1) Rename SF_Server to sendfile01_server to avoid collisions
2) The test always fails because SF_Server is not installed, add
   sendfile01_server into sendfile01 makefile to install it.

Signed-off-by: Simon Xu <xu.simon@oracle.com>
---
 testcases/network/tcp_cmds/sendfile/Makefile          | 2 +-
 testcases/network/tcp_cmds/sendfile/SF_Server         | 6 ------
 testcases/network/tcp_cmds/sendfile/sendfile01        | 2 +-
 testcases/network/tcp_cmds/sendfile/sendfile01_server | 6 ++++++
 4 files changed, 8 insertions(+), 8 deletions(-)
 delete mode 100755 testcases/network/tcp_cmds/sendfile/SF_Server
 create mode 100755 testcases/network/tcp_cmds/sendfile/sendfile01_server

diff --git a/testcases/network/tcp_cmds/sendfile/Makefile b/testcases/network/tcp_cmds/sendfile/Makefile
index 124ce5d..a8b0736 100644
--- a/testcases/network/tcp_cmds/sendfile/Makefile
+++ b/testcases/network/tcp_cmds/sendfile/Makefile
@@ -27,7 +27,7 @@ include $(abs_srcdir)/../Makefile.inc
 
 CPPFLAGS		+= -I$(abs_srcdir)/../include
 
-INSTALL_TARGETS		:= sendfile01
+INSTALL_TARGETS		:= sendfile01 sendfile01_server
 
 MAKE_TARGETS		+= testsf_c testsf_s testsf_c6 testsf_s6
 
diff --git a/testcases/network/tcp_cmds/sendfile/SF_Server b/testcases/network/tcp_cmds/sendfile/SF_Server
deleted file mode 100755
index 2383ce4..0000000
--- a/testcases/network/tcp_cmds/sendfile/SF_Server
+++ /dev/null
@@ -1,6 +0,0 @@
-#!/bin/sh
-#set -x
-cd $3
-exec 1< /dev/null       # open descriptor 1
-exec 2< /dev/null       # open descriptor 1
-nohup ./testsf_s $1 $2 &
diff --git a/testcases/network/tcp_cmds/sendfile/sendfile01 b/testcases/network/tcp_cmds/sendfile/sendfile01
index 46b90e2..ba61873 100755
--- a/testcases/network/tcp_cmds/sendfile/sendfile01
+++ b/testcases/network/tcp_cmds/sendfile/sendfile01
@@ -84,7 +84,7 @@ do_test()
 
     mkdir -p $TCtmp
     PORT=$$
-    if ! rsh -l root $IPADDR "$LTPROOT/testcases/bin/SF_Server $IPADDR $PORT $LTPROOT/testcases/bin $SERVER"; then
+    if ! rsh -l root $IPADDR "$LTPROOT/testcases/bin/sendfile01_server $IPADDR $PORT $LTPROOT/testcases/bin $SERVER"; then
         end_testcase "rsh failed to $IPADDR as root failed"
     fi
     sleep 10
diff --git a/testcases/network/tcp_cmds/sendfile/sendfile01_server b/testcases/network/tcp_cmds/sendfile/sendfile01_server
new file mode 100755
index 0000000..2383ce4
--- /dev/null
+++ b/testcases/network/tcp_cmds/sendfile/sendfile01_server
@@ -0,0 +1,6 @@
+#!/bin/sh
+#set -x
+cd $3
+exec 1< /dev/null       # open descriptor 1
+exec 2< /dev/null       # open descriptor 1
+nohup ./testsf_s $1 $2 &
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

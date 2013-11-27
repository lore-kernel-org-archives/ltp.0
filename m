Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1VlbYZ-0002RP-9w
	for ltp-list@lists.sourceforge.net; Wed, 27 Nov 2013 09:37:15 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VlbYX-0006Il-7A
	for ltp-list@lists.sourceforge.net; Wed, 27 Nov 2013 09:37:15 +0000
Received: from ucsinet21.oracle.com (ucsinet21.oracle.com [156.151.31.93])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id rAR9b6cn031056
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 27 Nov 2013 09:37:07 GMT
Received: from userz7021.oracle.com (userz7021.oracle.com [156.151.31.85])
	by ucsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rAR9b57q027540
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Wed, 27 Nov 2013 09:37:06 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
	by userz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rAR9b5nZ027527
	for <ltp-list@lists.sourceforge.net>; Wed, 27 Nov 2013 09:37:05 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 27 Nov 2013 13:36:52 +0400
Message-Id: <1385545013-22647-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH 1/2] configure: add configure check for GCC built-in
	function
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
Cc: vasily.isaenko@oracle.com, Alexey Kodanev <alexey.kodanev@oracle.com>

New m4 function tries to determine if GCC has __sync_fetch_and_or built-in
function which performs an atomic bit-wise inclusive OR operation.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 configure.ac          |    1 +
 m4/ltp-gcc_builtin.m4 |   43 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 0 deletions(-)
 create mode 100644 m4/ltp-gcc_builtin.m4

diff --git a/configure.ac b/configure.ac
index 4846afd..13ef749 100644
--- a/configure.ac
+++ b/configure.ac
@@ -170,5 +170,6 @@ LTP_CHECK_FS_IOC_FLAGS
 LTP_CHECK_MREMAP_FIXED
 LTP_CHECK_KERNEL_DEVEL
 LTP_CHECK_XFS_QUOTACTL
+LTP_CHECK_GCC_BUILTIN
 
 AC_OUTPUT
diff --git a/m4/ltp-gcc_builtin.m4 b/m4/ltp-gcc_builtin.m4
new file mode 100644
index 0000000..371fea7
--- /dev/null
+++ b/m4/ltp-gcc_builtin.m4
@@ -0,0 +1,43 @@
+dnl Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
+dnl
+dnl This program is free software; you can redistribute it and/or
+dnl modify it under the terms of the GNU General Public License as
+dnl published by the Free Software Foundation; either version 2 of
+dnl the License, or (at your option) any later version.
+dnl
+dnl This program is distributed in the hope that it would be useful,
+dnl but WITHOUT ANY WARRANTY; without even the implied warranty of
+dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+dnl GNU General Public License for more details.
+dnl
+dnl You should have received a copy of the GNU General Public License
+dnl along with this program; if not, write the Free Software Foundation,
+dnl Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+dnl
+dnl Author: Alexey Kodanev <alexey.kodanev@oracle.com>
+dnl
+
+dnl
+dnl LTP_CHECK_GCC_BUILTIN
+dnl ----------------------------
+dnl Checking for GCC atomic memory access built-in function __sync_fetch_and_or
+dnl which performs an atomic bit-wise inclusive OR operation
+dnl
+
+AC_DEFUN([LTP_CHECK_GCC_BUILTIN],[dnl
+
+AC_MSG_CHECKING([for __sync_fetch_and_or])
+
+AC_LINK_IFELSE(
+	[AC_LANG_PROGRAM([], [int i; return __sync_fetch_and_or(&i, 0);])],
+	[have_sync_fetch_and_or=yes],
+	[have_sync_fetch_and_or=no]
+)
+
+AS_IF([test "$have_sync_fetch_and_or" = yes],
+	AC_DEFINE([HAVE_SYNC_FETCH_AND_OR], [1],
+	          [Define if GCC has __sync_fetch_and_or]))
+
+AC_MSG_RESULT($have_sync_fetch_and_or)
+
+])
-- 
1.7.1


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

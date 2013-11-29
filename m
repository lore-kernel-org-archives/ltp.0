Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1VmIyj-0006qr-3Z
	for ltp-list@lists.sourceforge.net; Fri, 29 Nov 2013 07:59:09 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VmIyi-0001BZ-2z
	for ltp-list@lists.sourceforge.net; Fri, 29 Nov 2013 07:59:09 +0000
Received: from ucsinet21.oracle.com (ucsinet21.oracle.com [156.151.31.93])
	by userp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id rAT7x1p0032142
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 29 Nov 2013 07:59:02 GMT
Received: from aserz7022.oracle.com (aserz7022.oracle.com [141.146.126.231])
	by ucsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rAT7x0km006324
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Fri, 29 Nov 2013 07:59:01 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
	by aserz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rAT7x0iA023795
	for <ltp-list@lists.sourceforge.net>; Fri, 29 Nov 2013 07:59:00 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Fri, 29 Nov 2013 11:58:52 +0400
Message-Id: <1385711934-8999-1-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <20131128113652.GB19263@rei.Home>
References: <20131128113652.GB19263@rei.Home>
Subject: [LTP] [PATCH V2 1/3] autoconf check for utimensat(2)
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

Unfortunately, not all distributions have utimensat(2) defined (old glibc),
so we need a way to check it in our code.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 configure.ac        |    1 +
 m4/ltp-utimensat.m4 |   44 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 0 deletions(-)
 create mode 100644 m4/ltp-utimensat.m4

diff --git a/configure.ac b/configure.ac
index 4846afd..4af7662 100644
--- a/configure.ac
+++ b/configure.ac
@@ -162,6 +162,7 @@ LTP_CHECK_SYSCALL_NUMA
 LTP_CHECK_SYSCALL_QUOTACTL
 LTP_CHECK_SYSCALL_SIGNALFD
 LTP_CHECK_SYSCALL_UNSHARE
+LTP_CHECK_SYSCALL_UTIMENSAT
 LTP_CHECK_TASKSTATS
 LTP_CHECK_TIME
 LTP_CHECK_MADVISE
diff --git a/m4/ltp-utimensat.m4 b/m4/ltp-utimensat.m4
new file mode 100644
index 0000000..1f9a055
--- /dev/null
+++ b/m4/ltp-utimensat.m4
@@ -0,0 +1,44 @@
+dnl
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
+
+dnl
+dnl LTP_CHECK_SYSCALL_UTIMENSAT
+dnl ----------------------------
+dnl
+AC_DEFUN([LTP_CHECK_SYSCALL_UTIMENSAT],[
+	AC_MSG_CHECKING([for utimensat])
+	AC_LINK_IFELSE([AC_LANG_SOURCE([
+#include <stdlib.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+
+int main(void) {
+	long tv_nsec;
+	tv_nsec = UTIME_NOW;
+	tv_nsec = UTIME_OMIT;
+
+	return utimensat(AT_FDCWD, NULL, NULL, 0);
+}])],[has_utimensat="yes"])
+
+if test "x$has_utimensat" = "xyes"; then
+	AC_DEFINE(HAVE_UTIMENSAT, 1, [Define to 1 if you have utimensat(2)])
+	AC_MSG_RESULT(yes)
+else
+	AC_MSG_RESULT(no)
+fi
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

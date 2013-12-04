Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1VoBNk-0005xW-42
	for ltp-list@lists.sourceforge.net; Wed, 04 Dec 2013 12:16:44 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VoBNi-0000kE-B8
	for ltp-list@lists.sourceforge.net; Wed, 04 Dec 2013 12:16:44 +0000
Received: from acsinet21.oracle.com (acsinet21.oracle.com [141.146.126.237])
	by userp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id rB4CGZRY012277
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 4 Dec 2013 12:16:36 GMT
Received: from aserz7022.oracle.com (aserz7022.oracle.com [141.146.126.231])
	by acsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rB4CGYSV020528
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Wed, 4 Dec 2013 12:16:35 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
	by aserz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rB4CGY58015423
	for <ltp-list@lists.sourceforge.net>; Wed, 4 Dec 2013 12:16:34 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Wed,  4 Dec 2013 16:16:26 +0400
Message-Id: <1386159388-23713-1-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <529D7CFE.9090104@oracle.com>
References: <529D7CFE.9090104@oracle.com>
Subject: [LTP] [PATCH V3 1/3] autoconf check for utimensat(2)
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
Sponsored by Intel(R) XDK 
Develop, test and display web and hybrid apps with a single code base.
Download it for free now!
http://pubads.g.doubleclick.net/gampad/clk?id=111408631&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

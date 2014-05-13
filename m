Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1Wk64y-0002jM-OG
	for ltp-list@lists.sourceforge.net; Tue, 13 May 2014 06:20:44 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Wk64w-0003Ap-PN
	for ltp-list@lists.sourceforge.net; Tue, 13 May 2014 06:20:43 +0000
Received: from ucsinet22.oracle.com (ucsinet22.oracle.com [156.151.31.94])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s4D6KadC025121
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 13 May 2014 06:20:37 GMT
Received: from userz7021.oracle.com (userz7021.oracle.com [156.151.31.85])
	by ucsinet22.oracle.com (8.14.5+Sun/8.14.5) with ESMTP id
	s4D6KZEU028048
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Tue, 13 May 2014 06:20:36 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
	by userz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s4D6KZYI005462
	for <ltp-list@lists.sourceforge.net>; Tue, 13 May 2014 06:20:35 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Tue, 13 May 2014 10:20:22 +0400
Message-Id: <1399962023-23105-1-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <20140512125913.GA4741@rei>
References: <20140512125913.GA4741@rei>
Subject: [LTP] [PATCH 1/2] sendmsg,
	recvmsg: moved MSG_CMSG_COMPAT definition to a header
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

sendmsg01.c and recvmsg01.c both define MSG_CMSG_COMPAT in a
similar way. Moved this definition to a new header file to reduce
code duplication.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 testcases/kernel/syscalls/recvmsg/Makefile    |    2 +
 testcases/kernel/syscalls/recvmsg/recvmsg01.c |   15 +---------
 testcases/kernel/syscalls/sendmsg/Makefile    |    2 +
 testcases/kernel/syscalls/sendmsg/sendmsg01.c |   15 +---------
 testcases/kernel/syscalls/utils/msg_common.h  |   38 +++++++++++++++++++++++++
 5 files changed, 44 insertions(+), 28 deletions(-)
 create mode 100644 testcases/kernel/syscalls/utils/msg_common.h

diff --git a/testcases/kernel/syscalls/recvmsg/Makefile b/testcases/kernel/syscalls/recvmsg/Makefile
index bd617d8..e69c726 100644
--- a/testcases/kernel/syscalls/recvmsg/Makefile
+++ b/testcases/kernel/syscalls/recvmsg/Makefile
@@ -20,4 +20,6 @@ top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 
+CPPFLAGS		+= -I$(abs_srcdir)/../utils
+
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/recvmsg/recvmsg01.c b/testcases/kernel/syscalls/recvmsg/recvmsg01.c
index bc84a23..93c9190 100644
--- a/testcases/kernel/syscalls/recvmsg/recvmsg01.c
+++ b/testcases/kernel/syscalls/recvmsg/recvmsg01.c
@@ -40,20 +40,6 @@
  *
  */
 
-/* The #ifndef code below is for 2.5 64-bit kernels, where     */
-/* the MSG_CMSG_COMPAT flag must be 0 in order for the syscall */
-/* and this test to function correctly.                        */
-#ifndef MSG_CMSG_COMPAT
-
-#if defined (__powerpc64__) || defined (__mips64) || defined (__x86_64__) || defined (__sparc64__)
-#define MSG_CMSG_COMPAT 0x80000000
-#else
-#define MSG_CMSG_COMPAT 0
-#endif
-
-#endif
-/***************************************************/
-
 #include <stdio.h>
 #include <unistd.h>
 #include <string.h>
@@ -71,6 +57,7 @@
 
 #include "test.h"
 #include "usctest.h"
+#include "msg_common.h"
 
 char *TCID = "recvmsg01";
 int testno;
diff --git a/testcases/kernel/syscalls/sendmsg/Makefile b/testcases/kernel/syscalls/sendmsg/Makefile
index bd617d8..e69c726 100644
--- a/testcases/kernel/syscalls/sendmsg/Makefile
+++ b/testcases/kernel/syscalls/sendmsg/Makefile
@@ -20,4 +20,6 @@ top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 
+CPPFLAGS		+= -I$(abs_srcdir)/../utils
+
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/sendmsg/sendmsg01.c b/testcases/kernel/syscalls/sendmsg/sendmsg01.c
index 58d3364..1795a5e 100644
--- a/testcases/kernel/syscalls/sendmsg/sendmsg01.c
+++ b/testcases/kernel/syscalls/sendmsg/sendmsg01.c
@@ -30,20 +30,6 @@
  *	05/2003 Modified by Manoj Iyer - Make setup function set up lo device.
  */
 
-/*
- * The #ifndef code below is for 2.5 64-bit kernels, where
- * the MSG_CMSG_COMPAT flag must be 0 in order for the syscall
- * and this test to function correctly.
- */
-#ifndef MSG_CMSG_COMPAT
-#if defined(__powerpc64__) || defined(__mips64) || defined(__x86_64__) || \
-     defined(__sparc64__) || defined(__ia64__) || defined(__s390x__)
-#define MSG_CMSG_COMPAT 0x80000000
-#else
-#define MSG_CMSG_COMPAT 0
-#endif
-#endif /* MSG_CMSG_COMPAT */
-
 #include <stdio.h>
 #include <unistd.h>
 #include <errno.h>
@@ -63,6 +49,7 @@
 
 #include "test.h"
 #include "usctest.h"
+#include "msg_common.h"
 
 char *TCID = "sendmsg01";
 int testno;
diff --git a/testcases/kernel/syscalls/utils/msg_common.h b/testcases/kernel/syscalls/utils/msg_common.h
new file mode 100644
index 0000000..0471291
--- /dev/null
+++ b/testcases/kernel/syscalls/utils/msg_common.h
@@ -0,0 +1,38 @@
+/*
+ * Copyright (c) International Business Machines  Corp., 2001
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it would be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write the Free Software Foundation,
+ * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#ifndef LTP_MSG_COMMON
+#define LTP_MSG_COMMON
+
+/* The #ifndef code below is for 2.5 64-bit kernels, where     */
+/* the MSG_CMSG_COMPAT flag must be 0 in order for the syscall */
+/* and this test to function correctly.                        */
+#ifndef MSG_CMSG_COMPAT
+
+#if defined(__powerpc64__) || defined(__mips64) || defined(__x86_64__) || \
+	defined(__sparc64__) || defined(__ia64__) || defined(__s390x__)
+#define MSG_CMSG_COMPAT 0x80000000
+#else
+#define MSG_CMSG_COMPAT 0
+#endif
+
+#endif
+
+
+#endif /* LTP_MSG_COMMON */
-- 
1.7.1


------------------------------------------------------------------------------
"Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
Instantly run your Selenium tests across 300+ browser/OS combos.
Get unparalleled scalability from the best Selenium testing platform available
Simple to use. Nothing to install. Get started now for free."
http://p.sf.net/sfu/SauceLabs
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

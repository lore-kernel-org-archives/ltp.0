Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1YIctb-0001oU-3q
	for ltp-list@lists.sourceforge.net; Tue, 03 Feb 2015 12:47:59 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YIctZ-00044T-Pf
	for ltp-list@lists.sourceforge.net; Tue, 03 Feb 2015 12:47:59 +0000
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t13Clpkl005855
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Tue, 3 Feb 2015 07:47:51 -0500
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with
	ESMTP id t13ClonL006964
	for <ltp-list@lists.sourceforge.net>; Tue, 3 Feb 2015 07:47:50 -0500
From: Jan Stancek <jstancek@redhat.com>
Date: Tue,  3 Feb 2015 13:47:45 +0100
Message-Id: <71cb5b390704d5eeca9db095d599830577acbdff.1422967561.git.jstancek@redhat.com>
Subject: [LTP] [PATCH] sendmsg01: remove ".flags = ~MSG_CMSG_COMPAT" case
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

Testing sendmsg syscall with multiple flags can lead to undefined results,
depending on order in which these flags are processed.

Futher, this flag is defined by LTP in different way than it's defined
in kernel, which causes testcase to fail as it hits different check
in kernel for 64 and 32 bit testcase.

This patch removes the case entirely. And since this is the only place
using it, it removes msg_common.h, where it's defined as well.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/recvmsg/recvmsg01.c |    1 -
 testcases/kernel/syscalls/sendmsg/sendmsg01.c |   18 -----------
 testcases/kernel/syscalls/utils/msg_common.h  |   39 -------------------------
 3 files changed, 0 insertions(+), 58 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/utils/msg_common.h

diff --git a/testcases/kernel/syscalls/recvmsg/recvmsg01.c b/testcases/kernel/syscalls/recvmsg/recvmsg01.c
index 2964b26..d35f1fa 100644
--- a/testcases/kernel/syscalls/recvmsg/recvmsg01.c
+++ b/testcases/kernel/syscalls/recvmsg/recvmsg01.c
@@ -57,7 +57,6 @@
 
 #include "test.h"
 #include "usctest.h"
-#include "msg_common.h"
 
 char *TCID = "recvmsg01";
 int testno;
diff --git a/testcases/kernel/syscalls/sendmsg/sendmsg01.c b/testcases/kernel/syscalls/sendmsg/sendmsg01.c
index 0ae4bf8..2349385 100644
--- a/testcases/kernel/syscalls/sendmsg/sendmsg01.c
+++ b/testcases/kernel/syscalls/sendmsg/sendmsg01.c
@@ -49,7 +49,6 @@
 
 #include "test.h"
 #include "usctest.h"
-#include "msg_common.h"
 
 char *TCID = "sendmsg01";
 int testno;
@@ -305,23 +304,6 @@ struct test_case_t tdat[] = {
 	 .cleanup = cleanup4,
 	 .desc = "rights passing"}
 	,
-	{.domain = PF_UNIX,
-	 .type = SOCK_DGRAM,
-	 .proto = 0,
-	 .iov = iov,
-	 .iovcnt = 1,
-	 .buf = buf,
-	 .buflen = sizeof(buf),
-	 .msg = &msgdat,
-	 .flags = ~MSG_CMSG_COMPAT,
-	 .to = (struct sockaddr *)&sun1,
-	 .tolen = sizeof(sun1),
-	 .retval = -1,
-	 .experrno = EOPNOTSUPP,
-	 .setup = setup4,
-	 .cleanup = cleanup4,
-	 .desc = "invalid flags set w/ control"}
-	,
 	{.domain = PF_INET,
 	 .type = SOCK_DGRAM,
 	 .proto = 0,
diff --git a/testcases/kernel/syscalls/utils/msg_common.h b/testcases/kernel/syscalls/utils/msg_common.h
deleted file mode 100644
index 2ecd27e..0000000
--- a/testcases/kernel/syscalls/utils/msg_common.h
+++ /dev/null
@@ -1,39 +0,0 @@
-/*
- * Copyright (c) International Business Machines  Corp., 2001
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of
- * the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write the Free Software Foundation,
- * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
- */
-
-#ifndef LTP_MSG_COMMON
-#define LTP_MSG_COMMON
-
-/* The #ifndef code below is for 2.5 64-bit kernels, where     */
-/* the MSG_CMSG_COMPAT flag must be 0 in order for the syscall */
-/* and this test to function correctly.                        */
-#ifndef MSG_CMSG_COMPAT
-
-#if defined(__powerpc64__) || defined(__mips64) || defined(__x86_64__) || \
-	defined(__ia64__) || defined(__s390x__) || \
-	defined(__sparc__) && defined(__arch64__)
-#define MSG_CMSG_COMPAT 0x80000000
-#else
-#define MSG_CMSG_COMPAT 0
-#endif
-
-#endif
-
-
-#endif /* LTP_MSG_COMMON */
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

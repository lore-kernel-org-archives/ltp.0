Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jpalecek@web.de>) id 1MIZjM-0008Hh-RI
	for ltp-list@lists.sourceforge.net; Mon, 22 Jun 2009 02:58:00 +0000
Received: from fmmailgate03.web.de ([217.72.192.234])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MIZjL-0003QK-Ai
	for ltp-list@lists.sourceforge.net; Mon, 22 Jun 2009 02:58:00 +0000
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate03.web.de (Postfix) with ESMTP id 78F23100C5B74
	for <ltp-list@lists.sourceforge.net>;
	Mon, 22 Jun 2009 02:38:02 +0200 (CEST)
Received: from [83.208.36.163] (helo=debian)
	by smtp06.web.de with asmtp (WEB.DE 4.110 #277) id 1MIXXu-0006m4-00
	for ltp-list@lists.sourceforge.net; Mon, 22 Jun 2009 02:38:02 +0200
Date: Fri, 19 Jun 2009 16:14:26 +0200
From: "Jiri Palecek >" <"<jirka"@suse.de>(none)
MIME-Version: 1.0
Resent-To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>
Resent-Message-ID: <op.uvwhh1wwlwynca@debian>
Subject: [LTP] [PATCH] Adapt the cgroup/test_6_2 test to the various ways
 clone is called on different architectures
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
Sender: ltp-list-bounces@lists.sourceforge.net
Errors-To: ltp-list-bounces@lists.sourceforge.net
Cc: ltp-list@lists.sourceforge.net
Message-ID: <20090619141426.9Lba_oLJxmmRd252itNSTS1s6Dww5Alc7j1e2Pf4UBk@z>

 Code shamelessly taken from clone01 test

Signed-off-by: Jiri Palecek <jpalecek@web.de>
---
 .../kernel/controllers/cgroup/clone_platform.h     |   34 ++++++++++++++++++++
 testcases/kernel/controllers/cgroup/test_6_2.c     |   12 ++++++-
 2 files changed, 45 insertions(+), 1 deletions(-)
 create mode 100644 testcases/kernel/controllers/cgroup/clone_platform.h

diff --git a/testcases/kernel/controllers/cgroup/clone_platform.h b/testcases/kernel/controllers/cgroup/clone_platform.h
new file mode 100644
index 0000000..1785dd1
--- /dev/null
+++ b/testcases/kernel/controllers/cgroup/clone_platform.h
@@ -0,0 +1,34 @@
+/*
+ * Copyright (c) 2003 Silicon Graphics, Inc.  All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it would be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write the Free Software Foundation, Inc., 59
+ * Temple Place - Suite 330, Boston MA 02111-1307, USA.
+ *
+ */
+/* Common platform specific defines for the clone system call tests */
+
+//#define CHILD_STACK_SIZE 8192
+#define CHILD_STACK_SIZE 16384
+
+#if defined (__s390__) || (__s390x__)
+#define clone __clone
+extern int __clone(int(void*),void*,int,void*);
+#elif defined(__ia64__)
+#define clone2 __clone2
+/* Prototype provided by David Mosberger				*/
+/* int  __clone2(int (*fn) (void *arg), void *child_stack_base,		*/
+/* 		size_t child_stack_size, int flags, void *arg,		*/
+/*		pid_t *parent_tid, void *tls, pid_t *child_tid)		*/
+extern int  __clone2(int (*fn) (void *arg), void *child_stack_base, 
+		size_t child_stack_size, int flags, void *arg, 
+		pid_t *parent_tid, void *tls, pid_t *child_tid); 
+#endif
diff --git a/testcases/kernel/controllers/cgroup/test_6_2.c b/testcases/kernel/controllers/cgroup/test_6_2.c
index e5bddb2..79f5c20 100644
--- a/testcases/kernel/controllers/cgroup/test_6_2.c
+++ b/testcases/kernel/controllers/cgroup/test_6_2.c
@@ -24,6 +24,8 @@
 #include <unistd.h>
 #include <sched.h>
 
+#include "clone_platform.h"
+
 #define DEFAULT_USEC	30000
 
 int foo(void __attribute__((unused)) *arg)
@@ -42,7 +44,15 @@ int main(int argc, char **argv)
 
 	while (1) {
 		usleep(usec);
-		clone(foo, stack+4096, CLONE_NEWNS, NULL);
+#if defined(__hppa__)
+		clone(foo, stack, CLONE_NEWNS, NULL);
+#elif defined(__ia64__)
+		clone2(foo, stack,
+			    4096, CLONE_NEWNS, NULL, NULL, NULL, NULL);
+#else
+		clone
+		     (foo, stack + 4096, CLONE_NEWNS, NULL);
+#endif
 	}
 
 	return 0;
-- 
1.6.3.1




------------------------------------------------------------------------------
Are you an open source citizen? Join us for the Open Source Bridge conference!
Portland, OR, June 17-19. Two days of sessions, one day of unconference: $250.
Need another reason to go? 24-hour hacker lounge. Register today!
http://ad.doubleclick.net/clk;215844324;13503038;v?http://opensourcebridge.org
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

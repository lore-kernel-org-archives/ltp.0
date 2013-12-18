Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1VtDS9-0007X0-C9
	for ltp-list@lists.sourceforge.net; Wed, 18 Dec 2013 09:30:05 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VtDS7-0006ls-PN
	for ltp-list@lists.sourceforge.net; Wed, 18 Dec 2013 09:30:05 +0000
Message-ID: <1387358991.1664.37.camel@G08JYZSD130126>
From: "zenglg.jy" <zenglg.jy@cn.fujitsu.com>
Date: Wed, 18 Dec 2013 17:29:51 +0800
Mime-Version: 1.0
Subject: [LTP] [PATCH v5 1/2] lib/cloner.c: add more args
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

add args with ptid and ctid in ltp_clone().

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 include/test.h |  2 +-
 lib/cloner.c   | 20 ++++++++++++++++----
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/include/test.h b/include/test.h
index 94fc721..ffc1c8c 100644
--- a/include/test.h
+++ b/include/test.h
@@ -200,7 +200,7 @@ int self_exec(char *argv0, char *fmt, ...);
 
 /* Functions from lib/cloner.c */
 int ltp_clone(unsigned long clone_flags, int (*fn)(void *arg), void *arg,
-		size_t stack_size, void *stack);
+		size_t stack_size, void *stack, ...);
 int ltp_clone_malloc(unsigned long clone_flags, int (*fn)(void *arg),
 		void *arg, size_t stacksize);
 int ltp_clone_quick(unsigned long clone_flags, int (*fn)(void *arg),
diff --git a/lib/cloner.c b/lib/cloner.c
index a68ff1e..93e3f8c 100644
--- a/lib/cloner.c
+++ b/lib/cloner.c
@@ -27,6 +27,7 @@
 #include <string.h>
 #include <stdlib.h>
 #include <sched.h>
+#include <stdarg.h>
 #include "test.h"
 
 #undef clone			/* we want to use clone() */
@@ -50,20 +51,31 @@ extern int __clone2(int (*fn) (void *arg), void *child_stack_base,
  */
 int
 ltp_clone(unsigned long clone_flags, int (*fn) (void *arg), void *arg,
-	  size_t stack_size, void *stack)
+	  size_t stack_size, void *stack, ...)
 {
 	int ret;
+	pid_t *parent_tid, *child_tid;
+	void *tls;
+	va_list arg_clone;
+
+	va_start(arg_clone, stack);
+	parent_tid = va_arg(arg_clone, pid_t *);
+	tls = va_arg(arg_clone, void *);
+	child_tid = va_arg(arg_clone, pid_t *);
+	va_end(arg_clone);
 
 #if defined(__hppa__) || defined(__metag__)
-	ret = clone(fn, stack, clone_flags, arg);
+	ret = clone(fn, stack, clone_flags, arg, parent_tid, tls, child_tid);
 #elif defined(__ia64__)
-	ret = clone2(fn, stack, stack_size, clone_flags, arg, NULL, NULL, NULL);
+	ret = clone2(fn, stack, stack_size, clone_flags, arg,
+		     parent_tid, tls, child_tid);
 #else
 	/*
 	 * For archs where stack grows downwards, stack points to the topmost
 	 * address of the memory space set up for the child stack.
 	 */
-	ret = clone(fn, (stack ? stack + stack_size : NULL), clone_flags, arg);
+	ret = clone(fn, (stack ? stack + stack_size : NULL), clone_flags, arg,
+		    parent_tid, tls, child_tid);
 #endif
 
 	return ret;
-- 
1.8.2.1




------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349831&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

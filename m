Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1MlMLO-0000U5-Dg
	for ltp-list@lists.sourceforge.net; Wed, 09 Sep 2009 12:32:14 +0000
Date: Wed, 9 Sep 2009 14:31:10 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20090909123110.GA5751@schrodinger.suse.cz>
References: <20090831174107.GB30788@schrodinger.suse.cz>
	<1252324203.4922.37.camel@subratamodak.linux.ibm.com>
	<20090907160222.GA29017@schrodinger.suse.cz>
	<200909072235.00963.vapier@gentoo.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline
In-Reply-To: <200909072235.00963.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH] broken epoll Makefile
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Mike Frysinger <vapier@gentoo.org>
Cc: ltp-list@lists.sourceforge.net


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!
> the _GNU_SOURCE change shouldnt be in there (existing style is correct)

I don't like adding spaces between # and keyword but changed back as you wish.
 
> the fall back error should be TCONF, and it shouldnt say "epoll library" as 
> there is no such thing.  a better message might be "no epoll support found".

Okay.

Fixed patch attached.

Signed-off-by: Cyril Hrubis chrubis@suse.cz

-- 
Cyril Hrubis
chrubis@suse.cz

--NzB8fVQJ5HfG6fxh
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="configure_epoll.patch"

Index: ltp/configure.ac
===================================================================
--- ltp.orig/configure.ac
+++ ltp/configure.ac
@@ -13,6 +13,7 @@ AC_CHECK_HEADERS_ONCE([ \
 ifaddrs.h \
 sys/capability.h \
 sys/inotify.h \
+sys/epoll.h \
 ])
 
 LTP_CHECK_SYSCALL_EVENTFD
Index: ltp/testcases/kernel/syscalls/epoll/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/epoll/Makefile
+++ ltp/testcases/kernel/syscalls/epoll/Makefile
@@ -19,14 +19,6 @@
 CFLAGS += -I../../../../include -Wall
 LDLIBS += -L../../../../lib -lltp
 
-LIBC_HAS_EPOLL := $(shell echo '\#include <sys/epoll.h>' | $(CC) -E - > /dev/null 2>&1 && echo yes)
-ifeq ($(LIBC_HAS_EPOLL),yes)
-CFLAGS += -DLTP_EPOLL_USE_SYS_LIBC
-else
-CFLAGS += -I. -DLTP_EPOLL_USE_LIB
-LDLIBS += -lepoll
-endif
-
 SRCS    = $(wildcard *.c)
 TARGETS = $(patsubst %.c,%,$(SRCS))
 
Index: ltp/testcases/kernel/syscalls/epoll/epoll-ltp.c
===================================================================
--- ltp.orig/testcases/kernel/syscalls/epoll/epoll-ltp.c
+++ ltp/testcases/kernel/syscalls/epoll/epoll-ltp.c
 
@@ -95,14 +95,15 @@
 #include <sys/select.h>
 #include <sys/wait.h>
 
-#ifdef LTP_EPOLL_USE_LIB
-# include <epoll.h>
-#else
-# include <sys/epoll.h>
-#endif
-
-/* Harness Specific Include Files. */
+#include "config.h"
 #include "test.h"
+
+char *TCID = "sys_epoll02";	/* test program identifier */
+int TST_TOTAL = 1;		/* total number of tests in this file */
+
+#ifdef HAVE_SYS_EPOLL_H
+
+#include <sys/epoll.h>
 #include "usctest.h"
 
 /* Local Defines */
@@ -114,11 +115,6 @@
 #define NUM_RAND_ATTEMPTS 16
 #define BACKING_STORE_SIZE_HINT 32
 
-/* Dummy function for tst_brk* */
-extern void cleanup(void)
-{
-}
-
 /*
   Define the beginning of a "protected region".
   This is a region where a wide variety of errors
@@ -202,9 +198,6 @@ kid_status = kid_status;})
 extern int Tst_count;		/* counter for tst_xxx routines */
 extern char *TESTDIR;		/* temporary dir created by tst_tmpdir() */
 
-/* Global Variables */
-char *TCID = "sys_epoll02";	/* test program identifier */
-int TST_TOTAL = 1;		/* total number of tests in this file */
 
 /*
  * Given the number of random size requests to test,
@@ -367,7 +360,7 @@ static const char *result_strings[] = {
 	if (ev_ptr != NULL){ \
 		tst_resm(TFAIL, ( "(epoll_ctl(%d,%08x,%d,%p = {%08x,%08d}) returned %d:%s)" ) , ##__VA_ARGS__ , \
 			epoll_fds[epfd_index], epoll_ctl_ops[op_index], \
-			epoll_fds[fd_index], ev_ptr, ev_ptr->events, ev_ptr->data, errno, \
+			epoll_fds[fd_index], ev_ptr, ev_ptr->events, ev_ptr->data.fd, errno, \
 			strerror(errno)); \
 	} else { \
 		tst_resm(TFAIL, ( "(epoll_ctl(%d,%08x,%d,%p) returned %d:%s)" ) , ##__VA_ARGS__  , \
@@ -381,7 +374,7 @@ static const char *result_strings[] = {
 	if (ev_ptr != NULL){ \
 		tst_resm(TPASS, ( "(epoll_ctl(%d,%08x,%d,%p = {%08x,%08d}) returned %d:%s)" ) , ##__VA_ARGS__ , \
 			epoll_fds[epfd_index], epoll_ctl_ops[op_index], \
-			epoll_fds[fd_index], ev_ptr, ev_ptr->events, ev_ptr->data, errno, \
+			epoll_fds[fd_index], ev_ptr, ev_ptr->events, ev_ptr->data.fd, errno, \
 			strerror(errno)); \
 	} else { \
 		tst_resm(TPASS, ( "(epoll_ctl(%d,%08x,%d,%p) returned %d:%s)" ) , ##__VA_ARGS__  , \
@@ -390,8 +383,8 @@ static const char *result_strings[] = {
 	} \
 })
 #else
-#define EPOLL_CTL_TEST_FAIL(msg , ...) tst_resm(TFAIL, (const char*)(msg) , ##__VA_ARGS__)
-#define EPOLL_CTL_TEST_PASS(msg , ...) tst_resm(TPASS, (const char*)(msg) , ##__VA_ARGS__)
+#define EPOLL_CTL_TEST_FAIL(msg , ...) tst_resm(TFAIL, msg , ##__VA_ARGS__)
+#define EPOLL_CTL_TEST_PASS(msg , ...) tst_resm(TPASS, msg , ##__VA_ARGS__)
 #endif
 
 /****************************************************************************************/
@@ -642,12 +635,6 @@ int test_epoll_ctl(int epoll_fd)
 						} else	/* The call of epoll_ctl behaved as expected */
 							EPOLL_CTL_TEST_PASS((result_strings
 									     [result]));
-
-/* Just to be safe, undefine our macros */
-#undef EPOLL_CTL_TEST_FAIL
-#undef EPOLL_CTL_TEST_PASS
-#undef PROTECT_REGION_BEGIN
-#undef PROTECT_REGION_END
 					}
 				}
 			}
@@ -673,7 +660,7 @@ int main(int argc, char **argv)
 
 	/* Get the current time */
 	if (gettimeofday(&tv, NULL) != 0) {
-		tst_brkm(TBROK, cleanup, "gettimeofday failed");
+		tst_brkm(TBROK, NULL, "gettimeofday failed");
 		tst_exit();
 	} else {
 		tst_resm(TINFO, "gettimeofday() works");
@@ -704,3 +691,13 @@ int main(int argc, char **argv)
 
 	return 0;
 }
+
+#else
+
+int main(void)
+{
+	tst_resm(TCONF, "No epoll support found.");
+	tst_exit();
+}
+
+#endif

--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--NzB8fVQJ5HfG6fxh--


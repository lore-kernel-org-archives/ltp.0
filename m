Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jpalecek@web.de>) id 1MqoKp-0003Cw-CQ
	for ltp-list@lists.sourceforge.net; Thu, 24 Sep 2009 13:26:11 +0000
Received: from fmmailgate03.web.de ([217.72.192.234])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MqoKj-0007Ln-NN
	for ltp-list@lists.sourceforge.net; Thu, 24 Sep 2009 13:26:11 +0000
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate03.web.de (Postfix) with ESMTP id 069E011A105F9
	for <ltp-list@lists.sourceforge.net>;
	Thu, 24 Sep 2009 15:23:31 +0200 (CEST)
Received: from [83.208.36.163] (helo=debian)
	by smtp07.web.de with asmtp (WEB.DE 4.110 #314) id 1MqoIE-0005PI-00
	for ltp-list@lists.sourceforge.net; Thu, 24 Sep 2009 15:23:30 +0200
Date: Wed, 08 Jul 2009 16:34:29 +0200
From: "Jiri Palecek" <jpalecek@web.de>
MIME-Version: 1.0
Resent-To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>
Resent-Message-ID: <op.u0rjhxhlcfnueu@debian>
Subject: [LTP] [PATCH] Add a count parameter to create_sig_proc
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
Message-ID: <20090708143429.vcqTMHPg3apSYXXkH5HjmEbazrub0jtSAX-htRcPqbw@z>

Hello,

there were complaints about some tests (ppoll01) hanging sometimes. I've created this patch to address the issue.

 This should allow testing inherently racy conditions, such as a
 syscall returning EINTR upon signal handler execution. The problem
 here is that the signal could actually arrive before the syscall gets
 executed, which results in the test waiting for it forever. The
 solution is adding a parameter that would allow to specify how much
 signals a particular test expects - a racy test would ask for a large
 number of signals sent, so it will get one even if some were
 missed. Tests, which test behavior, which is not racy
 (eg. pselect()) should only request a single signal.

 Note that you need to manually kill the child process delivering the
 signals when you don't need them, if you ordered more signals than
 you actually handle.

 Also, this patch resets signal handling in child process created in
 create_sig_proc. This should avoid the child calling the parent's
 signal handlers and interfering with parent's cleanup process.

Regards
    Jiri Palecek

Signed-off-by: Jiri Palecek <jpalecek@web.de>
---
 .../syscalls/clock_nanosleep/clock_nanosleep01.c   |    4 +-
 .../syscalls/mq_timedreceive/mq_timedreceive01.c   |    4 +-
 .../kernel/syscalls/mq_timedsend/mq_timedsend01.c  |    4 +-
 testcases/kernel/syscalls/ppoll/ppoll01.c          |    2 +-
 testcases/kernel/syscalls/utils/common_j_h.c       |   34 ++++++++++++++++---
 testcases/kernel/syscalls/utils/include_j_h.h      |    2 +-
 6 files changed, 36 insertions(+), 14 deletions(-)

diff --git a/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c b/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c
index ece479a..444a5a4 100644
--- a/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c
+++ b/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c
@@ -285,8 +285,8 @@ static int do_test(struct test_case *tc)
          * Check before sleep time
          */
         if (tc->ttype == SEND_SIGINT) {
-                TEST(pid = create_sig_proc(500000, SIGINT));
-                if (TEST_RETURN < 0)
+                pid = create_sig_proc(500000, SIGINT, UINT_MAX);
+                if (pid < 0)
                         return 1;
         }
 
diff --git a/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c b/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c
index d6604d7..2d41a48 100644
--- a/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c
+++ b/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c
@@ -350,8 +350,8 @@ switch (tc->ttype) {
                 }
 
 		 if (tc->ttype == SEND_SIGINT) {
-                        TEST(pid = create_sig_proc(200000, SIGINT));
-                        if (TEST_RETURN < 0) {
+                        pid = create_sig_proc(200000, SIGINT, UINT_MAX);
+                        if (pid < 0) {
                                 result = 1;
                                 goto EXIT;
                         }
diff --git a/testcases/kernel/syscalls/mq_timedsend/mq_timedsend01.c b/testcases/kernel/syscalls/mq_timedsend/mq_timedsend01.c
index fee1a7f..b2cc7fc 100644
--- a/testcases/kernel/syscalls/mq_timedsend/mq_timedsend01.c
+++ b/testcases/kernel/syscalls/mq_timedsend/mq_timedsend01.c
@@ -351,8 +351,8 @@ static int do_test(struct test_case *tc)
                                 }
                         }
 			if (tc->ttype == SEND_SIGINT) {
-                                TEST(pid = create_sig_proc(200000, SIGINT));
-                                if (TEST_RETURN < 0) {
+                                pid = create_sig_proc(200000, SIGINT, UINT_MAX);
+                                if (pid < 0) {
                                         result = 1;
                                         goto EXIT;
                                 }
diff --git a/testcases/kernel/syscalls/ppoll/ppoll01.c b/testcases/kernel/syscalls/ppoll/ppoll01.c
index 1d96e04..a04935c 100644
--- a/testcases/kernel/syscalls/ppoll/ppoll01.c
+++ b/testcases/kernel/syscalls/ppoll/ppoll01.c
@@ -302,7 +302,7 @@ static int do_test(struct test_case *tc)
                 // fallthrough
 	case SEND_SIGINT:
                 nfds = 0;
-                TEST(pid = create_sig_proc(100000, SIGINT)); // 100msec
+                pid = create_sig_proc(100000, SIGINT, UINT_MAX); // 100msec
                 if (pid < 0)
                         return 1;
                 break;
diff --git a/testcases/kernel/syscalls/utils/common_j_h.c b/testcases/kernel/syscalls/utils/common_j_h.c
index 2b90cad..c460d85 100644
--- a/testcases/kernel/syscalls/utils/common_j_h.c
+++ b/testcases/kernel/syscalls/utils/common_j_h.c
@@ -37,7 +37,18 @@
 #include <errno.h>
 #include <mqueue.h>
 #include "include_j_h.h"
-
+#include "test.h"
+
+#define barrier() __asm__ __volatile__("": : :"memory")
+#define WITH_SIGNALS_BLOCKED(code) {											\
+		sigset_t held_sigs_;																	\
+		sigfillset(&held_sigs_);															\
+		sigprocmask(SIG_SETMASK, &held_sigs_, &held_sigs_);	\
+		barrier(); \
+		code;																									\
+		barrier(); \
+		sigprocmask(SIG_SETMASK, &held_sigs_, NULL);					\
+	}
 
 /*
  * Change user ID
@@ -97,20 +108,31 @@ int cleanup_euid(uid_t old_uid)
 	return 0;
 }
 
-
+static void sigterm_handler(int sig)
+{
+	_exit(0);
+}
 /*
  * Generate a child process which will send a signal
  */
-pid_t create_sig_proc(unsigned long usec, int sig)
+pid_t create_sig_proc(unsigned long usec, int sig, unsigned count)
 {
 	pid_t pid, cpid;
 
 	pid = getpid();
-	cpid = fork();
+	WITH_SIGNALS_BLOCKED(
+			if((cpid = fork()) == 0) {
+				tst_sig(NOFORK, SIG_DFL, NULL);
+				signal(SIGTERM, sigterm_handler);
+			}
+	);
 	switch (cpid) {
 	case 0:
-		usleep(usec);
-		kill(pid, sig);
+		while(count-- > 0) {
+			usleep(usec);
+			if(kill(pid, sig) == -1)
+				break;
+		}
 		_exit(0);
 		break;
 	case -1:
diff --git a/testcases/kernel/syscalls/utils/include_j_h.h b/testcases/kernel/syscalls/utils/include_j_h.h
index 571b541..0123a3f 100644
--- a/testcases/kernel/syscalls/utils/include_j_h.h
+++ b/testcases/kernel/syscalls/utils/include_j_h.h
@@ -137,7 +137,7 @@ int setup_uid(char *uname);
 int setup_euid(char *uname, uid_t *old_uid);
 int cleanup_euid(uid_t old_uid);
 
-pid_t create_sig_proc(unsigned long usec, int sig);
+pid_t create_sig_proc(unsigned long usec, int sig, unsigned count);
 
 int _setup_file(char *testdir, char *fname, char *path, int flags, mode_t mode);
 int setup_file(char *testdir, char *fname, char *path);
-- 
1.6.4.3




------------------------------------------------------------------------------
Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#33;
http://p.sf.net/sfu/devconf
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jpalecek@web.de>) id 1MqpJn-0007US-R0
	for ltp-list@lists.sourceforge.net; Thu, 24 Sep 2009 14:29:11 +0000
Received: from fmmailgate03.web.de ([217.72.192.234])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MqpJg-0001zj-5z
	for ltp-list@lists.sourceforge.net; Thu, 24 Sep 2009 14:29:11 +0000
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate03.web.de (Postfix) with ESMTP id A8813119F9A58
	for <ltp-list@lists.sourceforge.net>;
	Thu, 24 Sep 2009 15:30:32 +0200 (CEST)
Received: from [83.208.36.163] (helo=debian)
	by smtp08.web.de with asmtp (WEB.DE 4.110 #314) id 1MqoP2-00012Q-00
	for ltp-list@lists.sourceforge.net; Thu, 24 Sep 2009 15:30:32 +0200
Date: Thu, 30 Jul 2009 12:17:10 +0200
From: "Jiri Palecek" <jpalecek@web.de>
MIME-Version: 1.0
Resent-To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>
Resent-Message-ID: <op.u0rjtluacfnueu@debian>
Subject: [LTP] [PATCH] Add a test for race-free operation of ppoll
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
Message-ID: <20090730101710.jYfL0XwSX6RM9cgPCbgFIXvIUN52dQLzvt9_NSkcwf8@z>

Hello,

after the previous patch, this patch adds a test to test a use of ppoll() without races (ie. the intended use of ppoll). It blocks the signal, schedules a signal to be delivered and expects ppoll to return EINTR (and never lose the signal.

Regards
    Jiri Palecek

Signed-off-by: Jiri Palecek <jpalecek@web.de>
---
 testcases/kernel/syscalls/ppoll/ppoll01.c |   53 ++++++++++++++++++++++++++--
 1 files changed, 49 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/ppoll/ppoll01.c b/testcases/kernel/syscalls/ppoll/ppoll01.c
index a04935c..507eddc 100644
--- a/testcases/kernel/syscalls/ppoll/ppoll01.c
+++ b/testcases/kernel/syscalls/ppoll/ppoll01.c
@@ -155,6 +155,7 @@ enum test_type {
         TIMEOUT,
         FD_ALREADY_CLOSED,
         SEND_SIGINT,
+        SEND_SIGINT_RACE_TEST,
         INVALID_NFDS,
         INVALID_FDS,
         MINUS_NSEC,
@@ -219,22 +220,27 @@ static struct test_case tcase[] = {
                 .err            = EINTR,
         },
         { // case05
+                .ttype          = SEND_SIGINT_RACE_TEST,
+                .ret            = -1,
+                .err            = EINTR,
+        },
+        { // case06
                 .ttype          = INVALID_NFDS,
                 .ret            = -1,
                 .err            = EINVAL,
         },
-        { // case06
+        { // case07
                 .ttype          = INVALID_FDS,
                 .ret            = -1,
                 .err            = EFAULT,
         },
 #if 0
-        { // case07
+        { // case08
                 .ttype          = MINUS_NSEC,
                 .ret            = -1,
                 .err            = EINVAL, // RHEL4U1 + 2.6.18 returns SUCCESS
         },
-        { // case08
+        { // case09
                 .ttype          = TOO_LARGE_NSEC,
                 .ret            = -1,
                 .err            = EINVAL, // RHEL4U1 + 2.6.18 returns SUCCESS
@@ -306,6 +312,29 @@ static int do_test(struct test_case *tc)
                 if (pid < 0)
                         return 1;
                 break;
+  case SEND_SIGINT_RACE_TEST:
+    /* block the INT signal */
+                sigemptyset(&sigmask);
+                sigaddset(&sigmask, SIGINT);
+                sigprocmask(SIG_SETMASK, &sigmask, NULL);
+
+                /* and let it be unblocked when the syscall runs */
+                sigemptyset(&sigmask);
+                p_sigmask = &sigmask;
+                //sigsetsize = sizeof(sigmask);
+                sigsetsize = 8;
+                nfds = 0;
+                ts.tv_sec = 0;
+                ts.tv_nsec = 300000000; // 300msec => need to be enough for
+                                        //   waiting the signal
+                p_ts = &ts;
+                nfds = 0;
+                pid = create_sig_proc(0, SIGINT, 1);
+                if (pid < 0) {
+                  result=1;
+                  goto cleanup;
+                }
+                break;
         case INVALID_NFDS:
                 //nfds = RLIMIT_NOFILE + 1; ==> RHEL4U1 + 2.6.18 returns SUCCESS
                 nfds = -1;
@@ -344,12 +373,28 @@ TEST_END:
         /*
          * Check results
          */
+        if(tc->ttype == SEND_SIGINT_RACE_TEST) {
+          int sig;
+          sigprocmask(SIG_SETMASK, NULL, &sigmask);
+          for(sig=1; sig < SIGRTMAX; sig++) {
+              TEST(sigismember(&sigmask, sig));
+              if(TEST_RETURN < 0 && TEST_ERRNO == EINVAL && sig != SIGINT)
+                continue; /* let's ignore errors if they are for other signal than SIGINT that we set */
+              if((sig==SIGINT) != (TEST_RETURN!=0)) {
+                tst_resm(TFAIL, "Bad value of signal mask, signal %d is %s", sig, TEST_RETURN ? "on" : "off");
+                cmp_ok |=1;
+              }
+            }
+        }
         result |= (sys_errno != tc->err) || !cmp_ok;
         PRINT_RESULT_CMP(sys_ret >= 0, tc->ret, tc->err, sys_ret, sys_errno,
                          cmp_ok);
-
+ cleanup:
         if (fd >= 0)
                 cleanup_file(fpath);
+
+        sigemptyset(&sigmask);
+        sigprocmask(SIG_SETMASK, &sigmask, NULL);
         if (pid > 0) {
                 int st;
                 kill(pid, SIGTERM);
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

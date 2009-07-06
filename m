Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jpalecek@web.de>) id 1MO852-00010C-Ao
	for ltp-list@lists.sourceforge.net; Tue, 07 Jul 2009 10:39:20 +0000
Received: from fmmailgate01.web.de ([217.72.192.221])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MO84v-0004nw-VY
	for ltp-list@lists.sourceforge.net; Tue, 07 Jul 2009 10:39:20 +0000
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate01.web.de (Postfix) with ESMTP id 4A1DF108D1FE1
	for <ltp-list@lists.sourceforge.net>;
	Tue,  7 Jul 2009 12:15:59 +0200 (CEST)
Received: from [83.208.36.163] (helo=debian)
	by smtp08.web.de with asmtp (WEB.DE 4.110 #277) id 1MO7iQ-00062t-00
	for ltp-list@lists.sourceforge.net; Tue, 07 Jul 2009 12:15:58 +0200
Date: Tue, 07 Jul 2009 01:29:27 +0200
From: "Jiri Palecek" <jpalecek@web.de>
MIME-Version: 1.0
Resent-To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>
Resent-Message-ID: <op.uwo0ahd0cfnueu@debian>
Subject: [LTP] [PATCH] Fix failures of the clock_nanosleep01 test
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
Message-ID: <20090706232927.LaXtIbXtoyCS2STwHdV4hk3js9kP4zJxXZjfgS0ltCU@z>

 The failures were caused by strange interpretation of POSIX by the test:

  - POSIX says CLOCK_THREAD_CPUTIME_ID is an invalid value for the
    clock_id parameter, and results in an EINVAL

  - POSIX doesn't specify that the remaining time should be set in any
    way (eg. zeroed) on successful completion

Also, the test deletes some of the superfluous uses of the TEST macro.

Signed-off-by: Jiri Palecek <jpalecek@web.de>
---
 .../syscalls/clock_nanosleep/clock_nanosleep01.c   |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c b/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c
index 603201c..3c17a5c 100644
--- a/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c
+++ b/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c
@@ -211,7 +211,7 @@ static struct test_case tcase[] = {
                 .flags          = 0,
                 .sec            = 0,
                 .nsec           = 500000000, // 500msec
-                .ret            = ENOTSUP, // RHEL4U1 + 2.6.18 returns EINVAL
+                .ret            = EINVAL, // RHEL4U1 + 2.6.18 returns EINVAL
                 .err            = 0,
         },
         { // case05
@@ -256,8 +256,8 @@ static int chk_difftime(struct timespec *bef, struct timespec *aft,
                 t.tv_sec -= 1;
                 t.tv_nsec += 1000000000;
         }
-        TEST(expect = (sec * 1000) + (nsec / 1000000));
-        TEST(result = (t.tv_sec * 1000) + (t.tv_nsec / 1000000));
+        expect = (sec * 1000) + (nsec / 1000000);
+        result = (t.tv_sec * 1000) + (t.tv_nsec / 1000000);
         tst_resm(TINFO,"check sleep time: (min:%ld) < %ld < (max:%ld) (msec)",expect - MAX_MSEC_DIFF, result, expect + MAX_MSEC_DIFF);
         if (result < expect - MAX_MSEC_DIFF || result > expect + MAX_MSEC_DIFF)
                 return -1;
@@ -331,7 +331,7 @@ TEST_END:
         if (tc->ttype == NORMAL || tc->ttype == SEND_SIGINT) {
                 tst_resm(TINFO,"remain time: %ld %ld", rm.tv_sec, rm.tv_nsec);
                 if (tc->ttype == NORMAL)
-                        remain_ok = rm.tv_sec == 0 && rm.tv_nsec == 0;
+                        remain_ok = 1;
                 else
                         remain_ok = rm.tv_sec != 0 || rm.tv_nsec != 0;
         }
-- 
1.6.3.3




------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have 
the opportunity to enter the BlackBerry Developer Challenge. See full prize 
details at: http://p.sf.net/sfu/blackberry
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

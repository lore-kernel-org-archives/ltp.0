Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jpalecek@web.de>) id 1MujSO-00044i-94
	for ltp-list@lists.sourceforge.net; Mon, 05 Oct 2009 09:02:12 +0000
Received: from fmmailgate02.web.de ([217.72.192.227])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MujSG-0000Al-H2
	for ltp-list@lists.sourceforge.net; Mon, 05 Oct 2009 09:02:12 +0000
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate02.web.de (Postfix) with ESMTP id 482B212965E44
	for <ltp-list@lists.sourceforge.net>;
	Mon,  5 Oct 2009 11:01:58 +0200 (CEST)
Received: from [83.208.36.163] (helo=debian)
	by smtp05.web.de with asmtp (WEB.DE 4.110 #314) id 1MujS8-0000YP-00
	for ltp-list@lists.sourceforge.net; Mon, 05 Oct 2009 11:01:56 +0200
Date: Sat, 11 Jul 2009 22:17:35 +0200
From: "Jiri Palecek" <jpalecek@web.de>
MIME-Version: 1.0
Resent-To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>
Resent-Message-ID: <op.u1bkq8f8cfnueu@debian>
Subject: [LTP] [PATCH] Add tests for utimes() with NULL tv
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
Message-ID: <20090711201735.018_l6VKtghIWuhOM7g91ftsvbZCcC75BIsF-K6v-As@z>

Hello,

this adds some test cases for utimes(), among those one that actually should return EACCESS.

Regards
    Jiri Palecek

Signed-off-by: Jiri Palecek <jpalecek@web.de>
---
 testcases/kernel/syscalls/utimes/utimes01.c |   41 ++++++++++++++++++++------
 1 files changed, 31 insertions(+), 10 deletions(-)

diff --git a/testcases/kernel/syscalls/utimes/utimes01.c b/testcases/kernel/syscalls/utimes/utimes01.c
index 2fddb99..370db5c 100644
--- a/testcases/kernel/syscalls/utimes/utimes01.c
+++ b/testcases/kernel/syscalls/utimes/utimes01.c
@@ -159,6 +159,7 @@ enum test_type {
 		NORMAL,
 		FILE_NOT_EXIST,
 	        NO_FNAME,
+         NULL_TIMES
 };
 
 
@@ -226,6 +227,19 @@ static struct test_case tcase[] = {
                 .ret            = -1,
                 .err            = EFAULT,
         },
+        { // case05
+                .ttype          = NULL_TIMES,
+                .a_sec          = 1000,
+                .m_sec          = 2000,
+                .user           = "nobody",
+                .ret            = -1,
+                .err            = EACCES
+        },
+	{ // case06
+                .ttype          = NULL_TIMES,
+                .ret            = 0,
+                .err            = 0,
+        },
 };
 
 /*
@@ -265,7 +279,8 @@ static int do_test(struct test_case *tc)
                 fpath=FNAME_NX;
         }
         errno = 0;
-        if (tc->ttype == NO_FNAME) {
+        switch(tc->ttype) {
+        case NO_FNAME:
                 /**
                  * Note (garrcoop):
                  *
@@ -276,12 +291,17 @@ static int do_test(struct test_case *tc)
                  **/
                 const char *dummy = NULL;
                 TEST(sys_ret = utimes(dummy, tv));
+                break;
+        case NULL_TIMES:
+                TEST(utimes(fpath, NULL));
+                gettimeofday(tv, NULL);
+                tv[1]=tv[0];
+                break;
+        default:
+                TEST(utimes(fpath, tv));
+                break;
         }
-	else
-                TEST(sys_ret = utimes(fpath, tv));
-        sys_errno = errno;
-        if (sys_ret < 0)
-                goto TEST_END;
+        if(TEST_RETURN == 0) {
 
 	/*
          * Check test file's time stamp
@@ -293,14 +313,15 @@ static int do_test(struct test_case *tc)
                 goto EXIT1;
         }
         tst_resm(TINFO,"E:%ld,%ld <=> R:%ld,%ld",tv[0].tv_sec, tv[1].tv_sec, st.st_atime, st.st_mtime);
-        cmp_ok = st.st_atime == tv[0].tv_sec && st.st_mtime == tv[1].tv_sec;
+        cmp_ok = abs( st.st_atime - tv[0].tv_sec ) <= 1 &&
+                 abs( st.st_mtime - tv[1].tv_sec ) <= 1;
 
+        }
         /*
          * Check results
          */
-TEST_END:
-        result |= (sys_errno != tc->err) || !cmp_ok;
-        PRINT_RESULT_CMP(sys_ret >= 0, tc->ret, tc->err, sys_ret, sys_errno,cmp_ok);
+        result |= (TEST_ERRNO != tc->err) || !cmp_ok;
+        PRINT_RESULT_CMP(sys_ret >= 0, tc->ret, tc->err, (int)TEST_RETURN, (int)TEST_ERRNO, cmp_ok);
 
         /*
          * Restore effective user id
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

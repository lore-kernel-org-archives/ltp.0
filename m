Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1Nhngn-0006wH-PF
	for ltp-list@lists.sourceforge.net; Wed, 17 Feb 2010 17:27:53 +0000
Received: from mail-pz0-f187.google.com ([209.85.222.187])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Nhngl-0001hW-GH
	for ltp-list@lists.sourceforge.net; Wed, 17 Feb 2010 17:27:53 +0000
Received: by pzk17 with SMTP id 17so6532328pzk.4
	for <ltp-list@lists.sourceforge.net>;
	Wed, 17 Feb 2010 09:27:45 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4B7BA4B3.3070205@linux.vnet.ibm.com>
References: <4B7BA4B3.3070205@linux.vnet.ibm.com>
Date: Wed, 17 Feb 2010 09:27:45 -0800
Message-ID: <364299f41002170927y5d222238s8b3a861fcd0c40d8@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] Don't read errno unless the syscall failed
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
To: Rishikesh <risrajak@linux.vnet.ibm.com>
Cc: jpalecek@web.de, LTP <ltp-list@lists.sourceforge.net>

On Wed, Feb 17, 2010 at 12:11 AM, Rishikesh <risrajak@linux.vnet.ibm.com> wrote:
> Hi Jiri,
>
> Thanks for patch ( ref:
> http://marc.info/?l=ltp-list&m=126415968820646&w=2 ). It will be merged
> in feb 2010 release. please verify once it is out.

I took a bit different route to arrive at the same conclusion as more
spots could be affected by this POSIX ambiguity. I also fixed a
compiler warning and bumped _XOPEN_SOURCE to 600 as per my manpage for
mq_timedsend:

gcooper@orangebox /scratch/ltp-git/ltp-dev $ sudo
testcases/kernel/syscalls/mq_notify/mq_notify01
mq_notify01    0  TINFO  :  (case00) START
EXPECT: return value(ret)=(N >= 0) errno=0 (Success)
RESULT: return value(ret)=       0 errno=0 (Success)
mq_notify01    0  TINFO  :  (case00) END => OK
mq_notify01    0  TINFO  :  (case01) START
EXPECT: return value(ret)=(N >= 0) errno=0 (Success)
RESULT: return value(ret)=       0 errno=0 (Success)
mq_notify01    0  TINFO  :  (case01) END => OK
mq_notify01    0  TINFO  :  (case02) START
EXPECT: return value(ret)=(N >= 0) errno=0 (Success)
RESULT: return value(ret)=       0 errno=0 (Success)
mq_notify01    0  TINFO  :  (case02) END => OK
mq_notify01    0  TINFO  :  (case03) START
EXPECT: return value(ret)=-1 errno=9 (Bad file descriptor)
RESULT: return value(ret)=-1 errno=9 (Bad file descriptor)
mq_notify01    0  TINFO  :  (case03) END => OK
mq_notify01    0  TINFO  :  (case04) START
EXPECT: return value(ret)=-1 errno=9 (Bad file descriptor)
RESULT: return value(ret)=-1 errno=9 (Bad file descriptor)
mq_notify01    0  TINFO  :  (case04) END => OK
mq_notify01    0  TINFO  :  (case05) START
EXPECT: return value(ret)=-1 errno=9 (Bad file descriptor)
RESULT: return value(ret)=-1 errno=9 (Bad file descriptor)
mq_notify01    0  TINFO  :  (case05) END => OK
mq_notify01    0  TINFO  :  (case06) START
EXPECT: return value(ret)=-1 errno=16 (Device or resource busy)
RESULT: return value(ret)=-1 errno=16 (Device or resource busy)
mq_notify01    0  TINFO  :  (case06) END => OK
mq_notify01    1  TPASS  :  mq_notify call succeeded

diff --git a/testcases/kernel/syscalls/mq_notify/mq_notify01.c
b/testcases/kernel/syscalls/mq_notify/mq_notify01.c
index 6004373..0370740 100644
--- a/testcases/kernel/syscalls/mq_notify/mq_notify01.c
+++ b/testcases/kernel/syscalls/mq_notify/mq_notify01.c
@@ -45,7 +45,7 @@
 /* History:     Porting from Crackerjack to LTP is done by
        */
 /*              Manas Kumar Nayak maknayak@in.ibm.com>
        */
 /******************************************************************************/
-#define _XOPEN_SOURCE 500
+#define _XOPEN_SOURCE 600
 #include <sys/syscall.h>
 #include <sys/types.h>
 #include <sys/stat.h>
@@ -262,15 +262,20 @@ static int do_test(struct test_case *tc)
         int rc, i, fd = -1;
         struct sigevent ev;
         struct sigaction sigact;
+       struct timespec abs_timeout;
         char smsg[MAX_MSGSIZE];

         notified = cmp_ok = 1;

+       /* Don't timeout. */
+       abs_timeout.tv_sec = 0;
+       abs_timeout.tv_nsec = 0;
+
         /*
          * When test ended with SIGTERM etc, mq discriptor is left remains.
          * So we delete it first.
          */
-        TEST(mq_unlink(QUEUE_NAME));
+        mq_unlink(QUEUE_NAME);

         switch (tc->ttype) {
         case FD_NOT_EXIST:
@@ -345,7 +350,7 @@ static int do_test(struct test_case *tc)
          */
         for (i = 0; i < MSG_SIZE; i++)
                 smsg[i] = i;
-        TEST(rc = mq_timedsend(fd, smsg, MSG_SIZE, 0, NULL));
+        TEST(rc = mq_timedsend(fd, smsg, MSG_SIZE, 0, &abs_timeout));
         if (rc < 0) {
                 tst_resm(TFAIL,"mq_timedsend failed errno = %d :
%s",TEST_ERRNO, strerror(TEST_ERRNO));
                 result = 1;
@@ -359,7 +364,7 @@ TEST_END:
         /*
          * Check results
          */
-        result |= (sys_errno != tc->err) || !cmp_ok;
+        result |= (sys_ret != 0 && sys_errno != tc->err) || !cmp_ok;
         PRINT_RESULT_CMP(sys_ret >= 0, tc->ret, tc->err, sys_ret, sys_errno,
                          cmp_ok);

------------------------------------------------------------------------------
SOLARIS 10 is the OS for Data Centers - provides features such as DTrace,
Predictive Self Healing and Award Winning ZFS. Get Solaris 10 NOW
http://p.sf.net/sfu/solaris-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

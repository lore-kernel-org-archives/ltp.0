Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yjwei@cn.fujitsu.com>) id 1MTUhg-000779-3V
	for ltp-list@lists.sourceforge.net; Wed, 22 Jul 2009 05:49:24 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MTUhX-0001o5-Sg
	for ltp-list@lists.sourceforge.net; Wed, 22 Jul 2009 05:49:24 +0000
Message-ID: <4A66A7F2.7020802@cn.fujitsu.com>
Date: Wed, 22 Jul 2009 13:47:30 +0800
From: Wei Yongjun <yjwei@cn.fujitsu.com>
MIME-Version: 1.0
References: <4A6527B6.7070602@cn.fujitsu.com> <4A65BD95.7070001@petalogix.com>
In-Reply-To: <4A65BD95.7070001@petalogix.com>
Subject: Re: [LTP] [PATCH] Fix to set the signal handler of SIGINT in
	mq_timedreceive01
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: michal.simek@petalogix.com
Cc: ltp-list@lists.sourceforge.net

Hi,
> Hi,
>
> Please fix coding style violation.
> Use tab instead of spaces.
> Subrata should reject this patch with bad coding style.
> Can you please fix it?
>
>
>   =

Fixed it(the original source is all space, no tab),And also fixed the
compile warning.

[PATCHv2] Fix to set the signal handler of SIGINT in mq_timedreceive01

The test case mq_timedreceive01 does not register the signal
handler of SIGINT, so the problam will be terminated by SIGINT
from child process.

This patch fixed the problem. And also fixed the following
compile warning.

mq_timedreceive01.c: In function =91do_test=92:
mq_timedreceive01.c:379: warning: null argument where non-null required (ar=
gument 5)

Signed-off-by: Wei Yongjun <yjwei@cn.fujitsu.com>

diff --git a/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c =
b/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c
index dadc38d..d6604d7 100644
--- a/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c
+++ b/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c
@@ -106,6 +106,13 @@ extern void cleanup() {
         tst_exit();
 }
 =

+/*
+ * sighandler()
+ */
+void sighandler(int sig)
+{
+}
+
 /* Local  Functions */
 /*************************************************************************=
*****/
 /*                                                                        =
    */
@@ -126,6 +133,7 @@ extern void cleanup() {
 /*************************************************************************=
*****/
 void setup() {
         /* Capture signals if any */
+	signal(SIGINT, sighandler);
         /* Create temporary directories */
         TEST_PAUSE;
         tst_tmpdir();
@@ -301,7 +309,7 @@ static int do_test(struct test_case *tc)
 	int oflag;
         int i, rc, cmp_ok =3D 1, fd =3D -1;
         char smsg[MAX_MSGSIZE], rmsg[MAX_MSGSIZE];
-        struct timespec ts, *p_ts;
+        struct timespec ts, *p_ts =3D NULL;
         pid_t pid =3D 0;
         unsigned prio;
         size_t msg_len;
@@ -368,7 +376,7 @@ switch (tc->ttype) {
         case FD_FILE:
                 break;
         default:
-		TEST(rc =3D mq_timedsend(fd, smsg, tc->len, tc->prio, NULL));
+		TEST(rc =3D mq_timedsend(fd, smsg, tc->len, tc->prio, p_ts));
                 if (TEST_RETURN < 0) {
                  	tst_resm(TFAIL, "mq_timedsend failed - errno =3D %d : %s=
",TEST_ERRNO, strerror(TEST_ERRNO));
                         result =3D 1;
@@ -432,17 +440,6 @@ EXIT:
         return result;
 }
 =

-/*
- * sighandler()
- */
-void sighandler(int sig)
-{
-        if (sig =3D=3D SIGINT)
-                return;
-        // NOTREACHED
-        return;
-}
-
 =

 =

 /*





>> The test case mq_timedreceive01 does not register the signal
>> handler of SIGINT, so the problam will be terminated by SIGINT
>> from child process.
>>
>> This patch fixed the problem.
>>
>> Signed-off-by: Wei Yongjun <yjwei@cn.fujitsu.com>
>>
>> diff --git a/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01=
.c b/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c
>> index dadc38d..beeb298 100644
>> --- a/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c
>> +++ b/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c
>> @@ -106,6 +106,14 @@ extern void cleanup() {
>>          tst_exit();
>>  }
>>  =

>> +/*
>> + * sighandler()
>> + */
>> +void sighandler(int sig)
>> +{
>> +        return;
>> +}
>> +
>>  /* Local  Functions */
>>  /**********************************************************************=
********/
>>  /*                                                                     =
       */
>> @@ -126,6 +134,7 @@ extern void cleanup() {
>>  /**********************************************************************=
********/
>>  void setup() {
>>          /* Capture signals if any */
>> +        signal(SIGINT, sighandler);
>>          /* Create temporary directories */
>>          TEST_PAUSE;
>>          tst_tmpdir();
>> @@ -432,17 +441,6 @@ EXIT:
>>          return result;
>>  }
>>  =

>> -/*
>> - * sighandler()
>> - */
>> -void sighandler(int sig)
>> -{
>> -        if (sig =3D=3D SIGINT)
>> -                return;
>> -        // NOTREACHED
>> -        return;
>> -}
>> -
>>  =

>>  =

>>  /*
>>
>>
>>
>>
>>
>> ------------------------------------------------------------------------=
------
>> Enter the BlackBerry Developer Challenge  =

>> This is your chance to win up to $100,000 in prizes! For a limited time, =

>> vendors submitting new applications to BlackBerry App World(TM) will have
>> the opportunity to enter the BlackBerry Developer Challenge. See full pr=
ize  =

>> details at: http://p.sf.net/sfu/Challenge
>> _______________________________________________
>> Ltp-list mailing list
>> Ltp-list@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/ltp-list
>>   =

>>     =

>
>
>   =




---------------------------------------------------------------------------=
---
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

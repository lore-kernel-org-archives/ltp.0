Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MyF66-0004OQ-Ad
	for ltp-list@lists.sourceforge.net; Thu, 15 Oct 2009 01:25:42 +0000
Received: from mail-px0-f201.google.com ([209.85.216.201])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MyF5z-0005qu-Tw
	for ltp-list@lists.sourceforge.net; Thu, 15 Oct 2009 01:25:42 +0000
Received: by pxi39 with SMTP id 39so326270pxi.10
	for <ltp-list@lists.sourceforge.net>;
	Wed, 14 Oct 2009 18:25:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1255552134.4892.12.camel@subratamodak.linux.ibm.com>
References: <200910011340.32046.chandru@in.ibm.com>
	<1255436017.8438.36.camel@subratamodak.linux.ibm.com>
	<200910141211.11379.chandru@in.ibm.com>
	<1255552134.4892.12.camel@subratamodak.linux.ibm.com>
Date: Wed, 14 Oct 2009 18:25:29 -0700
Message-ID: <364299f40910141825k6d8a8e15w5843dd9d2574d262@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH V2] ppoll01: add signal() syscall to register the
	signal handler
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: subrata@linux.vnet.ibm.com
Cc: ltp-list@lists.sourceforge.net, vapier@gentoo.org

On Wed, Oct 14, 2009 at 1:28 PM, Subrata Modak
<subrata@linux.vnet.ibm.com> wrote:
> On Wed, 2009-10-14 at 12:11 +0530, Chandru wrote:
>> On Tuesday 13 October 2009 17:43:37 Subrata Modak wrote:
>> > On Thu, 2009-10-01 at 13:40 +0530, Chandru wrote:
>> > > The ppoll01 testcase has a signal handler in it but this signal hand=
ler is not registered with the kernel through the signal() syscall. The tes=
tcase fails when it sends a SIGINT to itself as part of one of the case of =
the test run.
>> > > The following patch
>> > > 1. Adds a signal() syscall to register the signal handler
>> > > 2. Corrects the expected 'revents' for the case where ppoll() is cal=
led on a file which is only opened in read/write mode, i.e case00.
>> > >
>> > > Signed-off-by: Chandru S <chandru@linux.vnet.ibm.com>
>> >
>> > Hi Chandru,
>> >
>> > Can you please resend this with a diff from the Latest CVS snapshot ?
>> >
>>
>> Hi Subrata,
>>
>> Thanks for letting me know. Here is the patch taken from the latest snap=
shot.
>>
>> The following patch adds a signal() syscall to the ppoll01 testcase. The=
 testcase has a signal handler in it but this signal handler is not registe=
red with the kernel through the signal() syscall. =A0Without the patch the =
testcase fails when it sends a SIGINT to itself as part of one of the case =
of the test run.
>>
>> Signed-off-by: Chandru S <chandru@linux.vnet.ibm.com>
>
> Thanks.
>
> Regards--
> Subrata
>
>> ---
>>
>> --- ltp/testcases/kernel/syscalls/ppoll/ppoll01.c.orig =A0 =A0 =A0 =A020=
09-10-14 16:58:45.547235527 +0530
>> +++ ltp/testcases/kernel/syscalls/ppoll/ppoll01.c =A0 =A0 2009-10-14 16:=
53:42.828486675 +0530
>> @@ -106,6 +106,8 @@ extern void cleanup() {
>> =A0 =A0 =A0 =A0 =A0tst_exit();
>> =A0}
>>
>> +void sighandler(int sig); =A0 =A0 =A0 /* signals handler function for t=
he test */
>> +
>> =A0/* Local =A0Functions */
>> =A0/********************************************************************=
**********/
>> =A0/* =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0*/
>> @@ -126,6 +128,8 @@ extern void cleanup() {
>> =A0/********************************************************************=
**********/
>> =A0void setup() {
>> =A0 =A0 =A0 =A0 =A0/* Capture signals if any */
>> + =A0 =A0 signal(SIGINT, &sighandler);
>> +
>> =A0 =A0 =A0 =A0 =A0/* Create temporary directories */
>> =A0 =A0 =A0 =A0 =A0TEST_PAUSE;
>> =A0 =A0 =A0 =A0 =A0tst_tmpdir();

Just curious -- was the issue seen at the following point in the code
previously?

361             TEST(sys_ret =3D syscall(__NR_ppoll, p_fds, nfds, p_ts,
p_sigmask, sigsetsize)); /* <-- Blocks here indefinitely */
362             sys_errno =3D errno;
363             if (sys_ret <=3D 0 || tc->ret < 0)
364                     goto TEST_END;
365
366             cmp_ok =3D fds[0].revents =3D=3D tc->expect_revents;

I've seen this issue 1 out of the 8 or 9 times I've run this test.

Thanks!
-Garrett

---------------------------------------------------------------------------=
---
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay =

ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

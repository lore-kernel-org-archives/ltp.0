Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NkUIq-0003ns-BW
	for ltp-list@lists.sourceforge.net; Thu, 25 Feb 2010 03:22:16 +0000
Received: from mail-pw0-f47.google.com ([209.85.160.47])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NkUIp-0001zw-CH
	for ltp-list@lists.sourceforge.net; Thu, 25 Feb 2010 03:22:16 +0000
Received: by pwi5 with SMTP id 5so4670222pwi.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 24 Feb 2010 19:22:09 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4B823884.4000100@cn.fujitsu.com>
References: <4B728073.3070209@cn.fujitsu.com>
	<4B7B9EC2.1010004@linux.vnet.ibm.com>
	<364299f41002170914u3a0d0b02o936a81d1ee601ecc@mail.gmail.com>
	<4B823884.4000100@cn.fujitsu.com>
Date: Wed, 24 Feb 2010 19:22:09 -0800
Message-ID: <364299f41002241922h31f32a1em6f12a2999fd931f8@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] timers: support clockid of
	CLOCK_REALTIME_COARSE/CLOCK_MONOTONIC_COARSE
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
To: Shi Weihua <shiwh@cn.fujitsu.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

On Sun, Feb 21, 2010 at 11:55 PM, Shi Weihua <shiwh@cn.fujitsu.com> wrote:
> at 2010-2-18 1:14, Garrett Cooper wrote:
>> On Tue, Feb 16, 2010 at 11:46 PM, Rishikesh <risrajak@linux.vnet.ibm.com=
> wrote:
>>> On 02/10/2010 03:16 PM, Shi Weihua wrote:
>>>> mainline commit da15cfdae03351c689736f8d142618592e3cebc3
>>>> =A0 (subject: time: Introduce CLOCK_REALTIME_COARSE)
>>>> added two clocks (CLOCK_REALTIME_COARSE/CLOCK_MONOTONIC_COARSE) in
>>>> 2.6.32-rc1, but it has not been responded in ltp. then, the following
>>>> error message occured.
>>>> -----
>>>> clock_gettime03 =A0 =A03 =A0TFAIL =A0: =A0failed to produce expected e=
rror [expected errno =3D 22 (Invalid argument), TEST_RETURN =3D 0]: TEST_ER=
RNO=3D???(0): Success
>>>> clock_gettime03 =A0 =A04 =A0TFAIL =A0: =A0failed to produce expected e=
rror [expected errno =3D 22 (Invalid argument), TEST_RETURN =3D 0]: TEST_ER=
RNO=3D???(0): Success
>>>> timer_create04 =A0 =A01 =A0TFAIL =A0: =A0didn't fail as expected [expe=
cted errno =3D 22 (Invalid argument)]: TEST_ERRNO=3D???(95): Operation not =
supported
>>>> timer_create04 =A0 =A02 =A0TFAIL =A0: =A0didn't fail as expected [expe=
cted errno =3D 22 (Invalid argument)]: TEST_ERRNO=3D???(95): Operation not =
supported
>>>> -----
>>>>
>>>> Following patch fixed this bug. and, passed on 2.6.32-rc1, 2.6.33-rc6,=
 2.6.23.1-42.fc8.
>>>>
>>>
>>> Can anyone provide their review & Acked ?
>>>
>>> Thanks "Shi Weihua" for patch.
>>
>> 1. Please provide before and after (once the items were fixed) output.
>
> before:
> ------
> clock_gettime03 =A0 =A01 =A0TPASS =A0: =A0got expected failure: TEST_ERRN=
O=3DEFAULT(14): Bad address
> clock_gettime03 =A0 =A02 =A0TPASS =A0: =A0got expected failure: TEST_ERRN=
O=3DEFAULT(14): Bad address
> clock_gettime03 =A0 =A03 =A0TFAIL =A0: =A0failed to produce expected erro=
r [expected errno =3D 22 (Invalid argument), TEST_RETURN =3D 0]: TEST_ERRNO=
=3D???(0): Success
> clock_gettime03 =A0 =A04 =A0TFAIL =A0: =A0failed to produce expected erro=
r [expected errno =3D 22 (Invalid argument), TEST_RETURN =3D 0]: TEST_ERRNO=
=3D???(0): Success
> clock_gettime03 =A0 =A05 =A0TPASS =A0: =A0got expected failure: TEST_ERRN=
O=3DEFAULT(14): Bad address
> clock_gettime03 =A0 =A06 =A0TPASS =A0: =A0got expected failure: TEST_ERRN=
O=3DEFAULT(14): Bad address
> <snip>
> timer_create04 =A0 =A01 =A0TFAIL =A0: =A0didn't fail as expected [expecte=
d errno =3D 22 (Invalid argument)]: TEST_ERRNO=3D???(95): Operation not sup=
ported
> timer_create04 =A0 =A02 =A0TFAIL =A0: =A0didn't fail as expected [expecte=
d errno =3D 22 (Invalid argument)]: TEST_ERRNO=3D???(95): Operation not sup=
ported
> timer_create04 =A0 =A03 =A0TPASS =A0: =A0failed as expected: TEST_ERRNO=
=3DEFAULT(14): Bad address
> timer_create04 =A0 =A04 =A0TPASS =A0: =A0failed as expected: TEST_ERRNO=
=3DEFAULT(14): Bad address
> timer_create04 =A0 =A05 =A0TPASS =A0: =A0failed as expected: TEST_ERRNO=
=3DEFAULT(14): Bad address
> timer_create04 =A0 =A06 =A0TPASS =A0: =A0failed as expected: TEST_ERRNO=
=3DEFAULT(14): Bad address
> ------
>
> after ( patch merged )
> ------
> clock_gettime03 =A0 =A01 =A0TPASS =A0: =A0got expected failure: TEST_ERRN=
O=3DEFAULT(14): Bad address
> clock_gettime03 =A0 =A02 =A0TPASS =A0: =A0got expected failure: TEST_ERRN=
O=3DEFAULT(14): Bad address
> clock_gettime03 =A0 =A03 =A0TPASS =A0: =A0got expected failure: TEST_ERRN=
O=3DEINVAL(22): Invalid argument
> clock_gettime03 =A0 =A04 =A0TPASS =A0: =A0got expected failure: TEST_ERRN=
O=3DEINVAL(22): Invalid argument
> clock_gettime03 =A0 =A05 =A0TPASS =A0: =A0got expected failure: TEST_ERRN=
O=3DEFAULT(14): Bad address
> clock_gettime03 =A0 =A06 =A0TPASS =A0: =A0got expected failure: TEST_ERRN=
O=3DEFAULT(14): Bad address
> <snip>
> timer_create04 =A0 =A01 =A0TPASS =A0: =A0failed as expected: TEST_ERRNO=
=3DEINVAL(22): Invalid argument
> timer_create04 =A0 =A02 =A0TPASS =A0: =A0failed as expected: TEST_ERRNO=
=3DEINVAL(22): Invalid argument
> timer_create04 =A0 =A03 =A0TPASS =A0: =A0failed as expected: TEST_ERRNO=
=3DEFAULT(14): Bad address
> timer_create04 =A0 =A04 =A0TPASS =A0: =A0failed as expected: TEST_ERRNO=
=3DEFAULT(14): Bad address
> timer_create04 =A0 =A05 =A0TPASS =A0: =A0failed as expected: TEST_ERRNO=
=3DEFAULT(14): Bad address
> timer_create04 =A0 =A06 =A0TPASS =A0: =A0failed as expected: TEST_ERRNO=
=3DEFAULT(14): Bad address
> ------
>
>> 2. *sigh* These constants should be autoconf conditionalized --
>> otherwise when Linux devs decide to change their minds about the
>> values of the constants or the values are different on different
>> architectures you'll run into red-herring errors. The test should be
>> resistant to this behavior, but currently isn't. This would also
>> prevent `ENOSYS'-like errors from showing up on kernels < 2.6.32-rc1.
>
> i checked the frequency of adding clock in include/linux/time.h.
> =A02005-04-16 =A0 =A0CLOCK_REALTIME/CLOCK_MONOTONIC/CLOCK_PROCESS_CPUTIME=
_ID/CLOCK_THREAD_CPUTIME_ID
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(when git initialized)
> =A02008-08-21 =A0 =A0CLOCK_MONOTONIC_RAW added
> =A02009-08-21 =A0 =A0CLOCK_REALTIME_COARSE/CLOCK_MONOTONIC_COARSE added
> =A0(from http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.g=
it;a=3Dhistory;f=3Dinclude/linux/time.h;h=3D6e026e45a179e2c66b347eb3834501a=
13be7ee2e;hb=3Daea187c46f7d03ce985e55eb1398d0776a15b928)
> so, the frequency is slow, i think.
> And, should to accept my patch at first. ;-)

    I've added the autoconf-conditionalized variables along with your
changes, and some other minor cleanups to git just moments ago.
Cheers,
-Garrett

---------------------------------------------------------------------------=
---
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

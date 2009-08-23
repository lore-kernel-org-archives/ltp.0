Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1Mf3kf-0005WN-Cr
	for ltp-list@lists.sourceforge.net; Sun, 23 Aug 2009 03:28:17 +0000
Received: from qw-out-2122.google.com ([74.125.92.26])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Mf3kZ-0001Yp-4e
	for ltp-list@lists.sourceforge.net; Sun, 23 Aug 2009 03:28:17 +0000
MIME-Version: 1.0
In-Reply-To: <20090823.103037.104044604.caiqian@cclom.cn>
References: <20090821.195739.1000278277145530969.caiqian@cclom.cn>
	<200908211200.33401.vapier@gentoo.org>
	<20090823.103037.104044604.caiqian@cclom.cn>
Date: Sat, 22 Aug 2009 20:28:05 -0700
Message-ID: <364299f40908222028o25e67baag778c85c5e372bbb5@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] The Best Practice to Skip Syscall Tests
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
To: CAI Qian <caiqian@cclom.cn>
Cc: ltp-list@lists.sf.net

On Sat, Aug 22, 2009 at 7:30 PM, CAI Qian<caiqian@cclom.cn> wrote:
> From: Mike Frysinger <vapier@gentoo.org>
> Subject: Re: [LTP] The Best Practice to Skip Syscall Tests
> Date: Fri, 21 Aug 2009 12:00:32 -0400
>
>> On Friday 21 August 2009 07:57:39 CAI Qian wrote:
>>> Test cases unshare failed to compile on systems without such a
>>> syscall. I am unsure what the best way to handle it. The old ways are,
>>>
>>> * add a kernel version check in the unshare tests code.
>>>
>>> or
>>>
>>> * add a m4 rule.
>>> * modify the unshare tests code to check if the macro, and add stub
>>> =A0 functions if the macro is false.
>>>
>>> The first approach is unable to handle non-vanilla kernels. The second
>>> approach needs to add stub functions which are unclean. What I would
>>> like to do is,
>>>
>>> * add a m4 rule.
>>> * modify unshare Makefile like this,
>>>
>>> =A0 ifdef HAVE_UNSHARE =A0<-- if the syscall is present, compile the te=
sts.
>>
>> the configure test should always be there if the code needs new
>> headers (like sys/signalfd.h). =A0if it's only a new syscall, then the
>> configure test should only be for the new symbol (assuming one is
>> provided). =A0in all cases, the tests should be compiled. =A0your propos=
al
>> doesnt handle the case where the C library is in place, but the kernel
>> is older so returns ENOSYS.
>
> OK, how about those two approaches?
>
> * add a stub C program to check if kernel returns ENOSYS. If so, returns
> =A01. Otherwise, 0.
> * add a m4 rule to check the headers or/and functions.
> * if ./configure found all headers and functions, and execute the stub
> =A0program to return 0, it will set HAVE_UNSHARE.
> * modify unshare Makefile to complie it only if HAVE_UNSHARE set.
>
> or
>
> * add a m4 rule to check the headers or/and functions.
> * if ./configure found all headers and functions, , it will set
> =A0HAVE_UNSHARE.
> * modify the test code to deal with three situations.
> =A0* HAVE_UNSHARE =3D 0
> =A0* HAVE_UNSHARE =3D 1 + ENOSYS
> =A0* HAVE_UNSHARE =3D 1 + no ENOSYS

Because it wouldn't work for cross-compilation.
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day =

trial. Simplify your report design, integration and deployment - and focus =
on =

what you do best, core application coding. Discover what's new with =

Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

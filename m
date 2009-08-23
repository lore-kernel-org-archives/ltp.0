Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <caiqian@cclom.cn>) id 1Mf30K-0000De-Rb
	for ltp-list@lists.sourceforge.net; Sun, 23 Aug 2009 02:40:24 +0000
Received: from smtp102.biz.mail.mud.yahoo.com ([68.142.200.237])
	by 72vjzd1.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1Mf30F-00086b-BJ
	for ltp-list@lists.sourceforge.net; Sun, 23 Aug 2009 02:40:24 +0000
Date: Sun, 23 Aug 2009 10:37:28 +0800 (CST)
Message-Id: <20090823.103728.112603315.caiqian@cclom.cn>
From: CAI Qian <caiqian@cclom.cn>
In-Reply-To: <364299f40908211417i21840c17n4e144c85852cb08a@mail.gmail.com>
References: <20090821.195739.1000278277145530969.caiqian@cclom.cn>
	<200908211200.33401.vapier@gentoo.org>
	<364299f40908211417i21840c17n4e144c85852cb08a@mail.gmail.com>
Mime-Version: 1.0
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
To: ltp-list@lists.sf.net
Cc: vapier@gentoo.org

From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] The Best Practice to Skip Syscall Tests
Date: Fri, 21 Aug 2009 14:17:06 -0700

> On Fri, Aug 21, 2009 at 9:00 AM, Mike Frysinger<vapier@gentoo.org> wrote:
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
>> the configure test should always be there if the code needs new headers =
(like
>> sys/signalfd.h). =A0if it's only a new syscall, then the configure test =
should
>> only be for the new symbol (assuming one is provided). =A0in all cases, =
the
>> tests should be compiled. =A0your proposal doesnt handle the case where =
the C
>> library is in place, but the kernel is older so returns ENOSYS.
> =

>     check_for_unshare was a poorly hacked app, IMO and Mike is
> correct. The issue needs to be a combination of buildtime and runtime
> tests as it needs to pass through the build and the issue with the
> syscall needs to be detected and marked TBROK if the syscall isn't
> implemented.

ENOSYS is the expected result if the kernel under test has no such
implementation, so I would consider TPASS or TCONF.

CAI Qian

>     I'll already removed that app from the build in
> makefile-infra-rework, but I agree that more autoconf testcases can be
> added at buildtime.
> Thanks,
> -Garrett
> =

> -------------------------------------------------------------------------=
-----
> Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-D=
ay =

> trial. Simplify your report design, integration and deployment - and focu=
s on =

> what you do best, core application coding. Discover what's new with =

> Crystal Reports now.  http://p.sf.net/sfu/bobj-july
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list

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

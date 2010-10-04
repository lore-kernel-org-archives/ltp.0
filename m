Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1P2ly0-0003Qf-Uh
	for ltp-list@lists.sourceforge.net; Mon, 04 Oct 2010 14:24:36 +0000
Received: from mail-gw0-f46.google.com ([74.125.83.46])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1P2ly0-0001Co-2M
	for ltp-list@lists.sourceforge.net; Mon, 04 Oct 2010 14:24:36 +0000
MIME-Version: 1.0
In-Reply-To: <20101004140650.GG19814@hallyn.com>
References: <20100929135647.GA4587@hallyn.com>
	<AANLkTikGmyHTu8ncUROKraoSffkbHqeNOAe7U3nAkU65@mail.gmail.com>
	<20101004140650.GG19814@hallyn.com>
Date: Mon, 4 Oct 2010 07:24:30 -0700
Message-ID: <AANLkTik7CE9J7GGBpUyTG6ijRrVo-iCLVvJAqzXZ4GSt@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] securebits: add secure_keepcaps testcases
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
To: "Serge E. Hallyn" <serge.hallyn@canonical.com>
Cc: ltp-list@lists.sf.net, Subrata Modak1 <subrata.modak@in.ibm.com>

On Mon, Oct 4, 2010 at 7:06 AM, Serge E. Hallyn
<serge.hallyn@canonical.com> wrote:
> Quoting Garrett Cooper (yanegomi@gmail.com):
>> Hi Serge,
>> =A0 =A0 Some comments about your provided code.
>
> Thanks.
>
>> > +AC_DEFUN([LTP_CHECK_SECUREBITS],
>> > +AC_CHECK_HEADERS(linux/securebits.h,[
>> > + =A0 =A0 =A0 LTP_SECUREBITS=3Dyes
>> > +])
>> > +)
>>
>> Some checks should probably be added for versioning as well as symbols
>> that get passed to prctl(2) (I'm not sure if checking for the symbols
>> that get passed to prctl(2) here is the correct way to go about things
>> though).
>
> Not sure how we would check the versioning, bc there is no versioning
> info in the interface.

Just checking for the symbols used with an autoconf test would be ok,
because according to the kernel.org manpage [1] some of these symbols
have only existed for the past year or two (and thus someone like
Mitani-san will come on the list and say that RHEL 4.x or 5.x compiles
are broken by the new test :)).

> ...
>
>> > + =A0 =A0 =A0 case 3:
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D prctl(PR_GET_SECUREBITS);
>>
>> What if this call fails?
>
> It doesn't pass or fail. =A0The return value is simply the current
> securebits.

According to the manpage [1], this syscall can fail.

>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D prctl(PR_SET_SECUREBITS, ret | S=
ECBIT_KEEP_CAPS);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret =3D=3D -1) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TFAIL|TERRNO, "=
PR_SET_SECUREBITS failed\n");
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_exit();
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>
>> > +#!/bin/sh
>> > +
>> > +echo "testing keepcaps"
>> > +check_keepcaps 1
>> > +tmp=3D$?
>> > +if [ $tmp -ne 0 ]; then
>> > + =A0 =A0 =A0 exit_code=3D$tmp
>> > +fi
>> > +check_keepcaps 2
>> > +tmp=3D$?
>> > +if [ $tmp -ne 0 ]; then
>> > + =A0 =A0 =A0 exit_code=3D$tmp
>> > +fi
>> > +check_keepcaps 3
>> > +tmp=3D$?
>> > +if [ $tmp -ne 0 ]; then
>> > + =A0 =A0 =A0 exit_code=3D$tmp
>> > +fi
>> > +
>> > +exit $exit_code
>>
>> What if (for instance) test 1 fails, and tests 2 or 3 pass?
>
> Yeah, I didn't do that right, and maybe it would be best
> to just shortcut on the first failure anyway.

That's what I thought. The only thing you lose is coverage potentially
if one of the tests is broken :/.

Thanks!
-Garrett

[1] http://www.kernel.org/doc/man-pages/online/pages/man2/prctl.2.html

---------------------------------------------------------------------------=
---
Virtualization is moving to the mainstream and overtaking non-virtualized
environment for deploying applications. Does it make network security =

easier or more difficult to achieve? Read this whitepaper to separate the =

two and get a better understanding.
http://p.sf.net/sfu/hp-phase2-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

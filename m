Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <serge.hallyn@canonical.com>) id 1P2mG2-0005c1-Ci
	for ltp-list@lists.sourceforge.net; Mon, 04 Oct 2010 14:43:14 +0000
Received: from adelie.canonical.com ([91.189.90.139])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1P2mG1-0005Ak-43
	for ltp-list@lists.sourceforge.net; Mon, 04 Oct 2010 14:43:14 +0000
Date: Mon, 4 Oct 2010 09:43:11 -0500
From: "Serge E. Hallyn" <serge.hallyn@canonical.com>
Message-ID: <20101004144311.GA24722@hallyn.com>
References: <20100929135647.GA4587@hallyn.com>
	<AANLkTikGmyHTu8ncUROKraoSffkbHqeNOAe7U3nAkU65@mail.gmail.com>
	<20101004140650.GG19814@hallyn.com>
	<AANLkTik7CE9J7GGBpUyTG6ijRrVo-iCLVvJAqzXZ4GSt@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <AANLkTik7CE9J7GGBpUyTG6ijRrVo-iCLVvJAqzXZ4GSt@mail.gmail.com>
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: Subrata Modak1 <subrata.modak@in.ibm.com>, ltp-list@lists.sf.net

Quoting Garrett Cooper (yanegomi@gmail.com):
> On Mon, Oct 4, 2010 at 7:06 AM, Serge E. Hallyn
> <serge.hallyn@canonical.com> wrote:
> > Quoting Garrett Cooper (yanegomi@gmail.com):
> >> Hi Serge,
> >> =A0 =A0 Some comments about your provided code.
> >
> > Thanks.
> >
> >> > +AC_DEFUN([LTP_CHECK_SECUREBITS],
> >> > +AC_CHECK_HEADERS(linux/securebits.h,[
> >> > + =A0 =A0 =A0 LTP_SECUREBITS=3Dyes
> >> > +])
> >> > +)
> >>
> >> Some checks should probably be added for versioning as well as symbols
> >> that get passed to prctl(2) (I'm not sure if checking for the symbols
> >> that get passed to prctl(2) here is the correct way to go about things
> >> though).
> >
> > Not sure how we would check the versioning, bc there is no versioning
> > info in the interface.
> =

> Just checking for the symbols used with an autoconf test would be ok,
> because according to the kernel.org manpage [1] some of these symbols
> have only existed for the past year or two

Right, but before that the header file wouldn't have existed.  The
symbols appeared with the header file's creation.

Of course someone can shoot himself in the foot with older kernel on
newer userspace.  I don't mind doing the extra checks, it'll just take
me a few weeks to get the chance.  The tests aren't going to go stale
in the meantime, so no big whoop.

> (and thus someone like
> Mitani-san will come on the list and say that RHEL 4.x or 5.x compiles
> are broken by the new test :)).

My theory is that this test will suffice for older RHEL :)  but
not for more experimental chaps, I guess.

> > ...
> >
> >> > + =A0 =A0 =A0 case 3:
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D prctl(PR_GET_SECUREBITS);
> >>
> >> What if this call fails?
> >
> > It doesn't pass or fail. =A0The return value is simply the current
> > securebits.
> =

> According to the manpage [1], this syscall can fail.

I don't actually see where the syscall says it can fail (it says that
for CAPBSET_READ, but not for GET_SECUREBITS.  So it can only fail
if the capability module's prctl() isn't called.  I know of no ways
that can happen with current upstream, bc smack, selinux, apparmor
and tomoyo all do not define security_prctl(), which means that the
capability one will be called.

But there's really nothing preventing that situation in the future.
In which case right now we'll cache the error when SET_SECUREBITS
either returns -ENOSYS or returns an error bc of invalid bits.

In any case, an extra check won't hurt.  I just felt the need to
double-check my original thinking :)

> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D prctl(PR_SET_SECUREBITS, ret |=
 SECBIT_KEEP_CAPS);
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret =3D=3D -1) {
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TFAIL|TERRNO,=
 "PR_SET_SECUREBITS failed\n");
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_exit();
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> >
> >> > +#!/bin/sh
> >> > +
> >> > +echo "testing keepcaps"
> >> > +check_keepcaps 1
> >> > +tmp=3D$?
> >> > +if [ $tmp -ne 0 ]; then
> >> > + =A0 =A0 =A0 exit_code=3D$tmp
> >> > +fi
> >> > +check_keepcaps 2
> >> > +tmp=3D$?
> >> > +if [ $tmp -ne 0 ]; then
> >> > + =A0 =A0 =A0 exit_code=3D$tmp
> >> > +fi
> >> > +check_keepcaps 3
> >> > +tmp=3D$?
> >> > +if [ $tmp -ne 0 ]; then
> >> > + =A0 =A0 =A0 exit_code=3D$tmp
> >> > +fi
> >> > +
> >> > +exit $exit_code
> >>
> >> What if (for instance) test 1 fails, and tests 2 or 3 pass?
> >
> > Yeah, I didn't do that right, and maybe it would be best
> > to just shortcut on the first failure anyway.
> =

> That's what I thought. The only thing you lose is coverage potentially
> if one of the tests is broken :/.

Yup, which is probably fine - if any one of these breaks, it'll
be a huge deal imo.

-serge

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

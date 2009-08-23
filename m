Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1Mf4Ce-0006ZW-2V
	for ltp-list@lists.sourceforge.net; Sun, 23 Aug 2009 03:57:12 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Mf4CX-0004Iz-Jt
	for ltp-list@lists.sourceforge.net; Sun, 23 Aug 2009 03:57:11 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Sat, 22 Aug 2009 23:57:12 -0400
References: <20090821.195739.1000278277145530969.caiqian@cclom.cn>
	<200908211200.33401.vapier@gentoo.org>
	<20090823.103037.104044604.caiqian@cclom.cn>
In-Reply-To: <20090823.103037.104044604.caiqian@cclom.cn>
MIME-Version: 1.0
Message-Id: <200908222357.13105.vapier@gentoo.org>
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
Content-Type: multipart/mixed; boundary="===============8377233947676232831=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============8377233947676232831==
Content-Type: multipart/signed; boundary="nextPart5846528.RMEbbiV1ic";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart5846528.RMEbbiV1ic
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Saturday 22 August 2009 22:30:37 CAI Qian wrote:
> From: Mike Frysinger <vapier@gentoo.org>
> > On Friday 21 August 2009 07:57:39 CAI Qian wrote:
> >> Test cases unshare failed to compile on systems without such a
> >> syscall. I am unsure what the best way to handle it. The old ways are,
> >>
> >> * add a kernel version check in the unshare tests code.
> >>
> >> or
> >>
> >> * add a m4 rule.
> >> * modify the unshare tests code to check if the macro, and add stub
> >>   functions if the macro is false.
> >>
> >> The first approach is unable to handle non-vanilla kernels. The second
> >> approach needs to add stub functions which are unclean. What I would
> >> like to do is,
> >>
> >> * add a m4 rule.
> >> * modify unshare Makefile like this,
> >>
> >>   ifdef HAVE_UNSHARE  <-- if the syscall is present, compile the tests.
> >
> > the configure test should always be there if the code needs new
> > headers (like sys/signalfd.h).  if it's only a new syscall, then the
> > configure test should only be for the new symbol (assuming one is
> > provided).  in all cases, the tests should be compiled.  your proposal
> > doesnt handle the case where the C library is in place, but the kernel
> > is older so returns ENOSYS.
>
> OK, how about those two approaches?
>
> * add a stub C program to check if kernel returns ENOSYS. If so, returns
>   1. Otherwise, 0.
> * add a m4 rule to check the headers or/and functions.
> * if ./configure found all headers and functions, and execute the stub
>   program to return 0, it will set HAVE_UNSHARE.
> * modify unshare Makefile to complie it only if HAVE_UNSHARE set.
>
> or
>
> * add a m4 rule to check the headers or/and functions.
> * if ./configure found all headers and functions, , it will set
>   HAVE_UNSHARE.
> * modify the test code to deal with three situations.
>   * HAVE_UNSHARE =3D 0
>   * HAVE_UNSHARE =3D 1 + ENOSYS
>   * HAVE_UNSHARE =3D 1 + no ENOSYS

in addition to the reasoning Garrett provided, this makes for a fairly=20
complicated setup for no real gain.  the solution i mentioned (and is being=
=20
used) covers all known build/runtime issues.

if you need a new C library function, check for it.  if you need a new C=20
library header, check for it.  if a test may be run on an older system and=
=20
thus the call fails with ENOSYS, the test must check for it and error out w=
ith=20
TCONF (and a helper message).  whether someone chooses to also add a runtim=
e=20
kernel version check (as can be seen in a few tests) is up to whoever feels=
=20
like doing the work.
=2Dmike

--nextPart5846528.RMEbbiV1ic
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iQIcBAABAgAGBQJKkL4ZAAoJEEFjO5/oN/WBbsYP/j1fp2WKwDUjGvrtjFSl2hdC
EcF+AkVl62LWgitz+mr0kSX8yNjZST2R9EIF8Hezhcj6wVRsYkoF/dRECIFeIJiZ
jFz/7OWWGg+MmFrspECyvljkA3acIkMwPzTO/TutmlxzxrMrrgqxPYPBhZd7Vzif
Mz9esbpOxP/N2+qOl8976AVXQ7ve8CykKlywTM5hAjZcxPaKMCFbfNttVzYY0hsI
htG3JAdEYujkaDhvxnAONz3A4fEk7bo2vh4z8C4OuST7XhxqKW1S7chzX339ZErz
rd5lRW0OCJtg8Jsbdw4w24fmEzcv3AlKLDnYn1bTH8FNGZg/pGY09ZflsCbyGZLB
a4CPbr6ERx/DDPQOHr5laiIQ30kvTrJxp59M3NPxkxXtiiMCrUYIJoz8RGjggqB7
NoezQVvvs+iGzIOZTcGpMJNnvEMEz663j7CeKwo1B2DUzo/8B8Gg226DVdPj2dI0
23n+eGWEbTEL+z6URuM6VXrC8Vsza4PsO9bYEkf2bGmGamKmk4MigClvpvwLsaVm
t+zVK68x4ULghDsddgLOAPVXDd3uVL99eQyBX+CRcGGNvcA9XDJR4g5QtuWQVt9H
UgiGgc9bEaxM7/vNAj80Odh7i7MKUYG5S2QQk/rKCJpBw/chSfZPl9SNZx/jydll
d6evRJiE74jZYclltq4F
=AjMs
-----END PGP SIGNATURE-----

--nextPart5846528.RMEbbiV1ic--


--===============8377233947676232831==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--===============8377233947676232831==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============8377233947676232831==--


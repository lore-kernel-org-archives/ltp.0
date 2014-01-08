Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1W0z0d-0005CL-Ba
	for ltp-list@lists.sourceforge.net; Wed, 08 Jan 2014 19:41:47 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1W0z0c-0008Dz-8F
	for ltp-list@lists.sourceforge.net; Wed, 08 Jan 2014 19:41:47 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Wed, 8 Jan 2014 14:41:42 -0500
References: <1385374379-25949-1-git-send-email-markos.chandras@imgtec.com>
	<201401060749.29230.vapier@gentoo.org>
	<52CD3B93.8090605@imgtec.com>
In-Reply-To: <52CD3B93.8090605@imgtec.com>
MIME-Version: 1.0
Message-Id: <201401081441.43107.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH v2] ptrace: Fix build problems with glibc-2.18
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============4715410593988590013=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: Markos Chandras <Markos.Chandras@imgtec.com>

--===============4715410593988590013==
Content-Type: multipart/signed; boundary="nextPart13000905.Gu5baIAjOR";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart13000905.Gu5baIAjOR
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Wednesday 08 January 2014 06:50:43 Markos Chandras wrote:
> On 01/06/2014 12:49 PM, Mike Frysinger wrote:
> > On Monday 06 January 2014 06:45:43 Markos Chandras wrote:
> >> On 01/05/2014 10:27 PM, Mike Frysinger wrote:
> >>> On Monday 25 November 2013 05:12:59 Markos Chandras wrote:
> >>>> Since glibc-2.18, the struct ptrace_peeksiginfo_args is
> >>>> also defined in sys/ptrace.h and conflicts with the definition
> >>>> from the Linux kernel in linux/ptrace.h. We fix this by not
> >>>> including the linux/ptrace.h header if the sys/ptrace.h header
> >>>> defines the said struct. Fixes
> >>>> https://github.com/linux-test-project/ltp/issues/6
> >>>=20
> >>> i'm somewhat inclined to undo this as it's really a bug in glibc-2.18
> >>>=20
> >>> that should be fixed in glibc-2.19:
> >>> 	https://sourceware.org/ml/libc-alpha/2014-01/msg00078.html
> >>=20
> >> Ehm that would break the build for people already using 2.18. Even if a
> >> new 2.18 is released with the fix, people using the old one will still
> >> face the same problem.
> >=20
> > i'm aware that would be the situation.  i'm fine with that.
>=20
> It's not my call to make, but forcing people to update their glibc in
> order to build LTP is a bit too much. I suggest to keep this workaround
> for X months, until more people have been moved to a fixed glibc version.

i'm not forcing people to update their glibc.  i am forcing them to get the=
ir=20
distro to land a simple fix.  or run a simple sed script as root to fix the=
ir=20
header.

> strace also has similar fix
> http://sourceforge.net/p/strace/code/ci/0b4060f61f1bb101b5d8d084714b7d2fe=
ac
> db199/

yes, and i already commented there
=2Dmike

--nextPart13000905.Gu5baIAjOR
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJSzan3AAoJEEFjO5/oN/WB8BgP/2SKEwE2GjEtH8BckCfJXDRm
R7+//4piQ4Ex2CBCd1g5KpPZipohg4Xsr6wyXfC9JZCAsHGifMhFcLGoqPm3JANT
GB+vvSROsoMDsB7K5mfu5WF10TL5U2YUAb03Vw6VD3zH4vZGJWehXjkHmtNpQteq
+LiPyMoK4hlKsmAA82a+SPfJmJGBDF+6lff3OsqIzJiBasBtRKyIVyFicwuXreJw
xujT6P5qy5mn9VyD7iqUqdyQ1NAJb/812thAMYdG9xuEOk5Jjcod6mJWbo9cVkjM
i17f2vDBpuhFhs8rhXkvIBHsMprLx8PJP6kFkMEsH9ILO5+QzgnQeyvpDPqbZBML
FJ6Ft2Eej38a/oZ2nYZUYeRMdad5Oq21fFwFAowBBe1ZgQyd7WTztHTsrOWWkUDc
L0hq10EE5B7z3u5mKpvCCzRyT5jZS6vRz8ytwyDo3VbDpF0zTeMp9JsjMtIm0at/
pBK0ypmCSe61s0ho7EvPWjyh3kL0WBHou7HwMPayRkkJocswaynArkWpnzjXqDWe
21fC8TZDhWySqecxD4PVrU1B36rj95JlKydwytl1owarU/YppHu03V2he1sCq9Tv
7ZXfbP39nbrHUh6+tfrE8qSfNy3WHwJl6+Z+292syizrcMY9NKhbbDX9Sh3bpFHj
mI6lUo4VSb6RR7VCOVgY
=7D1a
-----END PGP SIGNATURE-----

--nextPart13000905.Gu5baIAjOR--


--===============4715410593988590013==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349831&iu=/4140/ostg.clktrk
--===============4715410593988590013==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============4715410593988590013==--


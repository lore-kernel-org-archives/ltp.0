Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1MgyW9-0005wl-F3
	for ltp-list@lists.sourceforge.net; Fri, 28 Aug 2009 10:17:13 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MgyVw-0006sm-9X
	for ltp-list@lists.sourceforge.net; Fri, 28 Aug 2009 10:17:08 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Fri, 28 Aug 2009 06:16:52 -0400
References: <alpine.LRH.2.00.0908271703550.1134@vixen.sonytel.be>
	<1251448700.9081.13.camel@subratamodak.linux.ibm.com>
	<alpine.LRH.2.00.0908281044020.29648@vixen.sonytel.be>
In-Reply-To: <alpine.LRH.2.00.0908281044020.29648@vixen.sonytel.be>
MIME-Version: 1.0
Message-Id: <200908280616.53716.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH] Annotate tst_*() helpers with __attribute__
	((format (printf, M, N)))
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============7835741004322735667=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

--===============7835741004322735667==
Content-Type: multipart/signed; boundary="nextPart7081761.xTLtFVgRB0";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart7081761.xTLtFVgRB0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

On Friday 28 August 2009 04:48:08 Geert Uytterhoeven wrote:
> On Fri, 28 Aug 2009, Subrata Modak wrote:
> > Sorry. I need to revert this as it generates a huge set of warning for
> > all the tests compiled. It should not only get fixed at test.h, but also
> > in all tests that uses the tst_* family of functions, which obviously is
> > too big to fix.
>
> Yes, it should be fixed elsewhere, too. Reverting TEST_ERRNO to int should
> kill a few thousand of them...

ive fixed that (i always thought it weird TEST_ERRNO was declared as a long=
). =20
most of the remaining warnings are because TEST_RESULT is a long, but that =
is=20
understandable.  we cram the result of arbitrary functions into it and we n=
eed=20
something that is big enough.

that brings us down to ~900 warnings in testcases/kernel/syscalls/

> But without enabling the warnings, you don't notice the real bugs, where
> integers are passed instead of string pointers.

current warnings:
 - printf mismatches (i.e. long given to a %d)
 - NULL strings used for printf output
	- the tst_res code allows for this, but if you dont want output, then an=20
empty string "" works just as well as a NULL string
 - too many arguments to printf string
 - too few arguments to printf string
 - incorrect printf string
 - some others

considering many of these printf's only get used when an error occurs (i.e.=
=20
not normally executed), a crash is not likely to be noticed.  so doing this=
=20
extra work of fixing the warnings is certainly worth it in my book.
=2Dmike

--nextPart7081761.xTLtFVgRB0
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iQIcBAABAgAGBQJKl66VAAoJEEFjO5/oN/WBO7YP/1s9eWc+NMvyu/Uq9PtNizb8
oza1z2dPd4D63dCk8Nr6NlAdSNxbxKP8gQPX3hVVBQuntq2IHuPAnFr0fwJonQ5Q
Sw72hsdD7Lzr1AQZuERwParjYKMA9vwlBIRiH04/UeYjTh2l5RWzBTblYIFguxym
vFK3P+YRfjrYg17CnthJlhTHJuCLobou5cpZ+ZRS+K+o1qYemmgjvobG0BHIamd6
/xBablkhVDAA/Ot+zkPruwewmIlDNl1qHti8RZjkDsh+sgmo8toUGFQagJpJHO4L
rMapPieJbdnMUEzOs82r+8880O6t9ARRiqo4eRfRZ/hSX30gOXe50BxQ5FAkT+OB
55s9Y+2ir2vZsKFMCvjx3C3Js/965+ZlpShfOGLEpHv2ST2jACaghMCQOfvuuJk4
UrGPaxuzQN47/DIU9nkw4uEsQDi44nue+L2GWMiShcY2Z1q6CPut3l/601HnRzY7
P1f7NVH1KpkzaMClC/zBlizcrSx1zE7i6GGD+JYgeIxHTQqPXbu8Ej/aItp6ia9F
mbzyjOu3mh3CphlSPnnCOgRh16GUsvFS2lNuzSP4rGU4ex68MBed6QXeRqS3Iaa5
L5xbXdvWNiLbPUcWKkHYGPr5trElQRk2t1Sj1B5SqijlahIaZLsO8VcjEyK5NOlI
T314sBmZVAAzX7XKQQnj
=arM1
-----END PGP SIGNATURE-----

--nextPart7081761.xTLtFVgRB0--


--===============7835741004322735667==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--===============7835741004322735667==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============7835741004322735667==--


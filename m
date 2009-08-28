Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1MgxXN-000108-Ms
	for ltp-list@lists.sourceforge.net; Fri, 28 Aug 2009 09:14:25 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MgxXA-0004gl-Ry
	for ltp-list@lists.sourceforge.net; Fri, 28 Aug 2009 09:14:20 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Fri, 28 Aug 2009 05:14:02 -0400
References: <alpine.LRH.2.00.0908271703550.1134@vixen.sonytel.be>
	<1251439738.9081.9.camel@subratamodak.linux.ibm.com>
	<1251448700.9081.13.camel@subratamodak.linux.ibm.com>
In-Reply-To: <1251448700.9081.13.camel@subratamodak.linux.ibm.com>
MIME-Version: 1.0
Message-Id: <200908280514.03971.vapier@gentoo.org>
Subject: Re: [LTP]
 =?iso-8859-1?q?=5BPATCH=5D_Annotate_tst=5F*=28=29_helpers_w?=
 =?iso-8859-1?q?ith=09=5F=5Fattribute=5F=5F_=28=28format_=28printf=2C_M=2C?=
 =?iso-8859-1?q?_N=29=29=29_=28was=3A_Re=3A_=5BPATCH=5D_quotactl01=3A_Fix?=
 =?iso-8859-1?q?=09tst=5Fresm_=28=29_=09format_causing=09crash_=29?=
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============4679905769427863565=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net, subrata@linux.vnet.ibm.com
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

--===============4679905769427863565==
Content-Type: multipart/signed; boundary="nextPart1896111.QZRjM7U8qt";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1896111.QZRjM7U8qt
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Friday 28 August 2009 04:38:17 Subrata Modak wrote:
> On Fri, 2009-08-28 at 11:38 +0530, Subrata Modak wrote:
> > On Thu, 2009-08-27 at 17:29 +0200, Geert Uytterhoeven wrote:
> > > On Thu, 27 Aug 2009, Geert Uytterhoeven wrote:
> > > > When the quotactl syscall fails, quotactl01 crashes with a
> > > > segmentation fault due to an incorrect printf()-style format.
> > >
> > > This bug encouraged me to add annotations to the test helpers that ta=
ke
> > > printf()-style formats, cfr. the patch below.
> > >
> > > It causes a massive amount of compiler warnings, most of them caused =
by
> > > TEST_ERRNO being long. According to CVS history, both TEST_RETURN and
> > > TEST_ERRNO have been changed from int to long to accomodate 64-bit
> > > platforms, but to me the change of TEST_ERRNO looks bogus.
> > > As errno is int according to C99, TEST_ERRNO should actually be int
> > > too, right?
> > >
> > > Note that there are also a few other cases where integers are used on
> > > pointer type format specifiers. These will cause crashes when the code
> > > path is executed.
> > >
> > > >From 601578f79c05779acefe023fd499726d9fe4ce03 Mon Sep 17 00:00:00 20=
01
> > >
> > > From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
> > > Date: Thu, 27 Aug 2009 17:08:18 +0200
> > > Subject: [PATCH] Annotate tst_*() helpers with __attribute__ ((format
> > > (printf, M, N)))
> > >
> > > Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
> >
> > Ok. Thanks.
>
> Sorry. I need to revert this as it generates a huge set of warning for
> all the tests compiled. It should not only get fixed at test.h, but also
> in all tests that uses the tst_* family of functions, which obviously is
> too big to fix.

nothing is too big.  the proposed patch is a great idea and anything=20
preventing it from being merged should be resolved so it can go back in.
=2Dmike

--nextPart1896111.QZRjM7U8qt
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iQIcBAABAgAGBQJKl5/bAAoJEEFjO5/oN/WBp/EP/01a3PAG9xC1wue9L6jNELHw
K5fYIN4r+kTvu+ns7CIPTpjAt8UXyZaPHJLmZCOuNm6O2E/b4cAAmZ/lzRRVUJE6
vH37O12FMwyrd1Fc+Tigg5owmiDQejT6NRmx3lTqe1AbtZfUy/igHsMewjPHPKFe
bxkGnLCkfWdSHJQMSNyMff3AYWv8yMw06APud2rwZ8mNgSsFs7SZfbsA4MAmJVKI
5ofJ5YjjdU7AcoSljhNzFQwXX2U0OafT7QYfyobmNOzp5eAHsQ/emUJIVQW/v3Xj
qEjQMy9iyK7mbGEb3CytE6azMLe03j2XhfpLfsHuHH1uVsJSgGaX351JQn7wC3oy
voV/IFD6tQDIxsQvXbyiJ8UQmWK+1iaVPD8hUMrLnscyn6rJaQo8wSPIIFGQWKmM
6jA7J456onpjC9OCYedU5J0uIOO+CWUFf/z1nnZXcL92Ri4//tFMNlzpAlT9fvIK
BrGD8pGB7GqObR44NtKYnz7Kw+MbGux/FE4voidz5Z9cGnFNc7lQI6GXVfOhiwJl
t6WPbKLGx3lZ/wJIuLHeoXU/KSTxgVHfnAjAGc3rm2Y85xn1l1P+52nOedTdx36U
T3ePLJMNiqJZCcFaccMLD8qIaaNAz4oHaBmnxeOPkbrVHTAPxD2JBLVomTwXEzlu
zen1dke/wcmMll6iK81i
=kFul
-----END PGP SIGNATURE-----

--nextPart1896111.QZRjM7U8qt--


--===============4679905769427863565==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--===============4679905769427863565==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============4679905769427863565==--


Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1N6W55-0002pr-RI
	for ltp-list@lists.sourceforge.net; Fri, 06 Nov 2009 21:10:51 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N6W4z-0007GD-E2
	for ltp-list@lists.sourceforge.net; Fri, 06 Nov 2009 21:10:51 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Fri, 6 Nov 2009 16:12:10 -0500
References: <20091106095745.GA25377@basil.fritz.box>
	<364299f40911061225k2e359ae0w4466a571261e96e@mail.gmail.com>
	<20091106210225.GI819@basil.fritz.box>
In-Reply-To: <20091106210225.GI819@basil.fritz.box>
MIME-Version: 1.0
Message-Id: <200911061612.11199.vapier@gentoo.org>
Subject: Re: [LTP] LTP 20091031 Makefiles totally broken?!?
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============8254156491248780681=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Andi Kleen <andi@firstfloor.org>
Cc: ltp-list@lists.sourceforge.net, Nate Straz <nate@refried.org>

--===============8254156491248780681==
Content-Type: multipart/signed; boundary="nextPart1461193.O3lQHom3vn";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1461193.O3lQHom3vn
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Friday 06 November 2009 16:02:25 Andi Kleen wrote:
> I'm also highly surprised that this doesn't work with autoconf -- I thoug=
ht
> the whole point of autoconf was to generate portable makefiles, but
> in this case it seems to especially generate a non portable Makefile.

that is not the point of autoconf at all; it has nothing to do with makefil=
es. =20
that is the point of automake -- which we specifically are not using.  ther=
e=20
are way too many Makefiles that would need to be generated.
=2Dmike

--nextPart1461193.O3lQHom3vn
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.13 (GNU/Linux)

iQIcBAABAgAGBQJK9JErAAoJEEFjO5/oN/WBrBIQAIAWD8v1gpy759heMZMMQ3PQ
YS5TRb9vx9JEmLyRzJFAjgqDyvHunrSuyLrJq4S9db1NAGGJ7MWp/R/vovouV/6e
srRWcraCGe6SbR3P7VBPguuEYZ1GuDPZux4wQI/lrGot6UqPnSUoODAfZgtAkEks
94bd9T71RX28dwHs88E1gFWWppzbGaL2ZYXk+I6JkfWXhEx4z0I7e6ZDN6gHMryP
m5MkK0ZgnIeKlcbARXWYvZ3VFEdnHTI7CEW7J8vyAF+EksL3GMhHDQ6ycofWtxDp
3KsEDfVgf8bhIi5+WQAg5xhxzf+Wm+hilyrgEfuqpFnxGCZMM9UpA6t0rqBoHtni
hB2YlvuV3I/Y1nMPFuZFJyfHUFaucomTmjhtTzFKbg6Gsle9/ZtDcrsvQCQOLPfd
H40XA7iEB5rrT3NJxu5ewsEmLtP8Z9QiiJqzzswbRed4yX76UtqfRlFeEOx8rLsl
oKYJoV/vPFHS+t7MbjBeVos8TfVTFiocLa7SuOvLv73qGgXOflWYeyfqP4O5CCzD
699GE4qDdfobXklpG8l2pfz4oFjHC57uKZgFiJVzNZ1TB6ZfPDkus2s+ygnnN0i4
byeoqnSUSGQOXNwjZtaXijG+hR45eBlIlElVhUgZwFPZRA1/JAQaCC79kNB6dvKC
Zta8bbcUIFWNNrtG7ZtW
=mMb3
-----END PGP SIGNATURE-----

--nextPart1461193.O3lQHom3vn--


--===============8254156491248780681==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--===============8254156491248780681==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============8254156491248780681==--


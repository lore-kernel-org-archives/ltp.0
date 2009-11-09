Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1N7Zmq-0005gx-9f
	for ltp-list@lists.sourceforge.net; Mon, 09 Nov 2009 19:20:24 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N7Zmm-000802-0h
	for ltp-list@lists.sourceforge.net; Mon, 09 Nov 2009 19:20:24 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Mon, 9 Nov 2009 14:22:06 -0500
References: <1257220567.10382.3.camel@munipradeep-laptop>
	<200911031130.05930.vapier@gentoo.org>
	<1257788361.7677.70.camel@subratamodak.linux.ibm.com>
In-Reply-To: <1257788361.7677.70.camel@subratamodak.linux.ibm.com>
MIME-Version: 1.0
Message-Id: <200911091422.07495.vapier@gentoo.org>
Subject: Re: [LTP] Got warning message on ltp-full-20091031 while running
	./configure
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1850102764760021495=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: subrata@linux.vnet.ibm.com
Cc: ltp-list <ltp-list@lists.sf.net>

--===============1850102764760021495==
Content-Type: multipart/signed; boundary="nextPart14003364.IVcLecNshh";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart14003364.IVcLecNshh
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Monday 09 November 2009 12:39:21 Subrata Modak wrote:
> On Tue, 2009-11-03 at 12:30 -0400, Mike Frysinger wrote:
> > On Tuesday 03 November 2009 11:05:10 Garrett Cooper wrote:
> > > On Tue, Nov 3, 2009 at 7:50 AM, Mike Frysinger wrote:
> > > > On Tuesday 03 November 2009 08:01:08 Garrett Cooper wrote:
> > > >> >> On Tue, 2009-11-03 at 09:26 +0530, Munipradeep Beerakam wrote:
> > > >> >> > I got the following warning messages while running
> > > >> >> > "./configure" on the ltp-full-20091031. However, make and make
> > > >> >> > install worked fine.
> > > >> >> >
> > > >> >> > configure: WARNING: linux/genetlink.h: present but cannot be
> > > >> >> > compiled configure: WARNING: linux/genetlink.h:     check for
> > > >> >> > missing prerequisite headers?
> > > >> >> > configure: WARNING: linux/genetlink.h: see the Autoconf
> > > >> >> > documentation configure: WARNING: linux/genetlink.h:   =20
> > > >> >> > section "Present But Cannot Be Compiled"
> > > >> >> > configure: WARNING: linux/genetlink.h: proceeding with the
> > > >> >> > preprocessor's result
> > > >> >> > configure: WARNING: linux/genetlink.h: in the future, the
> > > >> >> > compiler will take precedence
> > > >> >> > configure: WARNING:     ##
> > > >> >> > ------------------------------------------------ ##
> > > >> >> > configure: WARNING:     ## Report this to
> > > >> >> > ltp-results@lists.sourceforge.net ##
> > > >> >> > configure: WARNING:     ##
> > > >> >> > ------------------------------------------------ ##
> > > >>
> > > >>     Yeah -- I need to find the header that defines u32 (instead of
> > > >> uint32 or uint32_t). Does anyone know which one was that again? I
> > > >> thought it was a kernel specific datatype (and in that event it
> > > >> shouldn't be exported).
> > > >
> > > > correct -- nothing in userspace should be using u32.  if the kernel
> > > > headers are, they're broken and need fixing, so complain to lkml/yo=
ur
> > > > distro.
> > >
> > >     That's what I figured -- ok. The test and the app should also be
> > > converted to straight linux/genetlink.h, because linux/genetlink.h is
> > > a superset of linux/netlink.h.
> >
> > we should get Subrata to generate the release with newer versions of
> > autotools (like autoconf-2.64) so that these warnings dont show up.  if
> > the header cant
>=20
> I upgraded my system to 2.64 just now.
>=20
> $ /usr/bin/autoconf --version
> autoconf (GNU Autoconf) 2.64
> Copyright (C) 2009 Free Software Foundation, Inc.
> License GPLv2+: GNU GPL version 2 or later
> <http://gnu.org/licenses/old-licenses/gpl-2.0.html>
> This is free software: you are free to change and redistribute it.
> There is NO WARRANTY, to the extent permitted by law.
> Written by David J. MacKenzie and Akim Demaille.
>=20
> Hope this would solve all such problems.

well, the configure script wasnt really broken before.  people just cant=20
handle any sort of warning message and reading the related log files can be=
=20
too much.
=2Dmike

--nextPart14003364.IVcLecNshh
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.13 (GNU/Linux)

iQIcBAABAgAGBQJK+GvfAAoJEEFjO5/oN/WBdz8QANRL4DF4C/ESzMttAz0AyS6z
KMyWvprO4cKPKYvkQeMCiHC2vhrfc+fto2cyUbRY4kwLnWa5Q5+8qkAshNb/OuHw
ktnHTWx2Kc4HylRJAdcN/udqHjuj/j4dDfk0kGpZTVTyGRuqbKhiKFx5ccpMOoRU
B/BmkI4QVcPT0nRC1ldRZGwPGeTybG9A7/T8LfNyuDtQsUunjm6sivPq/kBmBRTL
X0q8ElNVt9ag6HfE0dDgfwT0b9cUVhHC+ebbKvcVmM0WoExM93XsYH9vcDQJuTwu
yIc/2gG4ZHKXmyIyF+HIk13jATPPRn4zlgHY+R8qk4ZHYBijPWBJEqJNbReYHqlc
DCrNxboPR2S1wUXjf7NjtdF8V5vBd3HaLr93qffDGxclmo9SjUshfu9HwPtF+XnU
GpR4j4Q/vemwaV4krLULOxQVi9GKMrKozoM8nJMbGlkhzBGIUZAv7d0FRUc+qh2X
pbBSee02oCfKeOVd7oLtc9r3cg/PtIcF+TeMJdABUfkNnPOA/q9ouwsdOSJViU8q
hjuX/8Y7LCycgV5SCBTN7k+NL5jXc15FDj7FQK6Km5xnvKIxMWFoPxE7HGuQOBu6
zNq8Yg8pxCb4GRgWfNdyqNK64fEhMB3fKkLSQaxf3K8R54uHWjhINUiDdPncrLqF
BHsti3pvuGHyC4dazSnA
=JrjS
-----END PGP SIGNATURE-----

--nextPart14003364.IVcLecNshh--


--===============1850102764760021495==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--===============1850102764760021495==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============1850102764760021495==--


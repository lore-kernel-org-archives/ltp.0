Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1N6Mmp-0001Zo-RY
	for ltp-list@lists.sourceforge.net; Fri, 06 Nov 2009 11:15:23 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N6Mmk-0001VX-Ve
	for ltp-list@lists.sourceforge.net; Fri, 06 Nov 2009 11:15:23 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Fri, 6 Nov 2009 07:16:39 -0400
References: <20091106095745.GA25377@basil.fritz.box>
In-Reply-To: <20091106095745.GA25377@basil.fritz.box>
MIME-Version: 1.0
Message-Id: <200911060616.40305.vapier@gentoo.org>
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
Content-Type: multipart/mixed; boundary="===============6476693196973752032=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: Andi Kleen <andi@firstfloor.org>

--===============6476693196973752032==
Content-Type: multipart/signed; boundary="nextPart1519176.VrsUlzped7";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1519176.VrsUlzped7
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Friday 06 November 2009 04:57:45 Andi Kleen wrote:
> I ran configure, which seems to spend 99% of its time
> checking for stuff that is always there on any Linux,

not really.  most of the configure checks are there because people have=20
complained about specific issues trying to run on older linux distros.  and=
 we=20
arent actively blocking using LTP on other *nix systems.

> and after that I just get
>=20
> # make
> make: `testcases/realtime/configure' is up to date.
> #

=2DENEEDINFO

are you using live cvs ?  latest release ?  what distro ?  what version of=
=20
autoconf/make ?  what does `make -d` show ?

> Can we please have the old Makefiles back?

no
=2Dmike

--nextPart1519176.VrsUlzped7
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.13 (GNU/Linux)

iQIcBAABAgAGBQJK9AWYAAoJEEFjO5/oN/WBoTQP/0Yqozpq3XASznmS/HZFKk22
6b7zHTN8qEMkMvO+OWcW18o7p6R9wkpMYij5bycbnaajwWR/gJpFbUxhckdABGfC
2FBRyjuN1zAufgnq0HoUrs9ykHRScGoccuvJVO7kRbzp+YZ4h+dKUNirbMIV+B6g
xyV4lCxgj60u0yQ217FkvB/lfRb/1NO7usWtPBv6X4bal0cbklxKcDiyowYD/8qR
6aThktnat+OcTt97Z5BIVTY12rTdRTM9dpuxV5+e8XUO8UbI4K/AadPShdK4T4oB
obD818fC7Pp4hFGX9gohLPyoQnEK3Hv8jk1iWgdbL9zuUDkGhwfjdVlxByzb3FQT
K3quRb6xdDcQoD2LYHfgai5JhN8Tbcj2Aw92P0nJPUOuLwRk5eN0R5N5guBtyRHv
F2oMre3omhJWel0iFdETS8VUZNhSQX81AkXuWNpMZGQCAb0wbNWR3Y8/4rlXDF2n
uZyxhNU6idYHthGIH9yzmMfM8fGzxgaDIUKHCPVXKv4WAXC54emPfMoK7ZkWXkyR
jJqJOJdm0qyAe4mv8DwSvUQ1aj3pxIcolukhwOSkQYJWL5TPnDYfmejr31OvElk3
jvxrEhjf+7GgyzgxfumcmrJVMaGheT6nYbUhFqvgtlXVgm3tr6brvNIk0QZnLN4f
+U2Jc2YSbYK6Awi7IONw
=R6Bv
-----END PGP SIGNATURE-----

--nextPart1519176.VrsUlzped7--


--===============6476693196973752032==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--===============6476693196973752032==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============6476693196973752032==--


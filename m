Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1N6Ojo-0002TC-Qt
	for ltp-list@lists.sourceforge.net; Fri, 06 Nov 2009 13:20:24 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N6Oji-00063Z-9n
	for ltp-list@lists.sourceforge.net; Fri, 06 Nov 2009 13:20:24 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Fri, 6 Nov 2009 09:21:39 -0400
References: <20091106095745.GA25377@basil.fritz.box>
	<200911060616.40305.vapier@gentoo.org>
	<20091106130906.GW31511@one.firstfloor.org>
In-Reply-To: <20091106130906.GW31511@one.firstfloor.org>
MIME-Version: 1.0
Message-Id: <200911060821.40182.vapier@gentoo.org>
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
Content-Type: multipart/mixed; boundary="===============6659670031617139262=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Andi Kleen <andi@firstfloor.org>, Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

--===============6659670031617139262==
Content-Type: multipart/signed; boundary="nextPart4310020.fxbcaTqoLv";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart4310020.fxbcaTqoLv
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Friday 06 November 2009 08:09:06 Andi Kleen wrote:
> On Fri, Nov 06, 2009 at 07:16:39AM -0400, Mike Frysinger wrote:
> > On Friday 06 November 2009 04:57:45 Andi Kleen wrote:
> > > I ran configure, which seems to spend 99% of its time
> > > checking for stuff that is always there on any Linux,
> >
> > not really.  most of the configure checks are there because people have
> > complained about specific issues trying to run on older linux distros.=
=20
> > and we
>=20
> I always just deleted the tests that didn't build. That's far better
> than not building at all like now.

perhaps an acceptable workaround for you, but certainly not for most people

> > arent actively blocking using LTP on other *nix systems.
>=20
> yes you're just actively blocking running LTP on Linux now it seems.

please refrain from filling e-mails with unrelated BS

> > > and after that I just get
> > >
> > > # make
> > > make: `testcases/realtime/configure' is up to date.
> > > #
> >
> > -ENEEDINFO
> >
> > are you using live cvs ?  latest release ?  what distro ?  what version
> > of
>=20
> See Subject on SUSE 10.0
>=20
> > autoconf/make ?  what does `make -d` show ?
>=20
> autoconf doesn't matter because I didn't regenerate the script.
>=20
> GNU Make 3.80

looks like a bug in make-3.80.  works fine with make-3.81.  care to take a=
=20
look Garrett ?

usually i just install older versions on my system as `make-$VER` to make=20
testing different ones easy.  since all the makefiles use $(MAKE), this=20
shouldnt be a problem to execute `make-$VER` instead of `make`.
=2Dmike

--nextPart4310020.fxbcaTqoLv
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.13 (GNU/Linux)

iQIcBAABAgAGBQJK9CLkAAoJEEFjO5/oN/WBNs8P/36EBDufzqc4vpoQpLEe9p0U
RAq5fBA7IwQpMi4lthT9LF9pIOyfcHQTKilaHFeYHd4WYBBMeJnpZdsZapDlxwHs
rWWb5jqC6a0z9BSwpKeKrneepRN4RaaFJRbTOmYFJLkKv1c7nYZH+U4vaznFHWK8
9M0Q0FSsTD7yhRD3Tdptnr82xeG6eVs/iOLXiRmyN61A83Agr/7X+nPPaudTXeJf
Vq6+25W7LyLoB+Ghd1EZttuhyWfVuXaBgHsISEyK8E9wLWzw+l1VlCCkGcn5K05y
jhNgqJFWFCmYUKFs/rsrvXSjjE+Tall9NFd95S8NB67qyh3zZ/eRPZj/yHrSHIvI
O7DNdiTG/xJcCdaqB32rRm3UolDVZc9TU/sQ53pB7NSqrZZhTPWhh+cBWT1gBuFb
eVhL6M/XG4EpwLeulCff8AOtPlkSSz+NTIyd5Hpreyp75I7hgQSd8iHCIksgKfof
9mL3763KUarGXrglKSLVBHUmZ3okkRoclJ12thMo7w0rFwXq0n99VjUnbkYJumpZ
3UNyN7swYBHxGVn4iyab178wtYiwdeDwu3JoZciL6kkoS70RajAWl7rTplGqVrQE
usG/uFKCr11rPuIHi2ppFyZk68T89398tBUbbyTXFbbPLAHPdyfBbUcgZEPflGuj
Fa5fKKE/PtFyurvsqzqL
=1Clp
-----END PGP SIGNATURE-----

--nextPart4310020.fxbcaTqoLv--


--===============6659670031617139262==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--===============6659670031617139262==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============6659670031617139262==--


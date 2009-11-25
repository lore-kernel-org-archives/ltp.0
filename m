Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1NDCMe-00088c-EN
	for ltp-list@lists.sourceforge.net; Wed, 25 Nov 2009 07:32:36 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NDCMZ-0000Vs-3v
	for ltp-list@lists.sourceforge.net; Wed, 25 Nov 2009 07:32:36 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Wed, 25 Nov 2009 02:36:21 -0500
References: <000001ca6d7c$63dc8890$2b9599b0$@co.jp>
	<200911250033.23404.vapier@gentoo.org>
	<364299f40911242226g68c37f59r1fcfd23ad87dd1e@mail.gmail.com>
In-Reply-To: <364299f40911242226g68c37f59r1fcfd23ad87dd1e@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <200911250236.22440.vapier@gentoo.org>
Subject: Re: [LTP] mbind01 test failed with after ltp-2009-11-12.tar.gz
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1228863259734583951=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net, Nate Straz <nate@refried.org>, Mitani <mitani@ryobi.co.jp>

--===============1228863259734583951==
Content-Type: multipart/signed; boundary="nextPart1325062.lHBGG3uGJ2";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1325062.lHBGG3uGJ2
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Wednesday 25 November 2009 01:26:20 Garrett Cooper wrote:
> On Tue, Nov 24, 2009 at 9:33 PM, Mike Frysinger <vapier@gentoo.org> wrote:
> > On Wednesday 25 November 2009 00:17:16 Garrett Cooper wrote:
> >> --- regen.sh  19 Nov 2009 19:35:15 -0000      1.12
> >> +++ regen.sh  25 Nov 2009 05:12:13 -0000
> >> @@ -32,8 +32,13 @@ static void cleanup(void);
> >>               tst_brkm(TCONF, cleanup, "syscall " #NR " not supported =
on
> >> your arch"); \\ errno =3D ENOSYS; \\
> >>               __ret =3D -1; \\
> >> -     } else \\
> >> +     } else { \\
> >>               __ret =3D syscall(NR, ##__VA_ARGS__); \\
> >> +             if (__ret =3D=3D -1 && errno =3D=3D ENOSYS) { \\
> >> +                     tst_brkm(TCONF, cleanup, "syscall " #NR " not
> >> supported on your arch"); \\ +                 errno =3D ENOSYS; \\
> >> +             } \\
> >> +     } \\
> >>       __ret; \\
> >>  })
> >>  EOF
> >
> > i'd prefer this change
> > --- testcases/kernel/include/regen.sh   9 Oct 2009 17:55:48 -0000     =
=20
> > 1.11 +++ testcases/kernel/include/regen.sh   25 Nov 2009 05:28:27 -0000
> > @@ -30,11 +30,12 @@ static void cleanup(void);
> >  #define syscall(NR, ...) ({ \\
> >        int __ret; \\
> >        if (NR =3D=3D 0) { \\
> > -               tst_brkm(TCONF, cleanup, "syscall " #NR " not supported
> > on your arch"); \\ errno =3D ENOSYS; \\
> >                __ret =3D -1; \\
> >        } else \\
> >                __ret =3D syscall(NR, ##__VA_ARGS__); \\
> > +       if (__ret =3D=3D -1 && errno =3D=3D ENOSYS) \\
> > +               tst_brkm(TCONF, cleanup, "syscall " #NR " not supported
> > on your arch"); \\ __ret; \\
> >  })
> >  EOF
>=20
>     Ok -- that makes more sense.. besides, I think gcc was optimizing
> out the first branch with -O2 if it always evaluated to false. Here's
> the new patch (I'm keeping the errno =3D ENOSYS part because I want to
> make sure that tst_brkm doesn't mess up the errno value if a write(2)
> fails or something).

i thought tst_brkm exited when called with a cleanup func like we do here
=2Dmike

--nextPart1325062.lHBGG3uGJ2
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.13 (GNU/Linux)

iQIcBAABAgAGBQJLDN52AAoJEEFjO5/oN/WBKlgP/18U+uEmR/KY0E+oromkvidX
QEVuc9AFcM1r+bYWTy+k74HhsxgN/aa8nuB9zCVKWX6B/SsZ6XswHzx/6cAEELjw
wIRsxGOYQWT+k5D6v9PS4/Pzvx7UL7uw/zG/5Hyb8BTmbneRcR52i49VZE1SiN4j
xyX+tYaK4p0JriddwbcU809MQLv1LxJAjxlbpRKWMbUUUhJK0Y67yKxbtzIiEfA8
tD4fHG2eW5aWLcF3PYJAb1Ug8BBuHCy+cMtaZbhrBEyxqkgu57XvpZrrSN4EvqsT
TiCLEUeqDMH7fwOmIfzOHRRLVZGJP/CynJ1/Un6RY9T2Xmn8tvdJ5Rqp6d2Op6aI
msuFsPhfdB7nGJ+kmyZ3TtS6frDe/cjwvdL0Yb4x5yA3mA3oO3+a+rQ2AYAyPXQX
wPHvSAhUfBtSjSTJV87GiAh4R97M12dOsNRpBKAbcuVAmjjCOzm6zUsupUgNaiOg
A+ms/xDfZ/Oeg/tYDHoVZVIR/6lCzaf/zrw4DWR94j395FbtS5pm/mTedCUl8AUJ
5JTy3Vfb0WAHyeGWI98p81ajSIMz/thRpTB21CIXGQ0n0E8Zme0ha9PzLSOSO3Xd
ni/lROXXlFtBmvI1rBJxoSxLg+2fICTWEPxvj338EdSt/6TQZrgr7RKivVukRZWy
mzFxbEc5VDzJHLdIWfO4
=OPl9
-----END PGP SIGNATURE-----

--nextPart1325062.lHBGG3uGJ2--


--===============1228863259734583951==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--===============1228863259734583951==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============1228863259734583951==--


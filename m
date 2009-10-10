Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1MwkWN-0007sY-DT
	for ltp-list@lists.sourceforge.net; Sat, 10 Oct 2009 22:34:39 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MwkWH-0002rs-3R
	for ltp-list@lists.sourceforge.net; Sat, 10 Oct 2009 22:34:39 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Sat, 10 Oct 2009 18:34:25 -0400
References: <364299f40910091048w54ece725l2b07a04bb82f6a4f@mail.gmail.com>
	<200910101551.16789.vapier@gentoo.org>
	<364299f40910101502l19472085v233d75751e1badb6@mail.gmail.com>
In-Reply-To: <364299f40910101502l19472085v233d75751e1badb6@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <200910101834.26319.vapier@gentoo.org>
Subject: Re: [LTP] mixing of install/build targets
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============9175487761282365100=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

--===============9175487761282365100==
Content-Type: multipart/signed; boundary="nextPart22043112.ddLK6svzBR";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart22043112.ddLK6svzBR
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Saturday 10 October 2009 18:02:47 Garrett Cooper wrote:
> On Sat, Oct 10, 2009 at 12:51 PM, Mike Frysinger wrote:
> > On Friday 09 October 2009 13:48:42 Garrett Cooper wrote:
> >>     I'm posting the following diff as reference (it's compressed
> >> because the entire diff is ~1.8MB) as I'm now going to commit the
> >> following to CVS after 1.25 years of anticipation waiting for this
> >> enhancement in the Makefiles to correct issues related to difficulty
> >> primarily in 1) terms of maintenance, 2) lack of out-of-build-tree
> >> support, and 3) the fact that we weren't following autoconf-like
> >> practices for installation [ties into 1) and 2)].
> >>     If there are any issues in building the sourcebase after this,
> >> please consult the TODO file in the root directory to determine
> >> whether or not it's a known issue. If the issue isn't listed there,
> >> please email the list and CC me. I ran it on Fedora 10, Gentoo Linux,
> >> and Ubuntu Feisty Fawn, so I tried to get as much coverage as possible
> >> when making these changes.
> >
> > seems like the compile step depends on install dirs.  a simple make in a
> > subdir fails with:
> > $ make
> > mkdir -p "/opt/ltp/testcases/bin"
> > mkdir: cannot create directory `/opt/ltp': Permission denied
> > make: *** [/opt/ltp/testcases/bin] Error 1
> >
> > or if prefix isnt set:
> > $ make
> > mkdir -p "/testcases/bin"
> > mkdir: cannot create directory `/testcases': Permission denied
> > make: *** [/testcases/bin] Error 1
>=20
>     Both of these items requires the appropriate prefix to be put in
> config.mk, and/or the definition of DESTDIR, because the new Makefile
> infra installs directly to the destination folder.
>     I'll go and fix the latter case though...

i'm not sweating requiring the prefix to be sane via confgure/config.mk/...=
 =20
i'm saying the compile step should not be needing things in the prefix.  th=
at=20
includes the creation of the install prefix (i just did a cvs up and that=20
seems to be fixed), and building against the headers/libraries.  that seems=
 to=20
be broken atm:
$ make
gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall  -I//opt/ltp/include -
I../../../../include  -L//opt/ltp/lib   ptrace04.c  -laio -lltp -o ptrace04
/usr/lib/gcc/x86_64-pc-linux-gnu/4.4.1/../../../../x86_64-pc-linux-gnu/bin/=
ld:=20
cannot find -lltp
collect2: ld returned 1 exit status
make: *** [ptrace04] Error 1

those paths against the configured prefix (/opt/ltp) should not be there.  =
we=20
should be compiling against the local include only ($(top_srcdir)/include) =
and=20
linking against the local lib only ($(top_builddir)/lib).

also, it seems like the lib subdir is missing a default dependency on the=20
libltp.a library:
$ cd lib
$ make clean
rm -f -f libltp.a *.o *.pyc
$ make
make: Nothing to be done for `install'.
$ make libltp.a
<correct output>

actually, now that i see this output, i guess the problem is that the defau=
lt=20
target is "install" instead of "all" (which implies compiled local objects=
=20
only) ?
=2Dmike

--nextPart22043112.ddLK6svzBR
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iQIcBAABAgAGBQJK0QvyAAoJEEFjO5/oN/WBzrsP/0rixG/JJUllXEWcMuKEoe6z
08Oe8hs16Y9le6QKbHSXp9ar8KyEYIyFP/5plm3jQ+14e/dElBIHK+RhHZZeWjKA
/8qZl38zrjOl8Ffm5QcThCAj2MZFACLHIJ1GnCmXAlRAMLv6Oxzu+zfoep6Jt47s
O9a/NH3yg64ye3d1PiVgO4M4okwBtBeafgPOqfU9FnpbpnyYcggdnG6o5DWFnk67
BtooIYZ1vHveAzg2slIhkX7WJ+bMHGw85E7+wEvhfiVhfcr3vZUPfYK2jLKRMZu0
JwBhHVoy+9gLm/0mol7cjPzA5w97PijCjnnRjFrWP8M2vJnAuDGYCaQ3tm2Em5Pw
yBeA0oNh+fc/7WT+P/QpKtoKwuqJJfHB2KtXXJgXa0I9+2hilWJuPvUycZiPY6jE
YSiUY7+ITzKH7vFhCB5DzVEs1d6Ubz0zywC70+G+xux+tzkRo2D/a0GNLG9tAjmj
o8SBQrksBXF/P/0w1V66KzbjgWEWY1faWWnDjokQAlHRGKOzrw8lIrczBo5/TC53
u8kOxMO0Mh3whN5s9EWZ6ir5wcrvFUtMDG3pZMwSmG2GeSm9B6XtIcZ4Mg5LxOvs
oE1vV+TIruJAuLa/LDxV0RGP0kQT1bjt9Bx5iasgJHNFSpug6+Th7diKfYdotQL8
81hIJF3mktXASvyBWI5T
=Ljmj
-----END PGP SIGNATURE-----

--nextPart22043112.ddLK6svzBR--


--===============9175487761282365100==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
--===============9175487761282365100==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============9175487761282365100==--


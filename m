Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1N5MFs-0001ih-88
	for ltp-list@lists.sourceforge.net; Tue, 03 Nov 2009 16:29:12 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N5MFl-00068p-Nu
	for ltp-list@lists.sourceforge.net; Tue, 03 Nov 2009 16:29:12 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Tue, 3 Nov 2009 12:30:04 -0400
References: <1257220567.10382.3.camel@munipradeep-laptop>
	<200911031050.38755.vapier@gentoo.org>
	<364299f40911030805m5e40d9c8w74a69d7f452200f8@mail.gmail.com>
In-Reply-To: <364299f40911030805m5e40d9c8w74a69d7f452200f8@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <200911031130.05930.vapier@gentoo.org>
Subject: Re: [LTP] [Ltp-results] Got warning message on ltp-full-20091031
	while running ./configure
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============9176481829317054149=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net, ltp-list <ltp-list@lists.sf.net>

--===============9176481829317054149==
Content-Type: multipart/signed; boundary="nextPart1425083.zxLOelZbN9";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1425083.zxLOelZbN9
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Tuesday 03 November 2009 11:05:10 Garrett Cooper wrote:
> On Tue, Nov 3, 2009 at 7:50 AM, Mike Frysinger <vapier@gentoo.org> wrote:
> > On Tuesday 03 November 2009 08:01:08 Garrett Cooper wrote:
> >> >> On Tue, 2009-11-03 at 09:26 +0530, Munipradeep Beerakam wrote:
> >> >> > I got the following warning messages while running "./configure" =
on
> >> >> > the ltp-full-20091031. However, make and make install worked fine.
> >> >> >
> >> >> > configure: WARNING: linux/genetlink.h: present but cannot be
> >> >> > compiled configure: WARNING: linux/genetlink.h:     check for
> >> >> > missing prerequisite headers?
> >> >> > configure: WARNING: linux/genetlink.h: see the Autoconf
> >> >> > documentation configure: WARNING: linux/genetlink.h:     section
> >> >> > "Present But Cannot Be Compiled"
> >> >> > configure: WARNING: linux/genetlink.h: proceeding with the
> >> >> > preprocessor's result
> >> >> > configure: WARNING: linux/genetlink.h: in the future, the compiler
> >> >> > will take precedence
> >> >> > configure: WARNING:     ##
> >> >> > ------------------------------------------------ ##
> >> >> > configure: WARNING:     ## Report this to
> >> >> > ltp-results@lists.sourceforge.net ##
> >> >> > configure: WARNING:     ##
> >> >> > ------------------------------------------------ ##
> >>
> >>     Yeah -- I need to find the header that defines u32 (instead of
> >> uint32 or uint32_t). Does anyone know which one was that again? I
> >> thought it was a kernel specific datatype (and in that event it
> >> shouldn't be exported).
> >
> > correct -- nothing in userspace should be using u32.  if the kernel
> > headers are, they're broken and need fixing, so complain to lkml/your
> > distro.
>=20
>     That's what I figured -- ok. The test and the app should also be
> converted to straight linux/genetlink.h, because linux/genetlink.h is
> a superset of linux/netlink.h.

we should get Subrata to generate the release with newer versions of autoto=
ols=20
(like autoconf-2.64) so that these warnings dont show up.  if the header ca=
nt=20
be compiled, then we want it marked as not usable and so the related tests =
get=20
skipped.
=2Dmike

--nextPart1425083.zxLOelZbN9
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.13 (GNU/Linux)

iQIcBAABAgAGBQJK8FqNAAoJEEFjO5/oN/WBT8AP/3CD6UYXSbw/X5L+4A/NutwS
9qn1x0xYqMwmA/L57SKYPoO8I2xEjsAVjPEucqFfGcir/5B6o6hGSj846g6ExcUa
uwG4j6bl984VlWVaSLKyYzZIxSQFzlesvD0atAZVBnmj8xruSiFXUR1Y3Iirzn3K
ogediytYrAbMtVcimq/ZdLUIGc1Z6nS16+0PIEAEzyp8t1+OopX7ACj3Ipp+dtRv
GAYsjcNdYmMu/WGZhcK9YYbhr5ydFrX0/GAB75egRyua/kBJS/a22SM36KwhILs1
GxtrMELBDjTQkt9/PfZdvE6IBjyMt03tpY00c3oAUbYRM17BqIA5Oclw5O9obzR2
TFUbuvN8QPmL83PoAYcPqKVaFUKy0MTxtuow1fLhritBmRwFmxHiXb7jSaqXjsV+
C/laTeNb+focMDqupqTKLpzz65gJHNSGUFb1kgWs1hpzcT1YFcl8QyEmBO4OMc3l
6QIIuqDUA9hDASoY6aFnGBoW2Lj+k23RA3sRUmhtrFNKm9wCO6RuF0s4wel1CauS
mjNBk2f5XdUn2fRaApUysm9IN7FSVsXolsMsh3yJ6C1roGTknGf0l18UspvsYn9t
NujEEI6YZXy0yDXmjPEEONZpZfGyH7DM/sS89BgLkBp4I/8guKl7EFuZALT9K7dK
CE42+l6LHq5uYVYIMVId
=yKiB
-----END PGP SIGNATURE-----

--nextPart1425083.zxLOelZbN9--


--===============9176481829317054149==
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
--===============9176481829317054149==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============9176481829317054149==--


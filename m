Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1SFUPH-0005KK-NG
	for ltp-list@lists.sourceforge.net; Wed, 04 Apr 2012 17:54:07 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1SFUPD-0000kx-Iu
	for ltp-list@lists.sourceforge.net; Wed, 04 Apr 2012 17:54:07 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Wed, 4 Apr 2012 13:54:17 -0400
References: <alpine.BSF.2.00.1204032222300.25027@toaster.local>
	<201204041322.39735.vapier@gentoo.org>
	<CAGH67wR-2oyoiqiP1mBzinJ_AokW4Ce0yj5riuih1KTO0kUBcA@mail.gmail.com>
In-Reply-To: <CAGH67wR-2oyoiqiP1mBzinJ_AokW4Ce0yj5riuih1KTO0kUBcA@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <201204041354.18403.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH 0/4] Replace commonly used perl tools with awk
	equivalents
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============4061904129251348466=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

--===============4061904129251348466==
Content-Type: multipart/signed; boundary="nextPart1934724.IFqATFoORq";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1934724.IFqATFoORq
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Wednesday 04 April 2012 13:31:10 Garrett Cooper wrote:
> On Wed, Apr 4, 2012 at 10:22 AM, Mike Frysinger <vapier@gentoo.org> wrote:
> > On Wednesday 04 April 2012 01:23:43 Garrett Cooper wrote:
> >> The intent behind these changes are to remove unnecessary perl
> >> dependencies in LTP by using awk in its stead. It was something that w=
as
> >> discussed a while ago on ltp-list@.
> >=20
> > i like awk over perl a lot.  my only concern is non-POSIX stuff slipping
> > in (such as people who have gawk installed).  should we add a local
> > wrapper script that sees if the awk accepts a --posix flag and
> > automatically pass it ?
>=20
> That's actually a gawk-ism :)...

yes, that's why i phrased it "if the awk accepts"

awk --help | grep -q -e --posix && args=3D"${args} --posix"

> Seeing how Android and some other Linux distros like borrowing bits
> and pieces from BSD, I think that using --posix might not guarantee
> much (on the bright side it doesn't error out either with 'the
> one-true-awk'):

perhaps, but gawk provides a lot of useful funcs that i know i use that are=
n't=20
in POSIX, and we want to make sure these things don't slip in.  telling peo=
ple=20
"make sure you test with XXX awk" is certain to be error prone.

plus, there are certain edge conditions which are very subtle.  consider th=
e=20
handling of substr() and the starting position of "0":
	echo abc | mawk '{print substr($0, 0, 2)}'  -> a
	echo abc | gawk '{print substr($0, 0, 2)}'  -> ab
	echo abc | mawk '{print substr($0, 1, 2)}'  -> ab
	echo abc | gawk '{print substr($0, 1, 2)}'  -> ab

> I understand the goals, but looking at the manpage on opengroup and
> through one-true-awk's source, there's nothing consistent that
> guarantees that POSIX is adhered to in awk (but there probably should
> be a flag, environment variable, etc).

POSIX should be the LCD we work with without accidentally using something t=
hat=20
is specific to a single awk
=2Dmike

--nextPart1934724.IFqATFoORq
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJPfIrKAAoJEEFjO5/oN/WBa6UP+wUq/kH11MV+ee6ZfJGJcdOZ
N1LZsdRks9GEqJ9KrCbYBW3Q3whtd+oQJHJIlHAhGXen93wI5PqdVZuFrElU/LAx
thAVYDeZW+MsX0/cmqugW/zK5z7FWrjnhua+k3/HF4RDVLI/Vmr+nP1ocUvsjEu+
d7u64vRrRztOw1hk4eaZAdrwio+8DhR75GRgaQLNP2JHoRU0mYzclv6qqp3detcs
x2TDguFNB9rFlBaasmP4v5jXKEo95YWWTh3HIlMi8UPkSRVnZAsS3jyyXA1/ORGR
M+Pm1LBJk27RUjneuoT2MEDDw5XhLprXXGnsq8je0Bw6SdgCQB6P30kHClqT0Mrx
7h4Y3fX9dpCvioioM5p+UBcZAa3RhAyn2N2ojL+LjG6x/bJPyrAcD6MGiVVaKxMD
NHkooEEN62ZfKpqFMANGiy+ibVZYdCZCpNgjDcqjFCy3SbWPzXX3bY90FgK20eR1
OuLmEJ7Tu5iCvNKGLNygzXhtvR7WWRLvCGzd+Gaq1v2XyNCwvwgTK1JwUMqyQVEY
wMoyWSoVu0AHWU1U7j3Qm9eDzwORBJFsfUbvRZNuBzLGRh7pL8EElqMBG04SSvjz
duqxTbUDRccu6dqSD5MqEoMTUmwbR9HoM/ZtyyV66vAe+IpdOGoMFew9xItxX4x/
cNtTs4asAT/k8A1SZ5ir
=58t/
-----END PGP SIGNATURE-----

--nextPart1934724.IFqATFoORq--


--===============4061904129251348466==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Better than sec? Nothing is better than sec when it comes to
monitoring Big Data applications. Try Boundary one-second 
resolution app monitoring today. Free.
http://p.sf.net/sfu/Boundary-dev2dev
--===============4061904129251348466==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============4061904129251348466==--


Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1N6Vwy-0000eb-Pn
	for ltp-list@lists.sourceforge.net; Fri, 06 Nov 2009 21:02:28 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N6Vws-000644-Dj
	for ltp-list@lists.sourceforge.net; Fri, 06 Nov 2009 21:02:28 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Fri, 6 Nov 2009 16:03:45 -0500
References: <1257167821.4977.41.camel@subratamodak.linux.ibm.com>
	<87iqdn76jg.fsf@basil.nowhere.org>
In-Reply-To: <87iqdn76jg.fsf@basil.nowhere.org>
MIME-Version: 1.0
Message-Id: <200911061603.47785.vapier@gentoo.org>
Subject: Re: [LTP] [ANNOUNCE] The Linux Test Project has been Released for
	OCTOBER 2009
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============3508395160663150955=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: ltp-list <ltp-list@lists.sf.net>, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, Andrew Morton <akpm@linux-foundation.org>

--===============3508395160663150955==
Content-Type: multipart/signed; boundary="nextPart2309661.SqQ7l2ASyA";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2309661.SqQ7l2ASyA
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Friday 06 November 2009 15:16:35 Andi Kleen wrote:
> Subrata Modak <subrata@linux.vnet.ibm.com> writes:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > OCTOBER 2009 Highlights:
>=20
> s/High/Low/
>=20
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >      1. LTP Makefiles rewrite:(Project started 1.2 years back)
> >              I. To accommodate correct build/installation practices,
> >             II. better integrate Autoconf/Automake with tests for safer
> >                 builds,
> >            III. better cross-compilation of LTP sources.
>=20
> Just as a warning for everyone: that change broke building on most old
> distributions and there seems to be no interest in fixing that.

clearly as an active developer you should know better.  you dont get people=
 to=20
agree with and/or help you by pointlessly antagonizing them.
=2Dmike

--nextPart2309661.SqQ7l2ASyA
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.13 (GNU/Linux)

iQIcBAABAgAGBQJK9I8zAAoJEEFjO5/oN/WB4EwQAKX83vQLxg2juYpSzTEZhqjq
SgDGxGnz2hk0rcMOwsxUma+YIga7CnXwVXcn2qdkH8llnMPv0x89Rp4uair8QAg/
XjaHW+MiAxTgJKp2XFV+MnzApi6eK9tsxEUojypJV9VBHIOHgWqKUWUER8Xq5l7x
7rFS2EyRRW18dwworPTf8XQxiAmLQzZdlQ7tCiQEmqPcAygYUwmWNBBNtpRZB7rv
YSXAisAlI7aqhIw4Qc1kb3S9Kh+LxPP8K02Lfh2/tFgqHn51eINOllLicAVr+Prp
FzLUjOf52uIRWyl5M27oEFb5x5bt3ye24FWeGOL6R6VBHlHxZ6wu1VkcVi43Ynpu
3zpWdl0kNjMsogYf1qf4oIfKp49m6I4RCHGnRotdKzHP4fQi8bM7uvko0U8XkKao
5GRwL93zrRxHC+qBxUEE8Khhcerv7VIC/pjXUZBxZKJm3ic8CyZKCpORERVz6nPm
9r/gMXXAHXVgU5pVwsnDgMmYwFWZ+yVIeAqbKBXJtjhxHp77I5qlvUZHF320Waai
6zozcSPPJn3HUMNSesZkFqhFCP+Xc1SBLTpa+0aZ347r0LSbKY4o/2lT1nAB3G3W
D5vgp9eS3F36mhKdhc2bAt3F3LuLsP5i7yVLb5JfpopC8beWTsQnikxNKmKpNATJ
e4X+YwOgbK5ih38geUva
=SH/k
-----END PGP SIGNATURE-----

--nextPart2309661.SqQ7l2ASyA--


--===============3508395160663150955==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--===============3508395160663150955==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============3508395160663150955==--


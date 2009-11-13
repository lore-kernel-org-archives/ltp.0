Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1N8mqI-0006Qi-0z
	for ltp-list@lists.sourceforge.net; Fri, 13 Nov 2009 03:28:58 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N8mqA-0004me-78
	for ltp-list@lists.sourceforge.net; Fri, 13 Nov 2009 03:28:57 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Thu, 12 Nov 2009 22:31:04 -0500
References: <7273615.240961258006837527.JavaMail.coremail@bj126app93.126.com>
In-Reply-To: <7273615.240961258006837527.JavaMail.coremail@bj126app93.126.com>
MIME-Version: 1.0
Message-Id: <200911122231.05302.vapier@gentoo.org>
Subject: Re: [LTP] make error
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5456770099503810364=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: yali_ning <yali_ning@126.com>

--===============5456770099503810364==
Content-Type: multipart/signed; boundary="nextPart1339569.0U9yy95nZE";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1339569.0U9yy95nZE
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thursday 12 November 2009 01:20:37 yali_ning wrote:
>   I came across an error , when compiling the ltp-20091030. the step is :
>=20
> gcc -Wall -g -Os -g -O2 -fno-strict-aliasing -pipe -Wall=20
>  -I/mnt/sdb1/nly1/ltp-1030/ltp-full-20091031/testcases/kernel/include
>  -I../../../../include -I../../../../include   -L../../../../lib  vfork.c=
 =20
>  -lltp -o vfork In file included from /usr/include/asm/ptrace.h:58,
>                  from /usr/include/linux/ptrace.h:49,
>                  from vfork.c:45:
> /usr/include/asm/fpu.h:57: error: redefinition of 'struct ia64_fpreg'
> In file included from /usr/include/linux/ptrace.h:49,
>                  from vfork.c:45:
> /usr/include/asm/ptrace.h:208: error: redefinition of 'struct
>  pt_all_user_regs'

this should be fixed already in latest cvs
=2Dmike

--nextPart1339569.0U9yy95nZE
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.13 (GNU/Linux)

iQIcBAABAgAGBQJK/NL5AAoJEEFjO5/oN/WBU+kP/00qsHCxhd3CCi6KptiOV9hg
7YqzDrovptRLzul5butikiDQz1A97V5X7ID912tX7o/Cdox2+zvmpS6oo/FPo1/c
kAqSBel/CyF+kGCt2MwiaKmn35kvao+KI6xrW5PuAHAktrjR55MxsRkWtl44SmLf
LlEay/hrF0x+7xrhSaWLllTfpDx+swP8Vk7qotGZKwmUmprBslsWaFkYmHlT3VMg
uo2jst9q4IFo8gTD7064v1cjDCQyKou/wQzWLV8cK3cxMzLfRnoKf8xX5lK1x4y0
woOHojrCGArgCnSrXOi+qUOEb8Ri807pIJINgsx/ySvcKPAw1oEytmg7EjMqKlwa
CoW7vHBr7VzAo/Zo69wG4bzEXHPmDkhA2kWLBlX1bP0iYDpCDYrKAtPxBrFQuQ/B
ZIlCvqhdmeROTlAHBv9w7QgARGhgOWy8EXpZ9zAval4Q5Pe/ApvQychP5DL48o2V
F6+rRPvOZXP69WP6RC8OrW9/BfXrG5YHvLWZqZzzJJ2uvcobpd1TjYYh+YJYDdR9
TqdrUF2CR5i/m7T/VkKWJe1XOiOPboOBmKssCX/08oVe2JKPfs9YwPlOu0qbf1uA
maM3P0f2H1edtRlJlelo4BEmeS4DY2x6bD/wV0MNk0hP58IcsHGsU6Oik+00roj0
mirvQUeb8QQVInsSCsHg
=o13h
-----END PGP SIGNATURE-----

--nextPart1339569.0U9yy95nZE--


--===============5456770099503810364==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--===============5456770099503810364==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============5456770099503810364==--


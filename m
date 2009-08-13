Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1MbWJQ-00004u-TT
	for ltp-list@lists.sourceforge.net; Thu, 13 Aug 2009 09:09:32 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MbWJK-00088U-Id
	for ltp-list@lists.sourceforge.net; Thu, 13 Aug 2009 09:09:32 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Thu, 13 Aug 2009 05:09:18 -0400
References: <200907031601.52650.vapier@gentoo.org> <4A736253.90209@us.ibm.com>
In-Reply-To: <4A736253.90209@us.ibm.com>
MIME-Version: 1.0
Message-Id: <200908130509.19765.vapier@gentoo.org>
Subject: Re: [LTP] futex syscall tests
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============9167902532131560903=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Darren Hart <dvhltc@us.ibm.com>
Cc: LTP <ltp-list@lists.sourceforge.net>

--===============9167902532131560903==
Content-Type: multipart/signed; boundary="nextPart1512811.irKdXvnQTR";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1512811.irKdXvnQTR
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 31 July 2009 17:29:55 Darren Hart wrote:
> Mike Frysinger wrote:
> > are there any futex syscall tests already in ltp that i cant seem to
> > locate ? if not, i can adapt the few that already exist in the libfutex
> > code ...
>
> I recently done a lot of cleanup and a couple feature additions to the
> kernel futex code.  In doing so I was noticing the lack of a good futex
> system call test suite.  I had started a writeup of what such a test
> suite should accomplish.  I hadn't decided if I wanted to push it to LTP
> eventually or not.  As it sounds like you may have similar interests in
> this test, please find my very early, very incomplete, initial thoughts
> on such a testsuite.

i noticed recently the checkpoint/resume guys seem to have already started=
=20
some.  google for "c/r futex".
=2Dmike

--nextPart1512811.irKdXvnQTR
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iQIcBAABAgAGBQJKg9g/AAoJEEFjO5/oN/WBHLEP/3SDL5huS+ClAB/6FDiTK7RE
WFKPJypy8zo4dGwnpd+8V8GSf9Dibx+ODEmQS5UmdZ6C9DVHP+WQo47lVvxxKgLn
Olx5QGcXaUiYo9kHfmd/3HftHOokzqtbw+aiABmt0CY6VURmcQBPVw2YtLHeEEAw
emI20SfvE0pCGOypdm91xx2nzJytJsgKpaOGW278ScJEOglE/n8okwtqc+RanVIt
CuAvZa8GuhBe5+Lkym3P3r54SvksS1A/MGAXualT3sIz7i0LAMz9u1LF/8B0W2rX
xbldekJozh/4AdC2doEgme3Fml+ISKSypYcEGAGujKsdPjX3B5H1voLQ1FBnVJjP
bvjd/PrSkzI/bf3IprLZXct5qGztSioNjdmjrPEJqFUpDOshOwyKDVXPKPtJ4La+
oqop48DEO95rGc3+WQK6z2PmUrXajzWih2Y90UnqfcfBmpJaaqRljBKrM2b8RPkJ
XkJJMUI7+77bFIAkJSGae7voL9k+zXEq6Hh///wmMFt1UysUJGY56qqBvdN15S2E
e/wecG9FXjd67iWEOUYKbRqIiA+mgM1pg15o5ZqMp8rT64MPvC6R4SjS7/rzrEYt
LyGjC876n1AzDln48djzN+DFztMpJ/oRgDUY8OfzFlcpFs6axmRPU479ai8HDHXY
wPsohELFeU4IFOWEF3+K
=o06X
-----END PGP SIGNATURE-----

--nextPart1512811.irKdXvnQTR--


--===============9167902532131560903==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--===============9167902532131560903==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============9167902532131560903==--


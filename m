Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1NXpDY-0007tz-AK
	for ltp-list@lists.sourceforge.net; Thu, 21 Jan 2010 05:04:28 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NXpDX-00073J-IQ
	for ltp-list@lists.sourceforge.net; Thu, 21 Jan 2010 05:04:28 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Thu, 21 Jan 2010 00:04:15 -0500
References: <000701ca998a$51aed7b0$f50c8710$@co.jp>
	<364299f41001200525v31721544t521c73aceaa4b515@mail.gmail.com>
In-Reply-To: <364299f41001200525v31721544t521c73aceaa4b515@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <201001210004.23038.vapier@gentoo.org>
Subject: Re: [LTP] 2010-01-20 cvs build failed
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1149006173301260842=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: Mitani <mitani@ryobi.co.jp>

--===============1149006173301260842==
Content-Type: multipart/signed; boundary="nextPart1358521.C51tlIMhCM";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1358521.C51tlIMhCM
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Wednesday 20 January 2010 08:25:35 Garrett Cooper wrote:
> On Tue, Jan 19, 2010 at 8:37 PM, Mitani <mitani@ryobi.co.jp> wrote:
> > 6) <RHEL4.8 x86> (using make3.80)
> > Strangely, the "make" command returned immediately.
> > "echo $?" was 0. But log was only several lines as follows:
>=20
> You have to use make all when compiling `all' with make instead of
> just specifying `make' with 3.81 because make 3.80 doesn't have a
> concept of default goals/targets.

printf "all %:\n\t$(MAKE) -f Makefile $@\n" > GNUmakefile
=2Dmike

--nextPart1358521.C51tlIMhCM
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iQIcBAABAgAGBQJLV+BWAAoJEEFjO5/oN/WBLHMQAM6jp64dZXh3Hl5iZmrUNaZa
0ltkqYDQ36YSdOT047/ukP0pweOyyhVMPaSPhVTZR8onhCnPeMN8cxFmNgaFEqQi
lzj1zNkAZ7Svl4mP7Poo1knV8bIf5gtSg9kRAJQ5Fk0sZq6ySqwMbFSktUt4qdJ1
GdIaBWjIdPF2W2C+ZdAQWsZUJERjtqZFcO14xZsNOc5fTDZzRDk8rOrbUI2j1R8i
kxS/LfrKR69NFntTwSjk9XY55UzsHpFVuMSMABo4VwVcoIy53Uh+puZA/QjuNliJ
vAHUfhcixO0msqBqD5UMIXUPFRbzx8p/zF5paB2XGTVNcoQh4D3dg3XEm5JQtjB+
ISl/wt7Et6CJIhRzdBcd+fBcVZduF6gyOnnGQQJr85MsUYuL+EaDwvlEIjpM5xgu
WE2tMO5X3rQpuiwFNpxxiHsFXvX5SUrFCG/NmGIesq015FIqGyJeFS1Xerj4+I5U
c0tdjNbSLoNKkk2AHLMQL1QULjaZNoAWwc7JXhZ5rRElRo5A4hhmeYu4SiMtno7c
nQFqb78N4bvUIgnq/CmoytgFJpe5v5knKFKw2yIax6tgNXCPHmuJygG4EG+dNxtI
0oRm2RqJtNgnJd4A0CKs2mb1lQy2SlOYAqIlzmXEXpw6iIDKf9I+u+bnVE67vQCZ
nKvi1tbjVRX3DhsqfuUO
=ccXg
-----END PGP SIGNATURE-----

--nextPart1358521.C51tlIMhCM--


--===============1149006173301260842==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Throughout its 18-year history, RSA Conference consistently attracts the
world's best and brightest in the field, creating opportunities for Conference
attendees to learn about information security's most important issues through
interactions with peers, luminaries and emerging and established companies.
http://p.sf.net/sfu/rsaconf-dev2dev
--===============1149006173301260842==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============1149006173301260842==--


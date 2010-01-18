Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1NWzlr-0007kd-1s
	for ltp-list@lists.sourceforge.net; Mon, 18 Jan 2010 22:08:27 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NWzlq-0001BS-8g
	for ltp-list@lists.sourceforge.net; Mon, 18 Jan 2010 22:08:27 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Mon, 18 Jan 2010 17:08:23 -0500
References: <364299f41001151349i4e7067fbu68994eaf719b46de@mail.gmail.com>
	<b9d696241001181358g6a9c212by27da3451e4c6d0c3@mail.gmail.com>
In-Reply-To: <b9d696241001181358g6a9c212by27da3451e4c6d0c3@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <201001181708.24832.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH] Add make 3.80 $(abspath ) and $(realpath )
	emulation scripts
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1119051052130239864=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: "K.D. Lucas" <kdlucas@gmail.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>, Jiri Palecek <jirka@debian.org>, Andi Kleen <andi@firstfloor.org>, =?utf-8?q?=E7=A5=9E=E8=B0=B7=E6=9C=8B=E7=AF=84?= <mitani@ryobi.co.jp>

--===============1119051052130239864==
Content-Type: multipart/signed; boundary="nextPart7807546.AXfJQLK4vq";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart7807546.AXfJQLK4vq
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Monday 18 January 2010 16:58:58 K.D. Lucas wrote:
> Is there a bug when trying to make with version 3.81?
>=20
> I just tried compiling LTP 2009.1231 today, and I get:
>=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> configure: WARNING: linux/genetlink.h: present but cannot be compiled
> configure: WARNING: linux/genetlink.h:     check for missing prerequisite
> headers?
> configure: WARNING: linux/genetlink.h: see the Autoconf documentation
> configure: WARNING: linux/genetlink.h:     section "Present But Cannot Be
> Compiled"
> configure: WARNING: linux/genetlink.h: proceeding with the compiler's

no output emitted by configure would be related to make.  these particular=
=20
errors are because your distro installs broken kernel headers.
=2Dmike

--nextPart7807546.AXfJQLK4vq
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iQIcBAABAgAGBQJLVNvYAAoJEEFjO5/oN/WBvmAQAJ2b4Z2FSNi2tFAi0zKarU7o
9CzbLM362N887gIZW0OsazDFiIBiWkywq3T00IFY1XZqExQbOL80PsQx1/CBmq/p
36YVlhmyMIixJlg6f2XIeG7c3iUFU5BtvQxDy4HFKLaDmcKGVq4zIB7bq0uxGxAz
kSpEUKyftyN1yLQZ2UTLdcD5+myNKMHARsiHqVKWxDqP4KiTiiKFtVfOTRx1h+4a
URAJwBh2Nd+SENsOf5mNgo1B0w6/pyZFFyC9NmURDfhk5G2vajP2GImHEJ8q1ixo
zX1VG8MHdipR+bb6q2wXbH0Zd/uFAWIcu7vfjHcOpFxiKbeF7WvPhu44kDsWd77H
vkfxBvGkARPsGNuhSZyuCo3/P+oiIuy4ZDNIqBGcZbNQ9/zAeubMorXSakD41j9L
l2ZSGjPimbc5JgEXs8KShxURruSeCBKXgJfMhwL5SYAWCVmozoRViLkDJY9tEwXR
QxheaPDBCOWameWLcSMaI3M6sjBfu5DfEOIEE03QJTd1KQzw5kmUPQEY0YZg7YZ/
9LgwcLImVO2FU+NsJUXWrKnFLwer/VEfW0bdBP+ihemBO99zMAHVPJAgHC1g/s7V
NSrqHGRNUQ+jwXNbIM025/lEgdM2HTPODTyFlJ22dCr/hTFnJs4Ddb/zSeL7iCXA
WrrM3GyBihMF/B97SPX4
=HSrC
-----END PGP SIGNATURE-----

--nextPart7807546.AXfJQLK4vq--


--===============1119051052130239864==
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
--===============1119051052130239864==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============1119051052130239864==--


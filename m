Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1WQ6Zd-0002N5-1R
	for ltp-list@lists.sourceforge.net; Wed, 19 Mar 2014 02:49:45 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WQ6Zc-0003c6-B1
	for ltp-list@lists.sourceforge.net; Wed, 19 Mar 2014 02:49:45 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Tue, 18 Mar 2014 22:49:44 -0400
Message-ID: <1529764.55jJe8A1P6@vapier>
In-Reply-To: <20140318193156.GD15827@tarantula.localdomain>
References: <20140318193156.GD15827@tarantula.localdomain>
MIME-Version: 1.0
Subject: Re: [LTP] update ffsb autotools files for aarch64
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============8382820490243659033=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net


--===============8382820490243659033==
Content-Type: multipart/signed; boundary="nextPart3522056.4ulRYaYGYz";
	micalg="pgp-sha1"; protocol="application/pgp-signature"


--nextPart3522056.4ulRYaYGYz
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

On Tue 18 Mar 2014 14:31:56 Jeffrey Bastian wrote:
> The autotools files for ffsb -- utils/ffsb-6.0-rc2/config.guess and
> utils/ffsb-6.0-rc2/config.sub -- do not understand aarch64 and it fai=
ls
> to build:

we probably should have our build auto-copy the top level config.{sub,g=
uess}=20
files into subdirs when we unpack them sine we know those will be up to=
 date.
=2Dmike
--nextPart3522056.4ulRYaYGYz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAABAgAGBQJTKQXIAAoJEEFjO5/oN/WBuV4QAMbHJxDWziYiR6ym2KbudgSE
HBulYIHmYdcyqSaTiUBeHTQBT4mvGmpYymMEKLyVMrMtJIizoX+h6Cyt6nOxyv/d
hOIx1O7Uq2ZJeqoGSr1gn38Ml0HoOQ9z7AH2Rfwc6d7eLuD350DfmP1hT45Bkyzu
7+ryOu2p2rmTbAXACHg2RawXzfwyzTyafz92Y4+poub4Ow1ICOYf6nG3bk/cuny0
V/74zVJxo+nKhAk0Iwy5sp1yAIo42fXfrE3okzGvpr+NVkq3X16j6Kt7P5TMwH5u
LNWBnvxoXc15vCUIS1kQUFeFJa6jN6ye+l8L7AgVWDH/oYxykkBu3ZWZ9CUI7iLl
2VuIr8jVM0sGIXKn6raA2LvPV7jpcb7RwNlYEtLRuPt9+CqMRrYG4qYfs21ceAzM
MZtojFNlPSSNLLwFzX0bfKU4pdivQtHBalfRL8Gr35RYAi8HUlmCsAVNrmGbOMjJ
VoUl+4TMQhlq0wG0Rhxn69CspY42ByB9Lkf5DvzsEU/IkCjVHOjoLHL5REKLbZd8
Hnoo+anQ02C9s0rCHX4gBIj9UKIBmDBQ36ogCcjb8PJlv8MIOeJhczYIW57g8BMd
AEJWmTQ0OIGcisBPVom5y7V4wD0DxjXeuDDeSj/TMOa5rJfz1FzNPDoFg4cOZHGR
pspC/n//ijDKrkDxr5Fk
=I/L2
-----END PGP SIGNATURE-----

--nextPart3522056.4ulRYaYGYz--



--===============8382820490243659033==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/13534_NeoTech
--===============8382820490243659033==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============8382820490243659033==--



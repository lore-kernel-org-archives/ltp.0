Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1MNwS0-0000Le-Lt
	for ltp-list@lists.sourceforge.net; Mon, 06 Jul 2009 22:14:16 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MNwRk-0000hX-Ci
	for ltp-list@lists.sourceforge.net; Mon, 06 Jul 2009 22:14:06 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Mon, 6 Jul 2009 18:13:57 -0400
References: <364299f40907061322x726c3dcbh7ec674fc3851593f@mail.gmail.com>
In-Reply-To: <364299f40907061322x726c3dcbh7ec674fc3851593f@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <200907061813.57806.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH 1/3] Make IDcheck.sh DESTDIR aware and less strict
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============8256068951187973430=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============8256068951187973430==
Content-Type: multipart/signed; boundary="nextPart1799528.VDIyu1lvcE";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1799528.VDIyu1lvcE
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday 06 July 2009 16:22:17 Garrett Cooper wrote:
> The end goal of this patch is to make IDcheck.sh more rootfs- / cross-
> compilation friendly, such that it can be run from the primary compile
> instance, and instead of attempting to manipulate the target system
> data, manipulate the sys-root / rootfs data through the use of DESTDIR
> and by relaxing certain checks. Most of the checks were unnecessary
> anyhow (am i root?), etc and can be easily remedied by just relying on
> the other checks made by touch(1)'ing files and the post-process
> operation, as ENOPERM will be returned if one cannot access the
> configuration file of interest.
>
> Also, use awk for all operations instead of grep because it will
> reduces the potential for random failures when dealing with /etc/group
> and /etc/passwd files, and we can switch over to one subroutine
> instead of multiple subroutines for checks.

please use unified diffs only
-mike

--nextPart1799528.VDIyu1lvcE
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iQIcBAABAgAGBQJKUnclAAoJEEFjO5/oN/WBRAsQALB9+xk5qjDM9QapzFw7g5cC
KiLkIsKwm+SpdHhO7VYkoJyMJoyyYiAPD/+p8RypFe3sPhcVWZfQMCPRBMdLE1jz
yxwnxAw8Yjj9gYaViGIoY1pYRHv+0PP8MYCdpGc3KpvbhMPFsboKYSeboop+Un8A
7ewkFtd9IYJjXvYQu5ELmHfej1ZeymSn0q1XZPzy8LWpqBnED1Nc4Up8HBsdnwxQ
B4viRtk2Ey4YntgAFEMuTTbNQk6w1RDpE4+ddX8YT+BWfuOVDHIcxkBCpGnwok6v
TGQWpoOT2p6fVW6pFTqDobniFwXbCCB4q2YcvEGQs8GQlgt6hn6EzFr1ZpxsLXor
eaNLiLfBJAIBtwtqshAzJWu3BzgbXkjLSLmw+4sM/Aof2sVoof2FqVvP6CMookf8
jDaUczcVlkDVoJ67OBTv+1bRaMq+aLefb5Znexu5pQRjjGwASiTrBd6Gb9LIUT6c
BJK34eyo0J55VrXUKkDpfZ9jKgu9WPmDyEcbgMvWcY3yz9vrPvG7d5cSXezyIzpr
kfpbN7yczuOIEl+T3xx+vUsfQUF7emAD857HfJy7+qofUdQC6/oVr1kzYwYB40Vn
QaB+UCTLGjLppmI8UTNk1qwh6plZM8BfTJi6mi8Wd0GEoUKO5Qkue0sEpnjzH7Nf
Wuou6EVchEEBgUw6u/av
=LTmd
-----END PGP SIGNATURE-----

--nextPart1799528.VDIyu1lvcE--


--===============8256068951187973430==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--===============8256068951187973430==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============8256068951187973430==--


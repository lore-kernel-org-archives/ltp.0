Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1MgOVk-0007HN-2j
	for ltp-list@lists.sourceforge.net; Wed, 26 Aug 2009 19:50:24 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MgOVd-0002ng-O8
	for ltp-list@lists.sourceforge.net; Wed, 26 Aug 2009 19:50:24 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Wed, 26 Aug 2009 15:50:09 -0400
References: <alpine.LRH.2.00.0908261719130.29807@vixen.sonytel.be>
In-Reply-To: <alpine.LRH.2.00.0908261719130.29807@vixen.sonytel.be>
MIME-Version: 1.0
Message-Id: <200908261550.10710.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH] su01: Yellow Dog Linux doesn't support passwd -e
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2375710212955725743=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

--===============2375710212955725743==
Content-Type: multipart/signed; boundary="nextPart1643880.QUbr9n88QD";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1643880.QUbr9n88QD
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit

On Wednesday 26 August 2009 11:20:44 Geert Uytterhoeven wrote:
> Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
> ---
> Is there any better way to handle this??

change it to:
if passwd -h | grep -q -e '--expire\>' ; then
-mike

--nextPart1643880.QUbr9n88QD
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iQIcBAABAgAGBQJKlZHyAAoJEEFjO5/oN/WB6KwQAI0b08M/jxMn+AomTiThfjBf
uTDFLScI6rpYTMQ30TV37QBOeQp8J9084IJgiRxBcejSMnn0qc+3QkR72Ba1ceAL
EO5WczJjAY7nvUlfeDkTWnw3GA0eMAKWV8B91oaHnmxE6taAl2Q4r2wcXqO2COrB
LpC1IjwPLA2Sfm3QPKnyir3Nwzxy1zeU5qmE+WY6zKc3WrHm38HnVIdRzASRifeQ
sYTMb0TWOnR6CL/dz8zHKfwdMzNSk/x2GZaiKhR0LcWhZbdFcBTWzrigUOS1OVRQ
h29ckiyL7u39089OOuZ0tj68vAp8tsb6f4UcLGrJYO9ISGPQ6nAfr4fBUH+nZweZ
DNetNi8Jjhor2yF8YV35/VVE5eFUYeR0p5Sj4/FefxHVVLPRr53rqn7sFDNXQxL+
Yd8nUI4FT39o9uFH7aDkIVvPn3RhBKF3uo7TVAlCe+1v4XkV4dxe9k0Vcw+dqfmU
M+IvqPlaKJJDSB4M3jLSSFM4fvg2441Nl5yo+nsh/Rqw87DQWAPDX3WLQyQpiDbv
KaOFbDyYy/+IVA9fWRrDpArsyq2uxdegCQwiACOq6uparRty7hl9lbgoB5Hb9kVX
zw0i51m+vvLO0QmvxYcz8Cl58d4I0EXfALAkKoS9hSZjuwuLO4Ciy1qVdVlVXqc0
LZOcyVb2Rjczf9UNlfma
=AbQf
-----END PGP SIGNATURE-----

--nextPart1643880.QUbr9n88QD--


--===============2375710212955725743==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--===============2375710212955725743==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============2375710212955725743==--


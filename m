Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1MiFWJ-0003XG-H6
	for ltp-list@lists.sourceforge.net; Mon, 31 Aug 2009 22:38:39 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MiFWD-0000bp-8d
	for ltp-list@lists.sourceforge.net; Mon, 31 Aug 2009 22:38:39 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Mon, 31 Aug 2009 18:31:22 -0400
References: <OF78939903.9E28133E-ON85257623.00782F9F-85257623.007A366B@us.ibm.com>
In-Reply-To: <OF78939903.9E28133E-ON85257623.00782F9F-85257623.007A366B@us.ibm.com>
MIME-Version: 1.0
Message-Id: <200908311831.23233.vapier@gentoo.org>
Subject: Re: [LTP] older distribution levels
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0198295019827904675=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: Mark Ver <markver@us.ibm.com>

--===============0198295019827904675==
Content-Type: multipart/signed; boundary="nextPart46365549.as6mohctgE";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart46365549.as6mohctgE
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Monday 31 August 2009 18:14:52 Mark Ver wrote:
> 1)  new testcases expect new features and don't properly address compiling
> and/or running on the kernel and subsystems provided on the older
> distribution.

there is already a standard: add autoconf tests

> 2)  the LTP build itself requires new software (mostly new versions of
> autoconf) which are not yet provided on the older distribution.

if you're doing development, upgrade your distro.  older distros should be=
=20
given an ltp with autotools already generated (like happens with ltp=20
releases).
=2Dmike

--nextPart46365549.as6mohctgE
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iQIcBAABAgAGBQJKnE87AAoJEEFjO5/oN/WBvfgQAKCff2JUDSTjkFlcXZ+zu/Uc
Lzyo2BhXrVbhiGi273JHeD4KAH9MQVWndtFAS9Tp/4QRE+XS9Cl5oS93JFWiMjss
ESOy3mUTWZAdr+rHjeYRR3z+kNaaeRg9n9vHgxQLmBnbP6t4uiS99On4DGRHtPvw
jLWIEFxtwrjqyzgAuT/M0soY8JLCLxOrIsN7ntnl2Rx3lOPIXCfSpcxHfiWbArNA
l4fN0VlOTuvmHGgSVNWT7flWfmaTMZty5f6zn0cuWzGcT7UQt/+9fk79aEJSZyUb
zotRShRpwV3GgOAB22TDWNYtD//q2gGCNW6eRU/Y/9fNFmWYFChJOZL7WyKcv9AP
v7fPmd7dTGq/W90ThL8lHdLjM8m41UTLrKST62WF6Jnf4X/JhnajTiFQSIKD/rpm
hy1ysJEoZmuY+o6gxXrl0/xjIGBF+gliwBCltWfpVQb+1zdaZzpy9VDqit2aCrEN
nyCMGlkeL4W39sHcKMZ6DSER7J6fXP32SlHZKCTbwpfMYhG92eUwpBPcc9vR9B39
U9GSubyiXz0UpzlcVT/h9qaCXI2cWvrMWi70Yn7W+LcxEsBIInmOKLScBW0LzYpE
nZzZHtQiw0wHuWHxWYGBbgYHF59OBxSS+azAoINlNp0bmSjXeojW7fruIG3nCZDR
7XiZyw+JZt1lJa9ATKKU
=YlwY
-----END PGP SIGNATURE-----

--nextPart46365549.as6mohctgE--


--===============0198295019827904675==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--===============0198295019827904675==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============0198295019827904675==--


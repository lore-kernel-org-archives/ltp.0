Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1MNwOB-00009I-6C
	for ltp-list@lists.sourceforge.net; Mon, 06 Jul 2009 22:10:19 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MNwNy-00085z-Sn
	for ltp-list@lists.sourceforge.net; Mon, 06 Jul 2009 22:10:14 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Mon, 6 Jul 2009 18:10:03 -0400
References: <364299f40907061455n2f95c877sb40d6a97e856fd03@mail.gmail.com>
In-Reply-To: <364299f40907061455n2f95c877sb40d6a97e856fd03@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <200907061810.04510.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH] Missing limits.h include and test.h style in
	system_specific_process_info.c
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============8274151685579354954=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============8274151685579354954==
Content-Type: multipart/signed; boundary="nextPart6538916.qTnfSgOg3g";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart6538916.qTnfSgOg3g
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday 06 July 2009 17:55:43 Garrett Cooper wrote:
> 1. test.h is in .../include/. Thus #include should be #include
> "test.h", not #include <test.h>.
> 2. limits.h should be explicitly stated because certain constants are
> used in system_specific_process_info.c (SHRT_MAX for instance).
>
> Signed-off-by: Garrett Cooper <yanegomi@gmail.com>

unified diffs only please.  context diffs are awful.
-mike

--nextPart6538916.qTnfSgOg3g
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iQIcBAABAgAGBQJKUnY8AAoJEEFjO5/oN/WBKTUQANLEVOB3C+4on234VVPWg4W6
IQoow61VU0BXfIkeBNYBUtyMpYViswgAbr1YPbcmAZJR+yHhLelx+o78hhmuue7y
Jn/mzlxlmCPWcuRWy5fE/Ce1EGHyO9jQIHW2FzmhAU0Q7zJdw5f9kiHYAgdkOMHC
SeWY1ijdfh+hk6sBgpdYW8rtu+Q4+uwpWC49VHfiIonAN2pKAQI/8DGQZr7kZH+Q
CR/0r+KG5K3bKfTZUQDTO0fR73dPLPnU/QmwI1Nqayg7vLhTgS/rkRmeTlG1C7cU
/ULA19Vowqh/sVMO+i53YQhnB2hL7HRnd0Z6bb/ybfMaeYS60mWOVy4SYID5S4Bd
D74BT27TgYgPWOL+ZmlJBU2voPPEy5VIo4afE8/WwZ9SUTbw2OrRWWxdwEreVXpr
n3rnmMj2U/mXFTE+xelrV9N4zPewjV5hsTC99BCdfkf5L/wO5FtNOZcKphTC8CjW
1aGUS0DNa7RRDTmm5PAeYEPwVC1Lspivomnf9aVa6b/v0d8OCIIlRvyd9rmKcy5Y
8CGJZDRUp/OfBcVhMtp1jlIQr0Hns4yTPDEHXfnWCq1f5IPeQhVnuuYwMyoRfBSH
V1Yusj9bzxI2drl6N7XLmuLYIC1TPYhjLIjcpHH2LvDz1WUEO6XdvqxPs5HaSx+n
VyItt5yApvLENYrkVNnx
=YxoR
-----END PGP SIGNATURE-----

--nextPart6538916.qTnfSgOg3g--


--===============8274151685579354954==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--===============8274151685579354954==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============8274151685579354954==--


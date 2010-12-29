Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1PXz9a-0001WM-OA
	for ltp-list@lists.sourceforge.net; Wed, 29 Dec 2010 16:45:34 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.72) id 1PXz9X-0002pU-O4
	for ltp-list@lists.sourceforge.net; Wed, 29 Dec 2010 16:45:32 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Wed, 29 Dec 2010 11:44:57 -0500
References: <AANLkTi=qFxgs4CPQ2EUwHin1LTgxw0V-RENPV9rRqraF@mail.gmail.com>
In-Reply-To: <AANLkTi=qFxgs4CPQ2EUwHin1LTgxw0V-RENPV9rRqraF@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <201012291144.58092.vapier@gentoo.org>
Subject: Re: [LTP] [Bug Fix] utimensat01 can't build
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5436828500506082590=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============5436828500506082590==
Content-Type: multipart/signed; boundary="nextPart1531525.YZMSM5ZIgU";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1531525.YZMSM5ZIgU
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wednesday, December 29, 2010 04:35:48 Vivi wrote:
> LTP test case utimensat01.c can't build without file usctest.h.

this compiles fine for me on x86_64/Linux as well as Blackfin/Linux without=
=20
this change.  so why do you need this ?
=2Dmike

--nextPart1531525.YZMSM5ZIgU
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iQIcBAABAgAGBQJNG2WKAAoJEEFjO5/oN/WBLrgP/20YKZEJF6kfGzQEZFD18fHG
IlQZPu21WN0U3+Oytn7Jdggwlzq3M2N9T/yPzhEhIjl2QRW+DyoPe8r+hvCooyRu
mvdDH7bWr6X1hwi/vDXKrRWa6BBaS/UpkheYZA/U8plXfXL2ubixS+mU0Qj79x3O
ZGbUM2LfYQQfV2ubrUpQ0uRhGRtd7p/u4nqSJ1aZ9keSISFbrwsYULstNfglbohE
yL5AzM+NPnZYyK58bmI9LWO6VGYfFyzqAvBbAPR4T6tiUZvxwmCMwek5b6JEdLpr
HkTr/zqx19FdNgx3EK/wPTj3Btq+Pg/tpZ8OInHwS6vMPamKqC+OabuGSh+v93JO
tphneOaGLKEnkqlG5P3eUADjGGdDBvfQFwp01CDyFSCGIidTCQnMFZzCtyWA3HHN
aia+Ap5p5rPMcAKv8Bpdw1m78I2+UGq7dYx4xACmC9gc+3o+r24F83Fnx+wZ18WL
PuWq49b+VOytMjY6rx9IeYhMrX4p03A3YSZFfJEE9yPGlkxMwV/h6/EIRSvf+z9/
bqzaNnxlsJqOE/OStuW/NQp9A1wMt0REWBX3AOlVhnexYngK0UsCwoQQUlgHUD04
rTsuaT0rep4KULxNGECPD/ssXzu7mMlxaUKbqUPNmPjNQfUCbY7kLPoNXW/JN+ma
VxWgZ1bjf9F6CsCFMoZg
=vA/n
-----END PGP SIGNATURE-----

--nextPart1531525.YZMSM5ZIgU--


--===============5436828500506082590==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Learn how Oracle Real Application Clusters (RAC) One Node allows customers
to consolidate database storage, standardize their database environment, and, 
should the need arise, upgrade to a full multi-node Oracle RAC database 
without downtime or disruption
http://p.sf.net/sfu/oracle-sfdevnl
--===============5436828500506082590==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============5436828500506082590==--


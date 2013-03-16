Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1UGtDH-0001mE-Bb
	for ltp-list@lists.sourceforge.net; Sat, 16 Mar 2013 15:40:03 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1UGtDF-0001kO-Ir
	for ltp-list@lists.sourceforge.net; Sat, 16 Mar 2013 15:40:03 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Sat, 16 Mar 2013 11:43:03 -0400
References: <1363280151-10623-1-git-send-email-markos.chandras@gmail.com>
In-Reply-To: <1363280151-10623-1-git-send-email-markos.chandras@gmail.com>
MIME-Version: 1.0
Message-Id: <201303161143.04543.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH v2] ltp: Add support for Imagination Technologies
	Meta
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1471796249554363402=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============1471796249554363402==
Content-Type: multipart/signed; boundary="nextPart1795250.nG40HW0yh5";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1795250.nG40HW0yh5
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

On Thursday 14 March 2013 12:55:51 Markos Chandras wrote:
> This patch adds support for Imagination's Meta architecture.
> The Meta Linux kernel port will be included in the Linux Kernel
> v3.9. The Meta stack grows upwards so we need to add the appropriate
> __metag__ macro to the ltp_clone function. Also fix the #if/def
> macro for s390x.

merged, thanks
-mike

--nextPart1795250.nG40HW0yh5
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJRRJMIAAoJEEFjO5/oN/WBgnUP/jim/U2EBtxX+YJCEDuBmUb+
SpWrUn1lKC5I/uu3tHSOMjOXPJkaZDqS+Oe9qr/doqvOnp01imqCrs4MKhxLr3do
AxatznwLlrvntHpygVb3+U86XDaMY2177KRt0jFdmaz0WUVMaDKkfzvhN8sfLqE0
2uEoNaiMpKAXpjhXms4swWvcTvBrH4qlYZ4miMtCfur+p32rp3ahQuotRuZ3S4vU
J+p/Sui8Idfks3qZheHXWqs8wRJEc2++fsDJ6IQ6nduTywxNQMqgPygUZhJ+KTcK
sCFklxW9JWN9kXlDez1Re4LToqrniGB41ZHV91JBbTmerEgdzgiXOp6z0cOOQjJg
zZlX9XAzIh1CLXcsj31qFfdSltd6DPJOZKjRfSJOt2pdN16RCKld8FGGcIk0qa1I
oM0g1r7vyB8h43bvnS2hubOFiZe53rq/GzbWTBMP8xaiD34dTMew8/aBHouqZbEJ
6ZDAffxpsdy6dqoFYXX5ufiBSbK4M5iYKUDwWb74aXEBl92CiQ9RN3hXOJci6Wrc
O09dvoK037lq2jzo1FytB06hOZtUHqCfalV63Hwyr68S9okRYq3UYdaXGa0fJF4u
ejUTDEtz93EjK7vYnEEUdSkLBu60iOgME8sz75+Q0+LoRv016MBeJFYIVEd5QsQx
FMvAYtyTI9/L8Bk4l0IB
=w7h4
-----END PGP SIGNATURE-----

--nextPart1795250.nG40HW0yh5--


--===============1471796249554363402==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_mar
--===============1471796249554363402==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============1471796249554363402==--


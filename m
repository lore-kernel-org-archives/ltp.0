Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1MfVQZ-0007nn-5X
	for ltp-list@lists.sourceforge.net; Mon, 24 Aug 2009 09:01:23 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MfVQQ-00072W-2i
	for ltp-list@lists.sourceforge.net; Mon, 24 Aug 2009 09:01:23 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Mon, 24 Aug 2009 05:01:04 -0400
References: <20090824.155450.104049513.caiqian@cclom.cn>
In-Reply-To: <20090824.155450.104049513.caiqian@cclom.cn>
MIME-Version: 1.0
Message-Id: <200908240501.06023.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH 2/3 v2] Fix unshare01
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============6670121942781580551=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============6670121942781580551==
Content-Type: multipart/signed; boundary="nextPart7017335.eeH3VSnIWA";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart7017335.eeH3VSnIWA
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

On Monday 24 August 2009 03:54:50 CAI Qian wrote:
> +						tst_resm(TFAIL,
> +							"unshare Failed, "
> +							"errno=%d : %s",
> +							errno,
> +							strerror(errno));

missed one

> +						tst_resm(TFAIL,
> +							"unshare Failed 2, "
> +							"errno=%d : %s",
> +							errno,
> +							strerror(errno));

or two

> +						tst_resm(TFAIL,
> +							"unshare Failed 2, "
> +							"errno=%d : %s",
> +							errno,
> +							strerror(errno));

or three
-mike

--nextPart7017335.eeH3VSnIWA
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iQIcBAABAgAGBQJKklbRAAoJEEFjO5/oN/WBfm4P/jpO6+G+ceoX4ZkhnlIWnWqW
37XR3K4aE2UD8jTGD6SjbZRAc5nSnlTIs+qsxqw+r+YJKBXgobaQGnUCA+g51gjK
PAe31KXv4aqutGQMMqW90h3GgGU/yFAUAKH8QMaJVndVbcPt0T8TAzEFndv0fIq/
+eOST4qt2xIlrec0qbqovSFBszQECoQyjCGhyk/iaq9NP67wVghZ+QxaZlSFBCBM
PX+c+2rCqlSCZh1OojB730001CgeB0LJBxZAEUAIxKKz5iKbAxSYOviYGqpDKxJQ
2pMPZxaXdi5ncM9LQF712mqJGt2NiMB4dLCxwlC7c3M/3Z/wGoGFQnPmYSQrr4VV
ugONiRwzTpvoKTv7LA7heYSmrBk/Qk3TaQszRFX4MQ5dIUpclcEHzW1MWULx+icq
C4wJJ53wN1FxQgcNVuKpwAPQSWKIsTV9LY32WmUFLQcawMIByXjciUHb8WsN0XYX
v6gmP8isV2VhP3uCDANYTjc2yZOT/nmihzSuH4H9kpgWsEwmCh2eOE0cS5mKdwGU
WAmBo07gVi3ITSXP9FCN+ZVaUZThKltN/WmcI3Sbf2fV2Nh/y8YqeI2zXyq6ZBqA
nxxAJFF52Mj3zjkrUILW11sWqiqDFpHtXWqby1W3MmAU1hTwEgSh3FQuSy1zSuDp
XcvG2h6YpMkYOKEIUCs4
=NQj7
-----END PGP SIGNATURE-----

--nextPart7017335.eeH3VSnIWA--


--===============6670121942781580551==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--===============6670121942781580551==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============6670121942781580551==--


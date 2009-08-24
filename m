Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1MfSGf-0004iy-KB
	for ltp-list@lists.sourceforge.net; Mon, 24 Aug 2009 05:38:57 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MfSGX-0004Q5-PB
	for ltp-list@lists.sourceforge.net; Mon, 24 Aug 2009 05:38:57 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Mon, 24 Aug 2009 01:38:42 -0400
References: <20090824.121538.48518939.caiqian@cclom.cn>
In-Reply-To: <20090824.121538.48518939.caiqian@cclom.cn>
MIME-Version: 1.0
Message-Id: <200908240138.43350.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH 3/3] Fix unshare02
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============7149771690526506974=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============7149771690526506974==
Content-Type: multipart/signed; boundary="nextPart2591638.k67PrSzer3";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2591638.k67PrSzer3
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

this has the same problems i pointed out with your unshare01 chanes
-mike

--nextPart2591638.k67PrSzer3
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iQIcBAABAgAGBQJKkidjAAoJEEFjO5/oN/WBXMoQAM4PlzaXPjSiC8I7C87luwnm
HYjwzsheJf7sal2rMjq++IfOf59LiCkgwQVfCgJVx0PFawIMZNdIMfcAZ0AlbSwa
ObQP/giNuY2GlbxIlYpA8Orz1zBaTQMNj5W2qV47eBF3MtzRydkUtsvoRUlm5Ys1
ZYzOY0pyNmZMc8G7AgnfBouR+B1GXLUsSuheOQlQ3DQVZmWcLyoi5aZMGk6qqSl3
U/gAcUIrhj3RlV/Q7pR6PkbP7mgpJLf8DMoZbXMSPDhuEoFyO2Y7GnfyZ7Oe1CQw
mjJZS39hRUqTyE1OXkuFEeDHnRb7wnGhsA8qybqYsjLalQd/5nYoXEE1UFMJ9DAB
/Vf46an9cS09VwRKJvfTGdCXOCVwS6MCrhhAHB8etwxSSCuesQew9SuPcP8604qg
PqdIoRwxZ8M5kmv/VWn2RVjXyDLiqNrZOqVjlXpuemeDNk2rgW5jlvy99Kdktnrx
b4dRdnYhWD16QYW6y2FBKIXUImWPMyVFF9l5zIn7zN5znz3stx9484wNcyN1yU/u
4QAiW0LACBnXbjJKW3wIuaXg8usMckEJG5xn5ByOQOXbWVCM292vuEr+lY1FUVtv
WmzvJFr7hEGXbWDP7EkNXF9Qv7UTcZ5e+JHIyeJl73XEVo7/7Wan6IPK9L/TYr1m
yEvN385P8Ljme9lekM5u
=r/yH
-----END PGP SIGNATURE-----

--nextPart2591638.k67PrSzer3--


--===============7149771690526506974==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--===============7149771690526506974==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============7149771690526506974==--


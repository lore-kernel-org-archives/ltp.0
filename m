Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1Mm76m-0000jD-WE
	for ltp-list@lists.sourceforge.net; Fri, 11 Sep 2009 14:28:17 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Mm76i-0003WD-4T
	for ltp-list@lists.sourceforge.net; Fri, 11 Sep 2009 14:28:16 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Fri, 11 Sep 2009 22:28:07 -0400
References: <1252675233-19350-1-git-send-email-nobuhiro@andestech.com>
In-Reply-To: <1252675233-19350-1-git-send-email-nobuhiro@andestech.com>
MIME-Version: 1.0
Message-Id: <200909112228.08664.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH] pselect01: Fixed the checking logic to also
	consider some variation.
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============7486422928483556186=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============7486422928483556186==
Content-Type: multipart/signed; boundary="nextPart7806937.vaf3DSBs5j";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart7806937.vaf3DSBs5j
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Friday 11 September 2009 09:20:33 Nobuhiro Lin wrote:
> -		if (total_sec >=3D (end - start))
> +		if(((end - start) >=3D total_sec) && ((end - start) <=3D total_sec + 1=
))

please fix your style.  skimping on whitespace doesnt make for smaller code.

that said, your test boils down to "=3D=3D total_sec" or "=3D=3D total_sec =
+ 1". =20
might as well use that rather than confusing greater/less than comparisons.
=2Dmike

--nextPart7806937.vaf3DSBs5j
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iQIcBAABAgAGBQJKqwc4AAoJEEFjO5/oN/WB4hQQANlo7/UNyHoLy4/mJ+g11KrH
x0CnUUdFOsyD76O2qtRfbt614JATgvZ2FxksblSjxjo3WPXujOWXhpjT83SwTzfD
HcneDn89zsRzJriiVvw59Cim/9nWW1ZNTJSQ7UTn/ORtZDUzqEnG+GRF73RA/rUR
TNLit1TJmWcdvVhSNjJWLgNJjSUYMx/AILutECm49D49G+w2q5pJs8Z4IJErotQm
F/a9QbKjiZZd9z+jeH4ncVQI6bVHl8iiaTIrkd35rpCPYSBsF1SpsCz8xpODkrQe
V4uBV3aYLC+SkCcjxri2ptgfE+MlC/FFvJDsq4HGv47GBlpumKOM02mWJ3i47FOT
dfEd4qP/YpEX7f5cp/4jsmrtsv4BIsN8YFLNSfhNB//OkEH0gtgPJYrF1V6hKHj9
OUiISb1lyIlUQFaIMa4/9btiC2Cte3sUZcbm+u3e6Ncu1ONFLn6qY7E0d87IWsG4
pwMrqcvxvVLr+jK8veMejZj7/kDDVehe4986T60ETP1agd5YyYkM4ImuzgawPA+V
yZvnWaAjNDQy4Bu6Edc8ctpwk0HFxgFAryGrwSTi64k7ov1DVsv1r1LhabmlqRy0
1aX+XcDYKAWoHvx/HwE3jXpdkCHzK5DmNP68Nocyap+NW437cetwjX9b7sm+WtND
FwlKvZXiWhAvZe59LFIW
=7ukZ
-----END PGP SIGNATURE-----

--nextPart7806937.vaf3DSBs5j--


--===============7486422928483556186==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--===============7486422928483556186==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============7486422928483556186==--


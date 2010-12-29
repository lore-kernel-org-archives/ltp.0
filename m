Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1PY4oV-0008NH-Qr
	for ltp-list@lists.sourceforge.net; Wed, 29 Dec 2010 22:48:11 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.72) id 1PY4oT-0005od-H1
	for ltp-list@lists.sourceforge.net; Wed, 29 Dec 2010 22:48:11 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Wed, 29 Dec 2010 17:47:34 -0500
References: <AANLkTi=TOy3i69CnLoZPK+rYqUQ_TfCQXmV=STzYop2i@mail.gmail.com>
	<AAFECAC8-E32A-4241-B201-3EA5F0233FA1@gmail.com>
In-Reply-To: <AAFECAC8-E32A-4241-B201-3EA5F0233FA1@gmail.com>
MIME-Version: 1.0
Message-Id: <201012291747.35513.vapier@gentoo.org>
Subject: Re: [LTP] enable pwrite for 64 bits test
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============3494312822158919017=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============3494312822158919017==
Content-Type: multipart/signed; boundary="nextPart2446878.daVExScI8k";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2446878.daVExScI8k
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wednesday, December 29, 2010 17:10:42 Garrett Cooper wrote:
> This didn't add the runtest entire though.

what are you referring to exactly ?  the changes to pwrite's Makefile look=
=20
like all that's needed as compared to say pselect/Makefile.
=2Dmike

--nextPart2446878.daVExScI8k
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iQIcBAABAgAGBQJNG7qHAAoJEEFjO5/oN/WBmdcQAIHT2tpoqM6Cq38PnKca5NeZ
yPQ4rhzmHMuOv/j2NmL/WLJYjI1qurHZH9PLWiaOVQwSVqKBnHac2ByinIp9fP/1
o0hkJN+1xm6iKflLELWyfucxJ8qJj1h+zwSoQX2g4Z9oDrlyXWEwvQTplqKG4hgP
K9E7OeO070l8RNrcYqH6nkYUYMBCifMpbdrKvZl6e9XY7On7twRMUW6wouBJYWDd
xgvjxFn2nWuYzufwgWAZX3OQzRQxgWIHXiWzX7c6S2VRoyGGALmrBpDDEBfU3SZB
2Qx+x1AHBnyedwJRT/VhDXGWVSE6uRJyp7OuJcImjnBKKZ7I6milYwyrUp+XytIf
oqHNRH3lqGDIEIim5acpdQX2N1da8mBMXiLvl53CPzTR/vRiab2mp0R4rM+hepWM
Sj9+ZIYReRsFG3THnMElDHOXfJJh77vcgFE2GSFVywpZo0Kg72Bp9VOkpEhkjWpA
LgW20MXztnc32BfccWiFf8/21jIp02BhG8ugdceAZd9q+h+fqUPTPfK4GZZN+WTE
/8/s+Qg8gAusSHTrUAUQg6aJUHFoq8Z0s1tmoDFOVvqefZyYELNg+1pr8xShn398
2iUci5i/tDABwhSnCVfluWwStDaN/z0+1SPf+9ZnEkqVsInkLMLiMr0VjIb9yGFo
rX2MiTMb62hfp0cXjH+w
=LCX5
-----END PGP SIGNATURE-----

--nextPart2446878.daVExScI8k--


--===============3494312822158919017==
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
--===============3494312822158919017==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============3494312822158919017==--


Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1MMX7i-0006a2-MD
	for ltp-list@lists.sourceforge.net; Fri, 03 Jul 2009 00:59:30 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MMX7g-0006VN-GG
	for ltp-list@lists.sourceforge.net; Fri, 03 Jul 2009 00:59:30 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Thu, 2 Jul 2009 20:58:42 -0400
References: <364299f40907021746p3ce4bacdwbfc834ef7e4cfcfd@mail.gmail.com>
In-Reply-To: <364299f40907021746p3ce4bacdwbfc834ef7e4cfcfd@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <200907022058.43574.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH 8/10] config.mk not required for clean
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2706415571630398506=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============2706415571630398506==
Content-Type: multipart/signed; boundary="nextPart77918189.LnHqA6ac3u";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart77918189.LnHqA6ac3u
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 02 July 2009 20:46:05 Garrett Cooper wrote:
> In order to loosen the requirement of having config.mk for a clean /
> distclean operation, we need to check for %clean in MAKECMDGOALS.

then why not simply use sinclude ?
-mike

--nextPart77918189.LnHqA6ac3u
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iQIcBAABAgAGBQJKTVfDAAoJEEFjO5/oN/WBSfQP/jd9wfjT7djqeXvCHZj7KU8W
a3BDyhaxileGDBngnDm31MO+eHd+R6p6mWNCBddTYe1deNOGZa6mnYwQ7Q8HlCCu
CD+Lc/Hzp/ieZxos2p7ANhRVLbEGlHkH0uAohk+nwJNFhzMJYJInfRTzL9aWJbTk
T/nj8W36E71awIugH2t7WTXDih5RMtNCygdungTtgCQfta406mSIiMG9uNWxnNYj
0oNQ5eaFcSQAQbp6uMzRA29Kfiana34sHtyaXISkNvRNoC91971WwQDDpTuhHkQ+
Hbop6m7dxoobSpgU36x+hrVusYwKAushcXJSYoi9HVVmjMWHkks3P7fYw577zUsv
0TEjfOIk4CiQStT/QP6HcjxdJAG0Zig9yrZDKJzs6tzCejcAjphHnaZeP91TDH07
LPwiC6YpCCOsFGk2C+PdH9tcpwAs3oTLST6IUqze1zZUsqdE8HK+dM+/LC0c1ihg
I6c8F+5Lx3+El97N0OQyoMDRGgqKmgXrFiOwqOpmGfKszJ1+dp8yUlYwY0CWjucd
9z2kxW2s37Yavo3THKLlaEfKCu5jukDH8dKQUDBHNrN1YiotAVIiyUp4wDcG6arc
Q/p2Zv+gyna2BdVc/mGHRN/2QTaZbkgWTwuUef0cziPHZ1OC08v2tiRlDTbaaNHq
RVb2Xhdx1tOe4kKTWJTA
=W7xu
-----END PGP SIGNATURE-----

--nextPart77918189.LnHqA6ac3u--


--===============2706415571630398506==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--===============2706415571630398506==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============2706415571630398506==--


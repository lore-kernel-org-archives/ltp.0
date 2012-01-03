Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1RiB6e-00047C-Hf
	for ltp-list@lists.sourceforge.net; Tue, 03 Jan 2012 20:37:12 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1RiB6c-0001yQ-8T
	for ltp-list@lists.sourceforge.net; Tue, 03 Jan 2012 20:37:12 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Tue, 3 Jan 2012 15:37:17 -0500
References: <4F02DBAF.5040202@imgtec.com>
In-Reply-To: <4F02DBAF.5040202@imgtec.com>
MIME-Version: 1.0
Message-Id: <201201031537.17888.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH 05/21] syscalls: Cast st_nlink variables to proper
	integers
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============6774210519592217666=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: Markos Chandras <Markos.Chandras@imgtec.com>

--===============6774210519592217666==
Content-Type: multipart/signed; boundary="nextPart1633799.AbhPmfnPZC";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1633799.AbhPmfnPZC
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit

On Tuesday 03 January 2012 05:42:55 Markos Chandras wrote:
> Hi, please review the attached patch

casting to a (long) would be better
-mike

--nextPart1633799.AbhPmfnPZC
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJPA2b9AAoJEEFjO5/oN/WBIdAP/2k6F44OmZvtTPGE34BrHW4y
0LeU2EeImT4xP2p21va2ftqGdexgSoVGLTIQGwODAbmEnhbM3R5GPOv/T5NY65IF
tcoVEWNhbUl0MobAzIl3tZfBTpAuoMX6LBuazBW5O8+rwRj1uEezCQcaiuB4eI8S
XkH8lr7sLmEo40y7Pnq0CB0jSZaZIcLaSjuvmL/leJh8XXnzCr0uD2CYvxQofIUU
8YQCOFP/v2zfOuAjE9xVv4fJOaIcei9sbJRuKcvjGpa951nIsSec1yirBpAnLI1c
r2It6xnaxDIoTvU7PPZ6TSJqkDoSuCSrfUH4vDYQ2x5i4asZlhO7Ad5eXm/XTkQi
Igc+H1+9/PjjSD363Ws8aeIWkrt1PHYyWpSTwH/NFXeNquqtW6cz9JAvkLkzyFII
7w6tQiAmFR9/SZ46KQ09kJLOFVQWclv9djDbysGvdO8CQl/I56YJXwnHjMroIywQ
t62hVE80Y1Rw4jdFR/o0s/0KPXSCqAy6HR54cSr+hvNb9axcwHEeseO8o/5Gxw0M
xxNuRH/NDD43QJpRGQsU5gtLloNE0wLddsqM60lFBnAZdXLyRkyIXO/zNdjmxlJB
SinKVrLnSxKghYXPOjefnXzyVwp9gDNqAa5E+pESgKX0ZgrP4uwnI+6d93i652ib
1+r+5Nhe6Jm3q21hMWHo
=+Ar3
-----END PGP SIGNATURE-----

--nextPart1633799.AbhPmfnPZC--


--===============6774210519592217666==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Write once. Port to many.
Get the SDK and tools to simplify cross-platform app development. Create 
new or port existing apps to sell to consumers worldwide. Explore the 
Intel AppUpSM program developer opportunity. appdeveloper.intel.com/join
http://p.sf.net/sfu/intel-appdev
--===============6774210519592217666==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============6774210519592217666==--


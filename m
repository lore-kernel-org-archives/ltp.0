Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1RiB03-0003u9-0N
	for ltp-list@lists.sourceforge.net; Tue, 03 Jan 2012 20:30:23 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1RiB02-0000pi-7r
	for ltp-list@lists.sourceforge.net; Tue, 03 Jan 2012 20:30:22 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Tue, 3 Jan 2012 15:30:29 -0500
References: <4F0300B8.7050704@imgtec.com>
In-Reply-To: <4F0300B8.7050704@imgtec.com>
MIME-Version: 1.0
Message-Id: <201201031530.29753.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH 15/21] fs/stream: ret variable is has an integer
	type not size_t
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============8028292638374746019=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: Markos Chandras <Markos.Chandras@imgtec.com>

--===============8028292638374746019==
Content-Type: multipart/signed; boundary="nextPart2174410.DP7byQOYTi";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2174410.DP7byQOYTi
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tuesday 03 January 2012 08:20:56 Markos Chandras wrote:
> Hi, please review the attached patch

seems to me the proper fix in this file is to make "ret" into a "size_t".  =
it=20
holds the return values of fwrite/fread which both return size_t, not int.
=2Dmike

--nextPart2174410.DP7byQOYTi
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJPA2VlAAoJEEFjO5/oN/WBKHcP/2hS+iC5oJkkH6CJbDa0AYw9
QaVLyKQR1MYPEwbT7KnSh9M2gUlPW7nXfgQRw+4dtMS4AvMxdEQavBByLDce0PO7
8j3LHzMvgBM+r+4fdn0rZadNmZcyf9jamgENbJNYHgo/66bfC6FtMrRhowqgLQhi
yp8zLTSQ9TAHSGqWSUSZMl8qzelAj65yDiaE8QYpQ657/D/SKQBrz8dgVixYoY2+
IJsJoSY0JW4CKGt1eOGwWZNuqMURC4GR+ZOkDBNPYw+TsJp/67vyF6yPQWHQZ+Ww
DhV9hHrrP0K7gOYAMvIug1S2nNbl6puV1gb5kmWPuTu8H0tWtccZbdSd29E/I9E1
xvOu1Wxpw3H6ICJp2awwgexbqrzVdkPFuoQdhrscFsuIB97oGuRfUFauEuOlwgWa
b90oQIFyV+lVTi4oA1RnMPOkgKr5qtmk2eKcXinYDGIvnyyod7+ZEvJHu268XH7U
8YTjb1f7nUsCsNpl3yMTDCwMf7vyJf9bXSSSxUD+TLjRHHLi7zWE684WHrG0aelG
49pzD8s3QpAV5rtPULTCts3xtOcO8OnwS2PUqbT7v1MCsTiH7L718LCYX8Q4yKcI
qGMoLjcGQVzTeKibXkjMvaGIUmzb3Ea21+mljaOlZVq8K8IZFMtkoquTnbV2iFUZ
RcaK7xqBc4OIvLHxl5A0
=I9yN
-----END PGP SIGNATURE-----

--nextPart2174410.DP7byQOYTi--


--===============8028292638374746019==
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
--===============8028292638374746019==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============8028292638374746019==--


Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1WSUlu-0002OF-U8
	for ltp-list@lists.sourceforge.net; Tue, 25 Mar 2014 17:04:18 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WSUlt-0003PV-7m
	for ltp-list@lists.sourceforge.net; Tue, 25 Mar 2014 17:04:18 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Tue, 25 Mar 2014 13:04:13 -0400
Message-ID: <2709183.VL7AkHPJaX@vapier>
In-Reply-To: <4506ACC2AE90484D87F9A883BA36C21C548CD0@LCHQEX03.lancope.local>
References: <4506ACC2AE90484D87F9A883BA36C21C548CD0@LCHQEX03.lancope.local>
MIME-Version: 1.0
Subject: Re: [LTP] Suggested patch for Debian distro testing, part 2 of 2
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============4376786327597303460=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: Joseph Beckenbach <jbeckenbach@lancope.com>


--===============4376786327597303460==
Content-Type: multipart/signed; boundary="nextPart16846638.T17tGzcczZ";
	micalg="pgp-sha1"; protocol="application/pgp-signature"


--nextPart16846638.T17tGzcczZ
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

On Tue 25 Mar 2014 13:42:44 Joseph Beckenbach wrote:
> -. initialize.sh
> +. `dirname $0`/initialize.sh

style note: use $(...), not `...`.  you also should properly quote:
=09. "$(dirname "$0")/initialize.sh"
=2Dmike
--nextPart16846638.T17tGzcczZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAABAgAGBQJTMbcNAAoJEEFjO5/oN/WBL6IP/jjOW4Ii7ln+jjPS6DLtte4D
n7RvjqwahYtWnkSTMMduZYPw6djJP48SLNHXnEuco9sN/T6Sds1jlXWXoPD37k28
mFmfaJ69004GJA9EtdC0UBeuMcroAsfOlA79f3ljndDUbnSdwkBiMlhFUhmhIdt7
c+i1KOs5jEdVl24l+9IseBc4vtmrfPX7W/gD5jgNM5liJWyrQRpDlJ87hviZ1F5L
/fPlPS7NKUFTxA2ltLX1lauGZHhDvLkeIjB3iWoF2GyozYOoiQH3fleP1p80KD0B
imtjQF8dIGjB0FNfnBU3gqWMDsuGbpNJE9eaotSw/eP9QLKBcZrhWoS7tq8muICj
JN8GhQmQlURin6T3EIh1WP3nyzncxjwaJJ4Pe4JZBQxGDHMDm3SdcvuPnySTxgXI
LiZ6S3W8yzwwOCCtHcfoaDM7WEHeFOU/01kHOUZyw/f5DFRDl1VTkRW98zmV6jOG
5xZWtpYpz716CQe0F96vPDoL3qFYolQyZqtK1iuHVdRT5eF+ivgaDUqOMwJVW6vu
ebLQT6E26Dus+Oe2Az235LAf5G9UrHqF+CIf41KeEmY7bVfBohjwe85icuK7eprC
GnskR3MkV1GO+He/66pGeALoce+XMC08eUchF7BkEElBQ6wNlqIIvcfs7SAE7PJI
LKLCNSombPJZK+QxS8p0
=nFGn
-----END PGP SIGNATURE-----

--nextPart16846638.T17tGzcczZ--



--===============4376786327597303460==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/13534_NeoTech
--===============4376786327597303460==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============4376786327597303460==--



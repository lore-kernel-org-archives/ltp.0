Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1WwQK6-00076t-LT
	for ltp-list@lists.sourceforge.net; Mon, 16 Jun 2014 06:23:18 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WwQK5-0002qr-W0
	for ltp-list@lists.sourceforge.net; Mon, 16 Jun 2014 06:23:18 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Mon, 16 Jun 2014 02:23:18 -0400
Message-ID: <7096320.jvPuKC4bBK@vapier>
In-Reply-To: <1395930175-3138-4-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1395930175-3138-1-git-send-email-stanislav.kholmanskikh@oracle.com>
	<1395930175-3138-4-git-send-email-stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH V3 3/4] testscripts/isofs.sh: removed some
	"unnecessary" steps
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1323336357355482257=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: vasily.isaenko@oracle.com


--===============1323336357355482257==
Content-Type: multipart/signed; boundary="nextPart17330718.6f4Tdc7Eee";
	micalg="pgp-sha1"; protocol="application/pgp-signature"


--nextPart17330718.6f4Tdc7Eee
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

On Thu 27 Mar 2014 18:22:54 Stanislav Kholmanskikh wrote:
> +=09=09while /bin/true; do

do not hard code paths to tools.  if you want a dummy loop, do:
=09while :; do
=09=09...
=2Dmike
--nextPart17330718.6f4Tdc7Eee
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABAgAGBQJTno1WAAoJEEFjO5/oN/WBzcAQANbzziNVssfgAqvukp5vfJce
eI82kPKUkWR7maNXTi9B2VzhCkpSyoMfDZkS8ajBWiO/0Frle7hEGmPAwOJk1ydF
qZpnR0q0qvHJ+ZJu4ZzVwTymt98MMSBl4K2gPKZp4BgdbA+9r+NFtdFL28wUcMds
WmLoNi7WMId1rms1kEcBSXgUn7A5TRl/6Ggev0Pfweb/25zw8E8Bca3VSw26gAEV
fnCNfckWP2Rlipy2MThJd4Ek2GrtNWL5mZn0r3OSMMbFFLVMxvMxr1vD1zC3aqlw
4cKm+ageW6oDPvVukEbwur9b4lO6TNAyXowoyxh9YyOdjppKq55HYV6pdRqks1dv
dLZR9nf5aCJrEU1duzk+cbLfKfaKfBUgQR3u0Z8WEkn72CWRSTEu+ikcOueYWVCF
9dPR7ndYZ01MoY/QP6JlPn/ldkAjp6YE4UZZ7dZ6G7vKqWuo0RgZUFj0J1kSTGTN
bOhuTAx5Updsj7OdI2cXicrCqcF/aNxjbfxkLUjufFr70rKt5TknhJKh7hyfFMJi
yDITcXBr6YFBxWPqAX7JcsIlVZ4JmB6IOb8ddQEJhUoh345uGzs7lES6A5w6pQPN
utaOp/jHBJ3CE6wjyyI2UtotbfR16uiNdguZMihh9x2krOc3nWy5sXiXniqrc6R6
MkfeA2t3e4ZHS1t7gKcK
=rOgm
-----END PGP SIGNATURE-----

--nextPart17330718.6f4Tdc7Eee--



--===============1323336357355482257==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
HPCC Systems Open Source Big Data Platform from LexisNexis Risk Solutions
Find What Matters Most in Your Big Data with HPCC Systems
Open Source. Fast. Scalable. Simple. Ideal for Dirty Data.
Leverages Graph Analysis for Fast Processing & Easy Data Exploration
http://p.sf.net/sfu/hpccsystems
--===============1323336357355482257==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============1323336357355482257==--



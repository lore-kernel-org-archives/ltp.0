Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1WwQJ6-0003O6-9i
	for ltp-list@lists.sourceforge.net; Mon, 16 Jun 2014 06:22:16 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WwQJ4-0005Cr-Iq
	for ltp-list@lists.sourceforge.net; Mon, 16 Jun 2014 06:22:16 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Mon, 16 Jun 2014 02:22:15 -0400
Message-ID: <3170652.sUSmuoD47v@vapier>
In-Reply-To: <1395930175-3138-2-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1395930175-3138-1-git-send-email-stanislav.kholmanskikh@oracle.com>
	<1395930175-3138-2-git-send-email-stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH V3 1/4] testscripts/isofs.sh: cleanup
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0077367442783544183=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: vasily.isaenko@oracle.com


--===============0077367442783544183==
Content-Type: multipart/signed; boundary="nextPart5880841.Lfr7DbdMAr";
	micalg="pgp-sha1"; protocol="application/pgp-signature"


--nextPart5880841.Lfr7DbdMAr
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

On Thu 27 Mar 2014 18:22:52 Stanislav Kholmanskikh wrote:
> +MNT_POINT=3D"/tmp/isofs_$$"
> +COPY_DIR=3D"/etc/"
> +TEMP_DIR=3D"/tmp/for_isofs_test"
> +MAKE_FILE_SYS_DIR=3D$TEMP_DIR$COPY_DIR

not really a new issue, but scripts really should never hardcode paths =
in=20
/tmp/ or to that dir at all.  this is what `mktemp -d` is for.

> +if [ "$NO_CLEANUP" =3D=3D "no" ]; then

it is "=3D" in POSIX, not "=3D=3D"
=2Dmike
--nextPart5880841.Lfr7DbdMAr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABAgAGBQJTno0XAAoJEEFjO5/oN/WBtaAP/RBfi0YQoN2rhpC/uU1NZijH
Zjty3aul+l+wCeu30+FaVu21sEdEVagGRUil5bqpNeifuqD0qIDfFPieKyFZcwF/
kptGfMU+feHFsEzMw5OyRUa/5jpUGlwjpti7ktWGQwMSrz00Z0kOW8ukKTFc3ct3
tF/znROATg29nnQh+q5FDAokBnLltMNHKMYUUb7qOjnK7ssBPowkskRCJz4NNRYX
Tv+T/vWIMbI4j5ZugOHmRyyoFvWl1qBvpXAxnGwBb72Alw8HkOuQk6aE+uHfZyIC
AYXr48bxIoXaTH13kOX9ipdOk0QcSOK9rOaRqgy1jhrLqWS1KOMgW3HWmskB3sY/
mk7Zkai1WtErWQ1QGUBMvQgzkWHOqDW9QnbqQ/mLXKJmfF74ElV3q7eXCj/EsUbI
KWjM5r89+9qJJBoKp1QzbwVid8JCXg3z1yKcCEmaRZzb7QOyLePjNhmSRaoyZd79
VL/a7phCwqSwRzwBw5JxyT9LTkt3rwJr97+828K0iLcijYDtYTfHQ6T94bt8Kz21
jXBaEhj6uRwNmvgqsRsPtSM2XiYDL06BGctVMS3tL5szmK5UXSHJHqVP8HtyINTV
6SjDNizJ70SH1gB2M6avP/P4I3m3t+pMxdndUUHQRUCZLlsmCXonhPolSkW3x7/y
iqVfFWw5Khly93v5HPNP
=HBhn
-----END PGP SIGNATURE-----

--nextPart5880841.Lfr7DbdMAr--



--===============0077367442783544183==
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
--===============0077367442783544183==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============0077367442783544183==--



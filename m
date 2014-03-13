Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1WOCg0-0000Q2-0o
	for ltp-list@lists.sourceforge.net; Thu, 13 Mar 2014 20:56:28 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WOCfz-0000Mm-8O
	for ltp-list@lists.sourceforge.net; Thu, 13 Mar 2014 20:56:27 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Thu, 13 Mar 2014 16:56:25 -0400
Message-ID: <12581797.Xz9gpSyGDL@vapier>
In-Reply-To: <1394714306-9678-3-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1394714306-9678-1-git-send-email-stanislav.kholmanskikh@oracle.com>
	<1394714306-9678-3-git-send-email-stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH 2/3] isofs.sh: be more quiet
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0162703566178841981=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: vasily.isaenko@oracle.com


--===============0162703566178841981==
Content-Type: multipart/signed; boundary="nextPart2507149.1DEQgPeVXz";
	micalg="pgp-sha1"; protocol="application/pgp-signature"


--nextPart2507149.1DEQgPeVXz
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

On Thu 13 Mar 2014 16:38:25 Stanislav Kholmanskikh wrote:
>  =09=09echo "Running ls -lR $MNT_POINT Command"
> -=09=09ls -lR $MNT_POINT
> +=09=09ls -lR $MNT_POINT > /dev/null

the point of this command is to show the contents of the mount.  if you=
're not=20
doing that, then delete the call (and the echo above it).
=2Dmike
--nextPart2507149.1DEQgPeVXz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAABAgAGBQJTIht5AAoJEEFjO5/oN/WBsokP/iv4U3547zOuvgc7vCprBGIO
KzomT4F6mxj8+HlcqqSyieVuJTq6ssLLXkUdWM7cpHS+ohNU72mlJNapjc/c78ut
k33JKhWJLGJu5eUGaNpv1C6NSuQBBH4E/MVAkyeI1L+l0TTeGBUf57rn8qHtuOnz
kvWF8u/mXNalB5+l7K46BCyOqCcB3shl6hzW61LZszJ/ZxyU9a9l3nCkkjWmPz5o
hdibdrKvVwzCC4rQQ9Esm89/6D3JyZTr+eU0j4VvPjezFi1DZEYWtQA3BgcD1+w2
iN6C9yKbngs+SafujFPIHbyn8OHA5ksKVKeAs6ed9t/E8i/VNU/nqpXiuaS3cVQN
HpNJlLR3DZ0DFDMH6TvxlSJr9v2RCaMsXxb1GsfIQ7PFW0DlLfS+3wlWqUf+7tTX
lOtMm3gPcmQCoFlQ0+OEnvYz2m8pYJ3iEQPTx0sI3oGblyA0MnPoou9k7YXxbbaM
b89yoELYNZDCVi3ul2KraFjpZQJ9kPpC0E9WHxDeb8YiWZfhE1N7/5oBhlVlHedw
k/jpm0QLuP6t1/0/C4sPYyzTHE25DxdvkPqMcL7BFwSN9UHaypliy2MPu/Q3zh2O
DBcuoe1wkgVg8a21kxFe832xpi1oHIZI7wFErTxq2Xo8gPNdPfhLoQZMH7DZeIDe
q2CnWLIr/JxSWMU5mDyu
=2zry
-----END PGP SIGNATURE-----

--nextPart2507149.1DEQgPeVXz--



--===============0162703566178841981==
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
--===============0162703566178841981==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============0162703566178841981==--



Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <paul.larson@canonical.com>) id 1O7UCa-0004fe-3o
	for ltp-list@lists.sourceforge.net; Thu, 29 Apr 2010 13:54:52 +0000
Received: from adelie.canonical.com ([91.189.90.139])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1O7UCZ-0000qW-2T
	for ltp-list@lists.sourceforge.net; Thu, 29 Apr 2010 13:54:52 +0000
From: Paul Larson <paul.larson@canonical.com>
In-Reply-To: <y2j72fb0a5c1004192359ifea04178l1ced518757facae7@mail.gmail.com>
References: <y2j72fb0a5c1004192359ifea04178l1ced518757facae7@mail.gmail.com>
Date: Thu, 29 Apr 2010 08:54:42 -0500
Message-ID: <1272549282.2433.21.camel@plars-t500>
Mime-Version: 1.0
Subject: Re: [LTP] testcase mm-shmt09 failing on arm . please help
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5405043290572180169=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: rahul agarwal <raahul4321@gmail.com>
Cc: ltp-list@lists.sourceforge.net


--===============5405043290572180169==
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-0Hwufj8GRCiEB8R8gaEz"


--=-0Hwufj8GRCiEB8R8gaEz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2010-04-20 at 12:29 +0530, rahul agarwal wrote:
> i am getting the following error while executing the mm test :-
> =20
> <<<test_start>>>
> tag=3Dshmt09 stime=3D1271762065
> cmdline=3D"shmt09"
> contacts=3D""
> analysis=3Dexit
>=20
> <<<test_output>>>
> shmat1: Invalid argument
> shmt09      1  TPASS  :  sbrk, sbrk, shmget, shmat
> shmt09      2  TPASS  :  sbrk, shmat
> shmt09      3  TFAIL  :  Error: shmat Failed, shmid =3D 262144, errno =3D
> 22
Hi Rahul, what are you running on?  I don't see shmt09 fail, but on my
arm boards, I see a few other issues.

One of the major issues I see is msgctl10.  This test takes WAY too long
on arm, likely on any lower cpu/memory system.  It's good stress, but
blacklisting this one test significantly decreases my run time.  It also
makes the system almost appear hung while it's running.

Other than that, I have a handful of fails, most of which I have not had
time to investigate yet:
clone02     3  TFAIL  :  Test Failed
clone03     1  TFAIL  :  Test failed
clone05     2  TFAIL  :  Test Failed
clone06     1  TFAIL  :  Test Failed
fallocate01    1  TFAIL  :  fallocate(5, 0, 49152, 4096) failed:
TEST_ERRNO=3DEFBIG(27): File too large
fallocate01    2  TFAIL  :  fallocate(6, 1, 49152, 4096) failed:
TEST_ERRNO=3DEFBIG(27): File too large
fallocate02    7  TFAIL  :  fallocate(tfile_write_10893:6, 1, 0, 4096)
failed, expected errno:0: TEST_ERRNO=3DEFBIG(27): File too large
fallocate03    1  TFAIL  :  fallocate(tfile_sparse_10894, 0, 8192, 4096)
failed: TEST_ERRNO=3DEFBIG(27): File too large
fallocate03    2  TFAIL  :  fallocate(tfile_sparse_10894, 0, 49152,
4096) failed: TEST_ERRNO=3DEFBIG(27): File too large
fallocate03    3  TFAIL  :  fallocate(tfile_sparse_10894, 0, 69632,
4096) failed: TEST_ERRNO=3DEFBIG(27): File too large
fallocate03    4  TFAIL  :  fallocate(tfile_sparse_10894, 0, 102400,
4096) failed: TEST_ERRNO=3DEFBIG(27): File too large
fallocate03    5  TFAIL  :  fallocate(tfile_sparse_10894, 1, 8192, 4096)
failed: TEST_ERRNO=3DEFBIG(27): File too large
fallocate03    6  TFAIL  :  fallocate(tfile_sparse_10894, 1, 49152,
4096) failed: TEST_ERRNO=3DEFBIG(27): File too large
fallocate03    7  TFAIL  :  fallocate(tfile_sparse_10894, 1, 77824,
4096) failed: TEST_ERRNO=3DEFBIG(27): File too large
fallocate03    8  TFAIL  :  fallocate(tfile_sparse_10894, 1, 106496,
4096) failed: TEST_ERRNO=3DEFBIG(27): File too large
getcontext01    1  TFAIL  :  getcontext - Sanity test :  Fail errno=3D38 :
Function not implemented
sysctl03    1  TFAIL  :  Expected EPERM (1), got 13: Permission denied
sysctl03    2  TFAIL  :  Expected EPERM, got 13
sysctl03    1  TFAIL  :  Expected EPERM (1), got 13: Permission denied

This is from a run I did on yesterday's git snapshot, with msgctl10
blacklisted.  I only ran the syscalls suite.  I'm curious if anyone else
running on arm also sees these failures.  My current platform is a
beagleboard, but I've seen these failures on other armv7 devices as
well.  OS is Ubuntu 10.04.

Thanks,
Paul Larson

--=-0Hwufj8GRCiEB8R8gaEz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkvZj6AACgkQ3UR7ubYtCO6r1ACgukqCii1MYimk5h2d3pY2zx/x
a7kAoPSPnnrOemGAr7ggzEg8wUvi5wQI
=QkLw
-----END PGP SIGNATURE-----

--=-0Hwufj8GRCiEB8R8gaEz--



--===============5405043290572180169==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--===============5405043290572180169==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============5405043290572180169==--



Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <Renaud.Lottiaux@kerlabs.com>) id 1MnwjY-0005Hm-Rw
	for ltp-list@lists.sourceforge.net; Wed, 16 Sep 2009 15:47:52 +0000
Received: from bohort.kerlabs.com ([62.160.40.57])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MnwjT-0006qn-Ux
	for ltp-list@lists.sourceforge.net; Wed, 16 Sep 2009 15:47:52 +0000
From: Renaud Lottiaux <Renaud.Lottiaux@kerlabs.com>
Date: Wed, 16 Sep 2009 17:47:23 +0200
Mime-Version: 1.0
Message-Id: <200909161747.31638.Renaud.Lottiaux@kerlabs.com>
Subject: [LTP] [PATCH] [CONCURRENCY] Fix kill07
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============9045824255954563149=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list <ltp-list@lists.sourceforge.net>

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--===============9045824255954563149==
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg=pgp-sha1; boundary="=_bohort-24820-1253116024-0001-2"

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_bohort-24820-1253116024-0001-2
Content-Type: multipart/mixed;
  boundary="Boundary-01=_MiQsKvicP8ieXgh"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_MiQsKvicP8ieXgh
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi !

The following patch avoids that all kill07 test instances running
concurrently work with the same SHM object.

Signed-off-by: Matthieu Fertr=E9 <Matthieu.Fertre@kerlabs.com>

Regards.

R.


--Boundary-01=_MiQsKvicP8ieXgh
Content-Type: text/x-patch; charset="UTF-8";
	name="LTP-kill07-fix-concurrency.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="LTP-kill07-fix-concurrency.patch"

The following patch avoids that all kill07 test instances running
concurrently work with the same SHM object.

Signed-off-by: Matthieu Fertr=E9 <Matthieu.Fertre@kerlabs.com>

=2D-- a/testcases/kernel/syscalls/kill/kill07.c
+++ b/testcases/kernel/syscalls/kill/kill07.c
@@ -219,6 +219,13 @@ void setup(void)
 	/* Pause if that option was specified */
 	TEST_PAUSE;
=20
+	/*
+	 * Create a temporary directory and cd into it.
+	 * This helps to ensure that a unique msgkey is created.
+	 * See ../lib/libipc.c for more information.
+	 */
+	tst_tmpdir();
+
 	/* get an IPC resource key */
 	semkey =3D getipckey();
=20
@@ -241,6 +248,9 @@ void cleanup(void)
 	 */
 	rm_shm(shmid1);
=20
+	/* Remove the temporary directory */
+	tst_rmdir();
+
 	/* exit with return code appropriate for results */
 	tst_exit();
 }

--Boundary-01=_MiQsKvicP8ieXgh--

--=_bohort-24820-1253116024-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkqxCIwACgkQdd7FKntVVv9ntQCgg3TvSCBUS5Dz9/+lZKd6lw/R
lNcAn2p956J3FX6llp+ZcGZaFO2JsVAj
=6oeZ
-----END PGP SIGNATURE-----

--=_bohort-24820-1253116024-0001-2--


--===============9045824255954563149==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#33;
http://p.sf.net/sfu/devconf
--===============9045824255954563149==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============9045824255954563149==--


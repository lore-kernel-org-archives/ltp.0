Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <paul.larson@canonical.com>) id 1NUMrN-0008K7-Fi
	for Ltp-list@lists.sourceforge.net; Mon, 11 Jan 2010 16:11:17 +0000
Received: from adelie.canonical.com ([91.189.90.139])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NUMrM-0001Ia-AV
	for Ltp-list@lists.sourceforge.net; Mon, 11 Jan 2010 16:11:17 +0000
Received: from hutte.canonical.com ([91.189.90.181])
	by adelie.canonical.com with esmtp (Exim 4.69 #1 (Debian))
	id 1NUMr8-0002e6-9v
	for <Ltp-list@lists.sourceforge.net>; Mon, 11 Jan 2010 16:11:03 +0000
Received: from 75-27-138-126.lightspeed.austtx.sbcglobal.net ([75.27.138.126]
	helo=[192.168.1.70]) by hutte.canonical.com with esmtpsa
	(TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32) (Exim 4.69)
	(envelope-from <paul.larson@canonical.com>) id 1NUMr7-000441-UY
	for Ltp-list@lists.sourceforge.net; Mon, 11 Jan 2010 16:11:02 +0000
From: Paul Larson <paul.larson@canonical.com>
Date: Mon, 11 Jan 2010 10:10:58 -0600
Message-ID: <1263226258.2410.24.camel@plars-t500>
Mime-Version: 1.0
Subject: [LTP] Fix for make autotools
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1637827735527405705=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Linux Test Project <Ltp-list@lists.sourceforge.net>


--===============1637827735527405705==
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-K+936vS2Rb6HGJRYEh6P"


--=-K+936vS2Rb6HGJRYEh6P
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Make autotools seems to break on more recent versions without this.

Signed-off-by: Paul Larson <paul.larson@canonical.com>
---
diff --git a/include/mk/automake.mk b/include/mk/automake.mk
index e23d5d4..889e6cf 100644
--- a/include/mk/automake.mk
+++ b/include/mk/automake.mk
@@ -59,7 +59,7 @@ include:
 	mkdir -p "$@"
=20
 m4/ltp-version.m4: ChangeLog
-	sed -n '1{s:LTP-:AC_DEFUN([LTP_VERSION],[:;s:$$:]):;p;q}' $< > $@
+	sed -n '1{s:LTP-:m4_define([LTP_VERSION],[:;s:$$:]):;p;q}' $< > $@
=20
 .PHONY: automake
 AUTOMAKE_FILES :=3D config.guess config.sub install-sh missing stamp-h1


--=-K+936vS2Rb6HGJRYEh6P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAktLTY4ACgkQ3UR7ubYtCO65DQCfWavETJvlIYr78s09rYpQXPC2
qc4AoKFOJU6b3fPa6Pq/JDWDV7ykwKC+
=CWel
-----END PGP SIGNATURE-----

--=-K+936vS2Rb6HGJRYEh6P--



--===============1637827735527405705==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
--===============1637827735527405705==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============1637827735527405705==--



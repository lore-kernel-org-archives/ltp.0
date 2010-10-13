Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1P61z3-0003mz-Jx
	for ltp-list@lists.sourceforge.net; Wed, 13 Oct 2010 14:07:09 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1P61yz-0004HJ-QT
	for ltp-list@lists.sourceforge.net; Wed, 13 Oct 2010 14:07:09 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Wed, 13 Oct 2010 10:04:19 -0400
References: <1764805928.303201286974287503.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <1764805928.303201286974287503.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Message-Id: <201010131004.20059.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH v5] mmap/munmap /dev/zero
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5921185898715850448=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: CAI Qian <caiqian@redhat.com>

--===============5921185898715850448==
Content-Type: multipart/signed; boundary="nextPart1320222.rY8IDNpPWo";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1320222.rY8IDNpPWo
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Wednesday, October 13, 2010 08:51:27 CAI Qian wrote:
> mmap/munmap /dev/zero: a common way of malloc()/free() anonymous memory
> on Solaris.

what Garrett meant is that this is the subject, not the second line of the=
=20
changelog.  are you actually using git here, or just fudging the details an=
d=20
hoping people wont notice ?  your e-mails are not directly usable by git wh=
ich=20
means if we want to apply your patch, we need to screw around with it first=
=2E =20
please fix your git flow.

> +option_t options[] =3D {

needs at least static, and be nice if it were const too

> +	while (waitpid(-1, NULL, WNOHANG) > 0);

shouldnt you be checking the exit status of the children ?  otherwise, a=20
tst_brkm() call by them wont be noticed.  and why are you using WNOHANG ?  =
if=20
the parent happens to hit this point before some children exit, you basical=
ly=20
ignore them too.
=2Dmike

--nextPart1320222.rY8IDNpPWo
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iQIcBAABAgAGBQJMtbxjAAoJEEFjO5/oN/WB9kEP/iY2NXokO8cjEmEL3KUkpmRs
+58Mqatw/l0gYrTbh5AzOptGvDEjaBGRURR1WZVjlbqxG/zAQ0A+bpHRWn13D9oO
E6HyyUPrvBEpT1hdMS+SxdccHip1ZmP0kuKMzUfbihRoNTcjhnfLXNlfkj3tAuZU
pkUAN5wpK8dIpxCQI/UM0vRfOWUZ8jmibm3yOWxIAqDcmL6ERVCA6sRi3CSC8G91
60R/PXfVsP2xjeU3SM//JJ/0ISMYpyU/0vwPUTyXBHAIguzzEwZd9w0PcoHq9Wqi
EHAV9tHpjg4mcxSvna4Vy9+4pgeWme6EnESt0Kn8DN/pAp5Up7fQZFRxjE6bddnH
orhhDV/YTONvPsLSGfH2bke0O8BWGSY9E7wk7OdQkd7tBj3Q4a2+XK/lHq4mXvtL
hYCfY3wNDCiDbUbxhd2101bruirVq9rAnEZyb1QwiCVcR1s876lJFswlxt+jk5rV
amt8k4YTVYi04vtHn5XeVhrHyGLVXldac7aFSDAOiYx8layG3WeYLlEh1O+gRTuA
zt+u4VqIaruTvwTIA6rdDsnlur+yx23seVJJ2XDOS+HENeLaX2W7T6qu4WMzcULS
4QOTRsISnLlTalvlpoqEVP4r18UbZzhNivj9y/qrJaV43l8TeIhMnvse+ymZ5ceZ
1wQxl+KEj9GJz/iB3rpJ
=AWwW
-----END PGP SIGNATURE-----

--nextPart1320222.rY8IDNpPWo--


--===============5921185898715850448==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Beautiful is writing same markup. Internet Explorer 9 supports
standards for HTML5, CSS3, SVG 1.1,  ECMAScript5, and DOM L2 & L3.
Spend less time writing and  rewriting code and more time creating great
experiences on the web. Be a part of the beta today.
http://p.sf.net/sfu/beautyoftheweb
--===============5921185898715850448==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============5921185898715850448==--


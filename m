Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1Was8A-000228-CD
	for ltp-list@lists.sourceforge.net; Thu, 17 Apr 2014 19:37:54 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Was89-0005Kr-59
	for ltp-list@lists.sourceforge.net; Thu, 17 Apr 2014 19:37:53 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Thu, 17 Apr 2014 15:37:50 -0400
Message-ID: <3992309.8rLpXb3keE@vapier>
In-Reply-To: <1397208419-27737-1-git-send-email-alexey.kodanev@oracle.com>
References: <1397208419-27737-1-git-send-email-alexey.kodanev@oracle.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] configure: add configure check for GCC
	-Wold-style-definition
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============7625256494136054566=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: vasily.isaenko@oracle.com


--===============7625256494136054566==
Content-Type: multipart/signed; boundary="nextPart23723546.xOSDtbCM0r";
	micalg="pgp-sha1"; protocol="application/pgp-signature"


--nextPart23723546.xOSDtbCM0r
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

On Fri 11 Apr 2014 13:26:59 Alexey Kodanev wrote:
> +backup_cflags=3D"$CFLAGS"
> +CFLAGS=3D"-Wold-style-definition"

this isn't really safe.  the CFLAGS might have critical settings in the=
re that=20
impact linking.  why not just append ?
=2Dmike
--nextPart23723546.xOSDtbCM0r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAABAgAGBQJTUC2OAAoJEEFjO5/oN/WBgugP/iqb0TxNIBAMvUdnlNF43a0o
9/ZPKB1REfWxu0Dixg2rVNJTmzeVQVLwg6Wel8Vx7LYoT3UTZiUEAanAf3cOqsJM
VUBQ8/XqC6vcNB9S1zlqlDREfczI4Qc+VyOnM6Wb3T8nPHaDO2veV8pGiQCvah0a
oct79aQzDf2PPatIzHqVDsc7qmX9w3JDzV71adoB8I97YxmBDv+Hkf+15bEl6J0v
0SdCe59ba17/xWa1/NW8P6Zqwuvs7R7JNyfp9gkRtfFw69dWspfHkckdb1LEmbXv
Uv4ODu9qmeV/M/g7gRg9RuRHJtju9tRw3e6xv8yDWBF2tQNznxFknmW/EdyFcXr7
F1gBPQM5CxOSTyu0LC0/jRhc8V8qzw08ozsUVSRg1GLJFL5tQK2uyOgZTuh/nMXr
z8P7eOnzZi/JjI2d5ZyogAZX57PDSmnXZCjITaUKKzl/5hMAGfAU66PhUHnsPwTP
Ua1AmhHelxcQSm9dgxMWK3sLS7YhZ3IWKW7D9S1HeE3WuWUXhxUrqoryN/LWKw9z
DMM43a2otdMPI1n0kHAuh8rGBUcMV+0NDSXbSz045N2Sc7X9aGMwifAuz1QdDOp8
Z03kL04ANj8tL+RoUi/stmWPm5DEk/XKOihc6z4aQcxtTd46Infi8ejvLb3Bdmja
GsO8fn06nMgp7NqexbkU
=c0F7
-----END PGP SIGNATURE-----

--nextPart23723546.xOSDtbCM0r--



--===============7625256494136054566==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/NeoTech
--===============7625256494136054566==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============7625256494136054566==--



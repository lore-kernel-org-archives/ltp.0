Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <cristian@regolo.cc>) id 1PvX4X-00084w-Bs
	for ltp-list@lists.sourceforge.net; Fri, 04 Mar 2011 15:37:41 +0000
Received: from aiolia.regolo.cc ([178.79.135.37])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1PvX4W-00048p-4B
	for ltp-list@lists.sourceforge.net; Fri, 04 Mar 2011 15:37:41 +0000
Received: from regolo (85-18-251-172.ip.fastwebnet.it [85.18.251.172])
	by aiolia.regolo.cc (Postfix) with ESMTPSA id 3E2D764
	for <ltp-list@lists.sourceforge.net>;
	Fri,  4 Mar 2011 16:37:34 +0100 (CET)
Date: Fri, 4 Mar 2011 16:37:12 +0100
From: Cristian Greco <cristian@regolo.cc>
Message-ID: <20110304163712.7fd3b975@regolo>
Mime-Version: 1.0
Subject: [LTP] [PATCH] fstat05: fix regression on arches which get SIGSEGV
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============6656670121068112278=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============6656670121068112278==
Content-Type: multipart/signed; micalg=PGP-SHA256;
	boundary="Sig_/LH6MAthhjVK=Hd.LaLd/Axj";
	protocol="application/pgp-signature"

--Sig_/LH6MAthhjVK=Hd.LaLd/Axj
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

this should fix a regression for fstat05 on some architectures.


Signed-off-by: Cristian Greco <cristian@regolo.cc>
---
 testcases/kernel/syscalls/fstat/fstat05.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/testcases/kernel/syscalls/fstat/fstat05.c
b/testcases/kernel/syscalls/fstat/fstat05.c index bcb78a6..31adb59
100644 --- a/testcases/kernel/syscalls/fstat/fstat05.c
+++ b/testcases/kernel/syscalls/fstat/fstat05.c
@@ -284,4 +284,6 @@ void sighandler(int sig)
 	}
 	cleanup();
=20
-}
\ No newline at end of file
+  tst_exit();
+
+}
--=20
1.7.4.1


Thanks,
--
Cristian Greco
GPG key ID: 0xCF4D32E4

--Sig_/LH6MAthhjVK=Hd.LaLd/Axj
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCAAGBQJNcQcoAAoJEID329zPTTLkpacP/itPdhYjVCmn0zVW7LNWdLrU
UzZiiZwj8Hp2zUatTz7E+nn7W+Gy7emUefICEYPDoXXwq82r9AkU9DHAesWdsklC
Sei+PMpEsw3M3KbZPVg95nFtNU5TkhTsIvi/TVc6DrVonJ1zGthEq+Fx//5+QAkH
ualIj9091tZi52V6Wz195Msb/kUjtbOtSqHyPOMs6NROPEFucla+qa3SN/E+9E10
OYDG0hUjgQPG2QR77Ud9W8gYrcgVJHti9CHNze4lDTliQsYP9D8DsQ4jJOK0qfuR
eSLPyyD8mVrGhQKWsX1zagQLPrzyIEFVtDQu4ocB7TLXtEp60YBb5We9OgjBFW/a
f8F+9g0JmHV2q/KbTuSx8Eqk2RJlOqhl67HS055btDq4o172ulydOH+H4f1S3wmQ
LCa8iomB39i4Uo1YiiEMsTS5n4pZiCrRe5D6orNRx6yxJ1wKz57inrAXQNSnas5/
N9BtS9mThSZFIrrIDm3Mw8NMhPfBVQHZGNfYDgGNVOHGvCp/Z951a00fY7SG8NIZ
aBH5Ri43Cb6eXJPuw5GvLKRnlbj/wDJe3+cRAeo1DHV86cU72D1ilOJ/MHNCVz/v
x/sr/BlXsK0G2v4E15tywFxZ5RgB7R9J4WtBkJTTC0l7a/GW9oRefVq1yysIVheL
iupaUm2ghLhFYDhxReh7
=lAF/
-----END PGP SIGNATURE-----

--Sig_/LH6MAthhjVK=Hd.LaLd/Axj--


--===============6656670121068112278==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
What You Don't Know About Data Connectivity CAN Hurt You
This paper provides an overview of data connectivity, details
its effect on application quality, and explores various alternative
solutions. http://p.sf.net/sfu/progress-d2d
--===============6656670121068112278==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============6656670121068112278==--


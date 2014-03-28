Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1WTP1u-0000ui-9r
	for ltp-list@lists.sourceforge.net; Fri, 28 Mar 2014 05:08:34 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WTP1t-0007lc-IS
	for ltp-list@lists.sourceforge.net; Fri, 28 Mar 2014 05:08:34 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Fri, 28 Mar 2014 01:08:30 -0400
Message-ID: <698021823.mA9edKhrul@vapier>
In-Reply-To: <1395971064-625-1-git-send-email-xu.simon@oracle.com>
References: <1395971064-625-1-git-send-email-xu.simon@oracle.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] ip_tests.sh: don't use hardcoded eth0
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============3085175891084496556=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net


--===============3085175891084496556==
Content-Type: multipart/signed; boundary="nextPart2624932.g3yCLvkLs5";
	micalg="pgp-sha1"; protocol="application/pgp-signature"


--nextPart2624932.g3yCLvkLs5
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

On Fri 28 Mar 2014 09:44:24 Simon Xu wrote:
> The script uses hardcoded 'eth0' which used to work on most systems.
> This fix tries to find a 'working' network interface using the hostna=
me.

why doesn't hardcoding "lo" work ?
=2Dmike
--nextPart2624932.g3yCLvkLs5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAABAgAGBQJTNQPOAAoJEEFjO5/oN/WBhAcP/3nAnAS2K0eJYST+P5vFJekI
HlJxm/Q4m6sAZ8y/giOEq5XyLLoyjVBfFLsCIZr69j6Hri8srQ2HOO0viDSD4KJ5
q4J1FykYn2n8kiUE4GN2+DtHg/03k0tUSPFXAh8vFZS/LadWGmVNVxejW2RUevZy
nVTrf/7DCCkyHJDknN6My6NKuuteGaIHwxiO8UntvlTMPWfL3cDtieSiVfSxhiFq
hGnAXWovW+VfCh4pz78Sq9J2zsIHYziLOSTsYaogUKOslrhrRfM7Tj3Br+aCTNET
Q+y/z5Yz3X8IQQxde/Kt3PlM0oD2e5UWL8WtbZtXZjx4bK7HlMToNnlf7y/R1vjD
bx8KvhMaHcZmYJ+Ow1wekXRkRKUhgLqiPo7FUC7h7e+SIYaGVvxrm1ObRLYjDscz
zzwaQjHBHgX9sbDqk5h5PPNK5Q1zgaeoQXHsreEgywHzUxg+zryYkIgkYdM3/CPA
tBz9I8oitvsqi0NClfji8NQbDFHMqnufCEoIPU7xMQEVi+v/hGDx6J5d+TYUDDsA
Mbds0pI43lRXHF2JaKFOhiCjkJb13U7mlRlS7+/JG9bX8z+pYEhEqk/vDlb0sz1x
D23K+IXtMUwUFxAmgUNC+Y6jUB1SqjA8Z2yFr23pNaqvyhkpYlkvkCBF1n4t3Yk+
SJfzRFqWmjaAMNQE+efo
=aTm5
-----END PGP SIGNATURE-----

--nextPart2624932.g3yCLvkLs5--



--===============3085175891084496556==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--===============3085175891084496556==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============3085175891084496556==--



Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1RkIse-0002bT-Jc
	for ltp-list@lists.sourceforge.net; Mon, 09 Jan 2012 17:19:32 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1RkIsY-0000AW-Vs
	for ltp-list@lists.sourceforge.net; Mon, 09 Jan 2012 17:19:32 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Mon, 9 Jan 2012 12:19:20 -0500
References: <4F0ACAC0.6010309@imgtec.com>
In-Reply-To: <4F0ACAC0.6010309@imgtec.com>
MIME-Version: 1.0
Message-Id: <201201091219.20817.vapier@gentoo.org>
Subject: Re: [LTP] Split UCLIBC and UCLINUX test cases
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============7651453600213862663=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: Markos Chandras <Markos.Chandras@imgtec.com>

--===============7651453600213862663==
Content-Type: multipart/signed; boundary="nextPart2793710.poSrvKqVb4";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2793710.poSrvKqVb4
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Monday 09 January 2012 06:08:48 Markos Chandras wrote:
> Right now the use of UCLINUX implies the use of __UCLIBC__ as well. Even
> though this is true from UCLINUX's perspective, it is not valid from the
> uclibc's one. A non-uclinux system can perfectly work with uclibc. What
> I suggest is to keep the UCLINUX option as is, but also add a new option
> called UCLIBC which will enable us to avoid all the restrictions imposed
> by the use of UCLINUX macro (especially the disabled tests in
> testcases/kernel/systecall/Makefile).

header/func tests should get moved to configure.  we should not introduce o=
r=20
rely on any new ifdefs like UCLIBC or __UCLIBC__.
=2Dmike

--nextPart2793710.poSrvKqVb4
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJPCyGYAAoJEEFjO5/oN/WBM3wQAMCw/ovVVa4SB22/Mses8h1r
hIf3TDwDMwNlpydF3aur2e+rFykJjpzjp+FhvfxMr2UPg4R73bXBGmq70p2GdWg8
2ox6kMU0kEYCbukLufcoQ09eu8dvIme7Z/M+hV/raJk8Awz1NKVFuqPYBqGeaXl7
ILQCkqYj90hic4xXLZTD0Rdj1udUsUZOAjxLZX1YfljXsAlCIq2nGAbpM6Jx7/AV
pP+RG9IiW9BeIbIXyclMbm7anNgsBA2aPbQ35Oeq8ph8lT6UBuDMzVuGdQJSvvax
H0iI4IlcHRpi4KtwXf3CPm4+F8w78cg1NIXpmk8zq0JK9uuRyiVODMh+D3sU4miS
Io7pISk/HZDPtRTL+Gn+xw2orj8alDwoVFUvppinKk5fb85MiCVVMxmVsYiXxJrG
9PAUlP+M8QwfzLZ+5YFy6jKxvhP2WwUvkVyuKK59bmGFCBr8rnOzcJC1OyEKATAv
Q5bylBiQ5TxY8MO3sr8onHzzo8256c0rvbABWvgu4FRy5DFmcNXyHzb8+AaVlN2R
4i2CIIoihjQifWxperNiMwOAOoaVoG1JWs02OmcMBMVf3Sg3QNiPsGmqZhn1ZtpE
PSh+nV3u2LeOgGY1tmS+3ROlnMXjL5xWX3WhLijEWuw5wBHWzCkmzolD67kZ4ply
nhlVphCXI3PzcnXbpT95
=ttnc
-----END PGP SIGNATURE-----

--nextPart2793710.poSrvKqVb4--


--===============7651453600213862663==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Ridiculously easy VDI. With Citrix VDI-in-a-Box, you don't need a complex
infrastructure or vast IT resources to deliver seamless, secure access to
virtual desktops. With this all-in-one solution, easily deploy virtual 
desktops for less than the cost of PCs and save 60% on VDI infrastructure 
costs. Try it free! http://p.sf.net/sfu/Citrix-VDIinabox
--===============7651453600213862663==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============7651453600213862663==--


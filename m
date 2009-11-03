Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1N5PhU-00075t-H5
	for ltp-list@lists.sourceforge.net; Tue, 03 Nov 2009 20:09:56 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N5PhP-0004za-NQ
	for ltp-list@lists.sourceforge.net; Tue, 03 Nov 2009 20:09:56 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Tue, 3 Nov 2009 16:10:52 -0400
References: <1257168835.4977.46.camel@subratamodak.linux.ibm.com>
In-Reply-To: <1257168835.4977.46.camel@subratamodak.linux.ibm.com>
MIME-Version: 1.0
Message-Id: <200911031510.52895.vapier@gentoo.org>
Subject: Re: [LTP] Build Fails on some archs
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5985972013934566045=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net, subrata@linux.vnet.ibm.com

--===============5985972013934566045==
Content-Type: multipart/signed; boundary="nextPart1628294.dOhLyfiWCb";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1628294.dOhLyfiWCb
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Monday 02 November 2009 08:33:55 Subrata Modak wrote:
> There are some build failures of LTP on some archs. Probably, autoconf
> files needs to be written for them:

ive committed fixes for the clone/ptrace failures, but havent tested them o=
n=20
your specific arch, so if you could give it a whirl ...
=2Dmike

--nextPart1628294.dOhLyfiWCb
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.13 (GNU/Linux)

iQIcBAABAgAGBQJK8I5MAAoJEEFjO5/oN/WB0awQAM/lsD2C2aANq7G8PCt50FL+
WiXh8LRHLjcBTFGmMVcUTzXrqyO635WkgrxPSV9VBSaEGo4Qj2lH+fzqKbKvDXGV
I9giKxkgYop8rVFyt4PmQRj/14drVcoMqz+aTlc0hur7xyHNRjn0s08LcsXslT8o
I/xE8madJyWK4yyW9Dubr7E2M76mAuO741bxjwwrDILIrYHjIYMFWYX6jKSdVJPD
4xVLPeOkZ1EFOTD2bt6v0wwD+cL8NWK/wfuRWO1GMyDeb//8gEdBTG9CGyN5XXpm
KVDfOvth2xaVQsmAEziMHJH9ADOSWUzpp4XyHJefSKem+CPyLnIRRqT/z99AIGx7
ci4BDK0+7gb7dAcoRm1K0P/J7V8NrFkIAGngC2CpnqMmh5Jk1zyJzzJQ1FktCIqi
SweflhXs0huq9RxD44AhzqhGJLPH5q8Inz2MOiiF9o/+lqd4/8yIzi/RxY93Jegi
sWQJ9dQg7Ai/ldnwkKnpYREG+6irlTqQPl6PvCRi0FQl3FoqpA+pH7nIHn81QTvU
I07zNfZUsTf8CVLepSjGzb3CGWLPGMMN9XYSVMVPwDMJch0sv11xYpIBAJBuG8X1
csIPqX/HA2Sgz673soCj75psf3zxkZsxzphVVwFB0UqLyPzGeSu5r0XkXcWOLrpm
1PY99M8IwRl4D8l1CTmI
=g309
-----END PGP SIGNATURE-----

--nextPart1628294.dOhLyfiWCb--


--===============5985972013934566045==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
--===============5985972013934566045==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============5985972013934566045==--


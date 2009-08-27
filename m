Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1MgkYv-00051w-CM
	for ltp-list@lists.sourceforge.net; Thu, 27 Aug 2009 19:23:09 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MgkYq-0001lc-IE
	for ltp-list@lists.sourceforge.net; Thu, 27 Aug 2009 19:23:09 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Thu, 27 Aug 2009 15:22:54 -0400
References: <alpine.LRH.2.00.0908271703550.1134@vixen.sonytel.be>
In-Reply-To: <alpine.LRH.2.00.0908271703550.1134@vixen.sonytel.be>
MIME-Version: 1.0
Message-Id: <200908271522.55732.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH] quotactl01: Fix tst_resm() format causing crash
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2604447283662243082=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

--===============2604447283662243082==
Content-Type: multipart/signed; boundary="nextPart1673283.dKSsKlcvxA";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1673283.dKSsKlcvxA
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit

On Thursday 27 August 2009 11:04:40 Geert Uytterhoeven wrote:
> -                 	   	tst_resm(TFAIL, "%s failed - errno = %d : %s
> ...cmderror=%s", TCID, TEST_ERRNO, strerror(TEST_ERRNO),cmd[i]);
> +				tst_resm(TFAIL, "%s failed - errno = %d : %s ...cmd=0x%x", TCID,
> TEST_ERRNO, strerror(TEST_ERRNO), cmd[i]);

please use the new TTERRNO flag: tst_resm(TFAIL|TTERRNO, ....)
-mike

--nextPart1673283.dKSsKlcvxA
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iQIcBAABAgAGBQJKlt0PAAoJEEFjO5/oN/WBII4QAI/i+SAwqVJt5Oxjken0d5iY
QQ4WtByFS271lRwJtX6mOiF6+MHiXnYmFDD4VS9h/LrCWxonkUKtC5U/8cDQjc2w
l6qbulu7SYh1Cg9TbzZooALtLSuD60/Q1CueHviDe5aFu20LFoDW1AhZABnDeKbB
3IRRvePxOtCPE23Im1NzZ9aY2wVMMEQ+at8noOm1QWOGfMx8AAdmW70qNotjKTPq
2qh/zfc40CWqKDcN/lFEdNWDWxf1yf0awXWhaeStygUM6nmNFsBgdcpoRQFWjjSU
vR3vRcqSQ2kEMKE17GN7krAjvPWf22xkc0OYBL4iNtw+Tiom/1UhDY9dchQk8yBX
mPrnRkr+e+mcSC2Og/bMJI9/17VGgiYvvCdBpa0Gtu4gewLz9ZfGSMXcNc5O/dIS
JpRSCZMmRHSg293LTMrndqckdp4isUVD4eK1wdsiaiEsVAoiWSblWtmnTGjNSOIH
HsdbVnddh1sX9ZLwFdGEIA9PPS9ZQnJMongz8MdXHrC55rju3RXorlOzpaDYTGkW
hupnfHZpk01IfYmhrlWwgx0Ig1ESpIDbUvzL0uQIG4YDVvFH5AS5X525iIQqFPqu
88YSYXH9Wesr1MXaTDimMOZcEI6KR68SwMh91XPOBV/RjF4VdXRIE1NiuaPUEXG9
f+QOs/4nSxxs6jrqEurV
=kUzn
-----END PGP SIGNATURE-----

--nextPart1673283.dKSsKlcvxA--


--===============2604447283662243082==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--===============2604447283662243082==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============2604447283662243082==--


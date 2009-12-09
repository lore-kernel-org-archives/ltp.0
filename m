Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1NIKPk-0003CM-Sy
	for ltp-list@lists.sourceforge.net; Wed, 09 Dec 2009 11:09:00 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NIKPe-00050K-GF
	for ltp-list@lists.sourceforge.net; Wed, 09 Dec 2009 11:09:00 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Wed, 9 Dec 2009 06:09:07 -0500
References: <000001ca78a2$93fd5a50$bbf80ef0$@co.jp>
	<7F8A730D-2350-4FB1-8A5A-F37B8CFABFE9@gmail.com>
In-Reply-To: <7F8A730D-2350-4FB1-8A5A-F37B8CFABFE9@gmail.com>
MIME-Version: 1.0
Message-Id: <200912090609.08566.vapier@gentoo.org>
Subject: Re: [LTP] make error
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5937074230871138282=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: Mitani <mitani@ryobi.co.jp>

--===============5937074230871138282==
Content-Type: multipart/signed; boundary="nextPart7462174.GfL9DHOP8r";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart7462174.GfL9DHOP8r
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Wednesday 09 December 2009 02:48:45 Garrett Cooper wrote:
> I'm making multiple versioned copies of Fedora based toolchains and
>  sysroots to work around these issues, as I don't have a toolchain setup
>  for ia64, nor do I have real hardware to compile on. Really
>  counterproductive when trying to resolve these issues :(...

Gentoo has ia64 hardware you could get an account on, and `crossdev` should=
 be=20
able to produce ia64 cross-compilers.  due to the libunwind funkiness, ia64=
=20
tends to be one of the harder ones to make cross-toolchains for.
=2Dmike

--nextPart7462174.GfL9DHOP8r
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.13 (GNU/Linux)

iQIcBAABAgAGBQJLH4VUAAoJEEFjO5/oN/WBaKYP/A/HFlTo1rR66gt7YRSwbQZm
bBGLUgg6+2mrVtF12R4pSGccdJuRz1UVJn73jE4f07uNEeampiBsWzMuT2ODHjiU
udX1UvtmPislcpd01CM1v+OU3YAji1G+x9FcrE4fK2/E2B8pxXssVpn2hxwwIEpc
Dj4oKHFfef2TwQJAhj98lL10Iz1srxeUGxVlnNBiukX8/e5uAlfCldd0jGsm1Gzv
IU36sRURGJAY0TjbtgadvWDaQxqypzjoEh7Rz5kAyAxp4Ebkv7Cz0lWAag3IQYpS
d5pFlSR7Ab4V0EbW3Idb5qlLMUnZwYAfM/mwSviH9o4DzjVQbnSn9ndv4H7hvUBO
sro3tcBpRc6D+ck6CaOhr3vodVMu3Iy/ASpF+bGyUqxwvmKCUFBY1WeRuY5MGql6
LLZ/tpAPP6HoJg/K2x82B/0vR9tl+q3uPUCg6EHxgSm6UhRPInc/6C4rdwuHOMSb
diiBt1ybvTrC6ZBmZzy/laikZ8hm96gyut6TDS78odjBCVeETafcGIyBr/MnsWiT
FTYFUFbeOKEiD3FwAuHXBIum6rjYmmfcbrDoMYLNO1L0tk2V7/VaExVRGCtByQZC
vleN6Hofcaz6VyfeVFLntlVpgA0tVoyRxobL6QV/awolnPLyL+xqbb7brtEry61o
SJ4CvCD16XCQgC07Ffud
=H560
-----END PGP SIGNATURE-----

--nextPart7462174.GfL9DHOP8r--


--===============5937074230871138282==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Return on Information:
Google Enterprise Search pays you back
Get the facts.
http://p.sf.net/sfu/google-dev2dev

--===============5937074230871138282==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============5937074230871138282==--


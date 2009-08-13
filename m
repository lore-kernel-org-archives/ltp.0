Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1MbUd9-0008MT-Ds
	for ltp-list@lists.sourceforge.net; Thu, 13 Aug 2009 07:21:47 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MbUd1-0001CL-S5
	for ltp-list@lists.sourceforge.net; Thu, 13 Aug 2009 07:21:47 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Thu, 13 Aug 2009 03:21:31 -0400
References: <4A7AA1BE.9050901@petalogix.com>
	<8368651DACC1964480F951191B94A078F8A313@svexch01.mvista.com>
In-Reply-To: <8368651DACC1964480F951191B94A078F8A313@svexch01.mvista.com>
MIME-Version: 1.0
Message-Id: <200908130321.32869.vapier@gentoo.org>
Subject: Re: [LTP] utimes01
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0103148426439446686=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============0103148426439446686==
Content-Type: multipart/signed; boundary="nextPart1461723.kCoIbRd2sf";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1461723.kCoIbRd2sf
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 06 August 2009 20:56:58 Henry Yei wrote:
> Michal,

please do not top post

> This is a known issue. If you look at the manpages it states the following
> under the BUGS section:
>
> Linux is not careful to distinguish between the EACCES and EPERM
>     error returns.  On the other hand,  POSIX.1-2001 is buggy in its
>     error description for utimes().
>
> utimes01 passes on 2.6.28-13 kernel (Ubuntu 9.04) as well as the 2.6.18
> kernel in CentOS 4.

if POSIX allows for both, then so should LTP
-mike

--nextPart1461723.kCoIbRd2sf
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iQIcBAABAgAGBQJKg778AAoJEEFjO5/oN/WBRsQQAOGBWMLhvgZEG2k4/Q+oe7QW
N0koyTl3gPPgiEFB2fdUz8yF80lVorQaSJIWo/OjkDfMIowNzSyc9zLonM23W3gZ
aq3J0HVSfzgFgWCVriF4MdiHOkxL2GTdjX2Et2Jdf1HexscZc0QnckzycMtAtBzR
uIlAOtLDAnb59xMG6Ub6t6J9YpzKxWhzILo2PfK1s9hSjg/LH9L8sCjV7q/1vkQz
OOa66O5CKQ5OkkeIdaYXImYMzlgJHXDT0bvhZ1x9AxvpfF6L+H6UJvYQXSPKVog0
4/CNJLEp707zZsnNxSZuBNdyzvz0pO0Ehil1WqeJq2tpZwlsfvqapdY0imPNxnEw
otuC/gOHxemr0FJAFrLYPDf7x95x6asPv3zdtazMQikbWH/JQCEBuOiDLhWQYFlx
aaSbgdn4olgf4IcCOUqU38SjjwOHfZ6k8psvpkLYp2a0FgpcyLuaxVW4ETmpINim
fJW6JojrkRZfHIuSug1TV3SJQo+/vZT+oHymvfHMtGtaGdL+zLTOFb0OmjvIg0EX
h24juLMm7ejk5V/cuB/S88BlF0aqGadRyXiqXCNykToJSZ5eafpxfoA51G3bD5Rq
R8d1z8YgwQG0E9r/TYkFouKySvni9yCWM0T6xZNhjVcLLe1UZ4GsD4zAuRrfxrHJ
hwVOcl9J2zFh1uQoeJRH
=ez1r
-----END PGP SIGNATURE-----

--nextPart1461723.kCoIbRd2sf--


--===============0103148426439446686==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--===============0103148426439446686==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============0103148426439446686==--


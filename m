Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1MbS3s-0000l0-En
	for ltp-list@lists.sourceforge.net; Thu, 13 Aug 2009 04:37:12 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MbS3o-0005QI-91
	for ltp-list@lists.sourceforge.net; Thu, 13 Aug 2009 04:37:12 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Thu, 13 Aug 2009 00:36:59 -0400
References: <364299f40908021920v5b743b6k7a4516b79731de5d@mail.gmail.com>
In-Reply-To: <364299f40908021920v5b743b6k7a4516b79731de5d@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <200908130037.00080.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH] Fix compiler warnings for performance_counter
	tests
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1270434360725097947=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============1270434360725097947==
Content-Type: multipart/signed; boundary="nextPart1262781.2IFFBWrvf5";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1262781.2IFFBWrvf5
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sunday 02 August 2009 22:20:07 Garrett Cooper wrote:
> This simply fixes some missing declarations and linux_syscall_number.h
> cleanup related compiler warnings.

your e-mail has line wrapping problems

> -int main(void) {
> +int
> +main(void) {

unrelated noise
-mike

--nextPart1262781.2IFFBWrvf5
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iQIcBAABAgAGBQJKg5hsAAoJEEFjO5/oN/WByToQAJb3PikpOxrPYX1MzRWDqnS0
pKYWaGBW9RFpI5ZJvs3P1bHWLZ1ysjcZo/jOF2AP+wkXKcu5ijSpFtCyyLioEhur
hfxh9IsAfQKm+dogUd6i50sQoQbxhf2c+KlnYB1GtUpPpVZy4rdTBOARVlmGwqrl
qjJR0EnsnnMFmfdl97HX4vpAse3lprSpUZzmwn278R/yX4H9K25Pqb+5dWSGR0M7
OsQB3D8t+A7npvwSXzJfV19hHXVXqRlLin+gWgAK7qxuaNaxYKWtWTmNkuThpUqj
OkRQL2LsGP5fVelbCcpPD2aR1ajJkQVWOC1JU1FOJWhbd4YnmevihVm5oyrtY2bL
mtTxchQ2w3dHEnc00KG8y1Ist7X7VVuBfwHdvBrMdfR/1c8Q58SFrUYsI7X65ofs
mgOzwSNMgAhL9ykCSGgPcUrPQs0ZR1843Ej6ERN0rBgWTDpoScgXYtCo4kae/yX2
OYEBvX9p/dotSSKfaem1z35qEo+Qwmz78qppYav55Cpj+JkYIuhzcI4T1WY/BxTd
rm/SBSIdJWL8LeV6RdDZqxpqKKmxDm3WWs4GMmntUBZ4aGV+ThS6lvopgD81hBvG
Lsr6kWjwgClHHH2cpatRCyTH4W62ht5+J/VEd/d7oZ9kcHif5dFKQ3glhWVl8byV
jJHx4vrCr7asudlSjs7k
=w50Y
-----END PGP SIGNATURE-----

--nextPart1262781.2IFFBWrvf5--


--===============1270434360725097947==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--===============1270434360725097947==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============1270434360725097947==--


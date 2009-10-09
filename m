Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1Mw94I-0001Au-LC
	for ltp-list@lists.sourceforge.net; Fri, 09 Oct 2009 06:35:10 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Mw94C-0003Pn-Im
	for ltp-list@lists.sourceforge.net; Fri, 09 Oct 2009 06:35:10 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Fri, 9 Oct 2009 02:34:55 -0400
References: <20091009.152108.954124754429052503.yamato@redhat.com>
In-Reply-To: <20091009.152108.954124754429052503.yamato@redhat.com>
MIME-Version: 1.0
Message-Id: <200910090234.56735.vapier@gentoo.org>
Subject: Re: [LTP] Checking flex existance in configure
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============3849537889277724396=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============3849537889277724396==
Content-Type: multipart/signed; boundary="nextPart2316273.hOka4qUOii";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2316273.hOka4qUOii
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Friday 09 October 2009 02:21:08 Masatake YAMATO wrote:
> In INSTALL file:
>=20
>     3. Run "make" to build everything.
>        *NOTE: Some of the Makefiles (example: pan/Makefile) require the l=
ex
>  (or flex) package to be installed.
>=20
> I've added AC_PROG_LEX to configure.ac to check the existance of flex or
>  lex command.

Garrett has this fixed in his pending build patch.  i dont think this fix i=
s=20
critical, so it can be merged when Garrett commits his changes (hopefully=20
soon).  it'll make his life easier as it'll avoid conflicts (which suck wit=
h=20
CVS).
=2Dmike

--nextPart2316273.hOka4qUOii
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iQIcBAABAgAGBQJKztmQAAoJEEFjO5/oN/WBpp0QAKGg7J+xrSG48iixdYfwR54d
dBz1kUCpTpNGYLXvQLgFFpuFoMzUKO7pPfTiU9dSOp4Vq/eDFoUrKvZY5ElLqk8c
fpjawMhRQdm6Ddg3AlmxQsRKFfv+tUEdVZOKCSA9ApQ8qR+RM5RIbhp95fe7HI8j
0UfOgKCzZDxW4ZqMusJ9yHBTMzqN/Sf8C/RlRGe8N7rvfTBwAWq/4Q5RuYieLFc9
o9JAsWB/5jZOI/qVK26LtySHT7MF6UlD5t1svBNv3EOA+jS6HyMSe69vYtg1ORHc
GyPULswiLx5PIEiIa7JS8NrIkFKGeO/wp2J7U2pC4ZORmZOOPcw0YO5wujF8+HdN
iY2yISKPjiR+ybRFpXtIJyH347d6b9d/KrZj/cXsnyb1GSlv5qyYTB04b1R3TjMo
dJvAkXALVeyzldDyG2lEVNmg46v/9HGte/6uWIOXS3N8NKabHi5z1QFf3vxMpvBL
dfZIGbmVuVuhVYQBZevn4TA49Nmk9s+vN4QTwgGm+HmStY0qQ2owOhCdoT8Jp7KQ
bDe47ve5KDt6ULjwC0dnxtTXEUTjJCkx1/hFefcc/lksErXmpQMTU0kltuWzAcXo
81L34mJipiSUglVTuQxcvtvkJpun4Pay69ry16Ul9P5ZU6hYeoTrNwHCmprxc1ka
7HOHPsi1Q7T4MWN9t8Br
=z7Tm
-----END PGP SIGNATURE-----

--nextPart2316273.hOka4qUOii--


--===============3849537889277724396==
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
--===============3849537889277724396==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============3849537889277724396==--


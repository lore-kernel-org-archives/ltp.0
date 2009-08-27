Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1MgkcT-0000cx-2C
	for ltp-list@lists.sourceforge.net; Thu, 27 Aug 2009 19:26:49 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MgkcO-0002Rq-BU
	for ltp-list@lists.sourceforge.net; Thu, 27 Aug 2009 19:26:49 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Thu, 27 Aug 2009 15:26:34 -0400
References: <alpine.LRH.2.00.0908271705160.1189@vixen.sonytel.be>
In-Reply-To: <alpine.LRH.2.00.0908271705160.1189@vixen.sonytel.be>
MIME-Version: 1.0
Message-Id: <200908271526.35613.vapier@gentoo.org>
Subject: Re: [LTP] quotactl01: syscall(258, ...)???
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============8639449985161881033=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

--===============8639449985161881033==
Content-Type: multipart/signed; boundary="nextPart5499997.zAhvsBIZaS";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart5499997.zAhvsBIZaS
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

On Thursday 27 August 2009 11:07:55 Geert Uytterhoeven wrote:
> testcases/kernel/syscalls/quotactl/quotactl01.c has:
>
> 	TEST(result =3D syscall(258, &newtid));     //call quotactl()
>
> From the number and the parameter, it looks like __NR_set_tid_address is
> intended. But the comment suggests otherwise?

quotactl() takes more arguments while set_tid_address() only takes a pointe=
r. =20
so i'd change it to __NR_set_tid_address and see if it still works on your =
x86=20
system.
=2Dmike

--nextPart5499997.zAhvsBIZaS
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iQIcBAABAgAGBQJKlt3rAAoJEEFjO5/oN/WBXwYQALadCDUUDVejJGTeDN6wDRJP
r+HF0plGp9jRw5R1vsEkkiZgtjAwGMlDzHoxKQHjfdQUi2rkC4Fbu3hQmSIpXNok
uDVEo689yBIQ3K7Y84EZIM6G+v58BwLPFz/WEvFwji5l/GeVBBVI3YzzXsq4/ghH
qhXJXbERCADwdJepYrqCpR4B5SCejqkPsyRta10fBA32M/Ifxtt8ciFbWAX2z6y4
7WYHRrvz1uLkD9eJyzCxfHTeP+uU15AKvAmXaZRtGMeB4IOqNLIRkcxAaVFh6J87
CnhfUwt3HiXb+xArd6SzWf2KDxRXKQ0VAyTNkcqIuCzHEEKyfPmK4Bsyt1ZSC6qP
BRFj964HjBcW7v9EGOUX4dBmu6ErIob63eZRk8V8+r5dv2d/AI26ks3Axzta4yha
6mg9ihaIwA1H1OYHuKL9EfPe10Dgxn0cHUbXrsEC2sdJC+81EPY5eQhV1B+gVfRV
GA2yI2HCUkKxujB1t0+/apSU4DeTuieeScLWwcU/LmtLDS+vtIrrmMbsCE+nO9F7
S34wOHf65S+M6UkzVGk1HFB63YrA8Pq3HzzojfAk+bXdW25gqXcDTvLv7VN9To5G
9U4kdkxMjOpdznLAc+uBy9Orm+xDaz7OscRl84KAo8fsT5x23qMUI0SGOxE6yTNz
7cuM3woxNb/2tAwQqdWP
=Nnn0
-----END PGP SIGNATURE-----

--nextPart5499997.zAhvsBIZaS--


--===============8639449985161881033==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--===============8639449985161881033==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============8639449985161881033==--


Return-Path: <ltp-list-bounces@lists.sourceforge.net>
From: Mike Frysinger <vapier@gentoo.org>
Date: Fri, 14 Aug 2009 13:20:27 -0400
References: <alpine.LRH.2.00.0908071113370.11434@vixen.sonytel.be>
In-Reply-To: <alpine.LRH.2.00.0908071113370.11434@vixen.sonytel.be>
MIME-Version: 1.0
Message-Id: <200908141320.29316.vapier@gentoo.org>
Subject: Re: [LTP] linux-libc-dev and LTP compile failures on ppc
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============3575988983247780980=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, bugs@debian.org, ltp-results@lists.sourceforge.net

--===============3575988983247780980==
Content-Type: multipart/signed; boundary="nextPart4493318.zjXK1euune";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart4493318.zjXK1euune
Content-Type: text/plain;
  charset="iso-8859-7"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 14 August 2009 08:48:10 Geert Uytterhoeven wrote:
> This seems to be caused by <linux/cgroupstats.h> not being self-contained
>
> (it needs but doesn't include <linux/types.h>)

bug report should go to debian and/or lkml

> | gcc -g -O2 -I../../include -g -Wall -I../../../../include -Wall  =20
> | signalfd01.c  -L../../../../lib -lltp -o signalfd01 In file included fr=
om
> | /usr/include/asm/fcntl.h:9,
> |                  from /usr/include/linux/fcntl.h:4,
> |                  from /usr/include/linux/signalfd.h:13,
> |                  from signalfd01.c:62:
> | /usr/include/asm-generic/fcntl.h:117: error: redefinition of =A1struct
> | flock=A2 /usr/include/asm-generic/fcntl.h:140: error: redefinition of
> | =A1struct flock64=A2 make[4]: *** [signalfd01] Error 1
> | make[4]: Leaving directory
> | `/root/ltp-full-20090731/testcases/kernel/syscalls/signalfd'

upgrade your C library so that it provides sys/signalfd.h
=2Dmike

--nextPart4493318.zjXK1euune
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iQIcBAABAgAGBQJKhZzdAAoJEEFjO5/oN/WBX7sQAKA8lx59gendAfssbM08V8fD
x0v5rkuoO8XHoZHXgDFSlq9A5FTQERkoWm5zZS5zd8h0Vx6QISxHXtw75IdJH8zs
c/nqdsQRsTJyhIDXidm8C8gPv215xgeRsGsKQ9p1188nXUdasWb4UatT30xIUM3B
/75Dk0t1dMFNTRQ7RJdnLru20CDl59hjGCvOiEFmyZ01cuE1S7EhqioDq1JTc6u2
9BvkPl+3tn21qpEZogOHth59HqZVh1+o0yuv8MfWSwbhMow1d1T7l+QJ5lZf5jNO
6YOJnzGQ0I7uq6do2EqbBdNlk3Z4Zr8Oy9mgXJoOeHua2boDw6N6c/BRa2nF//yz
MfmrPAGvonKrzwpqK3uwrjC5rXWEQqhX7G+aylpjH4s4YdLuz0R65ScStqRvz2us
PRkfJ52Mh9aHmcOQzFIfcRBIyXtw1z6DILigVsl0bnaiADfjB7s9K43aXU5CHNd3
0MwKIEFCoVQgV5z/oTfyH1EQi0BH9kOUsn3VVrNtEI5NEm3sdzFxMbEG81IlmvIc
zQw4BxVCWcaOMZRjWtgYWbWT2YVMXOeyZ7HUTIGALy9VSzHBvqsJkQrQeIJcqPPv
v6foH7f5UpOs6tcjlV5EHcheLJxJAhZoEP3wGzP9QH5IQ/XqjIRBTv6nIxHtI7Tu
IyND6BP9fYSO8/ekUDwC
=O1Ol
-----END PGP SIGNATURE-----

--nextPart4493318.zjXK1euune--


--===============3575988983247780980==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--===============3575988983247780980==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============3575988983247780980==--


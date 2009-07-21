Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1MTMtX-0002Za-1s
	for ltp-list@lists.sourceforge.net; Tue, 21 Jul 2009 21:29:07 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MTMtP-0002Te-9N
	for ltp-list@lists.sourceforge.net; Tue, 21 Jul 2009 21:29:07 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Tue, 21 Jul 2009 17:28:54 -0400
References: <20090721.182542.1000278277145531816.caiqian@cclom.cn>
	<364299f40907210721q365aa8fdu21a1b2ff254bc60a@mail.gmail.com>
In-Reply-To: <364299f40907210721q365aa8fdu21a1b2ff254bc60a@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <200907211728.56027.vapier@gentoo.org>
Subject: Re: [LTP] LTP Intermediate Release for JULY 2009 Build Failures
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============6357474337999474906=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: ltp-list@lists.sf.net

--===============6357474337999474906==
Content-Type: multipart/signed; boundary="nextPart1425289.1mbEs6WpKq";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1425289.1mbEs6WpKq
Content-Type: text/plain;
  charset="windows-1252"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday 21 July 2009 10:21:44 Garrett Cooper wrote:
> I was tempted to fix the format string error, but I don't know what
> the potential implications are of switching the data type from
> u_int64_t to unsigned long long...

dont do that.  just use the proper format string from inttypes.h.
uint64_t f;
printf("f = %"PRIu64"\n", f);

> +/* Dummy function reference to avoid compiler warning from
> linux_syscall_numbers.h. */
> +extern void cleanup() { }

this is incorrect for a few reasons.  it should read:
+/* Dummy function as syscall() from linux_syscall_numbers.h uses cleanup() */
void cleanup() { }
-mike

--nextPart1425289.1mbEs6WpKq
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iQIcBAABAgAGBQJKZjMXAAoJEEFjO5/oN/WBKzAQAKIm85/X379goI5jpLq9pBJP
D6U47Zt18mvZ+v5X6wAx3TIAuOOD7iSx2nyhxp48dnnjgtJLzcM3d2vj8YDHXWt9
HBXtt3TNHj35VTLtVJAJMnM4MzdL+bg+EIyIvPK9KsFcBbH/hxjkD948PWfNACZi
YwIXa1AWpYCKz+cTa1qpjGFqXpRnJEzIxgBDAS4gvtCt5fN0iNsorZwrBOZSbfHm
KXGtojHJsEoJETI6selOVlW3V3UehomwqI2EHz5mnyMP6BaFNKzLaac/qNkkhLAY
mjPRI5riwqjwgYioRg+AI2zqyrwvi0C3Tfw0HhbTnTva56B86dvi+56/rLIWbToW
TT8oZYYhnYvZL42fM9HRe+AGbcOsMW6Laa/Q6Fp7AMYpzrwoZuudzHUsNuEo/lrs
syUoo8SGypWn/Ks3waaRKfQsLFimGUX19cWo9xNs+jbL6mF+qqxQ0dYwHLBQoQ6V
+LunwJrYXHmr2k4+c9Fb9olL0HvMX2iOgrH3Qw6HFCo7+hvFv0h884Yia9of2EvR
Hu45gYqZEWuIIgz9t74/jgVII9+24oD1kMkP/dvddI978PaFerrwuiUyNlAjPeIJ
L5y2+s8EpGots3MKK1EPCnPKyUuoe1EFxz99cxG7UpLlLOMOC0E1c14UR6a9x++A
4/YbMEkwez/BsBpjtNiG
=+2Xc
-----END PGP SIGNATURE-----

--nextPart1425289.1mbEs6WpKq--


--===============6357474337999474906==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--===============6357474337999474906==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============6357474337999474906==--


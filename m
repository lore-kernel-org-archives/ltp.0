Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1N8n6M-0000Z5-9w
	for ltp-list@lists.sourceforge.net; Fri, 13 Nov 2009 03:45:34 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N8n6F-0003Xt-SZ
	for ltp-list@lists.sourceforge.net; Fri, 13 Nov 2009 03:45:34 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Thu, 12 Nov 2009 22:47:41 -0500
References: <1257765429.7677.23.camel@subratamodak.linux.ibm.com>
	<1257788341.7677.62.camel@subratamodak.linux.ibm.com>
	<364299f40911121243i2bf72ab5p258fa78989b3df5@mail.gmail.com>
In-Reply-To: <364299f40911121243i2bf72ab5p258fa78989b3df5@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <200911122247.42705.vapier@gentoo.org>
Subject: Re: [LTP] Clone build fail with the latest CVS sanpshot
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============7731364008581019469=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list <ltp-list@lists.sf.net>

--===============7731364008581019469==
Content-Type: multipart/signed; boundary="nextPart3571598.N7PF96c0YD";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart3571598.N7PF96c0YD
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thursday 12 November 2009 15:43:20 Garrett Cooper wrote:
> On Mon, Nov 9, 2009 at 9:39 AM, Subrata Modak wrote:
> > On Mon, 2009-11-09 at 07:49 -0500, Mike Frysinger wrote:
> >> On Monday 09 November 2009 06:17:09 Subrata Modak wrote:
> >> > I get the following failure with today=C5=9B CVS. ./configure has be=
en done
> >> > before make:
> >> >
> >> > gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
> >> > -I/ltp-intermediate-20091109/testcases/kernel/include
> >> > -I/ltp-intermediate-20091109/testcases/kernel/containers/mqns/../lib=
cl
> >> >one -I../../../../include -I../../../../include
> >> >  -L/ltp-intermediate-20091109/testcases/kernel/containers/mqns/../li=
bc
> >> >lone -L../../../../lib  mqns_01.c   -lltp -lclone -lpthread -lrt -o
> >> > mqns_01
> >> > /ltp-intermediate-20091109/testcases/kernel/containers/mqns/../libcl=
on
> >> >e/li bclone.a(libclone.o): In function `do_clone_tests':
> >> >  /ltp-intermediate-20091109/testcases/kernel/containers/libclone/lib=
cl
> >> >one.c
> >> >
> >> > :25: undefined reference to `ltp_clone_quick' collect2: ld returned 1
> >> > : exit status
> >>
> >> should be fixed now.  static lib linking order is picky.
> >
> > Thanks Mike. building fine now.
>=20
> When you switch that back though, it fails to compile on Gentoo. Hence
> that's why I did `-lclone $(LDLIBS) -lpthread -lrt'.

huh ?  i test everything on gentoo, and this has been working for me.  if l=
tp=20
requires pthread/rt, that should be fixed in common code.  the issue here i=
s=20
that libclone needs libltp symbols, and that's it.

> Some autoconf tests need to be created to detect broken linkers like
> this because it's really annoying doing this tug-of-war with the
> library ordering...

i dont think so ... start by posting the actual error messages you're seein=
g.
=2Dmike

--nextPart3571598.N7PF96c0YD
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.13 (GNU/Linux)

iQIcBAABAgAGBQJK/NbeAAoJEEFjO5/oN/WBWgwP/32xf+N5HXdWwAa1/RN52xtV
+RvU3qfwmXO8MPAOprOgHIqVXSrzrZxKlqQlGSfyEspFFIVM2iQO3MohW1K++9ao
P3l597RwCh7RYWOV/DVy/7PhP9eWqjjFpjpPQHcNhjTmlau1mlju/cKJIPwgZcOa
wmttAYnGI2TnILv+w0kQVeUhN0Xss7cDgevC+ZOkY9EjrijlyQwXFJKK4PXgETme
c9XA2tjJXh6eZ02ou/iwkvCyTO1iK8aezmG6Ap3wKqRQTYZBJGAjGQIeidkZsXV5
USUjr/zZpAjV9Lu7I18vvc7wm5AvAuhRFA+DzmN027g07yNaTNDl+ucBafwezwT/
xdhKqa0zYIMk7tadFxFFLjk8wdOGds6zlzL9dkEtcYMeOpD/j9n3pFCOtyccMKDt
KLNOgUekn6F8Mkw1O0ZIV3+VSmr26652B1coGwdbuDnOOfvtwhZBBvXpV3tiTdR0
c3/Srkw6yJd+topoPuryAG7DDm2K9QkxaNZgB5eeX2MK9zT7jSoJSRfoih2Xvsou
SBK3EZIM6VjVe3p2AQgLeoZKO5GZE0F0hYQDkAeVLkyIWYZpTGfZuaW3OLlomVUB
dY21wZM0vZ2BuUhkv6CARIrulOSnESODOs5U7fUUawdH3rMHiNTaaWCgkF7jUIJt
/dElTooxuubmvPjUfOud
=CcWJ
-----END PGP SIGNATURE-----

--nextPart3571598.N7PF96c0YD--


--===============7731364008581019469==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--===============7731364008581019469==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============7731364008581019469==--


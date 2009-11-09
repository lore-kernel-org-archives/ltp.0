Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1N7Tee-0005Ci-TD
	for ltp-list@lists.sourceforge.net; Mon, 09 Nov 2009 12:47:32 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N7TeW-0008T6-V5
	for ltp-list@lists.sourceforge.net; Mon, 09 Nov 2009 12:47:32 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Mon, 9 Nov 2009 07:49:09 -0500
References: <1257765429.7677.23.camel@subratamodak.linux.ibm.com>
In-Reply-To: <1257765429.7677.23.camel@subratamodak.linux.ibm.com>
MIME-Version: 1.0
Message-Id: <200911090749.10428.vapier@gentoo.org>
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
Content-Type: multipart/mixed; boundary="===============4629792912989790679=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: subrata@linux.vnet.ibm.com
Cc: ltp-list <ltp-list@lists.sf.net>

--===============4629792912989790679==
Content-Type: multipart/signed; boundary="nextPart2579129.bkyt06FQNI";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2579129.bkyt06FQNI
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Monday 09 November 2009 06:17:09 Subrata Modak wrote:
> I get the following failure with today=C5=9B CVS. ./configure has been do=
ne
> before make:
>=20
> gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
> -I/ltp-intermediate-20091109/testcases/kernel/include
> -I/ltp-intermediate-20091109/testcases/kernel/containers/mqns/../libclone
>  -I../../../../include -I../../../../include =20
>  -L/ltp-intermediate-20091109/testcases/kernel/containers/mqns/../libclone
>  -L../../../../lib  mqns_01.c   -lltp -lclone -lpthread -lrt -o mqns_01
>  /ltp-intermediate-20091109/testcases/kernel/containers/mqns/../libclone/=
li
> bclone.a(libclone.o): In function `do_clone_tests':
>  /ltp-intermediate-20091109/testcases/kernel/containers/libclone/libclone=
=2Ec
> :25: undefined reference to `ltp_clone_quick' collect2: ld returned 1 exit
>  status

should be fixed now.  static lib linking order is picky.
=2Dmike

--nextPart2579129.bkyt06FQNI
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.13 (GNU/Linux)

iQIcBAABAgAGBQJK+A/GAAoJEEFjO5/oN/WBoTMP/2h/pZuK5kUdf4qja5MR0GlM
6BUFCvROIBPKh0nEI/RU8Ydc06YQDch33/Sp9EWqWOKpfM5NkRWTUvBmo6XaMFGe
zxdzNwhcD9qPLOtwsaP6pgBxCystblw3dKa8g+POovlzRinIT9e9ZhB7l5YLkYeb
DXXXYSI0WwZ0zjNwsxR1Lg5WU+USsKND8i/wxTIDvCB6s6HlonQIfvZn47xDnUeG
typLOYkxkURUnYzWOkVfxMDLLpxnfFJMYEXBCBJ8qV4Gsb8LEWqVafwrE5C7Z8YF
IcXGKKFjAmlyG1sXjGesGT5ZxrAruW8W8FsCEIb2+2Rm5H+/+NLtttA36lIaMaqt
HH2Is3KTtGglu3ru0S2WwxuKAB6ORi46D1bqWWTXMcpINtwsVU8KzHkinGN7LUud
ltvUn7k8M8SS6UFwwd1LF3PgjB6HMakc1CevT0J7xRqoBX20HxAleamN28NXJVj7
zf8jrpff/ljBtVnU/7oVbkaP9O72Vf+TKbLJltzCcyD6aXLdKCeiBk+4cq41Wi5z
jf1WtDane6i8L97z3q7soNQ/YEHTz3M/4y5yNezhWhTEr1a2hBm6M+ZaSLj8BbeT
KcKClxrM8LYj81kOm5fxC/PSgsUjip9xqmY8HdzxWmvJgOMCNFIcotaLyVahkiky
93sVHj2ZMrBaeIj+Vsrs
=8V/z
-----END PGP SIGNATURE-----

--nextPart2579129.bkyt06FQNI--


--===============4629792912989790679==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--===============4629792912989790679==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============4629792912989790679==--


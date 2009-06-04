Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1MC89Q-0007AA-JV
	for ltp-list@lists.sourceforge.net; Thu, 04 Jun 2009 08:18:16 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MC89P-00032T-6m
	for ltp-list@lists.sourceforge.net; Thu, 04 Jun 2009 08:18:16 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Thu, 4 Jun 2009 04:18:11 -0400
References: <4A277665.1080402@renesas.com>
In-Reply-To: <4A277665.1080402@renesas.com>
MIME-Version: 1.0
Message-Id: <200906040418.12742.vapier@gentoo.org>
Subject: Re: [LTP] [RFC][PATCH] Add cpu architecrute check
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============4015932491441438759=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============4015932491441438759==
Content-Type: multipart/signed; boundary="nextPart14328573.JmhaL4FEL9";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart14328573.JmhaL4FEL9
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 04 June 2009 03:23:17 Nobuhiro Iwamatsu wrote:
> --- a/Makefile
> +++ b/Makefile
> +ifndef ARCH
> +# copy from Makefile in linux kernel
> +ARCH :=3D $(shell uname -m

executing uname to detect build/target systems is never acceptable.

> --- a/testcases/kernel/syscalls/fallocate/Makefile
> +++ b/testcases/kernel/syscalls/fallocate/Makefile
> @@ -20,8 +20,14 @@
>  CFLAGS +=3D -I../../../../include -Wall
>  LDLIBS +=3D -L../../../../lib -lltp
>
> +# This system call is suported in i386, x86_64 and ppc only.
> +ifneq (,$(findstring $(ARCH), i386 x86_64 ppc))
>  SRCS    =3D $(wildcard *.c)
>  TARGETS =3D $(patsubst %.c,%,$(SRCS))
> +else
> +SRCS    =3D
> +TARGETS =3D
> +endif

atm, better to put the ifdef logic into the test itself.  look at some of t=
he=20
other tests that get stubbed out in the syscalls dir.
=2Dmike

--nextPart14328573.JmhaL4FEL9
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iQIcBAABAgAGBQJKJ4NEAAoJEEFjO5/oN/WBwNkP/AnWKtsIikM++mzY0vDpUief
LnvP7YbDKtVLKfG9AaQXS5TqLFZzr0oKQnBawYLEB7nN4kb2ROhCDFgO0JCMITgL
4r/HCKWPbrRakE2QiBt8kMCyPwTB0ZNWRg2fvgsI8AI+pqWt5d+aVARg5ef8LN76
etPCFgGjnUgwpG51Hk2GGF4o01L1ev0Qn0TbcxgXPx67JE3V7PYDoLWJnmSEPgB4
EzWCoKAl/Zj8p6SldY2SnfzUVXnwst8Wn6VgsUcdaFFVdOox+29TSmX0iI1thy5l
QrZJw4tPqEeL2zLOoOM+qwjRrUW7yjdVkHILsRzquP2EJjl4ZcSGowkPUHIBATX7
04WKwv8qGB52+8+Es7mgO1Z8OoTQeZ5DpIzbsi4q4UF4t5eUYyY9F2yPGNe8v0Jb
S+RAHTvXrpU7knbLir2AMA2Kpnet4zo8ClU7xCQi4ROu6r2Q/MIFBVDHnljP+dJG
9DA2l8c3potiBGy1DJROh97g6HMxqRhsO11dCWg1oVthpOSuYAqfIUvRJ76dr3IW
eHGQ3kGhwpVuiWhisfOSKcl4u2gAEtlN7XCbjLPSje9fHfledkW7hMBM2mNhfhvA
VXCpgyNabID3O3NQG9k9qdelzduF1lQETku2V5wUyOIZMEXxA+AVynjMKz9T/8lD
HgF3LiPBDUQNsHGmfO+z
=jL9Z
-----END PGP SIGNATURE-----

--nextPart14328573.JmhaL4FEL9--


--===============4015932491441438759==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
OpenSolaris 2009.06 is a cutting edge operating system for enterprises 
looking to deploy the next generation of Solaris that includes the latest 
innovations from Sun and the OpenSource community. Download a copy and 
enjoy capabilities such as Networking, Storage and Virtualization. 
Go to: http://p.sf.net/sfu/opensolaris-get
--===============4015932491441438759==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============4015932491441438759==--


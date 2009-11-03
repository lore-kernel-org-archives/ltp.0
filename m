Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1N5Ldd-00031F-SF
	for ltp-list@lists.sourceforge.net; Tue, 03 Nov 2009 15:49:41 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N5Ldc-0007bs-Uw
	for ltp-list@lists.sourceforge.net; Tue, 03 Nov 2009 15:49:41 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Tue, 3 Nov 2009 11:50:37 -0400
References: <1257220567.10382.3.camel@munipradeep-laptop>
	<1257238010.5162.12.camel@subratamodak.linux.ibm.com>
	<364299f40911030501y1c16a694r4ef8bfbfc80cb9cf@mail.gmail.com>
In-Reply-To: <364299f40911030501y1c16a694r4ef8bfbfc80cb9cf@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <200911031050.38755.vapier@gentoo.org>
Subject: Re: [LTP] [Ltp-results] Got warning message on ltp-full-20091031
	while running ./configure
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2537135466793541837=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: ltp-list <ltp-list@lists.sf.net>

--===============2537135466793541837==
Content-Type: multipart/signed; boundary="nextPart5102373.B2scD6J9Ar";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart5102373.B2scD6J9Ar
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Tuesday 03 November 2009 08:01:08 Garrett Cooper wrote:
> >> On Tue, 2009-11-03 at 09:26 +0530, Munipradeep Beerakam wrote:
> >> > I got the following warning messages while running "./configure" on
> >> > the ltp-full-20091031. However, make and make install worked fine.
> >> >
> >> > configure: WARNING: linux/genetlink.h: present but cannot be compiled
> >> > configure: WARNING: linux/genetlink.h:     check for missing
> >> > prerequisite headers?
> >> > configure: WARNING: linux/genetlink.h: see the Autoconf documentation
> >> > configure: WARNING: linux/genetlink.h:     section "Present But Cann=
ot
> >> > Be Compiled"
> >> > configure: WARNING: linux/genetlink.h: proceeding with the
> >> > preprocessor's result
> >> > configure: WARNING: linux/genetlink.h: in the future, the compiler
> >> > will take precedence
> >> > configure: WARNING:     ##
> >> > ------------------------------------------------ ##
> >> > configure: WARNING:     ## Report this to
> >> > ltp-results@lists.sourceforge.net ##
> >> > configure: WARNING:     ##
> >> > ------------------------------------------------ ##
>=20
>     Yeah -- I need to find the header that defines u32 (instead of
> uint32 or uint32_t). Does anyone know which one was that again? I
> thought it was a kernel specific datatype (and in that event it
> shouldn't be exported).

correct -- nothing in userspace should be using u32.  if the kernel headers=
=20
are, they're broken and need fixing, so complain to lkml/your distro.
=2Dmike

--nextPart5102373.B2scD6J9Ar
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.13 (GNU/Linux)

iQIcBAABAgAGBQJK8FFOAAoJEEFjO5/oN/WB4wgQAJBNfjWlr/+/EznSnmrP8VET
lDc/8xGE4+yuJEs/JkoF/yetPCcV8J2534cR79TQ1pIXvqfXUjlgxs5PllbTk7bs
VGMyrMBmDnyLBuJnEwsWGcffRcFHVhS7dmBpQVOQdecgNQsMxKuiA3ixzev6i6OL
lBiqaEwNMB1XqLqheJM949jpB5m0GKFv4Q8IxyNY53tdtmnGCxxwVTi8Cimk8lts
Y/M+C2Or3P0LtWl2JitxblQBWTbuRZmQ1YRcV4whl1UshHbykPUyoBijuEdpbdVk
0ZnokrfqFd0ld4TbabWhBXf1nLrQNT9/7+Ap9fO/qU/ZC7WF8MvhnFZonyVReqdT
sic7MJZfg4Yib3w3V/6x1FLcWQyWBJpU4b3B9FgPeZUH5vmYQli8qIc8IdBqq+vw
jXlx9WRFvzXwTxuNlsnH5UuVofIcP9MHlfCBgDUtf5/fgIey17Ie167swaLybNXb
YKO8Izqx0Us9TXN1yG2I17k8DVLzyuIGZ8BW0o4qupjIupXAG4SRKs4aBjc0V5jr
GHu58PZNJibt4s6xV2cyPJM7JCqQObxPsX7hEjOYP/7AvnDYxXWpln2uQSUUeU5s
0u1vCU3Gah7rZ586QOZU8x83bd4lt+FuEAa6bMBVQi0lILECD3jzymhFt3y52hbi
J+eFJkwUl5fptwtuCsJo
=O2xA
-----END PGP SIGNATURE-----

--nextPart5102373.B2scD6J9Ar--


--===============2537135466793541837==
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
--===============2537135466793541837==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============2537135466793541837==--


Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1MfSG9-0004hk-OI
	for ltp-list@lists.sourceforge.net; Mon, 24 Aug 2009 05:38:25 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MfSG4-0004Ne-T5
	for ltp-list@lists.sourceforge.net; Mon, 24 Aug 2009 05:38:25 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Mon, 24 Aug 2009 01:38:11 -0400
References: <20090824.120559.39168049.caiqian@cclom.cn>
In-Reply-To: <20090824.120559.39168049.caiqian@cclom.cn>
MIME-Version: 1.0
Message-Id: <200908240138.13098.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH 2/3] Fix unshare01
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============3960460565291014623=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============3960460565291014623==
Content-Type: multipart/signed; boundary="nextPart3925408.2k4J7u51KW";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart3925408.2k4J7u51KW
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Monday 24 August 2009 00:05:59 CAI Qian wrote:
> +#ifdef HAVE_UNSHARE
> +#include "linux_syscall_numbers.h"

this doesnt make sense.  if the C library has unshare(), then there is no=20
point in including the syscall numbers nor using syscall() because you can =
use=20
the C libraries' unshare().

> +				tst_resm(TFAIL, "fork() Failed, errno=3D%d : %s",
> +					TEST_ERRNO, strerror(TEST_ERRNO));

this (and just about every other line you changed) should be using the TTER=
RNO=20
flag rather than parsing TEST_ERRNO yourself.  so this line would simply be:
tst_resm(TFAIL|TTERRNO, "fork() failed");
=2Dmike

--nextPart3925408.2k4J7u51KW
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iQIcBAABAgAGBQJKkidFAAoJEEFjO5/oN/WBt1MQAN3NiEFhfqaXQN3WCQGQ6lUa
C4SwcH9Csxic9g7m2T2DF77r0fgpw71e8fEsy6ct1T6+Sk8qZPSJkteJx+9rJmI/
9yrMiEDMoI9jasDaAS0Ic4/0gEmIm5d30Egw2lF9KM1OX0fXBQJm5UWfbWi7PTgn
vgLbW3q9mw5oLBRlAr5d117qpG1LbneW8YecOWv3aBidfYLLo9Xo1XcdiYCFA/rt
Ouncszeb5T5oBjhv09dob0DZxJUEFIy9sAvPOuktwyuRwZ8qNb+pP00/hOuLouFF
suFVIx+BgiaY4TCg/gMvl0ezIlI7c64VA2PHGMoyThLfI/HXCSReK46I3MoseZHq
pS095XzT0UPMxQDLBjMPGrIEttkEt2QDc8OoBzRPq9lZI+mxNMVCiHsn6/foYa/8
jYV+aysdQQXFBrgN9lC5on+fEsr84r112k7NSk1Kstq9NV7kmZQFyJmLh9sSZ66z
vUbpa0obOLFv7qMBSdU+i/Cfklkq+ISU9uzMPms2i+19iIuC+Jd/nnWpXwY9pXjH
9MueuWoFTxzJWlRZ1tgJNO/UGFzxBUXhY2ZDulxpeiuZ7ufXUiZDU2n1WX+RrNG0
59OwIYEKfJgxRQQeaqNxdePvNOUTYQqv0QRGTf9pYZJjePPqi6f274Yo7WL2KJoL
Vga0M3q3qAPN6wmloj/h
=x2xT
-----END PGP SIGNATURE-----

--nextPart3925408.2k4J7u51KW--


--===============3960460565291014623==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--===============3960460565291014623==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============3960460565291014623==--


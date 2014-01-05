Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1VzwA5-00029K-MT
	for ltp-list@lists.sourceforge.net; Sun, 05 Jan 2014 22:27:13 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VzwA4-0004GG-OC
	for ltp-list@lists.sourceforge.net; Sun, 05 Jan 2014 22:27:13 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Sun, 5 Jan 2014 17:27:09 -0500
References: <1385374379-25949-1-git-send-email-markos.chandras@imgtec.com>
In-Reply-To: <1385374379-25949-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Message-Id: <201401051727.10564.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH v2] ptrace: Fix build problems with glibc-2.18
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5306661840247788607=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============5306661840247788607==
Content-Type: multipart/signed; boundary="nextPart2471628.bQ76xy76Ll";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2471628.bQ76xy76Ll
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Monday 25 November 2013 05:12:59 Markos Chandras wrote:
> Since glibc-2.18, the struct ptrace_peeksiginfo_args is
> also defined in sys/ptrace.h and conflicts with the definition
> from the Linux kernel in linux/ptrace.h. We fix this by not
> including the linux/ptrace.h header if the sys/ptrace.h header
> defines the said struct. Fixes
> https://github.com/linux-test-project/ltp/issues/6

i'm somewhat inclined to undo this as it's really a bug in glibc-2.18 that=
=20
should be fixed in glibc-2.19:
	https://sourceware.org/ml/libc-alpha/2014-01/msg00078.html
=2Dmike

--nextPart2471628.bQ76xy76Ll
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJSydw+AAoJEEFjO5/oN/WBz4kP/j4XHdM5h+YXQ4LKjn2RdKbm
h+an3Sv9MFbemmaWlGtweoaTYrddrqHmdVOejebvTML9THqRf+PZRS8a7155Rz+A
FLGfrfqacU4EMgvZPCdc2kSmAhYTUdJJEisqkzhiiSB1leITpXAAzp+njjg9t9qG
Hc8ZpiAusCS5FXrhO32bGh5A0CTpychkkD1CouRo5YGvAfz1ie2xy8Pab1nKCXyK
juBf/m2OgZEUHxNgWRg/8TOJyRKlykEnsmZc4yJEhjBZxJciH/ymJfL4U8nC4rv3
1uhhHBTwmp4ICH7dGKarJQoPsmH/YWxMPjR5G5OriDBLjueghN5e1Et+0+QiVMZ2
/jANvjiU6m0Eh947fJdYG66l9n8aRuULdi9HjZFe0meGfnII/TiJoM2ebxpnZmMH
9Pp2Rq5D++DsYmWakuPzq/9cbe9aOyxnjuUip1K1vrJXhWgHlA7D8TQ9+2mPiPT2
PXN0kc1vvqtQzMrEXTWR3f31len7dVf6PP9dpgiH/U0shxNvuTCA6A1gFicu9JTI
O63v4t3lo3vA9eR5sRRh7f6vZ8QQN0+ty1FMwImRHYJJRMtwGpLYeSqhvBGjBVRU
git4iUuLrhIuD6p0+aIqJsc7dMHw8dt5Wo3N0Mksj2tuMd5/Gz+qeY6IzIwVSi0v
7qkG/BOpy0xLAfd7Oq4I
=Rkae
-----END PGP SIGNATURE-----

--nextPart2471628.bQ76xy76Ll--


--===============5306661840247788607==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349831&iu=/4140/ostg.clktrk
--===============5306661840247788607==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============5306661840247788607==--


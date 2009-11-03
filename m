Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1N5MGb-0005oe-Oh
	for ltp-list@lists.sourceforge.net; Tue, 03 Nov 2009 16:29:57 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N5MGW-0006GX-Pv
	for ltp-list@lists.sourceforge.net; Tue, 03 Nov 2009 16:29:57 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Tue, 3 Nov 2009 12:30:52 -0400
References: <1257168835.4977.46.camel@subratamodak.linux.ibm.com>
	<200911021702.09153.vapier@gentoo.org>
In-Reply-To: <200911021702.09153.vapier@gentoo.org>
MIME-Version: 1.0
Message-Id: <200911031130.53505.vapier@gentoo.org>
Subject: Re: [LTP] Build Fails on some archs
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============8485501315156740249=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net, Garrett Cooper <yanegomi@gmail.com>

--===============8485501315156740249==
Content-Type: multipart/signed; boundary="nextPart1406824.aiuHl3jstC";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1406824.aiuHl3jstC
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Monday 02 November 2009 17:02:08 Mike Frysinger wrote:
> On Monday 02 November 2009 08:33:55 Subrata Modak wrote:
> > gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
> > -I/root/subrata/ltp/ltp-full-20091031/testcases/kernel/include
> > -I../../../../include -I../../../../include   -L../../../../lib
> > ptrace04.c   -lltp -o ptrace04
> > ptrace03.c: In function 'main':
> > ptrace03.c:182: warning: format '%d' expects type 'int', but argument 3
> > has type 'long int'
> > ptrace04.c: In function 'compare_registers':
> > ptrace04.c:50: error: storage size of 'pt_regs' isn't known
> > ptrace04.c:50: warning: unused variable 'pt_regs'
> > make[4]: *** [ptrace04] Error 1
>=20
> the ptrace stuff has always been fairly unfriendly to cross-arch work.=20
>  we'll probably have to add header tests for a bunch of files and unify it
>  in a local ptrace.h header.
>
> > gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
> > -I../../../../include -I../../../../include   -L../../../../lib
> > tomoyo_file_test.c   -o tomoyo_file_test
> > /tmp/ccvzdsNd.o: In function `main':
> > /root/subrata/ltp/ltp-full-20091031/testcases/kernel/security/tomoyo/ne=
wn
> >s. c:43: undefined reference to `clone' collect2: ld returned 1 exit
> > status
>=20
> these test cases need to be changed to the new common ltp clone code.  as
>  part of that, we should probably add a macro that changes clone() to a
>  compile error so that people stop using it by accident
> #define clone(...) DO_NOT_USE_CLONE

i'll take care of both of these issues if you want to look at the others
=2Dmike

--nextPart1406824.aiuHl3jstC
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.13 (GNU/Linux)

iQIcBAABAgAGBQJK8Fq9AAoJEEFjO5/oN/WBXBwQAI53E2lo/mHYyKGv3Y7GsXzz
9R13PZM6Mjupa5EFfwyGGEQrqcGIgpjno0Fp7jiviaW5zxlhSKU3mmcIM3wBOAR3
sPjwTLmvYNixA8sbWzqK93xvwLF6gDm9RXOX/69I6107oiJToYpKyADknafa5oGs
/cJjvOJj6vKcvtQvp/v8f+2SKE50CriSp+yCQufhFThMXldS66QpvccnVvZXwban
bNSRnoX27rUJDIwRuOemhCswpOXah2xpYG3uVCd3oyHXbeenXnmMCg7yLbMRckse
ew+6wy7tNrbE88ATtERZFBGZ6jWXffN3y3vgK46vHF9CwuPg33lBQP+aHRfYXkZZ
GhmNAqHmySE2x2jdn0tjJQSJEyxLNx+PR94s5fPBid0/8EPTz3cjujJvbqGOzay0
Ui6fIKYnDnLW3u9xqQaTHChcmH8OF4LWX0LkFME4rmCpMxpyoHh5LZB9KB/mK1xV
yUMGCJ5eqWsAwf6K5rl/ve909dPTa7jP0F4HoYqdZvkko2Z1s5P16UbekLgC6s6l
mVJl9qJ86j50Qu6e5SmJjxnlOBkggcgqLi8PJvdZ1AwV7Eq9uNZFVOr/SC1EJN1U
0SsM5XHJnBJrEOxKUAGp2UyQ20TTH7gRNwcwxB7loLgR7ZjPCvVnCnkY3XWXig6a
MVeF90fuQD3rGT2Jl6Nk
=awqQ
-----END PGP SIGNATURE-----

--nextPart1406824.aiuHl3jstC--


--===============8485501315156740249==
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
--===============8485501315156740249==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============8485501315156740249==--


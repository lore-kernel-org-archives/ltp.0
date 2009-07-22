Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1MTUHu-0000J5-5Q
	for ltp-list@lists.sourceforge.net; Wed, 22 Jul 2009 05:22:46 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MTUHl-0005RP-2M
	for ltp-list@lists.sourceforge.net; Wed, 22 Jul 2009 05:22:46 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Wed, 22 Jul 2009 01:22:32 -0400
References: <20090721.182542.1000278277145531816.caiqian@cclom.cn>
	<364299f40907212138rb1f671eke3aabd6587c0f925@mail.gmail.com>
	<364299f40907212201u64779636v91ff74c45c32c3f3@mail.gmail.com>
In-Reply-To: <364299f40907212201u64779636v91ff74c45c32c3f3@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <200907220122.33944.vapier@gentoo.org>
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
Content-Type: multipart/mixed; boundary="===============5353438496272292239=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net, ltp-list@lists.sf.net

--===============5353438496272292239==
Content-Type: multipart/signed; boundary="nextPart3207311.NifbtXgIH3";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart3207311.NifbtXgIH3
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 22 July 2009 01:01:34 Garrett Cooper wrote:
> On Tue, Jul 21, 2009 at 9:38 PM, Garrett Cooper wrote:
> > On Tue, Jul 21, 2009 at 2:28 PM, Mike Frysinger wrote:
> >> On Tuesday 21 July 2009 10:21:44 Garrett Cooper wrote:
> >>> I was tempted to fix the format string error, but I don't know what
> >>> the potential implications are of switching the data type from
> >>> u_int64_t to unsigned long long...
> >>
> >> dont do that.  just use the proper format string from inttypes.h.
> >> uint64_t f;
> >> printf("f =3D %"PRIu64"\n", f);
> >
>
> -       fprintf(stdout, "[%u] wait completed on %d: count=3D%llu\n",
> +       fprintf(stdout, "[%u] wait completed on %d: count=3D%lu64\n",
>                 getpid(), fd, cntr);

umm, you sure that's right ?  seems to me it'll output the number followed =
by=20
the string "64".  i think you need to look at my example again (and take=20
notice of the quote marks).
=2Dmike

--nextPart3207311.NifbtXgIH3
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iQIcBAABAgAGBQJKZqIZAAoJEEFjO5/oN/WBhP4QAL8bmjre8aj6Z77dncP/L7dy
oVevgxvjM1jStZhpUksChbfQW2ANd1L3K/NYQ25RSqO+ulaa3OYiWGttalns12N2
gtPo77kluy99UBjKmyUqHO/SWU4ie94hffS/kuYC+Q0sHyy+fWue1WU6Rbl1sM+U
38Har5jSRK7zTZyFK5hCOhqS4rZ04d4jONp+QH1wh6RQuJrHecttiQcZ9uxo6PIr
IgXMqxvtG4TG7zyyNmZUGUv0KQzWLXHNcdVWZ9W2z+yAXeEkeTJLxB5i/HngPUlK
gHI6ip6lysGmGZp1rcSlQGXuZ4NLL1+pJutc9KCRbGhRLilgtTMsVNIa2zXFKWM+
9ws+9IVV3dkgQOuPd5cynAmlCoessquXf6cJjtb33FNKIWtnKPzigm0brpQhV0b8
kAupCVFCu6mUbiW42JPwo2q3OYPECiLPJV29UoqqwdnYfBwJ5/kqJIBxa0KCgV2K
JCZev1JPibvpU57RIaF0jZcUbJoaTy39D/Eaz7i8HXDEcy15hnfH6Z27XQ7OhLb2
mMruU9CetM5vEldJ6ZkIDak+PtipOTr6EyY+tHZVGY1LrTII7N+UQv0ODHSZ7K6r
8/79pWDy/XUU0x5dejAN8vs5/mpk9yu675RybdJ/7dTLSmqaUmPrLc9yfJEuP7hd
YyBABZ+f0ms0GFwxPb7N
=CkWZ
-----END PGP SIGNATURE-----

--nextPart3207311.NifbtXgIH3--


--===============5353438496272292239==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--===============5353438496272292239==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============5353438496272292239==--


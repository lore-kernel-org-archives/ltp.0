Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1N8xrN-0002Qa-P3
	for ltp-list@lists.sourceforge.net; Fri, 13 Nov 2009 15:14:49 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N8xrH-0006a0-De
	for ltp-list@lists.sourceforge.net; Fri, 13 Nov 2009 15:14:49 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Fri, 13 Nov 2009 10:17:01 -0500
References: <1258098740-22455-1-git-send-email-avagin@gmail.com>
In-Reply-To: <1258098740-22455-1-git-send-email-avagin@gmail.com>
MIME-Version: 1.0
Message-Id: <200911131017.02467.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH] clock_settime03: improve message about fail
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============3192538720077808036=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============3192538720077808036==
Content-Type: multipart/signed; boundary="nextPart1346489.BI1Tm8zuoX";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1346489.BI1Tm8zuoX
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Friday 13 November 2009 02:52:20 Andrew Vagin wrote:
> ---
>  .../kernel/timers/clock_settime/clock_settime03.c  |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
>=20
> --- a/testcases/kernel/timers/clock_settime/clock_settime03.c
> +++ b/testcases/kernel/timers/clock_settime/clock_settime03.c
> @@ -195,10 +195,11 @@ main(int ac, char **av)
>  			} else {
>  				tst_resm(TFAIL, "clock_settime(2) failed to"
>  						" produce expected error; %d"
> -						" , errno : %s and got %ld",
> +						" , errno : %s and "
> +						"got %ld errno %d",
>  						testcase[i].exp_errno,
>  						testcase[i].exp_errval,
> -						TEST_RETURN);
> +						TEST_RETURN, TEST_ERRNO);

please convert it to TFAIL|TTERRNO instead
=2Dmike

--nextPart1346489.BI1Tm8zuoX
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.13 (GNU/Linux)

iQIcBAABAgAGBQJK/XhuAAoJEEFjO5/oN/WBvTAQAKDC4t2OasRQ8MKGsglYm/VC
phPcsfqq1JQJR2QTyMS00GrXvY0rvrjGG9YP5u47UdxEJRs8Gn+De1mwLpF9tEVs
k/Lwj3i6LFya7oh4Tod5hR0XkytgQrO80CdCDFbBElpKy3mpfs2+hFH4x5XHo0B+
jT1V1DRkLVmOsXFgMC3GiN746uT3aL/YcShaTy5D1SeTvIYSY94HzvPpgLUE9+Ph
dHPrZL8zttFLYQFX2q+Doud3xRFMJ2bwHNx5YhllWtsxsITkX8Xugfos2GHlvc4I
weHjoWYsH2k6FqMmoc7sd5wleWjz/wdEbqmAQXuuzynjFDPhnz9Wr0JnqxtrjM3y
PYDq/9gMpkfMsEolr5Ln5zXCTsG/zvS1yOhp+7tJN2fS1F1+GGpm28b/WSdmDZ9A
Fr94nnUTniattp9rj1wvxk0qEL+MND6o49dNcUiNJk3EfadqnIh8qt3mOykwzBxa
sECq43iXNJ/yPhtJyGJUmU2kAZichbFZlFPzuQGemgLmV9PmjSLpU47EBdGAYXm0
u9gw59NJIIHxzOhRKIfnYL5iGbuH+546scKD4I4YI7XgdItVxGyAe1Hx4FtE21LC
WVh7Pwk4+zQe4nfyYxuh7iuOGI6zo/+0th056L7HWF4VcpCAytTp97Mq2OGrEVxE
vvfwcx801GlORqyJHK84
=Xhhq
-----END PGP SIGNATURE-----

--nextPart1346489.BI1Tm8zuoX--


--===============3192538720077808036==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--===============3192538720077808036==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============3192538720077808036==--


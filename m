Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1W09cd-0006DV-7b
	for ltp-list@lists.sourceforge.net; Mon, 06 Jan 2014 12:49:35 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1W09cc-0000cS-4m
	for ltp-list@lists.sourceforge.net; Mon, 06 Jan 2014 12:49:35 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Mon, 6 Jan 2014 07:49:28 -0500
References: <1385374379-25949-1-git-send-email-markos.chandras@imgtec.com>
	<201401051727.10564.vapier@gentoo.org>
	<52CA9767.4040101@imgtec.com>
In-Reply-To: <52CA9767.4040101@imgtec.com>
MIME-Version: 1.0
Message-Id: <201401060749.29230.vapier@gentoo.org>
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
Content-Type: multipart/mixed; boundary="===============9118143452612215678=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: Markos Chandras <Markos.Chandras@imgtec.com>

--===============9118143452612215678==
Content-Type: multipart/signed; boundary="nextPart1501621.nDjXIO67zW";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1501621.nDjXIO67zW
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Monday 06 January 2014 06:45:43 Markos Chandras wrote:
> On 01/05/2014 10:27 PM, Mike Frysinger wrote:
> > On Monday 25 November 2013 05:12:59 Markos Chandras wrote:
> >> Since glibc-2.18, the struct ptrace_peeksiginfo_args is
> >> also defined in sys/ptrace.h and conflicts with the definition
> >> from the Linux kernel in linux/ptrace.h. We fix this by not
> >> including the linux/ptrace.h header if the sys/ptrace.h header
> >> defines the said struct. Fixes
> >> https://github.com/linux-test-project/ltp/issues/6
> >=20
> > i'm somewhat inclined to undo this as it's really a bug in glibc-2.18
> > that should be fixed in glibc-2.19:
> > 	https://sourceware.org/ml/libc-alpha/2014-01/msg00078.html
>=20
> Ehm that would break the build for people already using 2.18. Even if a
> new 2.18 is released with the fix, people using the old one will still
> face the same problem.

i'm aware that would be the situation.  i'm fine with that.
=2Dmike

--nextPart1501621.nDjXIO67zW
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJSyqZZAAoJEEFjO5/oN/WBCmgP/2TBB2070WYC0rnP0vs7JssV
atUJXgNKkl0yPo+t1Kr+4446Py04DXYV3ctcN75py6k1/SF3nbSkYfvZ9f/jFn8O
kkLowyTxMltQhUCE4HV7WTGI3oYMkzRssNdwMFg4Mpnw3VeKdx0Csfrh/n/aQTq/
RhfwQujF9mzP52VMPTpbAsFyUD/ZYJFtbQcsNcHABsYCy4WFLX3c4ugqHphyOp3l
dLwBkKQuuxbzeVLlCZoDGsj786vdB+p7aBm0bjuy6aklEEMqzV8IXKdabByHwD5e
zgA0p76rWMXkYoH6CGRA7BczueQxxLC5dyVkrM7LmBjfIJOVWI4OG3gIYitOGQy4
fvvIOLOMuUvv56znYOu1Ve+0UYQUDEZ47n5wwxIl3yGjYb32PfnJYe0EN9YZ/QzD
6HtfXRjS9KPodm55wV79hF0UdfaKFQWaSB+Axt0xD5THp/sSjAzNrQ1D/956LYO6
zxr1utY0tFf5Pyi3KAmy2zmMv2tDV2lYuQZKjU8R3nzcUge+YmGsf6dPfdN+xsgi
2wBBwmOacb8Q/OPcp65hlNLZvyTcyASGAC4rVyx1fcNWfmdLk8r3HCdItB2umYNQ
X0IG2WeIRbWA9HPvfc5d0FrbMZ+o0kmi9kJ8jU6diva+QvK4DGK9yR8T54EHB1PM
0EywwSp+I8MgaW+AIyHH
=gArU
-----END PGP SIGNATURE-----

--nextPart1501621.nDjXIO67zW--


--===============9118143452612215678==
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
--===============9118143452612215678==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============9118143452612215678==--


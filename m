Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1MsnPC-0003KM-7K
	for ltp-list@lists.sourceforge.net; Wed, 30 Sep 2009 00:50:54 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MsnP5-0001V8-Or
	for ltp-list@lists.sourceforge.net; Wed, 30 Sep 2009 00:50:54 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Tue, 29 Sep 2009 20:29:17 -0400
References: <20090929233015.GA22127@us.ibm.com>
In-Reply-To: <20090929233015.GA22127@us.ibm.com>
MIME-Version: 1.0
Message-Id: <200909292029.18319.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH 1/1] define and use common clone helpers (v2)
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============8374180836117763928=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>, Subrata Modak1 <subrata.modak@in.ibm.com>

--===============8374180836117763928==
Content-Type: multipart/signed; boundary="nextPart1746826.eKI3s9XT86";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1746826.eKI3s9XT86
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

On Tuesday 29 September 2009 19:30:15 Serge E. Hallyn wrote:
> Define ltp_clone() and ltp_clone_malloc() in libltp, and convert existing
> clone usages to them.  (clone04 can't use it bc it wants to pass NULL,
> which ltp_clone() will for many arches convert to NULL+stacksize-1).

i thought you fixed the clone04 issue ?

> +int ltp_clone(unsigned long clone_flags, int (*fn)(void *arg), void *arg,
> +		int stack_size, void *stack);

change stack_size to size_t to match malloc()

> +/* int  __clone2(int (*fn) (void *arg), void *child_stack_base,		*/
> +/* 		size_t child_stack_size, int flags, void *arg,		*/
> +/*		pid_t *parent_tid, void *tls, pid_t *child_tid)		*/
> +extern int  __clone2(int (*fn) (void *arg), void *child_stack_base,
> +		size_t child_stack_size, int flags, void *arg,
> +		pid_t *parent_tid, void *tls, pid_t *child_tid);

what's with the big commented prototype ?  just scrub it ...

> + *   1. hppa takes bottom of stack and no stacksize

note that it's because their stack grows up

> + *   3. all others take top of stack,

note that it's because their stack grows down

otherwise, all the changes look straight forward.  thanks again.
-mike

--nextPart1746826.eKI3s9XT86
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iQIcBAABAgAGBQJKwqZeAAoJEEFjO5/oN/WB1JoP/2jd71wEnhQKmmav+fBkLR8p
krObfwcPx49jNvobG+IB81Upt9eB74n58OBWg9Kki9NaXxlPKtmsw6TCvk/F3llV
p8Zd8CR9vFRTIy2Dv7/qag7QxyBq8fKV04E3OT2bN4c2YzkYMwXh+/qoUjqSTmM1
SLFkvoYbd9BUkiQ99E6hZsND4+O+vugY/HA5dLgR+++qrsnMFk+dXGn+YNADos2m
LU2kOzyjZkzb1XuyVIHqIqSt+NHPBe4LGaK7JnLJpgFkP6ExTeu09mVsS5U4Iwxy
St4ILZwGtGM0jh/lMS4YouL/C8R7k0LW+SPDMAuZES+L7Vzi6+pmZBo/tLUOjL3f
OP/94TroRIDybCtJQto7Y6lxsbvwmBfvHPvF6JBziUJU+n1qzjkxRGZxp53jbQZf
sMq1UNWrLOiCWgtjlkQV7KiAxxIx0kIpJVwKk8J89+Q3se9VEyFlBoQgipY9nZDC
zhLpPqTLYqUKdT+Jh/gN5p0DdccNHEqKEEGuBGaqb2zaw/PEtdzEkMOfwRMdEASw
gXfLXaqq0jjrHI9LxoacggEyeB7J13l6XGzKAvTdTj9aZgjLwpvPEBlpkA6OTjJ4
twc1a6fCHxj8SYAnH9MEjZkny4bTBed0PEaTKCFTcjbBHDwbianUboCjx0haQt7M
MOE6yCygQulApCtTYOGp
=OdKq
-----END PGP SIGNATURE-----

--nextPart1746826.eKI3s9XT86--


--===============8374180836117763928==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#33;
http://p.sf.net/sfu/devconf
--===============8374180836117763928==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============8374180836117763928==--


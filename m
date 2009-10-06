Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1Mv7WI-00062O-8P
	for ltp-list@lists.sourceforge.net; Tue, 06 Oct 2009 10:43:50 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Mv7WA-00017V-Fd
	for ltp-list@lists.sourceforge.net; Tue, 06 Oct 2009 10:43:50 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Tue, 6 Oct 2009 06:43:34 -0400
References: <364299f40910060307g33fcf21chcfcdb4cefe4e9bc@mail.gmail.com>
In-Reply-To: <364299f40910060307g33fcf21chcfcdb4cefe4e9bc@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <200910060643.35041.vapier@gentoo.org>
Subject: Re: [LTP] Issue 3 - ptrace06 hung for 7 hours
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============7265291364072700010=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============7265291364072700010==
Content-Type: multipart/signed; boundary="nextPart12570071.odSDxUhBni";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart12570071.odSDxUhBni
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Tuesday 06 October 2009 06:07:40 Garrett Cooper wrote:
>     Ran into another issue. When I was running ptrace06 in the
> syscalls test I noticed that it had been hung for over 7 hours -- is
> this a known issue?
>     strace'ing the child proc didn't help (got ENOPERM), and
> strace'ing the parent proc returned nada. I'm going to attach gdb and
> figure out what the issue is, but I was wondering whether or not
> anyone else knew.

you wont be able to strace the child because it's already attached with ptr=
ace=20
from the parent.  most likely the parent is sleeping and awaiting a signal=
=20
from the child as there was some race that caused a mismatch.

the test probably could do with a alarm() to prevent such hangs -- in the=20
normal case, it should execute in a few seconds if that.
=2Dmike

--nextPart12570071.odSDxUhBni
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iQIcBAABAgAGBQJKyx9XAAoJEEFjO5/oN/WBKXIQAIuFAWq0thx4NZU1NBPJjqjP
i1VQdhO/eY50uc6smA1f5nxnczpOfEh7uoOGAXJB/nXjYMZuTPqjorXNFEwqR2L1
vPfSRL04zDeE1Q20r0W6/uIJry80w+nQpzV31H3GhjhD+gHGcuDJmkUquAHgoaaz
mU8UHReL/5bpVK3I1KTPBiPdrkOxnl1Y3oBDqnrC70IVewAHNCd8AgmV8JK0gZ2v
Yn76emxf+G9hJcC0iMfTvVcM1od4txVcHRnTdVpXosS6Lt3zkSjonHluABJD7/ec
H1c/OnUk9oO6FIh6+G4gxBBbvyClz0cBLertyrTJm/wsZq82gHNBOtIHXD8WEM4G
dUcuYgSwYqJn28Pg0IvJzSUqYWaDxFfEUGSA48InTHyl9g//4h2eDdoMgI6ZEPm9
VT4mdgTi6z11+ZFfBv1nQ4zXLEafDfVRjEuRl+m2f0bnROk3Rtfqzb/ogs6h7YY5
gSARzXl+YAYT8qMVduKjre2ICA8GiE57mmPFydFO98dCi/k2M+HlzfPrmQgEQoQn
ta0DU6IFUGXxwveItYMtpbJcL4Bb6J+vbI6A3DkH+3y098iYqYwCtQDodk23PbKS
iORfXMuLfLPbXjJlD1Xoop5L/xQDAfz2Uwxdv8jt+JudF5Kgi1wOXgtUadpbs99S
mlo7cpWX1PEa/9Bk5QxF
=lDz+
-----END PGP SIGNATURE-----

--nextPart12570071.odSDxUhBni--


--===============7265291364072700010==
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
--===============7265291364072700010==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============7265291364072700010==--


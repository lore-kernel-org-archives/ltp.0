Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1NAuBf-0007FL-AC
	for ltp-list@lists.sourceforge.net; Wed, 18 Nov 2009 23:43:47 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NAuBZ-0004WO-1U
	for ltp-list@lists.sourceforge.net; Wed, 18 Nov 2009 23:43:47 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Wed, 18 Nov 2009 18:46:41 -0500
References: <1258098740-22455-1-git-send-email-avagin@gmail.com>
	<200911131017.02467.vapier@gentoo.org> <4B03F177.1090103@gmail.com>
In-Reply-To: <4B03F177.1090103@gmail.com>
MIME-Version: 1.0
Message-Id: <200911181846.42873.vapier@gentoo.org>
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
Content-Type: multipart/mixed; boundary="===============1918714590346624649=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: avagin@gmail.com
Cc: ltp-list@lists.sourceforge.net

--===============1918714590346624649==
Content-Type: multipart/signed; boundary="nextPart2067550.16xkU5ibXO";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2067550.16xkU5ibXO
Content-Type: Text/Plain;
  charset="koi8-r"
Content-Transfer-Encoding: quoted-printable

On Wednesday 18 November 2009 08:07:03 Andrew Vagin wrote:
> On 11/13/2009 06:17 PM, Mike Frysinger wrote:
> > On Friday 13 November 2009 02:52:20 Andrew Vagin wrote:
> >> ---
> >>   .../kernel/timers/clock_settime/clock_settime03.c  |    5 +++--
> >>   1 files changed, 3 insertions(+), 2 deletions(-)
> >>
> >> --- a/testcases/kernel/timers/clock_settime/clock_settime03.c
> >> +++ b/testcases/kernel/timers/clock_settime/clock_settime03.c
> >> @@ -195,10 +195,11 @@ main(int ac, char **av)
> >>   			} else {
> >>   				tst_resm(TFAIL, "clock_settime(2) failed to"
> >>   						" produce expected error; %d"
> >> -						" , errno : %s and got %ld",
> >> +						" , errno : %s and "
> >> +						"got %ld errno %d",
> >>   						testcase[i].exp_errno,
> >>   						testcase[i].exp_errval,
> >> -						TEST_RETURN);
> >> +						TEST_RETURN, TEST_ERRNO);
> >
> > please convert it to TFAIL|TTERRNO instead
>=20
> I don't understand. pls describe in detail

dont show/parse TEST_ERRNO yourself.  simply use what i showed as the first=
=20
argument to the tst_resm func.
=2Dmike

--nextPart2067550.16xkU5ibXO
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.13 (GNU/Linux)

iQIcBAABAgAGBQJLBIdiAAoJEEFjO5/oN/WBpc0P/3wHVcM0vtvCBv6yuCMnunl8
XEeQ97pv5okjbIfPXUDOR85IJ6wYdBuh01RcB2XkaSrHOeCIRhFr/nJ314M8ATmU
9mD/R0+iK1FuMpi2r/WgDxM85YDMAPux8zkG+CwboDMBZLUjrC4GB0k8+SNERe0c
MbfXZlLZslJCrHquuJAl9RQogkPslj2zvWdACKXPnUvYAUwBtKlsWqY9S8NjPGDY
Cu5jJkLFmNqzfSDTiEKMdyVYvsAEAvuxBVVajEZ8cu18YydU06jLmZetDBzqkSmc
oN3B0dUdNaHPbqcIlQATZMldIy97Rx7BRGcUJ9goaPEzKP4oA4JGKSsiaLch/4Up
/gHdeIM6ruUvDih+Q1uEHW8vD9TM4DF7U0R+VB3B8j8+nQANdU0CGR4pMa2mxr+j
fYzs7kgJCsDyeEtbiQihlAzQORUwToZ7XBL69CaWRDKGhSihwJs0P7UxrigUd3TG
LZJktqbItanMRf9hKiyFyr3D9b2EmEjbKoO0dgLHQ+ywIMNOg5aSxAglu7+jvu0Y
Qryn+ETRPFi2vI6iUtGAvWrESOp5mFNetbcuE9A/FOb9Zk2i0918pkikMuMU677+
0APhu94LuqzUYFoe6LuuNsDSNAvjM9u5z2S+59Ye3a7WvKq131FOPtDRvfl2DlI3
gGSUSX7nPz9cGVQZv0is
=coOC
-----END PGP SIGNATURE-----

--nextPart2067550.16xkU5ibXO--


--===============1918714590346624649==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--===============1918714590346624649==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============1918714590346624649==--


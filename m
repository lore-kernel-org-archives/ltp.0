Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1MR7Eh-00063u-HB
	for ltp-list@lists.sourceforge.net; Wed, 15 Jul 2009 16:21:39 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MR7Ef-0001wq-62
	for ltp-list@lists.sourceforge.net; Wed, 15 Jul 2009 16:21:39 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Wed, 15 Jul 2009 12:21:32 -0400
References: <364299f40907061818q7cda3465vffb00323af18c5f8@mail.gmail.com>
	<20090707021215.GC32310@count0.beaverton.ibm.com>
	<364299f40907062033j1660f689t65b8b8bdfb402f11@mail.gmail.com>
In-Reply-To: <364299f40907062033j1660f689t65b8b8bdfb402f11@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <200907151221.33580.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH 4/4] Make makefiles more autoconf friendly
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0918656169019087690=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============0918656169019087690==
Content-Type: multipart/signed; boundary="nextPart4368882.0vHigaBnX6";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart4368882.0vHigaBnX6
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 06 July 2009 23:33:14 Garrett Cooper wrote:
> On Mon, Jul 6, 2009 at 7:12 PM, Matt Helsley<matthltc@us.ibm.com> wrote:
> >> +prefix               ?=3D @prefix@
> >
> > I think you should set PREFIX too. Most Makefiles that honored prefix at
> > all expected that variable name. Perhaps it would be best to start with
> > that and then, if it's best, gradually change all the Makefiles?
>
> Sure -- will add that then too :).

we should migrate away from this variable.  a comment above it should be fi=
ne:
# this variable is deprecated, please stop using
PREFIX ?=3D `echo $(CURDIR)/Makefile should use prefix, not PREFIX 2>/dev/n=
ull;=20
echo $(prefix)`

> >> +
> >> +#
> >> +# Default to /opt/ltp if the directory specified was a zero-length
> >> string, to +# avoid spurious Make system errors.
> >> +#
> >> +# XXX (garrcoop): I'm almost positive there's a better way to do this
> >> in +# autoconf. Haven't figured it out yet...
> >> +#
> >> +ifeq ($(strip $(prefix)),)
> >> +prefix               =3D /opt/ltp
> >> +endif
> >
> > I thought the point was not having to run autoconf to get the default
> > build and install via Makefiles.
>
> Yeah, I thought about it and wondered to myself -- how many folks are
> there out there that actually handcraft config.h and config.mk files.
> Probably not that many folks to be honest...

there is a default config.{h,mk} that get used if autoconf isnt run.  this =
is=20
what i use.
=2Dmike

--nextPart4368882.0vHigaBnX6
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iQIcBAABAgAGBQJKXgINAAoJEEFjO5/oN/WBoYUQALfrOoJ5BFa66rf9Nl/V2Rmu
yuV/M5jfODXcbAjkZFdjT/rZH/gLe8kvk8v6mBk5vYoGVN2sThQZyNBTBJhUI0KP
6HR6VoI00K3c+wTYg09rPl+eizwoXE6NNm1Pu+SpSfKT+Fi6eWngQGBxIH7Psi2K
G/lLQIfNMwA+PgTHt916F08u2pNrQ44gFHFvEVDqlqqS5Q2QxJuDReOZhe6KjcMh
jO9CHFJjrg/Oqa1CFO4UnhOm9KhwcV1pnfA8ecuG1cSy7gmida5/zPg4v8/S5uKV
eAE6cYRnOofFvUj0lmJcGA9PqSDvXst+mxMAohD+K0YWqrpBo09EK31Rd+/a66Ar
/KTck2bUlTk0MLH47l2W1VJ6o3IePlKG/8Ta23fPlBiDmvTZuWIlCPMYtE48+qtS
KJ8xj8b+e6CJkZhzK7McYoyAdvoTDLE5W6657tO06YFgajkVA9czC3YyX4fMc6EM
CjYbB/NwoLTN5dyKg/NioldfCEM9srq5FSIAlsHzdK2Pi8fUNiKXPkWJv1em6o6d
Bp9/DLoXiPnG4FKRssDitZAvVRY9YrngtQbvatMIqowjgvP/3aJP8wPDl88n+iBZ
VKT+nN3jtYVJZ5PPzQzK2OiHT7loOGzpCB5Qjeajce7/EEh5HdyDJH3Y65bFMZlw
j0pQX6Cx8bBqRYky9jm7
=h2fx
-----END PGP SIGNATURE-----

--nextPart4368882.0vHigaBnX6--


--===============0918656169019087690==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have
the opportunity to enter the BlackBerry Developer Challenge. See full prize  
details at: http://p.sf.net/sfu/Challenge
--===============0918656169019087690==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============0918656169019087690==--


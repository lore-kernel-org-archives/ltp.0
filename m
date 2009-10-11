Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1Mwnls-000163-5R
	for ltp-list@lists.sourceforge.net; Sun, 11 Oct 2009 02:02:52 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Mwnll-0002Qx-Qc
	for ltp-list@lists.sourceforge.net; Sun, 11 Oct 2009 02:02:52 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Sat, 10 Oct 2009 22:02:37 -0400
References: <364299f40910091048w54ece725l2b07a04bb82f6a4f@mail.gmail.com>
	<200910101834.26319.vapier@gentoo.org>
	<364299f40910101601s6f868506k24aab4356a03fcd6@mail.gmail.com>
In-Reply-To: <364299f40910101601s6f868506k24aab4356a03fcd6@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <200910102202.38970.vapier@gentoo.org>
Subject: Re: [LTP] mixing of install/build targets
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============3262580819289688351=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

--===============3262580819289688351==
Content-Type: multipart/signed; boundary="nextPart2106906.SeRxOMWWQH";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2106906.SeRxOMWWQH
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Saturday 10 October 2009 19:01:06 Garrett Cooper wrote:
> On Sat, Oct 10, 2009 at 3:34 PM, Mike Frysinger <vapier@gentoo.org> wrote:
> > also, it seems like the lib subdir is missing a default dependency on t=
he
> > libltp.a library:
> > $ cd lib
> > $ make clean
> > rm -f -f libltp.a *.o *.pyc
> > $ make
> > make: Nothing to be done for `install'.
> > $ make libltp.a
> > <correct output>
> >
> > actually, now that i see this output, i guess the problem is that the
> > default target is "install" instead of "all" (which implies compiled
> > local objects only) ?
>=20
> Ok, that's what I figured. Fixing right now and will be done in <15 mins.

the generic target subdirs all work now, but looks like lib/ is a special=20
case.  lib.mk sets DEFAULT_GOAL to "install" which is no good.  if i drop t=
he=20
line, then whatever the first target declared is used as the default.  this=
=20
can be a little weird with how files are included, so changing this to "all=
"=20
gets expected behavior.

will the other .mk have similar problems ?  should we set DEFAULT_GOAL to a=
ll=20
in env_pre.mk so people dont have to worry about ordering ?
=2Dmike

--nextPart2106906.SeRxOMWWQH
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iQIcBAABAgAGBQJK0Ty+AAoJEEFjO5/oN/WB3zUQANGsXHglzESZ8UOSRZSN2l/T
fiphAT3Lcxm371+BVv9Al+bVzXRmG9VwS09YwpCiv/R1jJ/gX6JOcgfQ9abMgEoE
BWIe3kPsQqGmgYjio8HsekHyUuUs6e/PiR8mjati4a9YPRunzHLISlVGaIIJIKq3
nw3Jx50fRSxyzErggtPFJCVNZ5HCc41JM+twuOqEYG8kGiCV7+9xYlaf3C6qSfYd
V1BhWK7Jl3jPt1cGRQLwlF4wr68CQ9MUXFhNv5n8wdM3RmU5Y0cr4+fk0k4TCvOC
pwVaNTdHiRYy5J5APhIqS506KU759lRYGYSs2CnUFmWEJajMXDCi5kUJHOlsieRR
lEHYGeuTwDdQyRnz6zW8rTRS5ezmolAuMiSBAQWGPO1Dl0ekuTmggRYNheio9sNZ
T53LUrJ15WLb5qXrVlq5FyfxVMzQC/gm3PBFR/uqdwWtSUTSm4n9Kuk4L908gUPQ
SwTwoJ4jkfdWaXT2jSS0K4/B6rc/5i8Awj8h3ZX/t0crdagCIrK8kBSTc/jy9lt1
JaPmUlthUYryXFGtNyusHVK0FoLsN1vuifm5Z4wByfAqDFaQdnCbPz4TZLEm3u7E
bpqeFj4ArG9Ru8+3cKUZvsWr5fHvA71Xrftlshry2ocVXuKrAF6nDRRZA17iZ1d6
MImIEV97cJ8gNYsEhwm9
=wG6G
-----END PGP SIGNATURE-----

--nextPart2106906.SeRxOMWWQH--


--===============3262580819289688351==
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
--===============3262580819289688351==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============3262580819289688351==--


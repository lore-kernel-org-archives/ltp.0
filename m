Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1NGmeZ-0004Ws-9w
	for ltp-list@lists.sourceforge.net; Sat, 05 Dec 2009 04:53:55 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NGmeS-0003TJ-Sc
	for ltp-list@lists.sourceforge.net; Sat, 05 Dec 2009 04:53:55 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Fri, 4 Dec 2009 23:58:59 -0500
References: <4b1940f3.8413f30a.2877.6a27SMTPIN_ADDED@mx.google.com>
	<200912041406.40770.vapier@gentoo.org>
	<op.u4fxyb2ou2flwt@marcela-gaxm89c>
In-Reply-To: <op.u4fxyb2ou2flwt@marcela-gaxm89c>
MIME-Version: 1.0
Message-Id: <200912042358.59830.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH] Don't install datafiles with executable mode
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5052515342815088305=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: =?utf-8?q?Ji=C5=99=C3=AD_Pale=C4=8Dek?= <jpalecek@web.de>
Cc: ltp-list@lists.sourceforge.net

--===============5052515342815088305==
Content-Type: multipart/signed; boundary="nextPart11080734.xxDaXqlRju";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart11080734.xxDaXqlRju
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable

On Friday 04 December 2009 20:19:13 Ji=F8=ED Pale=E8ek wrote:
> On Fri, 04 Dec 2009 20:06:40 +0100, Mike Frysinger <vapier@gentoo.org>
>=20
> wrote:
> > On Friday 04 December 2009 11:58:13 Jiri Palecek wrote:
> >> the makefiles install all files with executable mode by default. This
> >> patch
> >>  changes it for some of the Makefiles, that install data files, which
> >>  should IMHO not be executable. The change makes INSTALL_MODE decide t=
he
> >>  actual mode when it is expanded inside the install rule (depending on
> >> $@,
> >>  which is the install target name).
> >
> > that's pretty fugly way to go about it.  let's go the more natural route
> > and
> > have the common code default to $(INSTALL_MODE_$@) and if that's unset,
> > use
> > the default $(INSTALL_MODE).
>=20
> Sorry, but I don't agree with that. This is a function-like approach which
> is not any less "natural" than what you propose - and it makes no demands
> on anyone who doesn't need it, and gives great power to those who need it.

your solution requires non-obvious delayed evaluation that isnt=20
straightforward.  mine is explicit, unambiguous, and already in use by many=
=20
other projects that ltp is related to.

> The main reason I don't like the INSTALL_MODE_$@ thing, is that eg.
> INSTALL_TARGETS can contain wildcards (eg. dir/*.ext), and there cannot be
> any such thing as $(INSTALL_MODE_dir/*.ext). You would have to enumerate
> all data files - or all program files - which would be a chore esp. if any
> of these isn't known in the makefile until "make all" is ran.

so fix install targets to expand the globs at make time and not shell time.=
 =20
i.e. something like INSTALL_TARGETS :=3D $(wildcard $(INSTALL_TARGETS))
=2Dmike

--nextPart11080734.xxDaXqlRju
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.13 (GNU/Linux)

iQIcBAABAgAGBQJLGeiTAAoJEEFjO5/oN/WBMewQALEyVZnxdsNVciwIBXdyBQwT
4L/QZtr+S7IeeNIEv1ZNr68K/+mfo6LssSNaxvsN3s2kCjB/mo7PdGsp1DT+LY+R
1AMknA9wLMKI6CsFkyxgpec0CuLPwWWUmC7mJ0cdmURkLq52V54tyrlXOWaMzTb/
loR9wikn+VTobARH1zuABwP+o/8DZOhA0kmQuv4S8+6CvGC/2waRndBFBzQkFbYh
tW7/NuXDhlLTC4zc1mD9U+T4N3yEtzpFUZ5LtZW4r4DJcsy6goghpTL7b2tIv5Nm
iDSAL23oKtZdpAQg6sBtixs/gfkQ6xzpIooOlxUBNAk1GJk3ZdZNcO90eN96tPEG
BlnWpjiyyUv6xUNOKdstYW1lFPqBw+MzrsfQPuFheGZ6AEMB52D5UV7qTlYyIsLq
6Qb6WEDPpp4lTOJHSiPKY4US3mAV2p+mfTE4FUz1ClHMI+6l9m6m7rJLLpcBOH5j
sT6LToQ59GW3ZbfgMEdwTviSLCERtRqUzE/8uY097CM2yva9jpFiQYCz1m8xzK7O
RU+WNPYngjB+bJaS1P78EGYAievEZznlGqiTlqOAYW+vyx662UJ2kcjK9WB3Enpj
4wHESB/8LGSwZou5QkMe/piEBI4vAb0xtNNI4c/C8mkzq/BcqM0whv4Q6FBx/jjq
BFM0Yx64Px5LpnAQwZn3
=b/F5
-----END PGP SIGNATURE-----

--nextPart11080734.xxDaXqlRju--


--===============5052515342815088305==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Join us December 9, 2009 for the Red Hat Virtual Experience,
a free event focused on virtualization and cloud computing. 
Attend in-depth sessions from your desk. Your couch. Anywhere.
http://p.sf.net/sfu/redhat-sfdev2dev
--===============5052515342815088305==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============5052515342815088305==--


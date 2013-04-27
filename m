Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1UVydU-0001Js-75
	for ltp-list@lists.sourceforge.net; Sat, 27 Apr 2013 06:29:28 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1UVydT-0006n7-1O
	for ltp-list@lists.sourceforge.net; Sat, 27 Apr 2013 06:29:28 +0000
Received: from vapier.localnet (localhost [127.0.0.1])
	by smtp.gentoo.org (Postfix) with ESMTP id 241F233DF68
	for <ltp-list@lists.sourceforge.net>;
	Sat, 27 Apr 2013 06:29:15 +0000 (UTC)
From: Mike Frysinger <vapier@gentoo.org>
Date: Sat, 27 Apr 2013 02:29:20 -0400
References: <8a051675195eceda293d88d157163083d7886570.1366724682.git.jstancek@redhat.com>
	<20130425143406.GA3084@rei.suse.cz>
	<201304251532.46436.vapier@gentoo.org>
In-Reply-To: <201304251532.46436.vapier@gentoo.org>
MIME-Version: 1.0
Message-Id: <201304270229.21748.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH] remove linux_syscall_numbers.h from tree
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1746611133267694472=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============1746611133267694472==
Content-Type: multipart/signed; boundary="nextPart2154465.encs2ogFVT";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2154465.encs2ogFVT
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thursday 25 April 2013 15:32:45 Mike Frysinger wrote:
> On Thursday 25 April 2013 10:34:07 chrubis@suse.cz wrote:
> > > > > is keeping it in the tree a big deal ?  i think it's pretty common
> > > > > for people to go into specific subdirs and run `make` and today,
> > > > > our subdirs don't declare a dependency on this file so it'll get
> > > > > automatically regenerated (nor do i think they should even
> > > > > bother).
> > > >=20
> > > > You need to regenerate the file after each change to the *.in files,
> > > > and that means that people will forget from time to time.
> > >=20
> > > so people aren't testing their commits ;)
> >=20
> > Aparently they don't, I've reruned the script and the result is that git
> > diff shows 6125 lines of changes. And the last time the *.in files were
> > changed was 2010...
> >=20
> > Which is another reason why we need proper solution.
> >=20
> > What about we:
> >  1) Commit the up to date linux_syscall_numbers.h
> > =20
> >  2) Add linux_syscall_numbers.h dependency on *.in
> > =20
> >     - that would regenerate the file on change, but only
> >    =20
> >       from the top make and will catch the change
> >       most of the time
> >=20
> > Which would IMHO be good short term fix and figure out something better
> > later.
>=20
> it used to depend on the *.in files (i added it way back in 2008 with
> d885d4ae1037aa4aa8bb12f374776188867903d3 and
> 89ba1191d6c592e2f6d16824caa78b09fc714811).  looks like the overhaul in
> commit ef77253961f909f87e82e6d2b620e87af33e9665 broke that.  in the follow
> up 1bf1c2ad7b4e25c4f09479378314c9a4dd2b3a78, the commit message indicates
> it had meant to fix this, but it seems to not have.
>=20
> so yes, let's add *.in and commit the regenerated file.

i've fixed & pushed this now
=2Dmike

--nextPart2154465.encs2ogFVT
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJRe3BBAAoJEEFjO5/oN/WBPXkQAMC9aE4mWnJctuVz1oaAB9As
LmCVrUyiFJfXJVImGQ39+y5A1pIVctmTop2CgCfXKvLCr4jly+3fEK+7GI2HwFn4
sREa1SprRrT+XmCuiExjF4aMiE8iBQBOKCXv/etUzuRGF3pgZ7z0whph4LFEDBnK
lBLy0KjlpreTLdejBA3mTE2yFkRJJS0lPfPP/I6oV3T5H8xLySrF5Giqgr+4+frH
BUpcjy0IHJTAmBm7j+osweBfqkszU9lUZGewZYzFbL2p11RGePm+LJ6pUCMPxuUg
6QsjyU2GE+1Q3/Xw3AYf6ErcmSpnOvxR2nX6v0RwsUwfdypNvAyqo5Hk+K0lyQGz
vWHcP2QzswedR6TZnDZW0V5h2YJFelurbjK0/ymS5fKByB5iPUrpicgMYO1IdbiX
Z5pojHAZHW7ZDaZq0Y4RB6CBDNIRG1d+RKszMGq/Ut8MD0xEAGhJd0VuYHFKxM5z
IIanyZRL7CU+rV6hhpZVZe2lu6OSbXSgJWTdymK27JvV2kkFnr7tpgjGThX+cM3I
jeVUWHdFxIFjCx15DKliIepLapJKGuIKtXGzwiWr42vG9yZ6h4hsjnlVlbJ2ug9s
GOdJL8eOe0F4OrQFgPj11+N8ATgcI442mM2YE8O/D0ULNwJsE0+omdZMnieT5OnH
k9T+Obkg0XRw64TDpW3z
=MYHG
-----END PGP SIGNATURE-----

--nextPart2154465.encs2ogFVT--


--===============1746611133267694472==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Try New Relic Now & We'll Send You this Cool Shirt
New Relic is the only SaaS-based application performance monitoring service 
that delivers powerful full stack analytics. Optimize and monitor your
browser, app, & servers with just a few lines of code. Try New Relic
and get this awesome Nerd Life shirt! http://p.sf.net/sfu/newrelic_d2d_apr
--===============1746611133267694472==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============1746611133267694472==--


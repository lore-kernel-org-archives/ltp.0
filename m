Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1VEik0-0001nG-Oo
	for ltp-list@lists.sourceforge.net; Wed, 28 Aug 2013 16:37:08 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VEijy-0000Lw-NC
	for ltp-list@lists.sourceforge.net; Wed, 28 Aug 2013 16:37:08 +0000
Received: from vapier.localnet (localhost [127.0.0.1])
	by smtp.gentoo.org (Postfix) with ESMTP id BFC3233ECC2
	for <ltp-list@lists.sourceforge.net>;
	Wed, 28 Aug 2013 16:37:00 +0000 (UTC)
From: Mike Frysinger <vapier@gentoo.org>
Date: Wed, 28 Aug 2013 12:37:02 -0400
References: <20130711110014.GB6142@rei.suse.cz> <20130828115601.GA4804@rei>
	<201308281234.41447.vapier@gentoo.org>
In-Reply-To: <201308281234.41447.vapier@gentoo.org>
MIME-Version: 1.0
Message-Id: <201308281237.03104.vapier@gentoo.org>
Subject: Re: [LTP] RFC add _FORTIFY_SOURCE to default LTP CFLAGS
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1610571545769370184=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============1610571545769370184==
Content-Type: multipart/signed; boundary="nextPart1624485.4tAhGUXlup";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1624485.4tAhGUXlup
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wednesday 28 August 2013 12:34:40 Mike Frysinger wrote:
> On Wednesday 28 August 2013 07:56:01 chrubis@suse.cz wrote:
> > > unfortunately that does not work.  this snippet from coreutils is
> > > probably better:
> > >   AH_VERBATIM([FORTIFY_SOURCE],
> > >   [/* Enable compile-time and run-time bounds-checking, and some
> > >   warnings,
> > >       without upsetting glibc 2.15+. */
> > >    #if !defined _FORTIFY_SOURCE && defined __OPTIMIZE__ && __OPTIMIZE=
__
> > >    # define _FORTIFY_SOURCE 2
> > >    #endif
> > >   ])
> >=20
> > That wouldn't work here, as config.h is included only in a few testcases
> > (in these that actually use some of the defines there).
> >=20
> > But given that this just copies some ifdefs into config.h what about
> > adding the snippet directly into compiler.h that is included from
> > test.h thus ends up in all testcases?
>=20
> SGTM

err, no, that won't work either.  _FORTIFY_SOURCE must be defined before an=
y=20
header file is included.  otherwise, including all the C lib headers and th=
en=20
test.h and then defining this won't accomplish anything.

you could probably turn that AH_VERBATIM into a compile test and then add i=
t=20
to CPPFLAGS based on the result.  that would probably work in most cases.
=2Dmike

--nextPart1624485.4tAhGUXlup
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJSHicvAAoJEEFjO5/oN/WBDX4P/0RzyzNUUGIibyyuKuJgaLkE
uB23Jgry5/8wzhitXTr1GEUL22tzR1Y8ef/I+WG57eEh/ZbXGcN2NpMuj8qOKtE0
EN2ci3EKJOpVV4Oj9YueJXMd2xNpbiNSfgopEYuBRPq4fGb/tZ5VSaoU55UBD7LO
Ct3K9N/meOiSNU3Y4sArF1ReeCvCcbiM/iife2miowTTWDZx7LbTb89MALuvYMQP
2iS2DX+2IcJNW9PFKbMrXEJUHJXn1CMpzyAsveP0JU7bR0+CycMUo3Cmj+EW7/3d
qEti6WDxmc4zEzDRdBWW8fArZX3HGes19Fu3ZfpVtf6Ayo5vVYDymA6bEqlsY0hJ
v1ZwBAa5209q+kbNo1evpUenWZWXq7ya7/9SCAYTmW5RrIS/pVUAadorq2qNUikZ
nbCMD+xoZthMU0Yt82ldHR2pazUXI5GWNWQMlDWIjGUgTccAyw/Mccl7Xljix0Sy
tf7PrFPW/6AzV7cLtqdt7HWho/N1sBaM0JsnLtMiFZxbS99pvoWIGGAWWAZ3pHjg
8spq1GlclOBK5wSjgrR3l+QlFd1qvzAaEt7rAybePiB7Z7S4M+Jg5PCEvvTTLmRg
WhLcF3SPp0zN8PcnMKmuDzBMiDF0YcbFhVdofEbRKtl0QgPZgnQ7Lrtv1AOialMt
jMRo5uP3HaHxEDZ3iGLH
=YYD5
-----END PGP SIGNATURE-----

--nextPart1624485.4tAhGUXlup--


--===============1610571545769370184==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Learn the latest--Visual Studio 2012, SharePoint 2013, SQL 2012, more!
Discover the easy way to master current and previous Microsoft technologies
and advance your career. Get an incredible 1,500+ hours of step-by-step
tutorial videos with LearnDevNow. Subscribe today and save!
http://pubads.g.doubleclick.net/gampad/clk?id=58040911&iu=/4140/ostg.clktrk
--===============1610571545769370184==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============1610571545769370184==--


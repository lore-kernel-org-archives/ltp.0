Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1N7CEy-00025V-Sh
	for ltp-list@lists.sourceforge.net; Sun, 08 Nov 2009 18:11:52 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N7CEr-0004e8-EQ
	for ltp-list@lists.sourceforge.net; Sun, 08 Nov 2009 18:11:52 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Sun, 8 Nov 2009 13:13:24 -0500
References: <1257167821.4977.41.camel@subratamodak.linux.ibm.com>
	<364299f40911061728g37c0cd6ble40974b0fe5b5597@mail.gmail.com>
	<20091108095019.184998b2.rdunlap@xenotime.net>
In-Reply-To: <20091108095019.184998b2.rdunlap@xenotime.net>
MIME-Version: 1.0
Message-Id: <200911081313.25577.vapier@gentoo.org>
Subject: Re: [LTP] [patch 2/2] INSTALL corrections & TODO
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0183615886905528290=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: ltp-list <ltp-list@lists.sf.net>, Randy Dunlap <rdunlap@xenotime.net>, Andi Kleen <andi@firstfloor.org>

--===============0183615886905528290==
Content-Type: multipart/signed; boundary="nextPart1874078.zkbJ0Qhij4";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1874078.zkbJ0Qhij4
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Sunday 08 November 2009 12:50:19 Randy Dunlap wrote:
> On Fri, 6 Nov 2009 17:28:42 -0800 Garrett Cooper wrote:
> > On Fri, Nov 6, 2009 at 4:03 PM, Randy Dunlap wrote:
> > > "Configuration" section to match Makefile message.
> > > How to use DESTDIR and --prefix together.
> > >
> > > TODO:
> > > "Quick Start" does not work.
> > > "Not using autoconf:" does not work.
> > >
> > > ---
> > >  INSTALL |    9 ++++++++-
> > >  1 file changed, 8 insertions(+), 1 deletion(-)
> > >
> > > --- ltp-full-20091031-auto.orig/INSTALL
> > > +++ ltp-full-20091031-auto/INSTALL
> > > @@ -29,7 +29,7 @@ downloaded from:
> > >  - http://ftp.gnu.org/gnu/m4/m4-1.4.7.tar.bz2
> > >  - http://ftp.gnu.org/gnu/m4/m4-1.4.7.tar.gz
> > >
> > > -Configuring
> > > +Configuration
> > >  -------------------
> > >  Using autoconf:
> > >         $ make autotools # This must be run from "$TOP_SRCDIR!"
> > > @@ -74,6 +74,13 @@ in the same directory where the source f
> > >   sysroot, as opposed to the host system's sysroot.
> > >  - Specify SKIP_IDCHECK=3D1 if and when you don't want to modify
> > > /etc/{group,passwd} on the target system's sysroot.
> > > +- If you want to build and install ltp inside its source tree (e.g.,
> > > in +  $TOP_SRCDIR/ltpbin/), to support multiple versions of LTP on one
> > > system, +  then use
> > > +
> > > +       $ cd $TOP_SRCDIR
> > > +       $ mkdir ltpbin
> > > +       $ ./configure DESTDIR=3D$PWD --prefix=3D$PWD/ltpbin
> > >
> > >  If you get a build error, please report it to ltp-list@lists.sf.net
> > > with following information,
> >
> > My only question about this is this step above a frequently used usecas=
e?
>=20
> I can't answer that.  It seems like a good idea to be able to have
> multiple versions of ltp installed and it took me a little while to
> figure out how to use both DESTDIR and --prefix, so I'd like a reference
> for it...

=2D-prefix and DESTDIR under LTP should work exactly the same as under any=
=20
autotooled package.  passing DESTDIR to configure doesnt make sense imo, no=
r=20
does this example.  this example suggests a file tree of:
$PWD/$PWD/ltpbin/.....
=2Dmike

--nextPart1874078.zkbJ0Qhij4
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.13 (GNU/Linux)

iQIcBAABAgAGBQJK9wpFAAoJEEFjO5/oN/WBrO4P/AtjRQDwPMRPn+G5qmLRVlXX
7M1AtqTon0wva939qecQTTtVy8QNkKA8g7s97qOCNRlYLONpo8GikixqV0n4IjKW
ez4jVzKEaLOtsTtRQu9cc8eg+MMe1MrgmcoqR3CraFPNIMs8qKzEyz812HY9zoC+
e7ozYW0YG3Y5/ru5/kZPaavTl9UGMdPJFUBUcIKtjBeAIjkspZEliRFtepK5yBpH
wJUP61YQ2Fag30kaq7w3EEH22uVLVPbKP+QY++qhpEfWU5P78cMljq2V7vjDI5CA
bdk3yqC8u2ASwnesSLbnRxlk62OdkEa6qkLZqr0vhiv+hsu7eGekPgSxeH10npyZ
r/rNqPxFiAdpuacBy8q7Hmowfm2vE6o1PSdaduyB9yyMb8z/6vjJux+eKnXRf2xh
cjSgIgudiHYgmn6Ob1DIHRK8Z+KsXoXtq1qw78fM5oIzi9g/156Rx9DJm2BjmhNx
bAH/GS53d2i8WQlKoerPntV/aGm2d/CrkOdbkpBiqw4oBKxTna+t/0cTZ3tIKrsu
NziX/PpMHw/+IWxDh2soqMwSTzRVUTFJTuSj2YoV8Tp3g0SlOE2/d2ElyAG5O/vp
/nkUYzukXpxL5dzs+iDsH+xcOb+hCJ77NXF+NnxLkvhnDihzKt5FofbvZtqgZbrh
0m0a5AsETHxOGTKLM5s2
=aFvt
-----END PGP SIGNATURE-----

--nextPart1874078.zkbJ0Qhij4--


--===============0183615886905528290==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--===============0183615886905528290==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============0183615886905528290==--


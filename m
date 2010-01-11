Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <paul.larson@canonical.com>) id 1NUOda-0005pa-70
	for Ltp-list@lists.sourceforge.net; Mon, 11 Jan 2010 18:05:10 +0000
Received: from adelie.canonical.com ([91.189.90.139])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NUOdZ-0001Po-A0
	for Ltp-list@lists.sourceforge.net; Mon, 11 Jan 2010 18:05:10 +0000
From: Paul Larson <paul.larson@canonical.com>
In-Reply-To: <364299f41001110943q4c476dc7n6dbf1fcf8b05c57d@mail.gmail.com>
References: <1263226258.2410.24.camel@plars-t500>
	<364299f41001110943q4c476dc7n6dbf1fcf8b05c57d@mail.gmail.com>
Date: Mon, 11 Jan 2010 12:04:59 -0600
Message-ID: <1263233099.2410.25.camel@plars-t500>
Mime-Version: 1.0
Subject: Re: [LTP] Fix for make autotools
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============4896883614229481382=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: Linux Test Project <Ltp-list@lists.sourceforge.net>


--===============4896883614229481382==
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-zVi6OCBTWzbPCUinAVb8"


--=-zVi6OCBTWzbPCUinAVb8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2010-01-11 at 09:43 -0800, Garrett Cooper wrote:
> On Mon, Jan 11, 2010 at 8:10 AM, Paul Larson <paul.larson@canonical.com> =
wrote:
> > Make autotools seems to break on more recent versions without this.
> >
> > Signed-off-by: Paul Larson <paul.larson@canonical.com>
> > ---
> > diff --git a/include/mk/automake.mk b/include/mk/automake.mk
> > index e23d5d4..889e6cf 100644
> > --- a/include/mk/automake.mk
> > +++ b/include/mk/automake.mk
> > @@ -59,7 +59,7 @@ include:
> >        mkdir -p "$@"
> >
> >  m4/ltp-version.m4: ChangeLog
> > -       sed -n '1{s:LTP-:AC_DEFUN([LTP_VERSION],[:;s:$$:]):;p;q}' $< > =
$@
> > +       sed -n '1{s:LTP-:m4_define([LTP_VERSION],[:;s:$$:]):;p;q}' $< >=
 $@
> >
> >  .PHONY: automake
> >  AUTOMAKE_FILES :=3D config.guess config.sub install-sh missing stamp-h=
1
>=20
> Hi Paul,
>     What version of automake and m4 are you using?

automake:
  Installed: 1:1.11-1
m4:
  Installed: 1.4.13-3

These are the current versions in Ubuntu 10.04 (Lucid)
Thanks,
Paul Larson


--=-zVi6OCBTWzbPCUinAVb8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAktLaEgACgkQ3UR7ubYtCO5PWQCgzeqJiG5RBnf6a4VhLVOGjCRd
1jwAoINLyeHqHkFbNV/GazYq2k3cYOPp
=ezLt
-----END PGP SIGNATURE-----

--=-zVi6OCBTWzbPCUinAVb8--



--===============4896883614229481382==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
--===============4896883614229481382==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============4896883614229481382==--



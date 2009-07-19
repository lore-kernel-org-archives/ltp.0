Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1MSK2r-00055W-16
	for ltp-list@lists.sourceforge.net; Sun, 19 Jul 2009 00:14:25 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MSK2k-0001WR-9X
	for ltp-list@lists.sourceforge.net; Sun, 19 Jul 2009 00:14:24 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Sat, 18 Jul 2009 20:14:10 -0400
References: <364299f40907061818q7cda3465vffb00323af18c5f8@mail.gmail.com>
	<200907181822.03140.vapier@gentoo.org>
	<364299f40907181607m42e27de9sacb61084452ea53a@mail.gmail.com>
In-Reply-To: <364299f40907181607m42e27de9sacb61084452ea53a@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <200907182014.11010.vapier@gentoo.org>
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
Content-Type: multipart/mixed; boundary="===============3238563482734855999=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

--===============3238563482734855999==
Content-Type: multipart/signed; boundary="nextPart65697115.SrfCcRFFXW";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart65697115.SrfCcRFFXW
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Saturday 18 July 2009 19:07:13 Garrett Cooper wrote:
> On Sat, Jul 18, 2009 at 3:22 PM, Mike Frysinger wrote:
> > On Saturday 18 July 2009 17:25:58 Garrett Cooper wrote:
> >> On Wed, Jul 15, 2009 at 9:37 AM, Mike Frysinger wrote:
> >> > On Sunday 12 July 2009 01:49:52 Garrett Cooper wrote:
> >> >> +# Avoid overwriting definitions in leaf callers.
> >> >> +CPPFLAGS     ?=3D @CPPFLAGS@ -I$(includedir)
> >> >> +CFLAGS               ?=3D @CFLAGS@
> >> >> +LDLIBS               ?=3D @LIBS@
> >> >> +LDFLAGS              ?=3D @LDFLAGS@ -L$(libdir)
> >> >
> >> > this looks like it'll cause problems if you set these in your
> >> > environment export CPPFLAGS=3D'' CFLAGS=3D'-pipe' LDFLAGS=3D''
> >> > make
> >> >
> >> > i would use $(origin ...) to determine whether the variables are
> >> > coming from the leaf Makefile
> >>
> >> Ah, yes. Excellent point.
> >>
> >> So what's the appropriate protocol then:
> >>
> >> If set in environment, ignore?
> >> Or:
> >> If set in Makefile, ignore?
> >
> > if it's set in the env, the "?=3D" should already handle that.  i cant
> > think of a reason for the leaf makefiles to be settings default flags .=
=2E.
> > do you have an example in mind ?
>
> Yes, actually. The problem with the current system is that we keep on
> using +=3D, which bloats the CFLAGS / LDFLAGS / LDLIBS, etc
> unnecessarily, so if we get 5 levels deep we end up with a line like:
>
> gcc -I../../../../../include -I../../../../include -I../../../include
> -I../../include -I../include
>
> etc.
>
> Now that's just plain silly and we'll run into ceilings very quickly
> with long argument lines, plus it'll slow down gcc / binutils with the
> search path.

well that should be addressed independently.  have the .mk export some=20
variable like LTP_BUILD_INITIALIZED =3D yes, and then stick all of these=20
defaults and appends behind that.
=2Dmike

--nextPart65697115.SrfCcRFFXW
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iQIcBAABAgAGBQJKYmVSAAoJEEFjO5/oN/WBidYQAIB/3pVb/9W3O78O/Dn24BuO
s+z/3kBa3HTU1C4s78DHetG44GWQ6/9HD7b43QeLSu3wK+zscdS4CqmkbdNCwmUM
lsJXOYP1hWuyUnfOuQO7IKlrh8b+9Ztzp7ygh08E8oKyvHaPKGkjMZr7JunAjGqG
BkYufK8dkFYq7Mc+1GyWJewOmOwxGzJdprrEb4KBu2yEWIxA2mZPurqrYHYV8I/v
gXxTuCVr2DrDncGtih88t4dt3ab/zKpLWNL+vc1dK6aZfH9nyo96LYBQs52p66gP
+LvpSt84LwPTWvTDXW+06sfr0fD4XOqg6qouh5T/HjejMzygLWwQJztl79yk6v+w
Q61nJEmWgJUK8rwJxP5bIfB0jvbJ2Afo49qf4F2G6XqSrLkJz8s679jl70uzSddJ
ggASbNIx/nc2gw3E7ktJWUoTKaSkDu0p/Wt5ysYkXGLCQaz9kXMP930GTHICbuAs
qGWXMrrK0PAPREBEUieRSdZEpg/LLlwPFcJ49lYi6IdQAGnYSIdWqHHpOq84KJzK
JJOjjV59rTupGKnr2Zemo+1rJcAx0VV/VMzDyQQiexUdXVW3jRjwRhbiYBEhB8J2
UlRBGLj9kCowYHO2WyJZH2c1UIRDInmLEYLwYvW5VKz4Ryl/7gWxljdd0or41lBx
MDRvPPxzJbYGnRckTKst
=7kqB
-----END PGP SIGNATURE-----

--nextPart65697115.SrfCcRFFXW--


--===============3238563482734855999==
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
--===============3238563482734855999==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============3238563482734855999==--


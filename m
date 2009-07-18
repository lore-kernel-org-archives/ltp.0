Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1MSIIJ-0004hU-VU
	for ltp-list@lists.sourceforge.net; Sat, 18 Jul 2009 22:22:15 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MSIIA-0000Kn-Bb
	for ltp-list@lists.sourceforge.net; Sat, 18 Jul 2009 22:22:15 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Sat, 18 Jul 2009 18:22:02 -0400
References: <364299f40907061818q7cda3465vffb00323af18c5f8@mail.gmail.com>
	<200907151237.49839.vapier@gentoo.org>
	<364299f40907181425h31ec769aw5f349b86891c94ad@mail.gmail.com>
In-Reply-To: <364299f40907181425h31ec769aw5f349b86891c94ad@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <200907181822.03140.vapier@gentoo.org>
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
Content-Type: multipart/mixed; boundary="===============1964778906241378067=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

--===============1964778906241378067==
Content-Type: multipart/signed; boundary="nextPart1279273.OVF4GGvcVV";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1279273.OVF4GGvcVV
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Saturday 18 July 2009 17:25:58 Garrett Cooper wrote:
> On Wed, Jul 15, 2009 at 9:37 AM, Mike Frysinger<vapier@gentoo.org> wrote:
> > On Sunday 12 July 2009 01:49:52 Garrett Cooper wrote:
> >> +# Avoid overwriting definitions in leaf callers.
> >> +CPPFLAGS     ?=3D @CPPFLAGS@ -I$(includedir)
> >> +CFLAGS               ?=3D @CFLAGS@
> >> +LDLIBS               ?=3D @LIBS@
> >> +LDFLAGS              ?=3D @LDFLAGS@ -L$(libdir)
> >
> > this looks like it'll cause problems if you set these in your environme=
nt
> > export CPPFLAGS=3D'' CFLAGS=3D'-pipe' LDFLAGS=3D''
> > make
> >
> > i would use $(origin ...) to determine whether the variables are coming
> > from the leaf Makefile
>
> Ah, yes. Excellent point.
>
> So what's the appropriate protocol then:
>
> If set in environment, ignore?
> Or:
> If set in Makefile, ignore?

if it's set in the env, the "?=3D" should already handle that.  i cant thin=
k of=20
a reason for the leaf makefiles to be settings default flags ... do you hav=
e=20
an example in mind ?

> >> +DEBUG_CFLAGS ?=3D -g
> >> +DEBUG_CXXFLAGS       ?=3D $(DEBUG_CFLAGS)
> >> +
> >> +CFLAGS               +=3D $(DEBUG_CFLAGS)
> >> +CXXFLAGS     +=3D $(DEBUG_CXXFLAGS)
> >> +
> >> +# There have been several bugs in the past related to -O2+ when
> >> +# -fno-strict-aliasing is not specified.
> >> +OPT_CFLAGS   ?=3D -O2 -fno-strict-aliasing
> >> +OPT_CXXFLAGS ?=3D $(OPT_CFLAGS)
> >
> > in general, i recall only like 1 bug that was a gcc issue.  all the
> > others were broken source code.  i dont think we should live with code
> > that violates aliasing rules.
>
> See my previous comment. There are ~10 different bugs spanning
> compilers from v3.3.x to 4.4.x, which deal with broken
> -fstrict-aliasing optimizations in the tree optimizer.

please centralize the comments then rather than sprinkling them about the=20
different source files.  here the comment should say:
# -fno-strict-aliasing: please see README.mk-devel

> >> --- m4/GNUmakefile    18 Jan 2009 22:22:40 -0000      1.1
> >> +++ m4/GNUmakefile    12 Jul 2009 05:46:28 -0000
> >
> > i think we only need a top level GNUmakefile.  all the other subdirs can
> > stay Makefile.
>
> Well, ok. I was just leaving it as-is, because that's the way it is today
> :).
>
> Like in rock-paper-scissors:
>
> GNUmakefile beats Makefile, which beats makefile.

mmm that GNUmakefile is there for a different reason (to ignore the automak=
e-
generated Makefile), so we dont want to go renaming it.  so you dont need t=
o=20
go doing something different.
=2Dmike

--nextPart1279273.OVF4GGvcVV
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iQIcBAABAgAGBQJKYksLAAoJEEFjO5/oN/WBgiEP/3K8RP8FRUutDAsKpnmsIPB2
m0pzQYXea5pB9MqPXYlM+D2Y5I6AqYdYY7GeibU/PPFLsuOkjDjQI4/APhIEZuVc
ENjrxWInqLCjZ93FBoKfFizScy32JkWT9Ln2q5YxhizWNUmotY0THF9uAiABmxXK
O6VjaP8wCa/BCtj/w/T6Z4qhFfYkczN6HBt0N+6hU4JOJws4d6xtuDvMxru/Zz5M
oszi+YQKI2THUyVhfSvAiLZV4O4+p+U+/26Oo1aWuyhYjasaZbRp7btVEmzSVDa+
kwo+gQEaU4bw7qoROA12jRc/p9wySh3G5lyDPFtGg88GZfA1aBEcnaLGFTnlMSGf
JauXsYaZEJGV81li5jfymGGqfNZc7NUd9NYSp/6Cy/40W1h2T5yhYm6JxVbDtFqR
cLquM6mQVs1JcA/mX37ZLDuhLB3bIRTMRT6GFuqUeVmb/4ndd46Cl9RHa+MnBdXl
xDojRnhI/8mT5U88pGAwG81zZ0Twp6ijaHVqEAhullcYL3RtjtAPZlqUJbV4l35F
ldyuXSKzYO/tYdd7VCeSrKKSeo6LwyHKQn/WsmqvEtdWLv2IZfP6gCXp1GkkEhs6
8FtwNjDyHGEf3h8hLiqU4bm5wm8YuuxwDL99MrY31IutQnOazwyKxWLJhyH8zGsZ
ItQ4D1nOHsYNHOFTZgGa
=uB23
-----END PGP SIGNATURE-----

--nextPart1279273.OVF4GGvcVV--


--===============1964778906241378067==
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
--===============1964778906241378067==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============1964778906241378067==--


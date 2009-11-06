Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1N6XuD-0007MR-Kz
	for ltp-list@lists.sourceforge.net; Fri, 06 Nov 2009 23:07:45 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N6Xu7-0004dw-1z
	for ltp-list@lists.sourceforge.net; Fri, 06 Nov 2009 23:07:45 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Fri, 6 Nov 2009 18:09:04 -0500
References: <20091106095745.GA25377@basil.fritz.box>
	<200911061409.03835.vapier@gentoo.org>
	<20091106230231.GC26614@count0.beaverton.ibm.com>
In-Reply-To: <20091106230231.GC26614@count0.beaverton.ibm.com>
MIME-Version: 1.0
Message-Id: <200911061809.05115.vapier@gentoo.org>
Subject: Re: [LTP] LTP 20091031 Makefiles totally broken?!?
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1136738944230377761=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Matt Helsley <matthltc@us.ibm.com>
Cc: ltp-list@lists.sourceforge.net

--===============1136738944230377761==
Content-Type: multipart/signed; boundary="nextPart1802815.k2GKtN3Tgs";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1802815.k2GKtN3Tgs
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Friday 06 November 2009 18:02:31 Matt Helsley wrote:
> On Fri, Nov 06, 2009 at 03:09:02PM -0400, Mike Frysinger wrote:
> > On Friday 06 November 2009 13:04:51 Garrett Cooper wrote:
> > > As I just wrote in the INSTALL file after the release (I apologize for
> > > not catching this beforehand, but all of the systems I use -- Fedora,
> > > Gentoo, RHEL 4 update 6, Ubuntu -- have make 3.81):
> >
> > hrm, it sucks to not support make 3.80.  while make 3.81 has been out f=
or
> > three years now, make 3.80 support would increase the coverage to 8
> > years. but if you've looked at the situation and found 3.80 support to =
be
> > non trivial, i wont whine too loud.
> >
> > > In order to compile and use pan, you must have bison/yacc, flex, and
> > > make 3.81+ installed.
> >
> > if we're forcing make-3.81+, then make it explicit:
> > ifneq ($(findstring x3.7,x$(MAKE_VERSION)),)
>=20
> This snippet might work better than findstring. If the make version is
> greater than or equal to 3.81 then NEED_NEWER_MAKE is n:
>=20
> NEED_NEWER_MAKE :=3D n
> MAX_VERSION :=3D $(shell echo 3.81 $(MAKE_VERSION) | xargs -r -n 1 | sort=
 -V
>  -r | head -n 1)

this involves executing a shell and a lot of external utilities.  my versio=
n=20
requires an internal make string search.  anything that involves $(shell) h=
ere=20
is going to be worse.

> > also, i thought we were going to rename the top level Makefile to
> > GNUmakefile and add a dummy Makefile that just spat out "sorry, ltp
> > requires GNU make".
>=20
> Bleh. Can't we just check the output of $(MAKE) --version rather than
> assume other makes use "Makefile"?

the assumption is that only GNU make parses "GNUmakefile".  i think that's =
a=20
pretty safe assumption.
=2Dmike

--nextPart1802815.k2GKtN3Tgs
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.13 (GNU/Linux)

iQIcBAABAgAGBQJK9KyRAAoJEEFjO5/oN/WBaToP/AzLRp0kS2S5oCATOewNnoY0
o2f5ot+ISexmb8qUesY+CofJ9/4ITuG85U0PXXetjXOnqjDau0HQC1efpdRk40Hm
tQR0KS7Sb+RIuJ9jkVzjn54kS2Q9dADUNvD8i1SAtM+Ohpt9q6dLXbNOolLc5Ku6
WIi8iCTtevh96uwjw5wtodnoOXObnpqGWlSbLTaz5y1CYKEwd8KHw85TjPQq3QB1
AqLWI5z0LDRW8N3j40CNX25zpaFHHsq3lPwuZ2dSQXNDkuljiCKwr445V1lA9fbo
WJ/2AwveEqGoHVyYiGsF1g5SAp8EVUXKK9bOEJk2GqiRlIef0SlV+O48uRTKClyj
GABjr0pyyOiWauezgSLZienqzTDv7knpA4+Qvk9oPdgWWuzEBVsvO/Op5DvyRMt4
v3Z8LqQfpzjgsBGJsqhsVZbzyeTyYJWAHplMYYq4geUW4qzHfSNRxuLm7mu8b/1J
jRMqwxD6c4BzETJVOXR3F3TXvwbhiNL3YkdvcpNNMSnH5zKK3WED2ISyXkakOrxI
RXnHIlt99LmqmU9U50qlVbS9g4jKsGOkMh2fwQIt08Ei8fncedURikOiIRj2li11
y0J7z+MAwMSyZLMqCrHs6gqiS77HKL6SnmCdNw1hOrjwgp5FjNDJ1BE1dlJKqtnL
bIzBkwxRTH5I/J8DW+LU
=w0My
-----END PGP SIGNATURE-----

--nextPart1802815.k2GKtN3Tgs--


--===============1136738944230377761==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--===============1136738944230377761==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============1136738944230377761==--


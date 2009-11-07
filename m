Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1N6Z4Z-0003DI-8j
	for ltp-list@lists.sourceforge.net; Sat, 07 Nov 2009 00:22:31 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N6Z4S-0000vU-LR
	for ltp-list@lists.sourceforge.net; Sat, 07 Nov 2009 00:22:27 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Fri, 6 Nov 2009 19:23:09 -0500
References: <20091106095745.GA25377@basil.fritz.box>
	<200911061809.05115.vapier@gentoo.org>
	<20091106233422.GB6619@count0.beaverton.ibm.com>
In-Reply-To: <20091106233422.GB6619@count0.beaverton.ibm.com>
MIME-Version: 1.0
Message-Id: <200911061923.09848.vapier@gentoo.org>
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
Content-Type: multipart/mixed; boundary="===============8550129979550240839=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Matt Helsley <matthltc@us.ibm.com>
Cc: ltp-list@lists.sourceforge.net

--===============8550129979550240839==
Content-Type: multipart/signed; boundary="nextPart22475368.YF0SRY97Zl";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart22475368.YF0SRY97Zl
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Friday 06 November 2009 18:34:22 Matt Helsley wrote:
> On Fri, Nov 06, 2009 at 06:09:04PM -0500, Mike Frysinger wrote:
> > On Friday 06 November 2009 18:02:31 Matt Helsley wrote:
> > > On Fri, Nov 06, 2009 at 03:09:02PM -0400, Mike Frysinger wrote:
> > > > also, i thought we were going to rename the top level Makefile to
> > > > GNUmakefile and add a dummy Makefile that just spat out "sorry, ltp
> > > > requires GNU make".
> > >
> > > Bleh. Can't we just check the output of $(MAKE) --version rather than
> > > assume other makes use "Makefile"?
> >
> > the assumption is that only GNU make parses "GNUmakefile".  i think
> > that's a pretty safe assumption.
>=20
> Right, but GNU Make also parses Makefile.

not if a GNUmakefile exists in the same dir, or the user forces the issue v=
ia=20
the -f flag

> If some poor bastard runs:
>=20
> make -f Makefile
>=20
> where GNU Make is "make" they may be further confused. Seems like it's
> better to check what's actually running ($(MAKE)) or will run
> (like `which make` in configure) than rely on a filename hack like this.

said poor bastard should be smacked :p.  checking the value of $(MAKE) wont=
=20
work as it could be an arbitrary number of things which could all be valid=
=20
values under GNU make.  configure checks wont matter because it's the user =
who=20
runs `make` or `gmake` or `make-some-noise`.  requiring `make` to be GNU ma=
ke=20
in configure when the user can easily run `gmake` at make time is pointless=
=20
user interference.

using a different filename on the other hand is exactly what GNU make has=20
designed in from the get go specifically for this purpose -- when GNU make =
is=20
required.  if you honestly think people are doing something pointless like=
=20
`make -f Makefile`, then it's trivial to add a check to it to (1) check=20
$(MAKE) --version and include GNUmakefile or (2) $(error out).  no point in=
=20
forcing the shell/etc... overhead in the default build for the majority of=
=20
users.
=2Dmike

--nextPart22475368.YF0SRY97Zl
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.13 (GNU/Linux)

iQIcBAABAgAGBQJK9L3tAAoJEEFjO5/oN/WBDDYP+QEroMGstTl7Q951x921HUiH
oZVHtQkoXAsg4GGeCM8PX/eOPGtwlxhErsEC8mCp2bg0UwaRgeqtRsYtFhnLzLM6
x9ly2OQNhcry8l90rL9pxBcaCG/hryYOUL3gq/Vua5WUzMH1jCx7N6joUFWVr7bp
D1AhPGOCagGo+LjzOcXg9wJs6nntcFprCHcGuGVuD85ZMjlcP7Rg+BAp/A1iGdO6
s7vUCwfDQi+ojB/T+pxqyEBD/E7wSelOKAkdZjdNTSKYoLXKH4I825wOpz2TYJR4
Qazm5kwDUWNhZDIXZ6r4paz2ABtjhJThaXn9xPk9vObbaogXkGjQNYn1agqskc2h
M0Uwk0KEsbH18NY05bnZCEwEFvsJT1JqDw8OVwrHFhPvZTLrmz4+WH//Yolvod8H
054PLbqiAjqGHtP8+I+PM+fibtYju6iuIm4BDpidejogJ9G3kEfdRtPwBRpOG0uE
giWwAUUt8wMgxn98hsN8mPQ1wC5kXyn+fIIJm4qVSjlt6EgwoD7cVUDLH7mzLAUb
2YHFlgHh9x531aci7jl6wksLQbzJzZK249aXc96DWYhZMu/XnISHpG3X8O0edE+6
YdTQ66EzTM9oeP+ICcyuLd7GU7bejrFDHEzFJuzpVT/JKmS5LSz2lYf9BEnb7vaC
I2MWQ000n31xeOmbA/y4
=hlKP
-----END PGP SIGNATURE-----

--nextPart22475368.YF0SRY97Zl--


--===============8550129979550240839==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--===============8550129979550240839==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============8550129979550240839==--


Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1MAzPX-0007io-LB
	for ltp-list@lists.sourceforge.net; Mon, 01 Jun 2009 04:46:11 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MAzPS-0007mC-Ry
	for ltp-list@lists.sourceforge.net; Mon, 01 Jun 2009 04:46:11 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Mon, 1 Jun 2009 00:44:47 -0400
References: <4A1E5847.6030807@petalogix.com>
	<200905301816.32273.vapier@gentoo.org>
	<4A22DA33.5050601@petalogix.com>
In-Reply-To: <4A22DA33.5050601@petalogix.com>
MIME-Version: 1.0
Message-Id: <200906010044.48635.vapier@gentoo.org>
Subject: Re: [LTP] Installing outside LTP source
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============7806306363659096917=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: michal.simek@petalogix.com
Cc: LTP <ltp-list@lists.sourceforge.net>, Jiri Palecek <jpalecek@web.de>

--===============7806306363659096917==
Content-Type: multipart/signed; boundary="nextPart1306916.fdI9AzZT9Y";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1306916.fdI9AzZT9Y
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sunday 31 May 2009 15:27:47 Michal Simek wrote:
> Mike Frysinger wrote:
> > On Saturday 30 May 2009 10:28:48 Michal Simek wrote:
> >> Mike Frysinger wrote:
> >>> On Thursday 28 May 2009 05:24:23 Michal Simek wrote:
> >>>> I would to ask you if someone works or worked on moving LTP to Kbuil=
d.
> >>>
> >>> the Subject line doesnt really seem to line up with this question.=20
> >>> what exactly do you want to do and why do you think Kbuild is the
> >>> solution ? saying "let's switch to Kbuild!" without any rhyme or reas=
on
> >>> sounds like a lot of work for no gain.
> >>
> >> I wanted to wrote two emails instead of one - that's why was there 2
> >> different things.
> >> 1. disable compilation "verbose" mode and turn on it with V=3D1.
> >
> > meh.  `make -s` seems to work fine enough for me.  most people arent
> > reviewing the output for warnings and similar issues, so i dont really
> > see much point of having quiet output in LTP.
>
> People don't do it because that warnings are hidden in huge log. It will
> be good to run sparse too.

i dont think sparse is applicable.  it is largely geared towards the polici=
es=20
employed in the kernel.

> >> 2. Move all binaries outside of LTP source code O=3D/path
> >
> > you mean out-of-tree compilation.  you can use lndir to get the same
> > functionality, but it isnt really an optimal method.
> >
> >> 3. I use only some parts of LTP for my testing and it will be good to
> >> enable/disable just tests which you want to use.
> >
> > you can run `make` in only the dirs you care about.  how deep do you
> > actually want to get ?  having Kconfig entries for every single test
> > (i.e. kernel/syscalls/{getsid,pipe}0{1,2} .....) is crazy.
>
> Yes, I agree that make no sense to add all syscalls test for example to
> Kconfig but I can imagine tests for noMMU as are currently wrote in
> Makefile.

sounds a bit arbitrary.  you and i may be interested in nommu, but what abo=
ut=20
other classifications of things people are interested in ?  that'd lead to=
=20
messy kbuild files where tests are arbitrary grouped and the resulting buil=
d=20
system would be just as bad.

> For example will be good for all to know why are some tests exclude for
> noMMU.

i dont see how that's relevant to kbuild.  that info should be documented=20
regardless in the test case itself.

> Maybe any handling for older glibc with missing some syscalls to prevent
> build failure.

that is already handled by autoconf/autoheader, plus kconfig/kbuild has no=
=20
functionality at all to address these issues.

> Setup global cflags and cross compiler.

already handled by autoconf.  integrating into kconfig would be reinventing=
=20
the wheel for no appreciable gain.

> If you look to runtest for testing description, make sense to me have
> all that filenames as Kconfig option and enable/disable that tests.

ive never used/looked at runtest, sorry

> >> 4. If is possible clean all Makefiles
> >
> > dont really know what that means
>
> this point depended on descriptions below. I think we talked about once
> in past.
>
> There are a lot of additions like CFLAGS, LDLIBS.
> CFLAGS +=3D -I../../../../include -Wall
> LDLIBS +=3D -L../../../../lib -lltp
>
> I think that install and clean parts could be possible to clean too and
> have Makefiles with
> one or two lines  like  test-y +=3Dtest_name
>
> Is it possible to do with Kbuild? That the same question as I had in
> previous email.

that can be done right now without any other issue.  create a top level .mk=
=20
file, define topdir in the specific Makefile, and then include it.
topdir =3D ../../../..
include $(topdir)/common.mk

then the common.mk can setup common flags or create automatic clean targets
=2Dmike

--nextPart1306916.fdI9AzZT9Y
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iQIcBAABAgAGBQJKI1zAAAoJEEFjO5/oN/WB62oP/iIq+2mgx4ErX1VfgeWfIQd7
wCDcMMeXTXVYXTQqAnk7wiRFSL48HU+FuVulPhuoQXJK+dArWrAWpbLSQLrkCZKI
BW9KwBmuKX4Xl8+eaaooU2UVJSas6gVjddoWc7vjdIlLv1/tRHow+3P8IturoeB0
ddUzXW1LmfPJuKzlYTXKJ5pjmGRi5xeEqy9Zyy7E+k9yw1xw2cVyrHR9PMdXF/2M
mLZw8hun8JIdJkb88ar2f8BLL7N2oWNeCmi0rpDGTOS6TGm4ENBBcygZlfYWtxEy
PqzW2j60YmN61EGRlBz75oFCagP64XER0GvFbIsYlo9eNFrtKAFo4xSlsIlfTMPQ
pDY8x4gl/qz7NB/p/rSPpdDAuwCuND/qN3x4hCiKunvo3VWwTW1Lr0tnqznXMlAS
hUBBQuBRUY1rUTGe/JG9aCXxgPbEwNajsHOJ5WEo+ySPopQPtd4w5JLWn9CL+LaO
Kv/Gzr0V3OIORH0ykjPjYNQcogCG9TtvgerfldeD9ZiEsWGXAXtKXBqcEulkHJML
MB0bZUe75/AmOeiGpqEZvYpEJ0s728kxrYfms/Vx2yXFe2yaSreCZiO1k4zZBLka
jb4ntR20e6SZZbMvcA9Is1KI1zlfn1/muw0xVIhMEcF9/qU49VRAS9KZ3+gMyraG
c9ly4KfWH3tYboxymByf
=/rW4
-----END PGP SIGNATURE-----

--nextPart1306916.fdI9AzZT9Y--


--===============7806306363659096917==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT 
is a gathering of tech-side developers & brand creativity professionals. Meet
the minds behind Google Creative Lab, Visual Complexity, Processing, & 
iPhoneDevCamp as they present alongside digital heavyweights like Barbarian 
Group, R/GA, & Big Spaceship. http://p.sf.net/sfu/creativitycat-com 
--===============7806306363659096917==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============7806306363659096917==--


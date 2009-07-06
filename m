Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1MNwL6-0001oC-DO
	for ltp-list@lists.sourceforge.net; Mon, 06 Jul 2009 22:07:08 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MNwKo-0005IS-V9
	for ltp-list@lists.sourceforge.net; Mon, 06 Jul 2009 22:06:55 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Mon, 6 Jul 2009 18:06:46 -0400
References: <4A51CEDC.6080605@linux.vnet.ibm.com> <4A51E253.200@st.com>
	<364299f40907061028o4c9c2922ma7d430f5e03f4b38@mail.gmail.com>
In-Reply-To: <364299f40907061028o4c9c2922ma7d430f5e03f4b38@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <200907061806.47824.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH] cgroups: conditionally enable building cgroup
	tests
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1376718806131013943=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: ltp-list@lists.sf.net

--===============1376718806131013943==
Content-Type: multipart/signed; boundary="nextPart1430728.mdWjM9j2a0";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1430728.mdWjM9j2a0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 06 July 2009 13:28:00 Garrett Cooper wrote:
> On Mon, Jul 6, 2009 at 4:38 AM, Francesco RUNDO wrote:
> > I've already fixed the same issue you reported. I've tested it
> > successfully.
> >
> > Subrata has already merged my patch (please, find it in attachment).
> >
> > Please, check it before to submit another patch.
>
> At the end of the day, the real problem is that we're not using the
> --with- functionality in autoconf, e.g. --with-cgroups, and instead
> we're hacking a lot of noise into Makefile's.

selectively compiling groups of code needs to be thought out before we star=
t=20
throwing --with-foo options at the problem.  otherwise we'll still end up w=
ith=20
crap, just in a different form.

> I can tell at first glance that that Makefile is a mess anyhow,
> because it's referencing _hardcoded_ /proc references and as such will
> fail to cross-compile properly if the target or the host are setup
> differently from one another, in the following two scenarios:

yes, the merged patch and that makefile suck.  there should never be any=20
filesystem check in a Makefile anymore.  while peeking in /proc is somewhat=
=20
forgivable, looking for headers never is ok.  we have autoconf tests now an=
d=20
Gowri's approach looks like the correct one.
=2Dmike

--nextPart1430728.mdWjM9j2a0
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iQIcBAABAgAGBQJKUnV3AAoJEEFjO5/oN/WBGNcP/3ZjJR47nPKaOHmrGGeUy8TT
TDSQ/ow3uV1FkwLSr+SG/67GseirXyDnUw4dQFTGvC3/i+wE/HpiB0drYEHqdjsl
8TvuFd32Cy0pZqete2S3W8Ao6dRSQhd3lXozSudIu4DWrJxgEQV2krzlheQhJOek
woR0KW7pG0GEs71hdpXyPv1Oqtw7t4Dxki9fDMSQWSt33U1kvraWpTqd9lTdDItm
YDl8UUs3bEmcHNSwTSs5OrbuPDpdbjoLqdtrgyArOgSQUR18qJLAvGb614ZQn1K2
XmSCWhyszhnc/BGf93bFIJlKiy3b7fS5uJuyaR1z8RFwxB3ABRlFXiJPLrPdwYSD
3aVZoiSSX/qqBBiXKYXAChmzd/rDO7bM8U86YpgkMTOJB76UWJdoBJ/SGl0ZuEx4
Sre3T7FE18KmQ+QkaK+qw9Me+csiXea0wo2o4E+1h9Xmm5VUrat0WowEOfcLb7op
RlqlAIIppxe8+woMtTo53FPUrDP2kW51mmVqF3gRkno0FhemxHCh1D04zVqn/H4o
VU8IZ5AjBMcZOVM2OP4QzGyuH2dzZmzuq1UVHFw/6oHwhGadD3Ly86TsbMaYOkzt
a37Sc8ls1WpqqPQAmFj1tNszrnhdb6mjR1LiY/mkd3xbtQW+z89XdiiCo8mmmy4P
ZCkQK688PckAKN4o40wY
=cSCX
-----END PGP SIGNATURE-----

--nextPart1430728.mdWjM9j2a0--


--===============1376718806131013943==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--===============1376718806131013943==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============1376718806131013943==--


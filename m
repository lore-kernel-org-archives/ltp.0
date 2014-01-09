Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1W1Gcl-000770-7S
	for ltp-list@lists.sourceforge.net; Thu, 09 Jan 2014 14:30:19 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1W1Gck-0006LM-4g
	for ltp-list@lists.sourceforge.net; Thu, 09 Jan 2014 14:30:19 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Thu, 9 Jan 2014 09:30:12 -0500
References: <1387358991.1664.37.camel@G08JYZSD130126>
	<201401090851.42915.vapier@gentoo.org>
	<256751357.13345901.1389276652247.JavaMail.root@redhat.com>
In-Reply-To: <256751357.13345901.1389276652247.JavaMail.root@redhat.com>
MIME-Version: 1.0
Message-Id: <201401090930.13714.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH] clone/clone08.c: check whether clone supports 7
	arguments
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2848990762397727652=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

--===============2848990762397727652==
Content-Type: multipart/signed; boundary="nextPart1655933.lDr60NL6Qy";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1655933.lDr60NL6Qy
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thursday 09 January 2014 09:10:52 Jan Stancek wrote:
> ----- Original Message -----
>=20
> > From: "Mike Frysinger" <vapier@gentoo.org>
> > To: "Jan Stancek" <jstancek@redhat.com>
> > Cc: ltp-list@lists.sourceforge.net
> > Sent: Thursday, 9 January, 2014 2:51:42 PM
> > Subject: Re: [LTP] [PATCH] clone/clone08.c: check whether clone supports
> > 7 arguments
> >=20
> > On Thursday 09 January 2014 08:23:48 Jan Stancek wrote:
> > > ----- Original Message -----
> > >=20
> > > > From: "Mike Frysinger" <vapier@gentoo.org>
> > > > To: ltp-list@lists.sourceforge.net
> > > > Sent: Thursday, 9 January, 2014 2:03:38 PM
> > > > Subject: Re: [LTP] [PATCH] clone/clone08.c: check whether clone
> > > > supports 7	arguments
> > > >=20
> > > > On Wednesday 08 January 2014 09:31:30 Zeng Linggang wrote:
> > > > > +AC_DEFUN([LTP_CHECK_CLONE7ARGS],[
> > > > > +AH_TEMPLATE(HAVE_CLONE7ARGS,
> > > > > +[Define to 1 if clone() supports 7 arguments.])
> > > > > +AC_MSG_CHECKING([for CLONE7ARGS])
> > > > > +AC_TRY_LINK([#define _GNU_SOURCE
> > > > > +		#include <sched.h>
> > > > > +		#include <stdlib.h>],
> > > > > +		[
> > > > > +		#if !defined(__ia64__)
> > > > > +		clone(NULL, NULL, 0, NULL, NULL, NULL, NULL);
> > > > > +		#endif
> > > > > +		],
> > > > > +		AC_DEFINE(HAVE_CLONE7ARGS) AC_MSG_RESULT(yes),
> > > > > AC_MSG_RESULT(no)) +])
> > > >=20
> > > > you aren't really testing for "clone takes 7 args", you're testing
> > > > for "clone has varargs support".  rename the define (and use _ in
> > > > its name), and drop the
> > > > ia64 check as it isn't needed.
> > >=20
> > > Why not? It should matter, according to clone(2) you should be using
> > > __clone2() on ia64: ia64
> > >=20
> > >        On ia64, a different interface is used:
> > exactly.  why does a clone() test have any bearing at all on ia64
> > behavior ? the code that checks the define won't get used in the
> > __ia64__ case, so having
> > a define here is pointless.
>=20
> I thought the check applies to whole ltp_clone, since that is what is
> called by testcases checking this define.

there's debate as to whether that's how we want to take things :).  we'll s=
ort=20
it out there.
=2Dmike

--nextPart1655933.lDr60NL6Qy
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJSzrJ1AAoJEEFjO5/oN/WBj9kP/jwlLPLq1aD2GBvxbq1yBCwq
Z/XaX4YNJhJ9m2udNpZ1HAv7tVlBC5jH5FV6xaMUIRjut3y0y9V7VKm91pUUDjq7
dsblYLvuudJqRVEj+fGjyWsQkagI4hRgQZRUCpo6Wf2RKoCWArDMwXGgeP2+JYvE
gRpoESmcvGJ/nBO5XSN59W7oQ5Vj2FTo2DFpWU+0HuOVWbvuB4OUpHB8dJAeiJml
sapSz+21xdDCFK+ODMYCm1DeCVqJf65WKlU6yB/5dIbT/rXqBESDjdbyV/waNwRH
lEvTciUNZ8wELt3QInUae3HGQELIweTKPV4hipmCn8r1kjeBhDoQMQ0zKvfE09yy
SaxQvL6NqvVMD15h0NWBNrGEpBHrEkRnYMiVg1/GSufEziS5Wj7BhoclwWOULzE0
tcHkH4ZhtRb2775UTSXDKZnPzy+8KgsV37nYGqG2CSbuX392Bit8n+5kh9YEsHZ5
04x8zNXOV1QsCWAAK83jzpCNcP7qgJA/i6Zwz188s70TQG+K69tTTQi/X+/PzAIl
BkkQEqWl44VwWKMSHo4TJP+fVNgit7iUs0MlafKcj+0wIXOwCYemQ/VHfTX0AJAj
7WJTqy4JdksuYK+uSiXyQmWwEhYdB9qJsa3nZa6WWb+NNXSDnkST5h0S7zfmc7GO
8NObS624kYT5/4H02Ayj
=oWGY
-----END PGP SIGNATURE-----

--nextPart1655933.lDr60NL6Qy--


--===============2848990762397727652==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
CenturyLink Cloud: The Leader in Enterprise Cloud Services.
Learn Why More Businesses Are Choosing CenturyLink Cloud For
Critical Workloads, Development Environments & Everything In Between.
Get a Quote or Start a Free Trial Today. 
http://pubads.g.doubleclick.net/gampad/clk?id=119420431&iu=/4140/ostg.clktrk
--===============2848990762397727652==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============2848990762397727652==--


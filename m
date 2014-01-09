Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1W1G1U-0000JH-C2
	for ltp-list@lists.sourceforge.net; Thu, 09 Jan 2014 13:51:48 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1W1G1T-00041p-Lh
	for ltp-list@lists.sourceforge.net; Thu, 09 Jan 2014 13:51:48 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Thu, 9 Jan 2014 08:51:42 -0500
References: <1387358991.1664.37.camel@G08JYZSD130126>
	<201401090803.39606.vapier@gentoo.org>
	<1382348670.13310097.1389273828896.JavaMail.root@redhat.com>
In-Reply-To: <1382348670.13310097.1389273828896.JavaMail.root@redhat.com>
MIME-Version: 1.0
Message-Id: <201401090851.42915.vapier@gentoo.org>
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
Content-Type: multipart/mixed; boundary="===============5144758455385851027=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

--===============5144758455385851027==
Content-Type: multipart/signed; boundary="nextPart2075819.6EvH4igK77";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2075819.6EvH4igK77
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thursday 09 January 2014 08:23:48 Jan Stancek wrote:
> ----- Original Message -----
>=20
> > From: "Mike Frysinger" <vapier@gentoo.org>
> > To: ltp-list@lists.sourceforge.net
> > Sent: Thursday, 9 January, 2014 2:03:38 PM
> > Subject: Re: [LTP] [PATCH] clone/clone08.c: check whether clone supports
> > 7	arguments
> >=20
> > On Wednesday 08 January 2014 09:31:30 Zeng Linggang wrote:
> > > +AC_DEFUN([LTP_CHECK_CLONE7ARGS],[
> > > +AH_TEMPLATE(HAVE_CLONE7ARGS,
> > > +[Define to 1 if clone() supports 7 arguments.])
> > > +AC_MSG_CHECKING([for CLONE7ARGS])
> > > +AC_TRY_LINK([#define _GNU_SOURCE
> > > +		#include <sched.h>
> > > +		#include <stdlib.h>],
> > > +		[
> > > +		#if !defined(__ia64__)
> > > +		clone(NULL, NULL, 0, NULL, NULL, NULL, NULL);
> > > +		#endif
> > > +		],
> > > +		AC_DEFINE(HAVE_CLONE7ARGS) AC_MSG_RESULT(yes), AC_MSG_RESULT(no))
> > > +])
> >=20
> > you aren't really testing for "clone takes 7 args", you're testing for
> > "clone has varargs support".  rename the define (and use _ in its name),
> > and drop the
> > ia64 check as it isn't needed.
>=20
> Why not? It should matter, according to clone(2) you should be using
> __clone2() on ia64: ia64
>        On ia64, a different interface is used:

exactly.  why does a clone() test have any bearing at all on ia64 behavior =
? =20
the code that checks the define won't get used in the __ia64__ case, so hav=
ing=20
a define here is pointless.
=2Dmike

--nextPart2075819.6EvH4igK77
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJSzqluAAoJEEFjO5/oN/WBAhcQALgCE0kU4X3wZ2Fv6+FX+9XM
WnmCt9NYi2Cx0lDsdWBnz28BbRnQ84owLcbYzX66es2V1ItVGgq+irh4sgkoJrfd
9CjGQREP7KvoRfa5JtLnKYgLhJbxPKJ7MmbrDXq/Mn2Gw6uCIk8g8JUXDgQca94+
gJxoBxukVmSdVqFAkt7pK4JVIIiQc/Kd4S4HAfhagjfUUNSRj1aPeDcjQPa3S8a/
GERrNLKiYysrhOuFnuE5TRrkcuRocxbrHg8ZJTziY8KfZqTLrZah2cUGRF+9B6HN
qKiQaEg9Shx0MnBwHjIOa2rBVChXlbdVEsoaLkCntohKfN0wdgz6vzr5UVDEX5Gd
7WqXgJjmSiXQB3PcsrVOOb61gyPQs6hcGBUwnCik1nnaKUCC6BGgiZ3wLL3U22Zh
opAoWHz7MBr/DX38g+K8FrMX25vfkVU9jJQ2yS5L2GZr7NptHU6/3Ff4is71TIWy
bMTACbi5k6HCkQ682ZX60GIKFSbtykN0CqEpjsmGvcChltsM23OwcX4IN75DHEpj
QMYwxmF283ATaijom1SZChOY/IcOBsDDED75nDS3Uv3aGIFgoFQDxd8uUfoRqpnt
xPihlCmr+UQszI/E7isSPtHnnllyHXtgddStHjjr+yXYKlgHK/cBnISJ5ifTQfEy
ONveYpV3vfFM+INH+EVz
=2MVG
-----END PGP SIGNATURE-----

--nextPart2075819.6EvH4igK77--


--===============5144758455385851027==
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
--===============5144758455385851027==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============5144758455385851027==--


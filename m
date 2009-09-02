Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1MiwJx-0001eI-5I
	for ltp-list@lists.sourceforge.net; Wed, 02 Sep 2009 20:20:45 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MiwJs-0000p1-Fo
	for ltp-list@lists.sourceforge.net; Wed, 02 Sep 2009 20:20:45 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Wed, 2 Sep 2009 16:13:38 -0400
References: <20090902141027.GA13905@us.ibm.com>
In-Reply-To: <20090902141027.GA13905@us.ibm.com>
MIME-Version: 1.0
Message-Id: <200909021613.39566.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH 1/1] Containers: Pass a valid stack address to
	clone
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0227509990708839906=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: Subrata Modak1 <subrata.modak@in.ibm.com>, Nathan T Lynch <natlynch@us.ibm.com>

--===============0227509990708839906==
Content-Type: multipart/signed; boundary="nextPart2459092.fnQumbBiUx";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2459092.fnQumbBiUx
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Wednesday 02 September 2009 10:10:27 Serge E. Hallyn wrote:
> Also fix the libnetns helper to, like the libclone one, special-case
> hppa and pass the bottom of the stack to clone2 for __ia64__ (as per
> the libclone example and the clone2 manpage).  I don't know and can't
> test whether it's right, but have to assume that one of the other was
> wrong.

please, let's stop screwing around with this and copying & pasting it=20
everywhere.  create a new dedicate "ltp_clone" or similar function and stic=
k=20
the arch-specific logic there.
int ltp_clone(func ptr, stack base, stack size, clone flags, func args...)
=2Dmike

--nextPart2459092.fnQumbBiUx
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iQIcBAABAgAGBQJKntHzAAoJEEFjO5/oN/WBnCcQAJ087onZpq9udKjUMLGzozyu
5xV10Bc9DtaSih5jfH/8EsEEnpSa4QrXpgz67EV5itchRelvt+yQ9bGZHRUgiyj6
tOqa0WIf82vMfYpVGgopdzavR97cKvXdjemyhLahKNdzvXBim1Kt/mFEYAiwXIxh
arfP/TZoQkXZ9k6m6IH2sF5YmQU5DIqZDMEy+0Kizwv5mkAa4oue1wB/HHxI5u/v
OInRUeCfhN2U7wsdGKihNSlbFrue/j1P6E5Q24OAtc1tbbvXJFKICSQCLChRXbun
771Yg3Z5SbOUzWLEB/JtVfFpEkMj5uN95ntpKrLvmecr2NE4320VPqAJ+Q/01+A6
WyEeGxhAhW3tUiYWimOf70FyyGx4wgYpiN/rp+gGV+DTV3/iMGHhIVFtR65Tqnpr
9DTYv/QqXyLmL70qCebT8le/BgnmMDuTrteT63t9nVUX1zd8BdNGGslbxnqUutH3
50hSPkkxOMFAjB/rTNl3B2J4PboEYqAr0yv3K8JzNekqIBnBz0zhfyBOqFP8o1gu
TeezthSTpfLGgq5jtyQYOpNhqgQ14VTgNMJRRGBJWJj6ZrkfCLtdMSGAE0kdhSYk
Of7sr/2MvCpk4x4I56n1rQ6Vp9xzUqjUfBQmnDllnSlh+oBFqaJvHGAEqfcYp8HL
Jif4KKG8nQDAWsCx5u+s
=q8qX
-----END PGP SIGNATURE-----

--nextPart2459092.fnQumbBiUx--


--===============0227509990708839906==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--===============0227509990708839906==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============0227509990708839906==--


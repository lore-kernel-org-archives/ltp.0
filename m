Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1MOgUl-0002ZW-0y
	for ltp-list@lists.sourceforge.net; Wed, 08 Jul 2009 23:24:11 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MOgUf-00041g-NF
	for ltp-list@lists.sourceforge.net; Wed, 08 Jul 2009 23:24:11 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Wed, 8 Jul 2009 19:24:07 -0400
References: <364299f40907061602v3d05964cq31150d97eab75daa@mail.gmail.com>
In-Reply-To: <364299f40907061602v3d05964cq31150d97eab75daa@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <200907081924.08439.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH 2/3] Make system enhancements, Draft 1
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0697314608136187966=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============0697314608136187966==
Content-Type: multipart/signed; boundary="nextPart2106507.LsgAeUC2Ri";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2106507.LsgAeUC2Ri
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 06 July 2009 19:02:50 Garrett Cooper wrote:
> 1. Write up a document on how to use the new Make system
> (README.mk-devel), so others may assist in the work that we're
> spearheading at Cisco and contributing back to LTP, and we can begin
> dropping the adhoc Makefiles.
> 2. Add master_rules.mk which contains canned rules for environment
> setup, leaf directories, and trunk directories to reduce Make logic
> noise in the existing LTP Makefile's. This is a more condensed and
> straightforward version of the original master_rules.mk file
> contributed and never integrated into LTP in the past.
> 3. Add master_include.mk, a file which stands as the defacto include
> Makefile for all . This was created out of the comment provided by
> Mike Frysinger w.r.t. a master include file.
>
> Note: This patch has been largely tested, but some of the additional
> functionality and rework in generic_trunk_target needs to be tested
> more prior to commit; hence it's a Draft 1 patch.

"srcdir" should refer to the current directory's source tree.  "top_srcdir"=
=20
should refer to the top level source tree.  building in-tree means srcdir w=
ill=20
be ".".  this is how autotools works and allows for easy out-of-tree=20
compilation.  same goes for "builddir" and "top_builddir", not this "objxxx=
"=20
convention.

for the toolchain, do you purposefully only document CC and CFLAGS ?

i'm not familiar with this "MAKEOPTS=3D';'" thing you refer to.  what's tha=
t all=20
about ?

you list the copyright info twice

master_rules.mk shouldnt be a '-include' ... we want an error if that doesn=
t=20
exist

your %.a rule is missing a call to ranlib on the archive
=2Dmike

--nextPart2106507.LsgAeUC2Ri
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iQIcBAABAgAGBQJKVSqYAAoJEEFjO5/oN/WBQ2wP/ia4SYkyaNc4g7dHivt38PNy
MFNQlLcSfD4uNjblMTyPWVmV1gO/ehQjrj2oPEVM0R4uRYi0NiQiOtnoDE9cqWun
uRzaNFeItAQxOtp5tLZrRGdJYMCkhYGioZXnOiIr9y44x74NONT8f0EHcnXblsHe
qcGw+iaHBQutJT4vukNkzCvS0knZiTsSXYsWvCxsGXPcr5jKTv03JhysgC9DiFKS
zSyOw1iCdXVkthgrTITEW+YZqSgvspTAqqcgo0tfJG4EmCNkX/1b4kuycOyScPXT
gT77Rk8tqQjZqdzLe6eyZO//pXQ6klFoo0VhB/4HWhaCrAN3UkfK9mFBBfibHr/h
PeSiLOLhsqrHAvaydbhL2WhJpT5qQY1adCU6jhsrRN4lOab5YnhcN2YyFG28Tupq
Qv+Ll3DuE3+wYAW+gB6JLawL3iZn9iCxf0uU5IPBuxIrVSoG8nndS77BnOaKa+X2
GJjTUqyyiEp51hEdw1447CJZIxK+OdOUq3Als3ugTNyjIblesWARlkexYidiQLHM
MD7raPdRKq/tWtJ9/KFNV3mii4ghLDVwLzBXb/rLSGQtGjx2Y5F2FbuPuOj9TiKv
3K5I/xa2tHfpA2rj8iLFrTNy8wpAHxZX9n7byTDdOCRIMTCgmlse+QfVYfSdv5J/
EwjdEY8+J5N6XX1OozQY
=f19H
-----END PGP SIGNATURE-----

--nextPart2106507.LsgAeUC2Ri--


--===============0697314608136187966==
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
--===============0697314608136187966==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============0697314608136187966==--


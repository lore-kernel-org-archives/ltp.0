Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1MfPd9-0001j0-Gg
	for ltp-list@lists.sourceforge.net; Mon, 24 Aug 2009 02:49:59 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MfPd3-000065-Mq
	for ltp-list@lists.sourceforge.net; Mon, 24 Aug 2009 02:49:59 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Sun, 23 Aug 2009 22:49:44 -0400
References: <20090824.012723.112609532.caiqian@cclom.cn>
In-Reply-To: <20090824.012723.112609532.caiqian@cclom.cn>
MIME-Version: 1.0
Message-Id: <200908232249.46097.vapier@gentoo.org>
Subject: Re: [LTP] What is the Story of "make autotools"
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5112596443260848284=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============5112596443260848284==
Content-Type: multipart/signed; boundary="nextPart1862356.fj4DtxQ3KK";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1862356.fj4DtxQ3KK
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Sunday 23 August 2009 13:27:23 CAI Qian wrote:
> $ make autotools
> make: *** No rule to make target `m4/Makefile.am', needed by
>       `m4/Makefile.in'.  Stop.

that file is in cvs.  if you have an incomplete checkout, there's nothing w=
e=20
can do about it.
=2Dmike

--nextPart1862356.fj4DtxQ3KK
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iQIcBAABAgAGBQJKkf/KAAoJEEFjO5/oN/WBYvgQAN3qLVcqTu5+XrnM4aJmm9Un
b0WSIHY/yHCeTZhGg8GPOQBPrlTadKfMX0eYojixwPLfXWgBq+JPfnVRpAg1kf1x
4tcXVruJMJ1hx4LhDAQXtfdyreYjotYCv6CecjTZhO0NtbI+ArWC4eCJwp9XJCr6
XIlOEmV2yf6pHFKe9nwkwVNOALK8oV5OJhDUBR4RS+YbZMDZD+50c6+dktdnkTWn
pnCv8YJ+hDPeMWzbU4hM61c8L159I7veZfXgEVDrdlLi/VBvRQhV/Gm3oxMV9DQy
ntKWZg6kWXinOpOd5yo315Fdt6RQGfpr5X5byACV0wgCypOdINpRpgaEAtDw1syZ
6RpqV9uHt8vE4tcWX1p3IwogRhpoDroR46YoDIskd+yD/PQBWMhM0u+qbN2/RHki
yBJzh222cFVT8608xm0xsfgJebk1okzYhWobU/Qx7pS9nA3sczmA891WYoPm6MP/
SoDN9z5JCrgcA/8YuDvUffR4RDvkj5aWx+SnkNerAZPFW9FrJoTUkwsM65P+s+Eo
CFAXXDmuaBPgf0ptsIjCcxXmf0y3Ae0whhQO/0Qg+BxZYeSof+exMtl/7LDOXt5r
eqOMgO3OS33YYHyjYgNd1pF6wqEPzjVVQ6gRZZn0M3VOJ0h4gaJ0Pr0VwKeDuQoh
ri/MHdVMoyBF4Sb1LHWO
=cuZ2
-----END PGP SIGNATURE-----

--nextPart1862356.fj4DtxQ3KK--


--===============5112596443260848284==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--===============5112596443260848284==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============5112596443260848284==--


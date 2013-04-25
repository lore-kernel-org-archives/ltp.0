Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1UVBVH-0007KA-3W
	for ltp-list@lists.sourceforge.net; Thu, 25 Apr 2013 02:01:43 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1UVBVG-0000kP-5L
	for ltp-list@lists.sourceforge.net; Thu, 25 Apr 2013 02:01:43 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Wed, 24 Apr 2013 22:01:29 -0400
References: <5177684F.7060204@cn.fujitsu.com>
	<201304241207.31644.vapier@gentoo.org>
	<20130425011303.GB30114@us.ibm.com>
In-Reply-To: <20130425011303.GB30114@us.ibm.com>
MIME-Version: 1.0
Message-Id: <201304242201.31244.vapier@gentoo.org>
Subject: Re: [LTP] question about a license
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0291047345290918814=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: James Takahashi <takahash@us.ibm.com>
Cc: ltp-list@lists.sourceforge.net, wboyer@us.ibm.com

--===============0291047345290918814==
Content-Type: multipart/signed; boundary="nextPart8557961.JgqQgoh0UP";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart8557961.JgqQgoh0UP
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Wednesday 24 April 2013 21:13:04 James Takahashi wrote:
> On Wed, 24 Apr 2013 12:07, Mike Frysinger <vapier@gentoo.org> wrote:
> > On Wednesday 24 April 2013 05:32:56 chrubis@suse.cz wrote:
> > > > When trying to cleanup syscalls/getitimer03.c, i meet a strange
> > > > license. It says:
> > > >=20
> > > > *******************************************************************=
**
> > > >=20
> > > > /*
> > > >=20
> > > >  * $Copyright: $
> > > >  * Copyright (c) 1984-2000
> > > >  * Sequent Computer Systems, Inc.   All rights reserved.
> > > >  *$
> > > >  * This software is furnished under a license and may be used
> > > >  * only in accordance with the terms of that license and with the
> > > >  * inclusion of the above copyright notice.   This software may not
> > > >  * be provided or otherwise made available to, or used by, any
> > > >  * other person.  No title to or ownership of the software is
> > > >  * hereby transferred.
> > > >  */
> > > >=20
> > > > *******************************************************************=
**
> > > >=20
> > > > Here is my question,
> > > > 1. Can i change this license to GPL2? or
> > > > 2. Can i modify code of the case under this license?
> > > >=20
> > > > Could you please provide me any pointer/suggstion. :)
> > >=20
> > > Given that the testcases is a few lines that calls getitimer() with
> > > invalid value, I would play safe and rewrite it from scratch.
> > >=20
> > > Anybody has different opinion?
> >=20
> > there are four such files:
> > 	testcases/kernel/syscalls/getitimer/getitimer03.c
> > 	testcases/kernel/syscalls/getresgid/getresgid01.c
> > 	testcases/kernel/syscalls/nftw/Makefile
> > 	testcases/kernel/syscalls/nftw/nftw64.h
> >=20
> > the Makefile has at least be rewritten enough that i think we can change
> > things as the code has largely been written by Garrett Cooper now
> >=20
> > if we can't locate someone (Wayne Boyer?) for the tests, i suggest
> > looking at what they test (just read the comment block), then delete the
> > file and write a new test from scratch.
> >=20
> > the header file i think might be accidental as none of the nftw files
> > look that way.  instead, they have the ibm copyright.  so i'd just
> > change it to that. -mike
>=20
> Wayne is still at IBM (Sequent was acquired by IBM).  I have CC'd him
> on this thread.
>=20
> If you'd elaborate on what sort of permission/assistance you need for
> this copyright issue, I'm sure Wayne would be happy to cooperate.

the code says Wayne wrote it.  if Wayne can confirm that, and if he can con=
firm=20
that we want to change the copyright to the standard ibm ones (found in man=
y=20
other files) and license it similarly.
=2Dmike

--nextPart8557961.JgqQgoh0UP
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJReI57AAoJEEFjO5/oN/WByVEP/izx5gmxHuAPUhEnZ2Akf4cd
41kzTt9ZeW7F0w6IsKx8d7CAuqDF4VvMKpNEuuk3in9qMT8wG/r24acxmk5I08WN
ZN77fvW5lGhGhXYK9Z4hyUaAN+mDJEqrRnaqSzYrU5N7DFG2awgQjnwhIo2B+pK3
Nywy6I9SGT2wBktiumOfV6LfNUmXzZMNPQJsAkwMJm/+NWIGJqCa8LBNDNInBrod
i2eUy43AuLcap6WXuPCYhEsdrI/EV8sdzU6YfF6fqRMEhJ01bwPJwMN7ecslhz+F
aqqNzSLdhGcV9lJNhrD/RZ2jGmFdXGZR1kQSnjejL5nGibosqQUQ7tiAFsJ/J9Ai
Wv3nrnqnxbr9kVXaC23Td7FgYlmRqD2228Sp3rlFFVu1hSpSGcUI54k66jX6mro/
1lNkHiL76yEEZp1DwslyJZyH/Zk0SuYeQ5l4/n/rGEo+pdcOGfu5Ey2cX60FbqE8
mm7/EwLH6yP9OLBynNPt5Rb2M7e8hJ5IIDqb+W8rWQW/6W7Ja4Q0IeTUYWvgvBf/
45/79ZsM808bwWf34pXqJ/kN8tk38l7KB/bugvuQ7qAl7yueCHavX+5idJOKMhYq
uc1FN1Y3/tH7/uVO52dZkttdxG6uWVsOy9IpMfMFilwcZ+rsGtaQQaOEAn6tKoN8
Iq4dqpJIlLD5uku1Tbu7
=nNPc
-----END PGP SIGNATURE-----

--nextPart8557961.JgqQgoh0UP--


--===============0291047345290918814==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Try New Relic Now & We'll Send You this Cool Shirt
New Relic is the only SaaS-based application performance monitoring service 
that delivers powerful full stack analytics. Optimize and monitor your
browser, app, & servers with just a few lines of code. Try New Relic
and get this awesome Nerd Life shirt! http://p.sf.net/sfu/newrelic_d2d_apr
--===============0291047345290918814==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============0291047345290918814==--


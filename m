Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1UVykE-0002rX-SO
	for ltp-list@lists.sourceforge.net; Sat, 27 Apr 2013 06:36:26 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1UVykD-0007DV-Tb
	for ltp-list@lists.sourceforge.net; Sat, 27 Apr 2013 06:36:26 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Sat, 27 Apr 2013 02:36:24 -0400
References: <OF9DB4E12A.D5B7A192-ON88257B58.0013E63A-88257B58.0013F584@us.ibm.com>
	<5178A940.7070807@linux.vnet.ibm.com>
In-Reply-To: <5178A940.7070807@linux.vnet.ibm.com>
MIME-Version: 1.0
Message-Id: <201304270236.26744.vapier@gentoo.org>
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
Content-Type: multipart/mixed; boundary="===============5455563720945704466=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Wayne Boyer <wayneb@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net, takahash@linux.vnet.ibm.com

--===============5455563720945704466==
Content-Type: multipart/signed; boundary="nextPart4845662.o6DXXd2VFV";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart4845662.o6DXXd2VFV
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Wednesday 24 April 2013 23:55:44 Wayne Boyer wrote:
> Mike Frysinger <vapier@gentoo.org> wrote on 04/24/2013 07:01:29 PM:
> > From: Mike Frysinger <vapier@gentoo.org>
> > To: takahash@linux.vnet.ibm.com,
> > Cc: ltp-list@lists.sourceforge.net, Wayne Boyer/Beaverton/IBM@IBMUS
> > Date: 04/24/2013 07:01 PM
> > Subject: Re: [LTP] question about a license
> >=20
> > On Wednesday 24 April 2013 21:13:04 James Takahashi wrote:
> > > On Wed, 24 Apr 2013 12:07, Mike Frysinger <vapier@gentoo.org> wrote:
> > > > On Wednesday 24 April 2013 05:32:56 chrubis@suse.cz wrote:
> > > > > > When trying to cleanup syscalls/getitimer03.c, i meet a strange
> > > > > > license. It says:
> > > > > >=20
> > > > > > ***************************************************************=
**
> > > > > > ****
> > > > > >=20
> > > > > > /*
> > > > > >=20
> > > > > >  * $Copyright: $
> > > > > >  * Copyright (c) 1984-2000
> > > > > >  * Sequent Computer Systems, Inc.   All rights reserved.
> > > > > >  *$
> > > > > >  * This software is furnished under a license and may be used
> > > > > >  * only in accordance with the terms of that license and with t=
he
> > > > > >  * inclusion of the above copyright notice.   This software may
> > > > > >  not * be provided or otherwise made available to, or used by,
> > > > > >  any * other person.  No title to or ownership of the software
> > > > > >  is * hereby transferred.
> > > > > >  */
> > > > > >=20
> > > > > > ***************************************************************=
**
> > > > > > ****
> > > > > >=20
> > > > > > Here is my question,
> > > > > > 1. Can i change this license to GPL2? or
> > > > > > 2. Can i modify code of the case under this license?
> > > > > >=20
> > > > > > Could you please provide me any pointer/suggstion. :)
> > > > >=20
> > > > > Given that the testcases is a few lines that calls getitimer() wi=
th
> > > > > invalid value, I would play safe and rewrite it from scratch.
> > > > >=20
> > > > > Anybody has different opinion?
> > > >=20
> > > > there are four such files:
> > > >    testcases/kernel/syscalls/getitimer/getitimer03.c
> > > >    testcases/kernel/syscalls/getresgid/getresgid01.c
> > > >    testcases/kernel/syscalls/nftw/Makefile
> > > >    testcases/kernel/syscalls/nftw/nftw64.h
> > > >=20
> > > > the Makefile has at least be rewritten enough that i think we can
> > > > change things as the code has largely been written by Garrett Cooper
> > > > now
> > > >=20
> > > > if we can't locate someone (Wayne Boyer?) for the tests, i suggest
> > > > looking at what they test (just read the comment block), then delete
> > > > the file and write a new test from scratch.
> > > >=20
> > > > the header file i think might be accidental as none of the nftw fil=
es
> > > > look that way.  instead, they have the ibm copyright.  so i'd just
> > > > change it to that. -mike
> > >=20
> > > Wayne is still at IBM (Sequent was acquired by IBM).  I have CC'd him
> > > on this thread.
> > >=20
> > > If you'd elaborate on what sort of permission/assistance you need for
> > > this copyright issue, I'm sure Wayne would be happy to cooperate.
> >=20
> > the code says Wayne wrote it.  if Wayne can confirm that, and if he
> > can confirm
> > that we want to change the copyright to the standard ibm ones (found in
> > many other files) and license it similarly.
>=20
> I looked at the four files in question.  I did write getitimer03.c and I
> believe using the standard IBM copyright is correct.
>=20
> I ported the getresgid01.c code to run under Linux.  As I recall it was
> originally a Sequent test case for the Dynix/ptx OS.  Again I believe
> using the standard IBM copyright is correct.
>=20
> I did not work with the last two files, but they follow the same pattern
> as the getresgid01.c code.  There were originally part of the Dynix/ptx
> test cases.

thanks!  that was much quicker than i expected :).  i've adjusted all the f=
iles=20
in the latest git repo now.
=2Dmike

--nextPart4845662.o6DXXd2VFV
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJRe3HqAAoJEEFjO5/oN/WBlXIQALt+cm86IgRtCdHGUtMOe9+9
1HKHDupYCA1nNEKjnpJLyYla2KtjPSV+WZlTHkLrhh+gGmkiH7ZXIGreN5JPgXnT
OxpNcficwWGCVJUCZQZYRcHzRQEeL6OjIGrl6GQeuYE//++oJs1pCqniqlCp3rDi
/OiAfnIWqg6zY9Xui8790xdfeowLCp7IIbXiQ3KOLDA0CO+YDdLPperFiB9SwShz
7hAdAS4OHRA0IflYISew1W0ETMVx79poIQujI8nLXsY2X/ssT4jq+czq3/9ihFhe
ZEXE8wulaJLbALdXNvj+ksZWa45n0ypqFHVJbBNyVf0gPorEvJ8Jbk0A/gRgOY+I
Bb7Mtq0z7f+dHi+NOIsUJ63WV8YKX9+cdxYXjKHUh21P/qlByir/JMUAaSqpoLa0
3cs9pYgMwNJR8XmOd2hCwNJrRrrZVeLrysAptDHgTsMBXGdfT/uS1JaaSGTYc1cI
VdYfHbYXBrU8GwtCm5AN/9lHjNyODNPkG3TY8Us437bdwKmcvzx/R+DMvHZYu6aK
AJG+tY2IS46bs9IV+KdN1n0aImaSYso5Ru/UE3+DXN3qGzysjlglkKlUdqWAP9PK
ltdGjPnELd35cc3DqVLZsa85Fl/pT2hC+w3rG3A8cc8Pr4Lxn/FHjJ0VyuUazchl
jjypKkC3AGW4Z5N33eu+
=ksZw
-----END PGP SIGNATURE-----

--nextPart4845662.o6DXXd2VFV--


--===============5455563720945704466==
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
--===============5455563720945704466==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============5455563720945704466==--


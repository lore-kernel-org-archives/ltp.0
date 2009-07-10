Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1MPGk0-0005gR-O4
	for ltp-list@lists.sourceforge.net; Fri, 10 Jul 2009 14:06:20 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MPGjv-0006xx-Qi
	for ltp-list@lists.sourceforge.net; Fri, 10 Jul 2009 14:06:20 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Fri, 10 Jul 2009 10:06:12 -0400
References: <200907090303.22607.vapier@gentoo.org>
	<1247222795.6630.28.camel@subratamodak.linux.ibm.com>
In-Reply-To: <1247222795.6630.28.camel@subratamodak.linux.ibm.com>
MIME-Version: 1.0
Message-Id: <200907101006.13796.vapier@gentoo.org>
Subject: Re: [LTP] [rfc] extend test type field with tst_* functions
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============8083074721158717922=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: subrata@linux.vnet.ibm.com
Cc: LTP <ltp-list@lists.sourceforge.net>

--===============8083074721158717922==
Content-Type: multipart/signed; boundary="nextPart9604662.2TzOEIag3P";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart9604662.2TzOEIag3P
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 10 July 2009 06:46:35 Subrata Modak wrote:
> On Thu, 2009-07-09 at 03:03 -0400, Mike Frysinger wrote:
> > the perceived problem: many many tests duplicate errno display and
> > they do so inconsistently.  many times the display is crappy and a lot
> > less helpful than it could & should be.  a test should merely have to s=
ay
> > "include the errno in the test output" so it can focus on its own detai=
ls.=20
> > much like the multitude of C library functions out there like perror() =
or
> > printf's %m.
> >
> > the proposed fix: extend the first argument to (1) take a define for
> > the test result and (2) also accept optional bit fields to further
> > manipulate the output.  the advantage here is we dont have to add a who=
le
> > lot of helper functions to complement the existing ones.  i.e. a new
> > tst_resmp() that would behave like tst_resm() but also append the errno
> > output.
>
> I like this idea. Very few comments:
>
>      1. The new patch does not show the implementation of tst_resmp(),

my point was that things like tst_resmp() are not the way to go but instead=
 we=20
should use the first argument as an optional bit field.  which is what my=20
patch implements.

>      2. If there are changes on this regard, the corresponding
>         information should be updated in ltp/doc/man3/tst_res.3,

thanks, i wasnt aware of this
=2Dmike

--nextPart9604662.2TzOEIag3P
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iQIcBAABAgAGBQJKV0rVAAoJEEFjO5/oN/WBzp0P/jTg2dDORq5DA8ivxsFvj7An
dp6HIHKcOUkLdwNPKDKmWzTTgm4drjlxNDHerhwx++J2VYb/7dIV6stkK19shLWu
ZiTs8eifAgKSlKCB7bJDX+ovk4Mkybgpo+jbhOsYaJRqBxz/YpJnmFGKUfciJu8Y
aPDKCU9Ip1cD3TBhagdYY5hnyIX9kmD2Zrtw6Rh9gwavz3tZt4H8lYX8Li0XyyhI
o+urQEluk7T1UHayUePRzaSlpzomqPBhZLAXnIqOozZVJtrfgcEj8aiIR0uLlnqT
+9tf+rTx8jJoRwblknXM4bQSQPFDaD8UI4gmGv8L1oD/P4fdlbq8NBuo9YP2lYsm
PIAPyenuEfIkwtM1fyop2rfczNw3y/J+mqtLzLqCbHff7UY2SGcYcA7gyipJTCEv
Bh4qNhsGYZGVnHLdlt1dQOa+ujcHXOw64QcNwyUYxLvWIsq0piQt3XTeW9z7LkFj
HFcK48j7Z8fJjRuz+x6g/wVVzNvPSLNs5lwSczVnwv9wh68Uh9OhO0o52Y5vYzl8
74ghXFI4/ZSKvXhRSdHzfdKfMBcRrheu5eqk/U9vnu2Up17x59lfeirfnRFhxsB8
Y6PUDkp85xo6VBvLeHalt1pegnh+83EOQmm1ljbeZw4qffSCDjqe2x64W5ku281A
gGLZboSf6488duGja0s1
=GqSm
-----END PGP SIGNATURE-----

--nextPart9604662.2TzOEIag3P--


--===============8083074721158717922==
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
--===============8083074721158717922==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============8083074721158717922==--


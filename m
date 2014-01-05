Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1VzwDE-0003qf-Ie
	for ltp-list@lists.sourceforge.net; Sun, 05 Jan 2014 22:30:28 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VzwDD-0001lJ-J1
	for ltp-list@lists.sourceforge.net; Sun, 05 Jan 2014 22:30:28 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Sun, 5 Jan 2014 17:30:24 -0500
References: <1386937862-12687-1-git-send-email-markos.chandras@imgtec.com>
	<201312160158.02840.vapier@gentoo.org>
	<52B43BDD.7080304@imgtec.com>
In-Reply-To: <52B43BDD.7080304@imgtec.com>
MIME-Version: 1.0
Message-Id: <201401051730.25397.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH v2] utils: sctp: Fix build for prefixed
	architectures
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============3306084574157214342=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Markos Chandras <Markos.Chandras@imgtec.com>
Cc: ltp-list@lists.sourceforge.net

--===============3306084574157214342==
Content-Type: multipart/signed; boundary="nextPart8538867.RamLi3LURd";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart8538867.RamLi3LURd
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Friday 20 December 2013 07:45:17 Markos Chandras wrote:
> On 12/16/2013 06:58 AM, Mike Frysinger wrote:
> > On Friday 13 December 2013 07:31:02 Markos Chandras wrote:
> >> Commit 6f22494d19b605ded308dc0fa713e91cb873f44a
> >> "Move sctp to utils and bump it to 1.0.15"
> >>=20
> >> introduced a build failure for the prefixed architectures.
> >> We need to take into consideration the __USER_LABEL_PREFIX__
> >> for architectures that define it when creating symbol aliases.
> >>=20
> >> The following upstream patch (0600c8968cc2dea04cbf13ec739216e2939d08fe)
> >> fixes the build for the Meta(metag) architecture
> >>=20
> >> [...]
> >> utils/sctp/func_tests/test_connectx.c:151: undefined reference to
> >> `_sctp_connectx' utils/sctp/func_tests/test_connectx.c:163: undefined
> >> reference to `_sctp_connectx' [...]
> >>=20
> >> Build tested on x86_64 and metag.
> >=20
> > we really should fix this instead by not using any symbol renaming.=20
> > symbol versions might make sense when dealing with a released project
> > and a stable shared library API, but it makes no sense in LTP.
> >=20
> > perhaps better to have a compile time knob to disable it all ?
> > -mike
>=20
> Well whatever works best. Personally I would avoid deviating from
> third-party code unless it's really necessary.

sure, but i'm not sure this change covers everything

there's still:
extern int sctp_connectx_orig (int)
    __attribute ((alias ("__sctp_connectx")));

i vaguely recall gcc doesn't add symbol prefixes to the alias attribute.  t=
he=20
documentation implies that too:

The alias attribute causes the declaration to be emitted as an alias for=20
another symbol, which must be specified. For instance,
          void __f () { /* Do something. */; }
          void f () __attribute__ ((weak, alias ("__f")));
defines =E2=80=98f=E2=80=99 to be a weak alias for =E2=80=98__f=E2=80=99. I=
n C++, the mangled name for the=20
target must be used. It is an error if =E2=80=98__f=E2=80=99 is not defined=
 in the same=20
translation unit.

since this still needs fixing upstream, might be a good time to also includ=
e a=20
knob to turn this crap off entirely ? :)
=2Dmike

--nextPart8538867.RamLi3LURd
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJSyd0BAAoJEEFjO5/oN/WBAeoQAIglppaUlx0T1XpCjw2pRvwc
mZeH9SQSqL295xsdwIdnKAzjVAYCMe7c/YRDy4NH/5bpqAyXSR4yFe/ArdCR2tKS
6ZLE6vALE9iQ5gYGMfOoAnY0Id0Nfq8G2fCgIEORApQs0vdK/vKywXVHTwZMeoM+
n0wgUOKJ7oN2OD11KJ5cH31z+yhobh/p7DoEvRSlrItRZwNFjiBF7i3w4URV6SFB
0ox1fQ+mXGcBZigJ1xWHXRAv3wfgrbuj52LBFgZa13f85WH6Ubi9eo+FA1ju4Q2q
2xbc+gAKuk5k2oa2NKCCeyHgjimqjnTO0oEAznyOSY5j+F1chRNydPzKLi9x9U+s
frSYVCV0bgjkPJj+uKEGcZpmuJ3dWDcjvvLXphQlYu917t+Y0AxWjbliutzn+099
1Amd+AmOZfvJCARHyph7vdp55fKET8yJt7QRPfowT1VBzW4GXbo572xQhwvbqK7+
EytkyHvE21dfstHYXDFXMbpJTETb8Oj3eQrhvKiTEO7dZWuw0c33xPRxb0FTtBA9
cyzFFgllqh2jniccsjRzoc5O2dr8B8bRlv5joHQbU5l5cbwVc6WGbZzYz9HG6wud
5TKRXYXjqIKmK4eD/PA9ZjP277besbFgwXtI3Z2QSRNdNQ8Hqx/q9rtv79ypGHa+
wYPCMZOkJdSYTksuHxJN
=CX8H
-----END PGP SIGNATURE-----

--nextPart8538867.RamLi3LURd--


--===============3306084574157214342==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349831&iu=/4140/ostg.clktrk
--===============3306084574157214342==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============3306084574157214342==--


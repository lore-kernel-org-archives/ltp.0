Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1Mwl0T-0004ei-NQ
	for ltp-list@lists.sourceforge.net; Sat, 10 Oct 2009 23:05:45 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Mwl0N-000244-6Z
	for ltp-list@lists.sourceforge.net; Sat, 10 Oct 2009 23:05:45 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Sat, 10 Oct 2009 19:05:31 -0400
References: <364299f40910091048w54ece725l2b07a04bb82f6a4f@mail.gmail.com>
	<364299f40910101502l19472085v233d75751e1badb6@mail.gmail.com>
	<364299f40910101530t3be5d6d8i5e530c5137d923b8@mail.gmail.com>
In-Reply-To: <364299f40910101530t3be5d6d8i5e530c5137d923b8@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <200910101905.32534.vapier@gentoo.org>
Subject: Re: [LTP] mixing of install/build targets
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============3990426066114333991=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

--===============3990426066114333991==
Content-Type: multipart/signed; boundary="nextPart1459631.uFjO8PtUsW";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1459631.uFjO8PtUsW
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Saturday 10 October 2009 18:30:11 Garrett Cooper wrote:
>     I just changed it so it won't do this anymore, but what I need to
> know exactly is how do you intend to do submakes, e.g. do you intend
> to manually compile the library, NOT do the install, then go to a
> subdir, run make all, and that's it?
>     make install (IMO) still needs $(prefix) to be defined to a sane
> setting, so it's now only a requirement for install.

requiring install-related variables to be sane in order to do `make install=
`=20
is fine (i.e. prefix/etc...).  but that is the only time install related=20
variables should be needed/consulted.

when you compile a package (i.e. run `make`) regardless of this being done =
at=20
the toplevel or a subdir only, the build process should never need anything=
=20
ltp related outside of the source tree (so i'm not talking about libcap or=
=20
whatever, just libltp).  this is the expected behavior for all packages out=
=20
there, not just ltp.

one reason for why this is a bad idea is that it is then impossible to=20
compile/test a new version of a package locally before installing it into t=
he=20
live filesystem.  you would have to first uninstall the old version (rm -rf=
=20
/opt/ltp), then compile/install the new version, and then hope that (1) the=
=20
build is successful as well as (2) the package working as expected (bug fre=
e).
=2Dmike

--nextPart1459631.uFjO8PtUsW
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iQIcBAABAgAGBQJK0RM8AAoJEEFjO5/oN/WBfmwQAKef2BTJmftczZfnblYh1fu/
xffM5Tm1IWdUEl/2+SV9TjpKJO5A+cf0jaUfdpITlys/IZ5c4AD4Jos9DbhnZ97s
/LEhJW53Of2RME7Wj7p+K9ZfXuxNVTkK/rxDymn7bHtqRyyyLjcAe06FPKxohv1n
leyrKoJXvTRh4IaK8bmzLAkLi+/i8aKfKWJUFsakj8lbgfNXkXHulMlHaNazLeIX
j6/xk29s5N/YjiZilRFMi1ZPAxk4MQOB9lrNAM+g3r95gxn7zSzLqK5TH4Iz73n9
qO3LJ7j121/53K44DhtjATPZic21qBQ3KKHk4oSFVIochhjbq6+8srxcIa08eku4
BKCkA9i1t0TEiuVhes0h7bfJfrjBmP02c9bii1osE67cg4891vD3iT5x/iiCT58O
uKj6uerK98B1Y0Gh+JywK7gFUPGYHK1lu9GcECpetLJbxVxa9nNUBoUVl8NDG4AN
rVMQvvlV1EEBQJm5n02L9UkTQAnBrCqqQ4hEZMYroSMNAPRYtPNN1RZ/j/bjMk41
5taU8Is7xJHx7x7QUs61Yd9lV0ejV/sZo0qfeREmEflGT60QL4WpH+7JlejHEAhl
tBO8jLyGEJ+1U+xU2O3l97aBrOrKfgBZ7BoK8ddIPZ2bUxVaQV7rQKn09H+UAlxE
97WDrq7Vf+mc6LTPVc8I
=9pZ1
-----END PGP SIGNATURE-----

--nextPart1459631.uFjO8PtUsW--


--===============3990426066114333991==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
--===============3990426066114333991==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============3990426066114333991==--


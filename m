Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1UaHwz-0003Xr-Oc
	for ltp-list@lists.sourceforge.net; Thu, 09 May 2013 03:55:25 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1UaHwy-0007ke-C7
	for ltp-list@lists.sourceforge.net; Thu, 09 May 2013 03:55:25 +0000
Received: from vapier.localnet (localhost [127.0.0.1])
	by smtp.gentoo.org (Postfix) with ESMTP id 5236F33BF5F
	for <ltp-list@lists.sourceforge.net>;
	Thu,  9 May 2013 03:55:08 +0000 (UTC)
From: Mike Frysinger <vapier@gentoo.org>
Date: Wed, 8 May 2013 23:55:13 -0400
MIME-Version: 1.0
Message-Id: <201305082355.14183.vapier@gentoo.org>
Subject: [LTP] new sub-project proposal of utility commands for poking
	funcs/syscalls directly
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============4445701695660777786=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: LTP List <ltp-list@lists.sourceforge.net>

--===============4445701695660777786==
Content-Type: multipart/signed; boundary="nextPart124393424.9LydEG3dXH";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart124393424.9LydEG3dXH
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

i wrote a testsuite for the Gentoo sandbox project.  for people unfamiliar=
=20
with this project, it's similar to fakeroot.  a readme with more details:
http://git.overlays.gentoo.org/gitweb/?p=3Dproj/sandbox.git;a=3Dblob;f=3DRE=
ADME

in order to test this project, i need to be able to easily & quickly run=20
specific C library funcs and syscalls.  writing small C files with the righ=
t=20
args is a pain and doesn't scale at all.  so i wrote a framework from scrat=
ch=20
which allows poking funcs from the command line:
http://git.overlays.gentoo.org/gitweb/?p=3Dproj/sandbox.git;a=3Dtree;f=3Dte=
sts

strace has need of pretty much the same thing.  atm, it's running higher le=
vel=20
tools like `stat` and `dd` and `find`, but this gets unmanageable quickly a=
s we=20
try to scale to more arches and tests.

rather than hosting the tests in the sandbox or the strace repo (and trying=
 to=20
import into the other), it seemed more natural to start a new sub-project=20
under the LTP umbrella.  we wouldn't want it to be in the main LTP repo sin=
ce=20
we can't check out subdirs w/git, so it'd have to be a new one.

what do people think ?  any suggestions on a name ?  how about "foker", the=
=20
function poker ?

as an example, i can quickly produce tools like so:
$ ./mkdirat-0=20
usage: mkdirat <tests>
test: < <ret> <dirfd> <path> <mode> >

<ret>      :=3D #[,<errno>]; # is a decimal and errno can be symbolic
<dirfd>    :=3D AT_FDCWD | fd # | path[:<flags>[:<mode>]]
<mode>     :=3D 0x# (for hex) | 0# (for octal) | # (for decimal)

$ strace -emkdirat ./mkdirat-0 0 AT_FDCWD dir 0777
mkdirat(AT_FDCWD, "dir", 0777)          =3D 0

the source file for this contains just enough to describe the signature of =
the=20
mkdirat() function:
#define CONFIG HAVE_MKDIRAT
#define FUNC mkdirat
#define SFUNC "mkdirat"
#define FUNC_STR "%i, \"%s\", %o"
#define FUNC_IMP dirfd, path, mode
#define ARG_CNT 3
#define ARG_USE "<dirfd> <path> <mode>"

#define process_args() \
	s =3D argv[i++]; \
	int dirfd =3D at_get_fd(s); \
	\
	s =3D argv[i++]; \
	char *path =3D s; \
	\
	s =3D argv[i++]; \
	mode_t mode =3D sscanf_mode_t(s);

#include "test-skel-0.c"
=2Dmike

--nextPart124393424.9LydEG3dXH
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJRix4iAAoJEEFjO5/oN/WBVjoP/jWSA2Yopf+4VK8HK8T5fXNG
Lgg+4NdnSDuXJtKdxH53fI88UHMAqCQODTfYePvt9rJa/htE2NzSSRTcNt2i+JkU
PPMsfgVWAbgzVbdoVoSyDfR3n1reqfovTVwSaDwNxZF18TetCccd7G+j1x7Vc6Pa
rwzgqRlYHBSD1na5TsrBxRucapZZvvPV421pA7MbUBy0cY7/7NkZKs6yQ9FR5/Te
LU34bnTtwVuWt/eA1mEbu1IraCBjqwWPvGOFuVWbJCu6VAB5woUsA4Yx24bRFtrs
QSNOF98VQvqhwaCLTuHbCOCuqgfrVomtbH14Uz5GVpSCvNuS+d67NaxajMVYI9Wc
C3uUYInRgrbiqP4gVghoqN+BkgB5oirE9P5fEYoP5w0GHyv+t+A5ZaSAjKi6sdWS
UbAsUW6NIzh67HhvjGZI71vOyxuwCiLSl1nXGmO+TsM1rNbJZZpcH6FuG1pXUGFp
6m6dM/nwH1ol9zBU65Xab2RAqpvxs6uWwvCUdJgI3D1VJuGxZTEA/2fHWnwy2lRw
0d0EY6GFl/x6NnM7cShNBXO15cxbWFRdkzzKlnTHisi0FUISAw4O/Ce64A5d+Zyu
AQjSruYE3+oQ1UD416riXIKLElgJJp8T08emU7c2s+xyibei3GWf8wFl0Xzcv0QX
Hgf5prFHbKxfgqHHo2k4
=pTTL
-----END PGP SIGNATURE-----

--nextPart124393424.9LydEG3dXH--


--===============4445701695660777786==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and 
their applications. This 200-page book is written by three acclaimed 
leaders in the field. The early access version is available now. 
Download your free book today! http://p.sf.net/sfu/neotech_d2d_may
--===============4445701695660777786==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============4445701695660777786==--


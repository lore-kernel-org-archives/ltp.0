Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1RkIwQ-0002mO-Iu
	for ltp-list@lists.sourceforge.net; Mon, 09 Jan 2012 17:23:26 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1RkIwL-0004xu-1W
	for ltp-list@lists.sourceforge.net; Mon, 09 Jan 2012 17:23:26 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Mon, 9 Jan 2012 12:23:13 -0500
References: <1326102275-32485-1-git-send-email-caspar@casparzhang.com>
	<20120109105133.GB27172@eguan-t400.redhat.com>
	<CAGH67wSHbU+1ptij7-X9ysU2CZXFOxtD7NYD9Yn0SuRtXThaUg@mail.gmail.com>
In-Reply-To: <CAGH67wSHbU+1ptij7-X9ysU2CZXFOxtD7NYD9Yn0SuRtXThaUg@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <201201091223.14655.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH] syscalls/xattr: fix compile when xattr.h not exist
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2285297074402211346=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============2285297074402211346==
Content-Type: multipart/signed; boundary="nextPart16584346.sYGpHNiN8C";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart16584346.sYGpHNiN8C
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Monday 09 January 2012 12:11:50 Garrett Cooper wrote:
> On Mon, Jan 9, 2012 at 2:51 AM, Eryu Guan <eguan@redhat.com> wrote:
> > On Mon, Jan 09, 2012 at 05:44:35PM +0800, Caspar Zhang wrote:
> >> if <attr/xattr.h> doesn't exist, compliation will fail. Fix it in
> >> autotools level.
> > >
> >> --- a/testcases/kernel/syscalls/getxattr/getxattr01.c
> >> +++ b/testcases/kernel/syscalls/getxattr/getxattr01.c
> >> @@ -37,7 +37,6 @@
> >>=20
> >>  #include <sys/types.h>
> >>  #include <sys/stat.h>
> >> -#include <attr/xattr.h>
> >>  #include <errno.h>
> >>  #include <fcntl.h>
> >>  #include <unistd.h>
> >> @@ -45,9 +44,16 @@
> >>  #include <stdlib.h>
> >>  #include <string.h>
> >>=20
> >> +#include "config.h"
> >>  #include "test.h"
> >>  #include "usctest.h"
> >>=20
> >> +char *TCID =3D "getxattr01";
> >> +
> >> +#ifdef HAVE_ATTR_XATTR_H
> >> +
> >> +#include <attr/xattr.h>
> >> +
> >>  #define XATTR_TEST_KEY "user.testkey"
> >>  #define XATTR_TEST_VALUE "this is a test value"
> >>  #define XATTR_TEST_VALUE_SIZE 20
> >> @@ -56,7 +62,6 @@
> >>  static void setup(void);
> >>  static void cleanup(void);
> >>=20
> >> -char *TCID =3D "getxattr01";
> >>  char filename[BUFSIZ];
> >>=20
> >>  struct test_case {
> >> @@ -171,3 +176,9 @@ static void cleanup(void)
> >>       TEST_CLEANUP;
> >>       tst_rmdir();
> >>  }
> >> +#else /* HAVE_ATTR_XATTR_H */
> >> +int main(int argc, char *argv[])
> >> +{
> >> +     tst_brkm(TCONF, NULL, "<attr/xattr.h> does not exist.");
> >> +}
> >> +#endif
> >> diff --git a/testcases/kernel/syscalls/getxattr/getxattr02.c
> >> b/testcases/kernel/syscalls/getxattr/getxattr02.c index
> >> 54d8949..52c5812 100644
> >> --- a/testcases/kernel/syscalls/getxattr/getxattr02.c
> >> +++ b/testcases/kernel/syscalls/getxattr/getxattr02.c
> >> @@ -41,7 +41,6 @@
> >>  #include <sys/types.h>
> >>  #include <sys/stat.h>
> >>  #include <sys/wait.h>
> >> -#include <attr/xattr.h>
> >>  #include <errno.h>
> >>  #include <fcntl.h>
> >>  #include <unistd.h>
> >> @@ -50,9 +49,16 @@
> >>  #include <stdlib.h>
> >>  #include <string.h>
> >>=20
> >> +#include "config.h"
> >>  #include "test.h"
> >>  #include "usctest.h"
> >>=20
> >> +char *TCID =3D "getxattr02";
> >> +
> >> +#ifdef HAVE_ATTR_XATTR_H
> >> +
> >> +#include <attr/xattr.h>
>=20
> The only thing requested is that:
>=20
> #ifdef HAVE_ATTR_XATTR_H
> #include <attr/xattr.h>
> #endif
>=20
> (please note the whitespace difference) be moved further up in the
> file to be sorted properly with the rest of the #includes, as noted in
> the style guide.

config.h should come before any include, and then the attr/xattr.h evaluati=
on=20
be in the normal location -- after C library includes and before LTP includ=
es=20
(like test.h).
=2Dmike

--nextPart16584346.sYGpHNiN8C
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJPCyKCAAoJEEFjO5/oN/WBCTsQAM/bXasDYRjdD5SXn4sNzNBB
TJZPVEsLvcVhCedlWi78IPsnoV1NSmnrqwqiLDYEv56M87p2F0cFUcprqKodwg7X
f63uVlDrJ80tuWjhsD1pNnS040JOGGVkm2W7QwyEmxuaxTZjkPR/veOzNRufQ7pI
9Fr8ppxl54rVGf4Tv4wAbEuOot47VyFFFFJPqEQiKKCtNRp1ka2dRzkTPPhphfzv
jICRUmtryH+cj9Fmv2EQMPztn8TuLElmkUIe4RbW3W52ybgTK/2h0+kt+3ISPomR
Fkd66r6nL5zqg/DNQ0D7P0z1rqOcFPj8poyYXA0jGlntA3azxPIDjAvWJu+5d6UF
GUId7+Sv1ijA21IlwndMMo/EwC4GVD2L720Dzmzqd7zbnF9pQz32ti0q2P8JkAYt
CiEjD8w9Vmcy4YPyUCfpToZMjuMYCYPzAJ2BB6LXQQEEAQy2UOSX+6z8n33mhZP2
Vys0NgZBZkhfa10v/wNK4pFnLDdP+gLf9/6K1jvolMGw6Msjq2ZiMSlSCfVOWvIS
h0Ux/YoNWsCzOp0twq9xb2niz/P2N3fwB9+67okCzx5yPPahUmDN7xo0Mi09VeEO
qieU0TZgcJtm9wYZ/fSLhNplDsIVI0wY7iksQV+jklemaZ/bKHb+MYmSUrGK4e5D
rOPXF28a6yl/uSWogbRG
=11pg
-----END PGP SIGNATURE-----

--nextPart16584346.sYGpHNiN8C--


--===============2285297074402211346==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Ridiculously easy VDI. With Citrix VDI-in-a-Box, you don't need a complex
infrastructure or vast IT resources to deliver seamless, secure access to
virtual desktops. With this all-in-one solution, easily deploy virtual 
desktops for less than the cost of PCs and save 60% on VDI infrastructure 
costs. Try it free! http://p.sf.net/sfu/Citrix-VDIinabox
--===============2285297074402211346==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============2285297074402211346==--


Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1UmDQg-00049M-5h
	for ltp-list@lists.sourceforge.net; Tue, 11 Jun 2013 01:31:22 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1UmDQb-0004QI-5f
	for ltp-list@lists.sourceforge.net; Tue, 11 Jun 2013 01:31:22 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Mon, 10 Jun 2013 21:31:03 -0400
References: <1370528507-15313-1-git-send-email-alexey.kodanev@oracle.com>
In-Reply-To: <1370528507-15313-1-git-send-email-alexey.kodanev@oracle.com>
MIME-Version: 1.0
Message-Id: <201306102131.04281.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH] configure: add configure checks to compile kernel
	modules
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============7470351652440210821=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: Alexey Kodanev <alexey.kodanev@oracle.com>, vasily.isaenko@oracle.com

--===============7470351652440210821==
Content-Type: multipart/signed; boundary="nextPart1775072.37ddSzo6E4";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1775072.37ddSzo6E4
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Thursday 06 June 2013 10:21:47 Alexey Kodanev wrote:
> --- /dev/null
> +++ b/m4/ltp-kernel_devel.m4
> @@ -0,0 +1,72 @@
> +dnl Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
> +dnl
> +dnl This program is free software; you can redistribute it and/or
> +dnl modify it under the terms of the GNU General Public License as
> +dnl published by the Free Software Foundation.
> +dnl
> +dnl This program is distributed in the hope that it would be useful,
> +dnl but WITHOUT ANY WARRANTY; without even the implied warranty of
> +dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +dnl GNU General Public License for more details.
> +dnl
> +dnl You should have received a copy of the GNU General Public License
> +dnl along with this program; if not, write the Free Software Foundation,
> +dnl Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

you've apparently deleted the phrase "either version 2 of the License, or (=
at=20
your option) any later version.".  i have no idea why you would do such a=20
thing, but it's obviously not desirable.  apparently this isn't the first t=
ime=20
as i see you've done it in at least 0e335dbed65afb79eab5b30e8d49d8066f16531=
6.

please send a patch to fix your previous commits, and fix this one as well.=
  or=20
i'm afraid we'll have to revert.

> +AC_DEFUN([LTP_CHECK_KERNEL_DEVEL],
> +[

cuddle the [ up and use dnl.  see _LTP_CHECK_LINUX_PTRACE for what i mean.

> +AC_ARG_WITH(
> +	    [kbuild-release],

"kbuild "is meaningless outside of the linux kernel tree.  it's also not a=
=20
specific release.  call it "linux-version" instead.  or maybe "kmod-version=
".

> +	    [AC_HELP_STRING([--with-kbuild-release=3DRELEASE],
> +			    [specify the kernel release to build modules for])],

you're mixing tabs & spaces in a way that only works with 8 spaces.  either=
=20
use pure tabs to indent (one level at a time), or use tabs to line up to th=
e=20
common part, then use spaces after that.

> +	    [KBUILD_RELEASE=3D"${withval}"],
> +	    [KBUILD_RELEASE=3D`uname -r`])

defaulting like this won't work.  you need to check $cross_compiling is set=
 to=20
yes in order to default to `uname -r`.

seems like it'd be simpler to just do:
	AC_ARG_WITH([linux-version], [AC_HELP_STRING(...)],,
		AS_IF([test "$cross_compiling" !=3D no],
			[with_linux_version=3D`uname -r`]))
	LINUX_VERSION=3D$with_linux_version
	AC_SUBST(LINUX_VERSION)

> +AC_MSG_RESULT([checking for kernel-devel... $WITH_MODULES])

err, that's not how it works.  you first call AC_MSG_CHECKING([for kernel-
devel]) and then you do AC_MSG_RESULT([$WITH_MODULES]) after the actual=20
checks.
=2Dmike

--nextPart1775072.37ddSzo6E4
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJRtn3YAAoJEEFjO5/oN/WBFWgP+wdg7Oly4jIL82l3KAOuYUYZ
tdQRXDhj/l+igwFhoIv/+whMTppWrHYNh5tPE9yYsg4oOQV/s8d2Nn9mbPqkydeG
hQgTa65vKSTZ3RLKmq6djbgpJZ0myGh/at8Yi/WgFQYJzBj2re6uK4tl/P3NT4DW
xd/8S4Ue3uNSyeZcuXPW7EmXVti0W9hVUGF2gNE+1usNHHPBWuLqfojxa2B8g2of
yaht+NKEljMjUNqKTvAD9VkAN/pEWDQ1Tm6WsmYtUt+hb/O1lGcxhLSDLd1/oMhL
HJk/1aNwNyU/5gIruWA6XVU1m/OMBDwssIWk6jMFF62mzM/IZfplDSxGlKe71zxi
OwV0POyr2iAPsDiGhYq1194Tz/ootDownXSYCgD7l9EWUD1DvcTQ4J7ciUnJ8k+Z
ifjDeLfKAS15wgatTUIH+DvMMGXNiuz0pek/UesG7RyP4lv47KSUTuYWLOIxQZnO
GYjt2r2nTrQPSvXiak+8PhHAhHDK3AvPXX4qC6eCtEldtCyoFkGSP5NTqKySqmnC
DS8NsjBMmSKkaZf2Nghod9OZ4GlUmnVmt56GnepP/WYqc4uLUfCYvEJ9jTsuODC8
bCEYCx5i5i58E7XoaEJTLcxYlTLlfNkY/r7KinDW5ttymclsXJFjOdz98OUMCj0h
WJRmaRjDfF6ynaq6M/XG
=OYGL
-----END PGP SIGNATURE-----

--nextPart1775072.37ddSzo6E4--


--===============7470351652440210821==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
--===============7470351652440210821==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============7470351652440210821==--


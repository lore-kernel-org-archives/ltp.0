Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1MR7US-00017a-6g
	for ltp-list@lists.sourceforge.net; Wed, 15 Jul 2009 16:37:56 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MR7UN-0006AQ-NZ
	for ltp-list@lists.sourceforge.net; Wed, 15 Jul 2009 16:37:56 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Wed, 15 Jul 2009 12:37:48 -0400
References: <364299f40907061818q7cda3465vffb00323af18c5f8@mail.gmail.com>
	<364299f40907062033j1660f689t65b8b8bdfb402f11@mail.gmail.com>
	<364299f40907112249g1a04c53cn4d25ce385f88bcaf@mail.gmail.com>
In-Reply-To: <364299f40907112249g1a04c53cn4d25ce385f88bcaf@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <200907151237.49839.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH 4/4] Make makefiles more autoconf friendly
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============4167141259586477839=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============4167141259586477839==
Content-Type: multipart/signed; boundary="nextPart1455693.Csaogb2DV5";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1455693.Csaogb2DV5
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sunday 12 July 2009 01:49:52 Garrett Cooper wrote:
> -AC_CONFIG_FILES([config.mk m4/Makefile])
> +AC_CONFIG_FILES([ include/mk/config.mk lib/ltp.pc ltp-devel.spec
> m4/Makefile \ +README.ltp-devel ])

if you're going to start splitting lines, might as well do all of them and=
=20
keep them sorted
AC_CONFIG_FILES([ \
	file1 \
	file2 \
	file3 \
])

> --- /dev/null	1 Jan 1970 00:00:00 -0000
> +++ ltp-devel.spec.in	12 Jul 2009 05:46:28 -0000

each of the .in files should have a target in the related Makefile so that =
it=20
gets updated if the source is modified

ltp-devel.spec: $(srcdir)/ltp-devel.spec.in
	./config.status $@

> +++ include/mk/config.mk.in	12 Jul 2009 05:46:28 -0000
> +AIO_LIBS	=3D @AIO_LIBS@
> +CRYPTO_LIB	=3D @CRYPTO_LIB@
> +SELINUX_LIBS	=3D @SELINUX_LIBS@

there should be a note here about standardizing the naming.  it should be=20
"FOO_LIBS", not "_LIB".

> +# Avoid overwriting definitions in leaf callers.
> +CPPFLAGS	?=3D @CPPFLAGS@ -I$(includedir)
> +CFLAGS		?=3D @CFLAGS@
> +LDLIBS		?=3D @LIBS@
> +LDFLAGS		?=3D @LDFLAGS@ -L$(libdir)

this looks like it'll cause problems if you set these in your environment
export CPPFLAGS=3D'' CFLAGS=3D'-pipe' LDFLAGS=3D''
make

i would use $(origin ...) to determine whether the variables are coming fro=
m=20
the leaf Makefile

also, please add '-pipe' to default CFLAGS

> +DEBUG_CFLAGS	?=3D -g
> +DEBUG_CXXFLAGS	?=3D $(DEBUG_CFLAGS)
> +
> +CFLAGS		+=3D $(DEBUG_CFLAGS)
> +CXXFLAGS	+=3D $(DEBUG_CXXFLAGS)
> +
> +# There have been several bugs in the past related to -O2+ when
> +# -fno-strict-aliasing is not specified.
> +OPT_CFLAGS	?=3D -O2 -fno-strict-aliasing
> +OPT_CXXFLAGS	?=3D $(OPT_CFLAGS)

in general, i recall only like 1 bug that was a gcc issue.  all the others=
=20
were broken source code.  i dont think we should live with code that violat=
es=20
aliasing rules.

> +#export AR CC CFLAGS CPPFLAGS LDLIBS LDFLAGS RANLIB

forgot to delete ?

> --- m4/GNUmakefile	18 Jan 2009 22:22:40 -0000	1.1
> +++ m4/GNUmakefile	12 Jul 2009 05:46:28 -0000

i think we only need a top level GNUmakefile.  all the other subdirs can st=
ay=20
Makefile.

> +LFLAGS			+=3D -l -w
> +CFLAGS			+=3D -w

punt these
=2Dmike

--nextPart1455693.Csaogb2DV5
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iQIcBAABAgAGBQJKXgXdAAoJEEFjO5/oN/WBiYcP/jHVDRtS6+vsRuiW2YaRb1Qa
yXxcrI7uv1RHotZKDab6vH4M80erxzZWG3tiNyqPIfOpLiG2qEAZS9BUErvUyIvm
pGG629QTADwDqAhgYqYlpyffWS16ECLnftPREs4OFDZbI5NoOZp5cWLJNnP7muLx
p7eIoNmEY1PRed+/Etsh9gl53BKy/Xm56cke8cZFi20VsvJmlfWhKXBx+nM8vdnq
qPm3ILrYUpnA+gRrjQwCNWUIZW3imdkFgebKi8X9s51Q0dKk4c2qpu5oNGnmrveb
6ny/3Ztwmk2uuB+sCzXYTYjH+QlibihY1JL16pnnYxOhbjWR1jCPY2Wq2RbxSeMU
XzhHGdcQ21Ltw4RLV+TLIG+/hs7Kkn6i365yRIkaYSRFE/lvDHaZ46GXlhFxeMQC
3+BYA/BHVZCf/dVFfVGMA2TRRh9ekS67gIyOwZz2y+3sNk8DnFhnCXkyS1fJNA0w
VfEtLk+CUsMVzJjEt6yKgPrUt7uxz6rpRuS/bzU7MhA8DdZhhLHGHZDNtNt+vT1o
I5U3bJ/JrfV7+Kns/3Z7gbz/79q1aY3mTTPHeGSKwR52PjP/13bjqvwCUFfyz+Fu
B+aD10uH9Afh/jHVMV8yqlPlypsAmMhxYxT7DdcwOGS7LyPbUI5UloYTY99NBeB8
/uuUe+Y2p2rZeHQL1bEm
=j0KI
-----END PGP SIGNATURE-----

--nextPart1455693.Csaogb2DV5--


--===============4167141259586477839==
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
--===============4167141259586477839==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============4167141259586477839==--


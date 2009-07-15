Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1MR7ky-0002TC-Va
	for ltp-list@lists.sourceforge.net; Wed, 15 Jul 2009 16:55:00 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MR7kp-0005Li-RQ
	for ltp-list@lists.sourceforge.net; Wed, 15 Jul 2009 16:55:00 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Wed, 15 Jul 2009 12:54:48 -0400
References: <364299f40907112242j13b7349fued53c53f3f8defee@mail.gmail.com>
In-Reply-To: <364299f40907112242j13b7349fued53c53f3f8defee@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <200907151254.49595.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH 3/4] Make system enhancements, Draft 2
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============3963245248779447241=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============3963245248779447241==
Content-Type: multipart/signed; boundary="nextPart1510457.LhaNC7pbBz";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1510457.LhaNC7pbBz
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sunday 12 July 2009 01:42:03 Garrett Cooper wrote:
> +$(CC)			: The system C compiler.
> +
> +$(CXX)			: The system C++ compiler.

should add $(CPP) - the system preprocessor

> +$(CFLAGS)		: Compiler flags.

C compiler flags

should add $(CXXFLAGS) too

> +$(LD)			: The library linker.

the system linker (typically $(CC))

> +$(LDFLAGS)		: What to pass in to the linker, including -L arguments
> +			  and other ld arguments, apart from -l library
> +			  includes (see $(LDLIBS)).

should note that flags should be in the form given to the compiler driver=20
because we arent invoking `ld` -- i.e. -Wl,-foo not -foo

> +$(LDLIBS)		: Libraries to pass into the linker (e.g. -lltp, etc).

s/into/to/

> +$(OPT_CFLAGS)		: Optimization flags to pass into the C compiler, -O2,
> +			  etc. IF YOU SPECIFY -O2 OR HIGHER, ENSURE THAT YOU
> +			  ALSO SPECIFY -fno-strict-aliasing, BECAUSE OF PAST
> +			  OPTIMIZATION GCC BUGS!!!

tr '[:upper:]' '[:lower:]'

do you have any actual examples of this ?

> +$(OPT_CXXFLAGS)		: Optimization flags to pass into the C++ compiler.

s/into/to/

> +$(RANLIB)		: What to run after archiving a library.

the archive indexer

> +# Replace [options] with any make specific options and variables, for ea=
ch
> +# step, example: -j 4, DESTDIR=3D/path/for/install, etc.
> +make ac-clean ac-maintainer-clean distclean maintainer-clean [options]

there should be no need to run these targets.  "maintainer-clean" should im=
ply=20
all of these other targets.

> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> +Other Errata
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> +
> +- This system (in its current form) supports cross-compilation out of a
> single +directory. Object directory support will be completed soon to
> properly enable +cross-compilation. This is required to avoid sporadic
> Make-related errors.

i have no idea what you're talking about here

> +# Where's the root source directory?
> +top_srcdir			:=3D $(abspath $(top_srcdir))
> +# Where's the source located at?
> +srcdir				?=3D .
> +# Where's the root object directory?
> +builddir			?=3D $(srcdir)

need a top_builddir too

> +# Where are we currently located in the object and source tree?
> +relpath				:=3D $(subst $(abs_builddir),,$(CURDIR))

is this actually necessary ?

> +all: | $$(MAKE_DEPS) $$(MAKE_TARGETS)
> +
> +clean: $$(CLEAN_DEPS)
> +	-$(RM) -f $$(CLEAN_TARGETS)
> +
> +pre-install: | $$(INSTALL_PATH) $$(PREINSTALL_DEPS)
> +
> +install: | $$(INSTALL_FILES) $$(POSTINSTALL_DEPS)

so why do we need these _DEPS vars ?  do you need the $(MAKE_DEPS) to be=20
processed before $(MAKE_TARGETS) ?

at least for the clean target, it'd be easier to write it:
clean::
	$(RM) -f $$(CLEAN_TARGETS)

and then people can just define their own "clean::" in their makefile to do=
=20
whatever they want.  be nice if we could use this method for all the target=
s.
=2Dmike

--nextPart1510457.LhaNC7pbBz
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iQIcBAABAgAGBQJKXgnZAAoJEEFjO5/oN/WBWWcP/10E+RztcPginjhGe+Azs8py
qH8ECVGokR+OnlId98pWd8s2FGH8w4iZzi7/MlMGIWLMN/OkXSawNCUHjnby8wm0
QMsugslB36vVEk0zCcFxlGmvi0fJilREQ5USW+hfjH9/ZPUE5V5fGcPNeHKEyxeg
G0Wocj94igJdgRVS1ZQVdswKX+QJ8vW3R25HtP6rCX/1hVyHImYvLI3LDSGJPpc6
ZZnVJyPiOWSuM0fpufQXMmyAsgRjigPbeKyctxQzfKT4Y2Gc2WOAt2mZLShB59YM
rG1uh+55ducOV6MljZ7SLmWOwqE4DgTD3Ku2TuRlUwxweVNsUWzU3ls/d94S/zIl
GR9Rb6JVFb1VVqiYKobEbBKt8IbuDbrzwQpSHCo4azCaQ5MR8MU261FpMYFAWeRL
iYV13kgUvibj+f0+qXJvBavm4RWPjnWYoo6DiZV7svq9X733NutTYQCHts3Wbgp+
al12mNFG0lDlXaFgGwRIFGIUffCw9+JdGs4y8clmZV5S7B45sMONz/tYfcv29HCl
EC2NFIMWwZneLf2Xwgg2BE/kAnch2+7aYDhf6f4eS94452IAy4ce69pA27rSjLeV
1HueVb2vkQy2+PCJ36Lxei+jpGy2L7LnQdlV/CTuns37qo8ol+NiqAHa4C1fr+WG
KyFlJXh9uFpOa9v2AmTf
=G8R+
-----END PGP SIGNATURE-----

--nextPart1510457.LhaNC7pbBz--


--===============3963245248779447241==
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
--===============3963245248779447241==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============3963245248779447241==--


From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 29 Nov 2017 15:52:49 +0100
Subject: [LTP] [RFC PATCH 1/4] travis: Add build script
In-Reply-To: <CAEemH2fG=O7vVj=xyY58gwQLkq5JUw4fa4yaUEMAyoJfWE0V_A@mail.gmail.com>
References: <20171128232130.4843-1-pvorel@suse.cz>
 <20171128232130.4843-2-pvorel@suse.cz>
 <CAEemH2evorTPAHpnYjydKcvwYha27zYSPZGKLZe+97Mni7N7vA@mail.gmail.com>
 <20171129082743.d5i5stufxmn25twr@dell5510>
 <CAEemH2fG=O7vVj=xyY58gwQLkq5JUw4fa4yaUEMAyoJfWE0V_A@mail.gmail.com>
Message-ID: <20171129145249.6wfxny7sqnwchrjk@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li,

> Hmm, what kind of files will be missed?
see bellow.

> I just tried your build.sh with this new function, but seems make
> install successfully.

> build_out_of_tree()
> {
>     echo "===== build ltp out of tree ====="
>     TOP=$PWD
>     TOP_SRCDIR=$TOP/../ltp
>     SYSROOT=$TOP/../ltp-install
>     TOP_BUILDDIR=$TOP/../ltp-build
>     test -d "$TOP_BUILDDIR" || mkdir -p "$TOP_BUILDDIR"

>     pushd $TOP_SRCDIR; make autotools; popd
pushd and popd are bashisms, which we don't want to use (we need to have POSIX compliant
shell scripts). I know, you're reading this INSTALL, which is IMHO too complicated (I'd
like to simplify this instructions, but that's another task).

>     pushd "$TOP_BUILDDIR" && "$TOP_SRCDIR/configure"
You're running configure without flags. For travis we run full build, e.g. with
--with-open-posix-testsuite --with-realtime-testsuite flags.
Try to run it at least with --with-open-posix-testsuite and you see these errors:
make -C "testcases" \
	-f "/home/pvorel/install/src/ltp.git/testcases/Makefile" install
make[1]: Entering directory '/home/pvorel/install/src/ltp-build/testcases'
make[2]: Entering directory '/home/pvorel/install/src/ltp-build/testcases/open_posix_testsuite'
/home/pvorel/install/src/ltp.git/testcases/open_posix_testsuite/Makefile:38: Makefile.linux: No such file or directory
make[2]: *** No rule to make target 'Makefile.linux'.  Stop.
make[2]: Leaving directory '/home/pvorel/install/src/ltp-build/testcases/open_posix_testsuite'
make[1]: *** [/home/pvorel/install/src/ltp.git/../ltp.git/include/mk/generic_trunk_target.inc:93: install] Error 2
make[1]: Leaving directory '/home/pvorel/install/src/ltp-build/testcases'
make: *** [/home/pvorel/install/src/ltp.git/../ltp.git/Makefile:142: testcases-install] Error 2
make: Leaving directory '/home/pvorel/install/src/ltp-build'

I've got some patches which fix error in installing, but some of the files don't get
installed (I don't remember which ones), that's why I haven't pushed the fixes yet.

>     OUT_OF_BUILD_TREE_DIR=$TOP_BUILDDIR
>     make \
>         -C "$OUT_OF_BUILD_TREE_DIR" \
>         -f "$TOP_SRCDIR/Makefile" \
>         "top_srcdir=$TOP_SRCDIR" \
>         "top_builddir=$OUT_OF_BUILD_TREE_DIR"

>     make \
>         -C "$OUT_OF_BUILD_TREE_DIR" \
>         -f "$TOP_SRCDIR/Makefile" \
>         "top_srcdir=$TOP_SRCDIR" \
>         "top_builddir=$OUT_OF_BUILD_TREE_DIR" \
>         "DESTDIR=$SYSROOT" \
>         SKIP_IDCHECK=1 install
>     popd
> }
Also -j flag for make is missing, which speeds build a lot (again, that's why I don't like
way in INSTALL).

Kind regards,
Petr

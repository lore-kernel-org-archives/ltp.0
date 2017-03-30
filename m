From: Li Wang <liwang@redhat.com>
Date: Thu, 30 Mar 2017 18:33:23 +0800
Subject: [LTP] Out-of-tree build missing some data files.
In-Reply-To: <BN6PR11MB20512A7C76A7882343FFDE98CD350@BN6PR11MB2051.namprd11.prod.outlook.com>
References: <BN6PR11MB2051C2F128C4DC206D611144CD3F0@BN6PR11MB2051.namprd11.prod.outlook.com>
 <20170328133708.GF1045@rei>
 <BN6PR11MB20517B46C814B90AB73E3D43CD320@BN6PR11MB2051.namprd11.prod.outlook.com>
 <20170329133156.GF7089@rei.lan>
 <BN6PR11MB20512A7C76A7882343FFDE98CD350@BN6PR11MB2051.namprd11.prod.outlook.com>
Message-ID: <CAEemH2cMoGycJxb13zDBP9xijMb5p2OfyTXsXUom-n8zJNFboQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

I'm trying to build ltp out of tree but failed with errors like:

=========
make[2]: Leaving directory `/root/ltp-build/testcases/lib'
make[2]: Entering directory `/root/ltp-build/testcases/open_posix_testsuite'
/root/ltp/testcases/open_posix_testsuite/Makefile:38: Makefile.linux:
No such file or directory
make[2]: *** No rule to make target `Makefile.linux'.  Stop.
make[2]: Leaving directory `/root/ltp-build/testcases/open_posix_testsuite'
make[1]: *** [all] Error 2
=========

Two problems here:

1. The open_posix_testuite is also compiling in this time, but I
remember I didn't pass any parameter to config that.

2. It obviously could not build open_posix_testsuite out of tree
successfully, should we fix this for LTP?


my test script is:

$ cat build-ltp-out-of-tree.sh

#!/bin/bash

TOP=$PWD
TOP_SRCDIR=$TOP/ltp
SYSROOT=$TOP/ltp-install
TOP_BUILDDIR=$TOP/ltp-build
test -d "$TOP_BUILDDIR" || mkdir -p "$TOP_BUILDDIR"

if [ -f $TOP_SRCDIR/.git/config ]; then
    echo "LOG: ltp has been cloned in $TOP_SRCDIR"
    pushd $TOP_SRCDIR; git pull  > /dev/null 2>&1; make autotools; popd
else
    cd $TOP && git clone https://github.com/linux-test-project/ltp  --depth=1
    pushd $TOP_SRCDIR; make autotools; popd
fi

pushd "$TOP_BUILDDIR" && "$TOP_SRCDIR/configure"
OUT_OF_BUILD_TREE_DIR=$TOP_BUILDDIR
make \
    -C "$OUT_OF_BUILD_TREE_DIR" \
    -f "$TOP_SRCDIR/Makefile" \
    "top_srcdir=$TOP_SRCDIR" \
    "top_builddir=$OUT_OF_BUILD_TREE_DIR"

make \
    -C "$OUT_OF_BUILD_TREE_DIR" \
    -f "$TOP_SRCDIR/Makefile" \
    "top_srcdir=$TOP_SRCDIR" \
    "top_builddir=$OUT_OF_BUILD_TREE_DIR" \
    "DESTDIR=$SYSROOT" \
    SKIP_IDCHECK=1 install
popd



-- 
Regards,
Li Wang
Email: liwang@redhat.com

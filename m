From: Petr Vorel <pvorel@suse.cz>
Date: Wed,  5 Apr 2017 10:58:21 +0200
Subject: [LTP] [PATCH 2/2] travis: Add out-of-tree build
In-Reply-To: <20170405085821.13121-1-pvorel@suse.cz>
References: <20170405085821.13121-1-pvorel@suse.cz>
Message-ID: <20170405085821.13121-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .travis.yml | 11 +++++++++-
 build.sh    | 69 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+), 1 deletion(-)
 create mode 100755 build.sh

diff --git a/.travis.yml b/.travis.yml
index d937f9dcf..d030cc796 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -10,6 +10,15 @@ matrix:
                   packages: ['gcc-4.6']
 
         - os: linux
+          compiler: gcc-4.6
+          addons:
+              apt:
+                  sources: ['ubuntu-toolchain-r-test']
+                  packages: ['gcc-4.6']
+          env:
+              OUT_OF_TREE=true
+
+        - os: linux
           compiler: gcc-4.7
           addons:
               apt:
@@ -72,4 +81,4 @@ notifications:
     email:
         secure: "b/xcA/K5OyQvPPnd0PRahTH5LJu8lgz8goGHvhXpHo+ZPsPgTDXNFo5cX9fSOkMuFKeoW8iGl0wOgK2+ptc8mbYDw277K4RFIHRHeV/KIoE1EzjQnEFiL8J0oHCAvDj12o0AXeriTyY9gICXKbR31Br6Zh5eKViDJe2OAGeHeDU="
 
-script: make autotools && ./configure --prefix $HOME/ltp --with-open-posix-testsuite --with-realtime-testsuite && make -j$(getconf _NPROCESSORS_ONLN) && make -j$(getconf _NPROCESSORS_ONLN) install
+script: ./build.sh $OUT_OF_TREE
diff --git a/build.sh b/build.sh
new file mode 100755
index 000000000..62fa4eb76
--- /dev/null
+++ b/build.sh
@@ -0,0 +1,69 @@
+#!/bin/sh
+#
+# Copyright (c) Linux Test Project, 2017
+#
+# Script used for travis builds and for local test builds.
+#
+# TODO: Implement comparasion of installed files. List of installed files can
+# be used only for local builds as Travis currently doesn't support sharing
+# file between jobs, see [1].
+# [1]: https://github.com/travis-ci/travis-ci/issues/6054
+#
+# Written by Petr Vorel <pvorel@suse.cz>
+
+set -e
+
+PREFIX="$HOME/ltp"
+CONFIGURE_OPTS="--with-open-posix-testsuite --with-realtime-testsuite"
+
+in_tree_build()
+{
+    echo "===== IN TREE BUILD INTO $PREFIX ====="
+
+    make autotools
+    ./configure $CONFIGURE_OPTS --prefix "$PREFIX"
+    make -j$(getconf _NPROCESSORS_ONLN)
+    make -j$(getconf _NPROCESSORS_ONLN) install
+
+    cd $PREFIX && find | sort > list.in-tree.txt
+}
+
+out_tree_build()
+{
+    echo "===== OUT OF TREE BUILD INTO $PREFIX ====="
+
+    local ltp_git="$PWD"
+    local ltp_out="$PWD/../ltp-build"
+
+    make autotools
+
+    mkdir -p $ltp_out
+    cd $ltp_out
+
+    $ltp_git/configure --prefix="/`basename $PREFIX`" $CONFIGURE_OPTS
+    make -C $ltp_out -f $ltp_git/Makefile top_srcdir=$ltp_git top_builddir=$ltp_out -j$(getconf _NPROCESSORS_ONLN)
+    DESTDIR="`dirname $PREFIX`" make -C $ltp_out -f $ltp_git/Makefile top_srcdir=$ltp_git top_builddir=$ltp_out -j$(getconf _NPROCESSORS_ONLN) install
+
+    cd $PREFIX && find | sort > list.out-tree.txt
+}
+
+if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
+    cat << EOF
+USAGE:
+in tree build:
+$0
+
+out of tree build:
+$0 any-string
+EOF
+    exit 0
+fi
+
+rm -rf $PREFIX
+if [ "$1" ]; then
+    out_tree_build
+else
+    in_tree_build
+fi
+
+# vim: set ft=sh ts=4 sts=4 sw=4 expandtab :
-- 
2.12.0


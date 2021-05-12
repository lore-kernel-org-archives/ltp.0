From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 12 May 2021 18:57:01 +0200
Subject: [LTP] [PATCH 1/2] build.sh: Support passing configure options
Message-ID: <20210512165702.22883-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

and document that in help

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 build.sh | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/build.sh b/build.sh
index 1ec6a51d8..985cc00e8 100755
--- a/build.sh
+++ b/build.sh
@@ -1,5 +1,5 @@
 #!/bin/sh
-# Copyright (c) 2017-2020 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2017-2021 Petr Vorel <pvorel@suse.cz>
 # Script for travis builds.
 #
 # TODO: Implement comparison of installed files. List of installed files can
@@ -15,9 +15,9 @@ CC="${CC:-gcc}"
 DEFAULT_PREFIX="$HOME/ltp-install"
 DEFAULT_BUILD="native"
 DEFAULT_TREE="in"
-CONFIGURE_OPTS_IN_TREE="--with-open-posix-testsuite --with-realtime-testsuite"
+CONFIGURE_OPTS_IN_TREE="${CONFIGURE_OPT:---with-open-posix-testsuite --with-realtime-testsuite $CONFIGURE_OPT_EXTRA}"
 # TODO: open posix testsuite is currently broken in out-tree-build. Enable it once it's fixed.
-CONFIGURE_OPTS_OUT_TREE="--with-realtime-testsuite"
+CONFIGURE_OPTS_OUT_TREE="${CONFIGURE_OPT:---with-realtime-testsuite $CONFIGURE_OPT_EXTRA}"
 MAKE_OPTS="-j$(getconf _NPROCESSORS_ONLN)"
 
 build_32()
@@ -172,6 +172,14 @@ BUILD TYPES:
 32       32-bit build (PKG_CONFIG_LIBDIR auto-detection for x86_64)
 cross    cross-compile build (requires set compiler via -c switch)
 native   native build
+
+Default configure options:
+in-tree:    $CONFIGURE_OPTS_IN_TREE
+out-of-tree $CONFIGURE_OPTS_OUT_TREE
+
+configure options can be:
+- overwritten with \$CONFIGURE_OPT environment variable
+- extended the default with \$CONFIGURE_OPT_EXTRA environment variable
 EOF
 }
 
-- 
2.31.1


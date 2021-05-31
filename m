From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 31 May 2021 18:50:51 +0200
Subject: [LTP] [PATCH 2/3] CI: Rename travis script directory
In-Reply-To: <20210531165052.8731-1-pvorel@suse.cz>
References: <20210531165052.8731-1-pvorel@suse.cz>
Message-ID: <20210531165052.8731-3-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This is a preparation for moving from Travis CI to GitHub Actions.

Link: https://github.com/linux-test-project/ltp/issues/761

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .travis.yml                            | 2 +-
 {travis => ci}/alpine.sh               | 0
 {travis => ci}/centos.sh               | 0
 {travis => ci}/debian.cross-compile.sh | 0
 {travis => ci}/debian.i386.sh          | 0
 {travis => ci}/debian.minimal.sh       | 0
 {travis => ci}/debian.sh               | 0
 {travis => ci}/fedora.sh               | 0
 {travis => ci}/opensuse.sh             | 0
 {travis => ci}/tumbleweed.sh           | 0
 {travis => ci}/ubuntu.sh               | 0
 11 files changed, 1 insertion(+), 1 deletion(-)
 rename {travis => ci}/alpine.sh (100%)
 rename {travis => ci}/centos.sh (100%)
 rename {travis => ci}/debian.cross-compile.sh (100%)
 rename {travis => ci}/debian.i386.sh (100%)
 rename {travis => ci}/debian.minimal.sh (100%)
 rename {travis => ci}/debian.sh (100%)
 rename {travis => ci}/fedora.sh (100%)
 rename {travis => ci}/opensuse.sh (100%)
 rename {travis => ci}/tumbleweed.sh (100%)
 rename {travis => ci}/ubuntu.sh (100%)

diff --git a/.travis.yml b/.travis.yml
index 5d759dab4..d0c88da45 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -128,4 +128,4 @@ script:
     - if [ "$METADATA" = "asciidoctor-pdf" ]; then CONFIGURE_OPT_EXTRA="--with-metadata-generator=asciidoctor --enable-metadata-pdf"; fi
     - if [ ! "$TREE" ]; then TREE="in"; fi
     - case $VARIANT in cross-compile*) BUILD="cross";; i386) BUILD="32";; *) BUILD="native";; esac
-    - $CONTAINER run $CONTAINER_ARGS -t ltp /bin/sh -c "cd travis && ./$INSTALL.sh && if [ \"$VARIANT\" ]; then ARCH=\"$ARCH\" ./$INSTALL.$VARIANT.sh; fi && CONFIGURE_OPT_EXTRA=\"$CONFIGURE_OPT_EXTRA\" ../build.sh -o $TREE -t $BUILD -c $CC $INSTALL_OPT"
+    - $CONTAINER run $CONTAINER_ARGS -t ltp /bin/sh -c "cd ci && ./$INSTALL.sh && if [ \"$VARIANT\" ]; then ARCH=\"$ARCH\" ./$INSTALL.$VARIANT.sh; fi && CONFIGURE_OPT_EXTRA=\"$CONFIGURE_OPT_EXTRA\" ../build.sh -o $TREE -t $BUILD -c $CC $INSTALL_OPT"
diff --git a/travis/alpine.sh b/ci/alpine.sh
similarity index 100%
rename from travis/alpine.sh
rename to ci/alpine.sh
diff --git a/travis/centos.sh b/ci/centos.sh
similarity index 100%
rename from travis/centos.sh
rename to ci/centos.sh
diff --git a/travis/debian.cross-compile.sh b/ci/debian.cross-compile.sh
similarity index 100%
rename from travis/debian.cross-compile.sh
rename to ci/debian.cross-compile.sh
diff --git a/travis/debian.i386.sh b/ci/debian.i386.sh
similarity index 100%
rename from travis/debian.i386.sh
rename to ci/debian.i386.sh
diff --git a/travis/debian.minimal.sh b/ci/debian.minimal.sh
similarity index 100%
rename from travis/debian.minimal.sh
rename to ci/debian.minimal.sh
diff --git a/travis/debian.sh b/ci/debian.sh
similarity index 100%
rename from travis/debian.sh
rename to ci/debian.sh
diff --git a/travis/fedora.sh b/ci/fedora.sh
similarity index 100%
rename from travis/fedora.sh
rename to ci/fedora.sh
diff --git a/travis/opensuse.sh b/ci/opensuse.sh
similarity index 100%
rename from travis/opensuse.sh
rename to ci/opensuse.sh
diff --git a/travis/tumbleweed.sh b/ci/tumbleweed.sh
similarity index 100%
rename from travis/tumbleweed.sh
rename to ci/tumbleweed.sh
diff --git a/travis/ubuntu.sh b/ci/ubuntu.sh
similarity index 100%
rename from travis/ubuntu.sh
rename to ci/ubuntu.sh
-- 
2.31.1


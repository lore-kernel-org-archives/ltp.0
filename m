From: Petr Vorel <pvorel@suse.cz>
Date: Tue,  6 Aug 2019 18:45:23 +0200
Subject: [LTP] [PATCH v3 4/4] build: Move
 -Werror-implicit-function-declaration from make to build.sh
Message-ID: <20190806164523.557-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Previously it was passed only to Android build. Generally Werror flags
should be on for development but disabled for releases and production.
We don't have any configure flag stating development build, so using it
in build.sh should be sufficient as it can be used in both Travis CI
builds and local development.

+ respect CC variable in build.sh (for these lazy to pass it via -c flag)

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Change v2->v3:
* move flag to build.sh, so it can be reused for local development
* respect CC

 build.sh               | 4 +++-
 include/mk/env_post.mk | 4 ----
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/build.sh b/build.sh
index 3da2adf55..78845bf95 100755
--- a/build.sh
+++ b/build.sh
@@ -9,6 +9,9 @@
 
 set -e
 
+CFLAGS="${CFLAGS:--Werror-implicit-function-declaration}"
+CC="${CC:-gcc}"
+
 DEFAULT_PREFIX="$HOME/ltp-install"
 DEFAULT_BUILD="native"
 DEFAULT_TREE="in"
@@ -16,7 +19,6 @@ CONFIGURE_OPTS_IN_TREE="--with-open-posix-testsuite --with-realtime-testsuite"
 # TODO: open posix testsuite is currently broken in out-tree-build. Enable it once it's fixed.
 CONFIGURE_OPTS_OUT_TREE="--with-realtime-testsuite"
 MAKE_OPTS="-j$(getconf _NPROCESSORS_ONLN)"
-CC=gcc
 
 build_32()
 {
diff --git a/include/mk/env_post.mk b/include/mk/env_post.mk
index 913bdf5d1..f4169ad66 100644
--- a/include/mk/env_post.mk
+++ b/include/mk/env_post.mk
@@ -42,10 +42,6 @@ CPPFLAGS			+= -D__UCLIBC__ -DUCLINUX
 endif
 
 ifeq ($(ANDROID),1)
-# There are many undeclared functions, it's best not to accidentally overlook
-# them.
-CFLAGS				+= -Werror-implicit-function-declaration
-
 LDFLAGS				+= -L$(top_builddir)/lib/android_libpthread
 LDFLAGS				+= -L$(top_builddir)/lib/android_librt
 endif
-- 
2.22.0


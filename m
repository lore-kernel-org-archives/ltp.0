From: Petr Vorel <pvorel@suse.cz>
Date: Fri,  2 Aug 2019 17:04:45 +0200
Subject: [LTP] [PATCH v2 4/4] make,
 travis: Remove -Werror-implicit-function-declaration
In-Reply-To: <20190802150445.10984-1-pvorel@suse.cz>
References: <20190802150445.10984-1-pvorel@suse.cz>
Message-ID: <20190802150445.10984-5-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

and add it to Travis CI builds.

Previously it was passed only to Android build. Generally Werror flags
should be on for development but disabled for releases and production.
We don't have any configure flag stating development build, so using it
only in Travis CI should be sufficient (although we lost lost this check
for Android as we don't test it in our Travis CI setup).

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Travis build: https://travis-ci.org/pevik/ltp/builds/566982062

 .travis.yml            | 3 ++-
 include/mk/env_post.mk | 4 ----
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index a29551650..dcb5affb5 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -79,5 +79,6 @@ script:
     - INSTALL="${DISTRO%%:*}"
     - INSTALL="${INSTALL%%/*}"
     - if [ ! "$TREE" ]; then TREE="in"; fi
+    - CFLAGS="-Werror-implicit-function-declaration"
     - case $VARIANT in cross-compile*) BUILD="cross";; i386) BUILD="32";; *) BUILD="native";; esac
-    - docker run -it ltp /bin/sh -c "cd travis && ./$INSTALL.sh && if [ \"$VARIANT\" ]; then ./$INSTALL.$VARIANT.sh; fi && ../build.sh -o $TREE -t $BUILD -c $CC"
+    - docker run -it ltp /bin/sh -c "cd travis && ./$INSTALL.sh && if [ \"$VARIANT\" ]; then ./$INSTALL.$VARIANT.sh; fi && CFLAGS='$CFLAGS' ../build.sh -o $TREE -t $BUILD -c $CC"
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


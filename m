From: Clemens Famulla-Conrad <cfamullaconrad@suse.de>
Date: Mon, 18 Nov 2019 11:57:35 +0100
Subject: [LTP] [PATCH v1] travis: add ppc64le and s390x builds (issue: #615)
Message-ID: <20191118105735.15012-1-cfamullaconrad@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Travis started to support ppc64le and s390x
https://blog.travis-ci.com/2019-11-12-multi-cpu-architecture-ibm-power-ibm-z

This patch enable ppc64le and s390x build on debian:stable.

Remove `-i` switch from docker command as it isn't needed and caused
trouble running docker 'The input device is not a tty'.

Signed-off-by: Clemens Famulla-Conrad <cfamullaconrad@suse.de>
---
 .travis.yml | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index b16a3872a..be1504b92 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -65,6 +65,16 @@ matrix:
           env: DISTRO=centos:latest
           compiler: gcc
 
+        - os: linux
+          arch: ppc64le
+          compiler: gcc
+          env: DISTRO=debian:stable
+
+        - os: linux
+          arch: s390x
+          compiler: gcc
+          env: DISTRO=debian:stable
+
 before_install:
     - DIR="/usr/src/ltp"
     - printf "FROM $DISTRO\nRUN mkdir -p $DIR\nWORKDIR $DIR\nCOPY . $DIR\n" > Dockerfile
@@ -76,4 +86,4 @@ script:
     - INSTALL="${INSTALL%%/*}"
     - if [ ! "$TREE" ]; then TREE="in"; fi
     - case $VARIANT in cross-compile*) BUILD="cross";; i386) BUILD="32";; *) BUILD="native";; esac
-    - docker run -it ltp /bin/sh -c "cd travis && ./$INSTALL.sh && if [ \"$VARIANT\" ]; then ./$INSTALL.$VARIANT.sh; fi && ../build.sh -o $TREE -t $BUILD -c $CC"
+    - docker run -t ltp /bin/sh -c "cd travis && ./$INSTALL.sh && if [ \"$VARIANT\" ]; then ./$INSTALL.$VARIANT.sh; fi && ../build.sh -o $TREE -t $BUILD -c $CC"
-- 
2.16.4


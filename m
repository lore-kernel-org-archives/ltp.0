From: Petr Vorel <pvorel@suse.cz>
Date: Fri,  1 Mar 2019 11:33:04 +0100
Subject: [LTP] [PATCH] travis: Use official opensuse images
Message-ID: <20190301103304.20233-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

We're using deprecated opensuse images [1] [2] which has been now
removed, which cause travis failures. Replace them with the official
ones.

[1] https://hub.docker.com/_/opensuse/
[2] https://github.com/docker-library/official-images/issues/5371

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
https://travis-ci.org/pevik/ltp/builds/500273788
---
 .travis.yml | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 24de925b0..8c3aa241d 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -46,11 +46,11 @@ matrix:
           compiler: gcc
 
         - os: linux
-          env: DISTRO=opensuse:tumbleweed
+          env: DISTRO=opensuse/tumbleweed
           compiler: gcc
 
         - os: linux
-          env: DISTRO=opensuse:leap
+          env: DISTRO=opensuse/leap
           compiler: gcc
 
         - os: linux
@@ -72,6 +72,7 @@ before_install:
 
 script:
     - INSTALL="${DISTRO%%:*}"
+    - INSTALL="${INSTALL%%/*}"
     - if [ ! "$TREE" ]; then TREE="in"; fi
     - case $VARIANT in cross-compile*) BUILD="cross";; i386) BUILD="32";; *) BUILD="native";; esac
     - docker run -it ltp /bin/sh -c "cd travis && ./$INSTALL.sh && if [ \"$VARIANT\" ]; then ./$INSTALL.$VARIANT.sh; fi && ../build.sh -o $TREE -t $BUILD -c $CC"
-- 
2.20.1


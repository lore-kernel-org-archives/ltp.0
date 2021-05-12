From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 12 May 2021 18:57:02 +0200
Subject: [LTP] [PATCH 2/2] travis: Enhance docparse testing
In-Reply-To: <20210512165702.22883-1-pvorel@suse.cz>
References: <20210512165702.22883-1-pvorel@suse.cz>
Message-ID: <20210512165702.22883-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Specify various asciidoc and asciidoctor configure setup,
including PDF. Used in native builds only.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Tested:
https://travis-ci.org/github/pevik/ltp/builds/770919150

A proof it finds a bug introduced in 04a7608fe and reverted in c0b511d93:
https://travis-ci.org/github/pevik/ltp/jobs/770919265

Kind regards,
Petr

 .travis.yml | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index ef996889a..5d759dab4 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -1,4 +1,4 @@
-# Copyright (c) 2017-2020 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2017-2021 Petr Vorel <pvorel@suse.cz>
 
 dist: bionic
 sudo: required
@@ -30,7 +30,7 @@ matrix:
         - os: linux
           # Message: WARNING: xsltproc: cannot process http://docbook.sourceforge.net/release/xsl-ns/current/manpages/docbook.xsl
           # doc/meson.build:70:1: ERROR: Problem encountered: Docs cannot be built: xsltproc does not work correctly
-          env: DISTRO=alpine:latest
+          env: DISTRO=alpine:latest METADATA=asciidoctor
           compiler: gcc
 
         # build with minimal dependencies
@@ -40,47 +40,47 @@ matrix:
 
         # other builds
         - os: linux
-          env: DISTRO=fedora:latest MAKE_INSTALL=1 CONTAINER=podman
+          env: DISTRO=fedora:latest MAKE_INSTALL=1 CONTAINER=podman METADATA=asciidoctor-pdf
           compiler: clang
 
         - os: linux
-          env: DISTRO=centos:7 TREE=out
+          env: DISTRO=centos:7 TREE=out METADATA=asciidoc-pdf
           compiler: gcc
 
         - os: linux
-          env: DISTRO=debian:testing
+          env: DISTRO=debian:testing METADATA=asciidoctor-pdf
           compiler: gcc
 
         - os: linux
-          env: DISTRO=debian:oldstable
+          env: DISTRO=debian:oldstable METADATA=asciidoc-pdf
           compiler: clang
 
         - os: linux
-          env: DISTRO=opensuse/tumbleweed CONTAINER=podman
+          env: DISTRO=opensuse/tumbleweed CONTAINER=podman METADATA=asciidoctor
           compiler: gcc
 
         - os: linux
-          env: DISTRO=opensuse/leap
+          env: DISTRO=opensuse/leap METADATA=asciidoc-pdf
           compiler: gcc
 
         - os: linux
-          env: DISTRO=debian:oldstable
+          env: DISTRO=debian:oldstable METADATA=asciidoctor
           compiler: gcc
 
         - os: linux
-          env: DISTRO=debian:testing
+          env: DISTRO=debian:testing METADATA=asciidoc-pdf
           compiler: clang
 
         - os: linux
-          env: DISTRO=ubuntu:groovy TREE=out
+          env: DISTRO=ubuntu:groovy TREE=out METADATA=asciidoctor
           compiler: gcc
 
         - os: linux
-          env: DISTRO=ubuntu:xenial
+          env: DISTRO=ubuntu:xenial METADATA=asciidoc-pdf
           compiler: gcc
 
         - os: linux
-          env: DISTRO=centos:latest
+          env: DISTRO=centos:latest METADATA=asciidoctor
           compiler: gcc
 
 before_install:
@@ -123,6 +123,9 @@ script:
     - INSTALL="${DISTRO%%:*}"
     - INSTALL="${INSTALL%%/*}"
     - if [ "$MAKE_INSTALL" = 1 ]; then INSTALL_OPT="-i"; fi
+    - if [ "$METADATA" = "asciidoc-pdf" ]; then CONFIGURE_OPT_EXTRA="--with-metadata-generator=asciidoc --enable-metadata-pdf"; fi
+    - if [ "$METADATA" = "asciidoctor" ]; then CONFIGURE_OPT_EXTRA="--with-metadata-generator=asciidoctor"; fi
+    - if [ "$METADATA" = "asciidoctor-pdf" ]; then CONFIGURE_OPT_EXTRA="--with-metadata-generator=asciidoctor --enable-metadata-pdf"; fi
     - if [ ! "$TREE" ]; then TREE="in"; fi
     - case $VARIANT in cross-compile*) BUILD="cross";; i386) BUILD="32";; *) BUILD="native";; esac
-    - $CONTAINER run $CONTAINER_ARGS -t ltp /bin/sh -c "cd travis && ./$INSTALL.sh && if [ \"$VARIANT\" ]; then ARCH=\"$ARCH\" ./$INSTALL.$VARIANT.sh; fi && ../build.sh -o $TREE -t $BUILD -c $CC $INSTALL_OPT"
+    - $CONTAINER run $CONTAINER_ARGS -t ltp /bin/sh -c "cd travis && ./$INSTALL.sh && if [ \"$VARIANT\" ]; then ARCH=\"$ARCH\" ./$INSTALL.$VARIANT.sh; fi && CONFIGURE_OPT_EXTRA=\"$CONFIGURE_OPT_EXTRA\" ../build.sh -o $TREE -t $BUILD -c $CC $INSTALL_OPT"
-- 
2.31.1


From: Petr Vorel <petr.vorel@gmail.com>
Date: Tue, 10 Dec 2019 21:13:19 +0100
Subject: [LTP] [PATCH 1/3] travis: Add musl build (with Alpine Linux)
In-Reply-To: <20191210201321.1430984-1-petr.vorel@gmail.com>
References: <20191210201321.1430984-1-petr.vorel@gmail.com>
Message-ID: <20191210201321.1430984-2-petr.vorel@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

it was needed to temporarily remove test broken on musl
to fix compilation.

Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
---
 .travis.yml      |  7 +++++++
 travis/alpine.sh | 51 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)
 create mode 100755 travis/alpine.sh

diff --git a/.travis.yml b/.travis.yml
index 51040b0f0..51efa22e3 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -19,6 +19,13 @@ matrix:
           env: DISTRO=debian:stable VARIANT=cross-compile.aarch64 TREE="out"
           compiler: aarch64-linux-gnu-gcc
 
+        # musl (native)
+        - os: linux
+          # Message: WARNING: xsltproc: cannot process http://docbook.sourceforge.net/release/xsl-ns/current/manpages/docbook.xsl
+          # doc/meson.build:70:1: ERROR: Problem encountered: Docs cannot be built: xsltproc does not work correctly
+          env: DISTRO=alpine:latest
+          compiler: gcc
+
         # build with minimal dependencies
         - os: linux
           env: DISTRO=debian:stable VARIANT=minimal TREE="out"
diff --git a/travis/alpine.sh b/travis/alpine.sh
new file mode 100755
index 000000000..cef627b65
--- /dev/null
+++ b/travis/alpine.sh
@@ -0,0 +1,51 @@
+#!/bin/sh
+# Copyright (c) 2019 Petr Vorel <petr.vorel@gmail.com>
+set -e
+
+apk update
+
+apk add \
+	acl-dev \
+	autoconf \
+	automake \
+	clang \
+	gcc \
+	keyutils-dev \
+	libaio-dev \
+	libacl \
+	libcap-dev \
+	libselinux-dev \
+	libsepol-dev \
+	libtirpc-dev \
+	linux-headers \
+	make \
+	musl-dev \
+	numactl-dev \
+	openssl-dev \
+	pkgconfig
+
+echo "=== /etc/os-release ==="
+cat /etc/os-release
+
+echo "WARNING: remove unsupported tests (until they're fixed)"
+cd ..
+rm -rfv \
+	testcases/kernel/pty/pty01.c \
+	testcases/kernel/pty/pty02.c \
+	testcases/kernel/pty/ptem01.c \
+	testcases/kernel/sched/process_stress/process.c \
+	testcases/kernel/syscalls/accept4/accept4_01.c \
+	testcases/kernel/syscalls/confstr/confstr01.c \
+	testcases/kernel/syscalls/fmtmsg/fmtmsg01.c \
+	testcases/kernel/syscalls/getcontext/getcontext01.c \
+	testcases/kernel/syscalls/getdents/getdents01.c \
+	testcases/kernel/syscalls/getdents/getdents02.c \
+	testcases/kernel/syscalls/ioctl/ioctl01.c \
+	testcases/kernel/syscalls/ioctl/ioctl02.c \
+	testcases/kernel/syscalls/rt_tgsigqueueinfo/rt_tgsigqueueinfo01.c \
+	testcases/kernel/syscalls/sched_getaffinity/sched_getaffinity01.c \
+	testcases/kernel/syscalls/timer_create/timer_create01.c \
+	testcases/kernel/syscalls/timer_create/timer_create03.c \
+	testcases/misc/crash/crash01.c \
+	utils/benchmark/ebizzy-0.3
+cd -
-- 
2.24.0


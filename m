From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 10 Nov 2020 13:00:35 +0100
Subject: [LTP] [PATCH 1/1] travis: Add libefivar support
Message-ID: <20201110120035.20543-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

Travis support for Martin's patchset
https://patchwork.ozlabs.org/project/ltp/list/?series=213179&state=*

Travis CI:
https://travis-ci.org/github/pevik/ltp/builds/742684375

Kind regards,
Petr

 travis/debian.cross-compile.sh | 1 +
 travis/debian.i386.sh          | 1 +
 travis/debian.minimal.sh       | 1 +
 travis/debian.sh               | 1 +
 travis/fedora.sh               | 1 +
 travis/tumbleweed.sh           | 1 +
 6 files changed, 6 insertions(+)

diff --git a/travis/debian.cross-compile.sh b/travis/debian.cross-compile.sh
index 0a7ef7710..e27c6c9bc 100755
--- a/travis/debian.cross-compile.sh
+++ b/travis/debian.cross-compile.sh
@@ -20,5 +20,6 @@ apt update
 apt install -y --no-install-recommends \
 	gcc-${gcc_arch}-linux-gnu \
 	libc6-dev-${ARCH}-cross \
+	libefivar-dev:$ARCH \
 	libmnl-dev:$ARCH \
 	libtirpc-dev:$ARCH
diff --git a/travis/debian.i386.sh b/travis/debian.i386.sh
index 707a23ca6..1cf7734dd 100755
--- a/travis/debian.i386.sh
+++ b/travis/debian.i386.sh
@@ -13,6 +13,7 @@ apt install -y --no-install-recommends \
 	libcap2:i386 \
 	libc6-dev-i386 \
 	libc6:i386 \
+	libefivar-dev:i386 \
 	libkeyutils1:i386 \
 	libnuma1:i386 \
 	libssl-dev:i386 \
diff --git a/travis/debian.minimal.sh b/travis/debian.minimal.sh
index 3f1941969..4b6d65727 100755
--- a/travis/debian.minimal.sh
+++ b/travis/debian.minimal.sh
@@ -8,6 +8,7 @@ apt remove -y \
 	libaio1 \
 	libcap-dev \
 	libcap2 \
+	libefivar-dev \
 	libkeyutils-dev \
 	libkeyutils1 \
 	libmm-dev \
diff --git a/travis/debian.sh b/travis/debian.sh
index b759a9576..dec18189c 100755
--- a/travis/debian.sh
+++ b/travis/debian.sh
@@ -25,6 +25,7 @@ apt install -y --no-install-recommends \
 	libcap2 \
 	libc6 \
 	libc6-dev \
+	libefivar-dev \
 	libkeyutils-dev \
 	libkeyutils1 \
 	libmm-dev \
diff --git a/travis/fedora.sh b/travis/fedora.sh
index 990a84daf..27b979353 100755
--- a/travis/fedora.sh
+++ b/travis/fedora.sh
@@ -9,6 +9,7 @@ yum -y install \
 	clang \
 	gcc \
 	findutils \
+	efivar-devel \
 	libtirpc \
 	libtirpc-devel \
 	pkg-config \
diff --git a/travis/tumbleweed.sh b/travis/tumbleweed.sh
index 4d5e9da79..2ce919426 100755
--- a/travis/tumbleweed.sh
+++ b/travis/tumbleweed.sh
@@ -10,6 +10,7 @@ zypper --non-interactive install --force-resolution --no-recommends \
 	gcc \
 	gzip \
 	make \
+	efivar-devel \
 	kernel-default-devel \
 	keyutils-devel \
 	libacl-devel \
-- 
2.29.2


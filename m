From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon,  5 Oct 2020 15:30:52 +0200
Subject: [LTP] [PATCH 09/11] travis: Install docparse dependencies
In-Reply-To: <20201005133054.23587-1-chrubis@suse.cz>
References: <20201005133054.23587-1-chrubis@suse.cz>
Message-ID: <20201005133054.23587-10-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Petr Vorel <pvorel@suse.cz>

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 travis/alpine.sh         |  3 +++
 travis/debian.minimal.sh |  8 +++++++-
 travis/debian.sh         |  9 ++++++++-
 travis/fedora.sh         | 11 ++++++++---
 travis/tumbleweed.sh     |  8 +++++++-
 5 files changed, 33 insertions(+), 6 deletions(-)

diff --git a/travis/alpine.sh b/travis/alpine.sh
index f8960bed0..b793a9fbe 100755
--- a/travis/alpine.sh
+++ b/travis/alpine.sh
@@ -6,6 +6,8 @@ apk update
 
 apk add \
 	acl-dev \
+	asciidoc \
+	asciidoctor \
 	autoconf \
 	automake \
 	clang \
@@ -23,6 +25,7 @@ apk add \
 	musl-dev \
 	numactl-dev \
 	openssl-dev \
+	perl-json \
 	pkgconfig
 
 cat /etc/os-release
diff --git a/travis/debian.minimal.sh b/travis/debian.minimal.sh
index 3f1941969..5e6ba8662 100755
--- a/travis/debian.minimal.sh
+++ b/travis/debian.minimal.sh
@@ -2,7 +2,11 @@
 # Copyright (c) 2018-2020 Petr Vorel <pvorel@suse.cz>
 set -ex
 
-apt remove -y \
+apt="apt remove -y"
+
+$apt \
+	asciidoc \
+	asciidoctor \
 	libacl1-dev \
 	libaio-dev \
 	libaio1 \
@@ -17,3 +21,5 @@ apt remove -y \
 	libsepol1-dev \
 	libssl-dev \
 	libtirpc-dev
+
+$apt asciidoc-base ruby-asciidoctor || true
diff --git a/travis/debian.sh b/travis/debian.sh
index 28685f4d3..743b79001 100755
--- a/travis/debian.sh
+++ b/travis/debian.sh
@@ -8,8 +8,12 @@ grep -v oldstable-updates /etc/apt/sources.list > /tmp/sources.list && mv /tmp/s
 
 apt update
 
-apt install -y --no-install-recommends \
+apt="apt install -y --no-install-recommends"
+
+$apt \
 	acl-dev \
+	asciidoc \
+	asciidoctor \
 	autoconf \
 	automake \
 	build-essential \
@@ -26,6 +30,7 @@ apt install -y --no-install-recommends \
 	libcap2 \
 	libc6 \
 	libc6-dev \
+	libjson-perl \
 	libkeyutils-dev \
 	libkeyutils1 \
 	libmm-dev \
@@ -40,4 +45,6 @@ apt install -y --no-install-recommends \
 	lsb-release \
 	pkg-config
 
+$apt ruby-asciidoctor-pdf || true
+
 df -hT
diff --git a/travis/fedora.sh b/travis/fedora.sh
index 3c224f71e..6127d367d 100755
--- a/travis/fedora.sh
+++ b/travis/fedora.sh
@@ -2,7 +2,10 @@
 # Copyright (c) 2018-2020 Petr Vorel <pvorel@suse.cz>
 set -ex
 
-yum -y install \
+yum="yum -y install"
+
+$yum \
+	asciidoc \
 	autoconf \
 	automake \
 	make \
@@ -12,8 +15,10 @@ yum -y install \
 	findutils \
 	libtirpc \
 	libtirpc-devel \
+	perl-JSON \
 	pkg-config \
 	redhat-lsb-core
 
-# CentOS 8 doesn't have libmnl-devel
-yum -y install libmnl-devel || yum -y install libmnl
+# CentOS 8 fixes
+$yum libmnl-devel || $yum libmnl
+$yum rubygem-asciidoctor || true
diff --git a/travis/tumbleweed.sh b/travis/tumbleweed.sh
index 6247daa98..43ca3252a 100755
--- a/travis/tumbleweed.sh
+++ b/travis/tumbleweed.sh
@@ -2,7 +2,10 @@
 # Copyright (c) 2018-2020 Petr Vorel <pvorel@suse.cz>
 set -ex
 
-zypper --non-interactive install --force-resolution --no-recommends \
+zyp="zypper --non-interactive install --force-resolution --no-recommends"
+
+$zyp \
+	asciidoc \
 	autoconf \
 	automake \
 	clang \
@@ -23,4 +26,7 @@ zypper --non-interactive install --force-resolution --no-recommends \
 	libtirpc-devel \
 	linux-glibc-devel \
 	lsb-release \
+	perl-JSON \
 	pkg-config
+
+$zyp ruby2.7-rubygem-asciidoctor || $zyp ruby2.5-rubygem-asciidoctor
-- 
2.26.2


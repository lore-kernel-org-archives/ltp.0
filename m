From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 14 Apr 2021 20:28:50 +0200
Subject: [LTP] [PATCH v2 1/1] travis: Fix openSUSE Tumbleweed
Message-ID: <20210414182850.23308-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

openSUSE Tumbleweed build fails due broken permission detection due
faccessat2() incompatibility in libseccomp/runc used in old docker with
old kernel on Ubuntu Focal on hosts in Travis CI together with guests
with the newest glibc 2.33.

Fixing Tumbleweed required switch to podman and downloading newest runc
release (v1.0.0-rc93) which contains the fix [1], because proposed glibc
fix [2] aren't going to merged to upstream [3] nor to Tumbleweed
downstream glibc [4].

Using podman requires sudo to workaround running out of subuids/subgids:
tar: ./LICENSE: Cannot change ownership to uid 339315, gid 578953: Invalid argument

Sooner or later it will be required for more distros (Fedora, Debian
Ubuntu), but don't waste build time until required.

Also add --network=host to avoid problems on certain Travis setup:
Error: /usr/bin/slirp4netns failed: "open(\"/dev/net/tun\"): No such device

[1] https://github.com/opencontainers/runc/pull/2750
[2] https://sourceware.org/pipermail/libc-alpha/2020-November/119955.html
[3] https://sourceware.org/pipermail/libc-alpha/2020-November/119978.html
[4] https://bugzilla.opensuse.org/1182451

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes v1->v2:
* Add --network=host parameter (found by Mimi)
* Remove --runtime=/usr/bin/runc, it's the default thus not needed to be set

Kind regards,
Petr
 .travis.yml | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index e73b24e..3053c5d 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -1,4 +1,7 @@
+# Copyright (c) 2017-2021 Petr Vorel <pvorel@suse.cz>
+
 dist: bionic
+sudo: required
 language: C
 services:
     - docker
@@ -30,7 +33,7 @@ matrix:
 
         # glibc (gcc/clang)
         - os: linux
-          env: DISTRO=opensuse/tumbleweed TSS=ibmtss
+          env: DISTRO=opensuse/tumbleweed TSS=ibmtss CONTAINER=podman CONTAINER_ARGS="--network=host"
           compiler: clang
 
         - os: linux
@@ -66,13 +69,29 @@ matrix:
           compiler: gcc
 
 before_install:
-    - df -hT
+    # Tumbleweed requires podman and newest runc due docker incompatible with glibc 2.33 (faccessat2)
+    - CONTAINER="${CONTAINER:-docker}"
+    - >
+        if [ "$CONTAINER" = "podman" ]; then
+            # podman
+            . /etc/os-release
+            sudo sh -c "echo 'deb http://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_${VERSION_ID}/ /' > /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list"
+            wget -nv https://download.opensuse.org/repositories/devel:kubic:libcontainers:stable/xUbuntu_${VERSION_ID}/Release.key -O- | sudo apt-key add -
+            sudo apt update
+            sudo apt -y install podman slirp4netns
+
+            # runc
+            sudo curl -L https://github.com/opencontainers/runc/releases/download/v1.0.0-rc93/runc.amd64 -o /usr/bin/runc
+            sudo chmod +x /usr/bin/runc
+        fi
+    - $CONTAINER info
+
     - DIR="/usr/src/ima-evm-utils"
     - printf "FROM $DISTRO\nRUN mkdir -p $DIR\nWORKDIR $DIR\nCOPY . $DIR\n" > Dockerfile
     - cat Dockerfile
-    - docker build -t ima-evm-utils .
+    - $CONTAINER build $CONTAINER_ARGS -t ima-evm-utils .
 
 script:
     - INSTALL="${DISTRO%%:*}"
     - INSTALL="${INSTALL%%/*}"
-    - docker run -t ima-evm-utils /bin/sh -c "cd travis && if [ \"$VARIANT\" ]; then ARCH=\"$ARCH\" ./$INSTALL.$VARIANT.sh; fi && ARCH=\"$ARCH\" CC=\"$CC\" TSS=\"$TSS\" ./$INSTALL.sh && if [ ! \"$VARIANT\" ]; then which tpm_server || which swtpm || ../tests/install-swtpm.sh; fi && CC=\"$CC\" VARIANT=\"$VARIANT\" ../build.sh"
+    - sudo $CONTAINER run $CONTAINER_ARGS -t ima-evm-utils /bin/sh -c "cd travis && if [ \"$VARIANT\" ]; then ARCH=\"$ARCH\" ./$INSTALL.$VARIANT.sh; fi && ARCH=\"$ARCH\" CC=\"$CC\" TSS=\"$TSS\" ./$INSTALL.sh && if [ ! \"$VARIANT\" ]; then which tpm_server || which swtpm || ../tests/install-swtpm.sh; fi && CC=\"$CC\" VARIANT=\"$VARIANT\" ../build.sh"
-- 
2.31.1


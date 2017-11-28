From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 29 Nov 2017 00:21:30 +0100
Subject: [LTP] [RFC PATCH 4/4] travis: Install all dependencies (headers and
	libraries)
In-Reply-To: <20171128232130.4843-1-pvorel@suse.cz>
References: <20171128232130.4843-1-pvorel@suse.cz>
Message-ID: <20171128232130.4843-5-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Before it was checked building the code without dependencies (i.e.
warning about missing libraries => testing autotools checks) which
we don't now, but it's better test building the code with installed
dependencies.

The only exception is selinux support on 32bit build as as
libsepol1-dev:i386 conflict with libsepol1-dev:amd64, thus
libselinux1-dev:i386 cannot be installed:
The following packages have unmet dependencies:
 libsepol1-dev : Conflicts: libsepol1-dev:i386 but 2.2-1ubuntu0.1 is to be installed
 libsepol1-dev:i386 : Conflicts: libsepol1-dev but 2.2-1ubuntu0.1 is to be installed
E: Unable to correct problems, you have held broken packages.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .travis.yml | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/.travis.yml b/.travis.yml
index 2c186b71c..7e4fdb2c3 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -108,4 +108,34 @@ notifications:
         secure: "b/xcA/K5OyQvPPnd0PRahTH5LJu8lgz8goGHvhXpHo+ZPsPgTDXNFo5cX9fSOkMuFKeoW8iGl0wOgK2+ptc8mbYDw277K4RFIHRHeV/KIoE1EzjQnEFiL8J0oHCAvDj12o0AXeriTyY9gICXKbR31Br6Zh5eKViDJe2OAGeHeDU="
 
 before_install:
+    - sudo apt install -f -y
+      libacl1-dev
+      libacl1:amd64
+      libacl1:i386
+      libaio-dev
+      libaio1:amd64
+      libaio1:i386
+      libcap-dev
+      libcap2:amd64
+      libcap2:i386
+      libc6
+      libc6-dev
+      libc6-dev-i386
+      libc6:i386
+      libkeyutils-dev
+      libkeyutils1:amd64
+      libkeyutils1:i386
+      libmm-dev
+      libnuma-dev
+      libnuma1:amd64
+      libnuma1:i386
+      libselinux1-dev:amd64
+      libssl-dev:amd64
+      libssl-dev:i386
+      libsepol1-dev:amd64
+      libssl-dev
+      libtirpc1:amd64
+      libtirpc1:i386
+      linux-libc-dev
+
 script: ./build.sh $BUILD
-- 
2.15.0


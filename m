From: Petr Vorel <pvorel@suse.cz>
Date: Fri,  1 Dec 2017 16:46:40 +0100
Subject: [LTP] [RFC PATCH v2 4/5] travis: Add out-of-tree build
In-Reply-To: <20171201154641.27407-1-pvorel@suse.cz>
References: <20171201154641.27407-1-pvorel@suse.cz>
Message-ID: <20171201154641.27407-5-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .travis.yml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/.travis.yml b/.travis.yml
index 3ca37e47a..cc5627412 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -74,6 +74,14 @@ matrix:
                   sources: ['ubuntu-toolchain-r-test']
                   packages: ['gcc-6', 'gcc-6-multilib', 'linux-libc-dev:i386']
 
+        - os: linux
+          env: BUILD="out"
+          compiler: gcc-7
+          addons:
+              apt:
+                  sources: ['ubuntu-toolchain-r-test']
+                  packages: ['gcc-7']
+
 notifications:
     email:
         secure: "b/xcA/K5OyQvPPnd0PRahTH5LJu8lgz8goGHvhXpHo+ZPsPgTDXNFo5cX9fSOkMuFKeoW8iGl0wOgK2+ptc8mbYDw277K4RFIHRHeV/KIoE1EzjQnEFiL8J0oHCAvDj12o0AXeriTyY9gICXKbR31Br6Zh5eKViDJe2OAGeHeDU="
-- 
2.15.0


From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 14 Jul 2021 16:20:01 +0200
Subject: [LTP] [PATCH v5 4/4] CI: Run also make test
In-Reply-To: <20210714142001.20566-1-pvorel@suse.cz>
References: <20210714142001.20566-1-pvorel@suse.cz>
Message-ID: <20210714142001.20566-5-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

on all targets

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .github/workflows/ci.yml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/.github/workflows/ci.yml b/.github/workflows/ci.yml
index f67f14927..776dbf646 100644
--- a/.github/workflows/ci.yml
+++ b/.github/workflows/ci.yml
@@ -151,6 +151,11 @@ jobs:
     - name: Compile
       run: ./build.sh -r build -o ${TREE:-in}
 
+    - name: Test
+      run: |
+        case "$VARIANT" in cross-compile*) BUILD="cross";; i386) BUILD="32";; *) BUILD="native";; esac
+        ./build.sh -r test -o ${TREE:-in} -t $BUILD
+
     - name: Install
       run: |
         if [ "$MAKE_INSTALL" = 1 ]; then INSTALL_OPT="-i"; fi
-- 
2.32.0


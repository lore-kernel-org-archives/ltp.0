From: Petr Vorel <pvorel@suse.cz>
Date: Mon,  2 Aug 2021 19:35:35 +0200
Subject: [LTP] [PATCH v7 6/7] CI: Run also make test-c, test-shell
In-Reply-To: <20210802173536.19525-1-pvorel@suse.cz>
References: <20210802173536.19525-1-pvorel@suse.cz>
Message-ID: <20210802173536.19525-7-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

run C and shell test separately (test-c and test-shell instead of test).
Having them separate helps to easily navigate in CI.

It's run on all jobs, but on cross compile jobs it's obviously skipped.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
The same as in v6.

 .github/workflows/ci.yml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/.github/workflows/ci.yml b/.github/workflows/ci.yml
index f67f14927..9d37f49e4 100644
--- a/.github/workflows/ci.yml
+++ b/.github/workflows/ci.yml
@@ -151,6 +151,16 @@ jobs:
     - name: Compile
       run: ./build.sh -r build -o ${TREE:-in}
 
+    - name: Test C API
+      run: |
+        case "$VARIANT" in cross-compile*) BUILD="cross";; i386) BUILD="32";; *) BUILD="native";; esac
+        ./build.sh -r test-c -o ${TREE:-in} -t $BUILD
+
+    - name: Test shell API
+      run: |
+        case "$VARIANT" in cross-compile*) BUILD="cross";; i386) BUILD="32";; *) BUILD="native";; esac
+        ./build.sh -r test-shell -o ${TREE:-in} -t $BUILD
+
     - name: Install
       run: |
         if [ "$MAKE_INSTALL" = 1 ]; then INSTALL_OPT="-i"; fi
-- 
2.32.0


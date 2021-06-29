From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 29 Jun 2021 23:48:08 +0200
Subject: [LTP] [PATCH v3 5/5] CI: Run also make test
In-Reply-To: <20210629214808.18760-1-pvorel@suse.cz>
References: <20210629214808.18760-1-pvorel@suse.cz>
Message-ID: <20210629214808.18760-6-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

on all targets

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .github/workflows/ci.yml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.github/workflows/ci.yml b/.github/workflows/ci.yml
index f67f14927..553d3c62b 100644
--- a/.github/workflows/ci.yml
+++ b/.github/workflows/ci.yml
@@ -151,6 +151,9 @@ jobs:
     - name: Compile
       run: ./build.sh -r build -o ${TREE:-in}
 
+    - name: Test
+      run: ./build.sh -r test -o ${TREE:-in}
+
     - name: Install
       run: |
         if [ "$MAKE_INSTALL" = 1 ]; then INSTALL_OPT="-i"; fi
-- 
2.32.0


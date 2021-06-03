From: Petr Vorel <pvorel@suse.cz>
Date: Thu,  3 Jun 2021 20:38:27 +0200
Subject: [LTP] [RFC PATCH 3/3] CI: Run also make check
In-Reply-To: <20210603183827.24339-1-pvorel@suse.cz>
References: <20210603183827.24339-1-pvorel@suse.cz>
Message-ID: <20210603183827.24339-4-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

ona all targets

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .github/workflows/ci.yml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.github/workflows/ci.yml b/.github/workflows/ci.yml
index 185f49e41..01e2578fa 100644
--- a/.github/workflows/ci.yml
+++ b/.github/workflows/ci.yml
@@ -151,6 +151,9 @@ jobs:
     - name: Compile
       run: ./build.sh -r build -o ${TREE:-in}
 
+    - name: Test
+      run: ./build.sh -r check -o ${TREE:-in}
+
     - name: Install
       run: |
         if [ "$MAKE_INSTALL" = 1 ]; then INSTALL_OPT="-i"; fi
-- 
2.31.1


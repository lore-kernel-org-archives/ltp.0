From: Joerg Vehlow <lkml@jv-coder.de>
Date: Fri, 11 Oct 2019 11:07:37 +0200
Subject: [LTP] [PATCH 2/2] shell: Rename
 s/tst_test_drivers/tst_require_drivers/
In-Reply-To: <20191011090737.17997-1-lkml@jv-coder.de>
References: <20191011090737.17997-1-lkml@jv-coder.de>
Message-ID: <20191011090737.17997-3-lkml@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Joerg Vehlow <joerg.vehlow@aox-tech.de>

This require describes the function of the command better than test.
"tst_require_root" is also a well established name in ltp api with the
same semantic.

Signed-off-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>
---
 testcases/lib/tst_test.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 125e3a105..4c9a92c2c 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -326,7 +326,7 @@ tst_check_cmds()
 	return 0
 }
 
-tst_test_drivers()
+tst_require_drivers()
 {
 	[ $# -eq 0 ] && return 0
 
@@ -449,7 +449,7 @@ tst_run()
 	[ "$TST_DISABLE_SELINUX" = 1 ] && tst_disable_selinux
 
 	tst_require_cmds $TST_NEEDS_CMDS
-	tst_test_drivers $TST_NEEDS_DRIVERS
+	tst_require_drivers $TST_NEEDS_DRIVERS
 
 	if [ -n "$TST_MIN_KVER" ]; then
 		tst_kvcmp -lt "$TST_MIN_KVER" && \
-- 
2.20.1


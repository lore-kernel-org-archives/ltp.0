From: Joerg Vehlow <lkml@jv-coder.de>
Date: Tue, 16 Mar 2021 07:55:42 +0100
Subject: [LTP] [PATCH] open_posix: Add all logfiles to gitignore
Message-ID: <20210316065542.1221203-1-lkml@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Joerg Vehlow <joerg.vehlow@aox-tech.de>

The logfiles are created, when the tests are compiled and
should not be committed.

Signed-off-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>
---
 testcases/open_posix_testsuite/.gitignore | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/testcases/open_posix_testsuite/.gitignore b/testcases/open_posix_testsuite/.gitignore
index 7ddf3cd90..ad281df14 100644
--- a/testcases/open_posix_testsuite/.gitignore
+++ b/testcases/open_posix_testsuite/.gitignore
@@ -13,3 +13,5 @@
 
 /bin/t0
 run.sh
+
+logfile
\ No newline at end of file
-- 
2.25.1


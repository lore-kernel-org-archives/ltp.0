From: Yixin Zhang <yixin.zhang@intel.com>
Date: Fri, 20 Apr 2018 11:18:51 +0800
Subject: [LTP] [PATCH ltp 2/6] io/stress_floppy/stress_floppy: Fix
	shellcheck issue SC2069
In-Reply-To: <20180420031855.22657-1-yixin.zhang@intel.com>
References: <20180420031855.22657-1-yixin.zhang@intel.com>
Message-ID: <20180420031855.22657-2-yixin.zhang@intel.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

error: The order of the 2>&1 and the redirect matters. The 2>&1 has to
be last. [SC2069]

Signed-off-by: Yixin Zhang <yixin.zhang@intel.com>
---
 testcases/kernel/io/stress_floppy/stress_floppy | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/io/stress_floppy/stress_floppy b/testcases/kernel/io/stress_floppy/stress_floppy
index b269f5ffe..ff327dffb 100755
--- a/testcases/kernel/io/stress_floppy/stress_floppy
+++ b/testcases/kernel/io/stress_floppy/stress_floppy
@@ -96,7 +96,7 @@ test_tar()
 		else
 			tst_resm TINFO "$the_file Tar read passed."
 		fi
-		diff $TCdat/dumpdir/$the_file $the_file 2>&1 >/dev/null
+		diff $TCdat/dumpdir/$the_file $the_file >/dev/null 2>&1
 		if [ $? -ne 0 ]; then
 			tst_resm TFAIL "Diff of the $the_file tar files failed!"
 			return
@@ -140,7 +140,7 @@ test_dump()
 
 	for the_file in 1K_file 10K_file 100K_file
 	do
-		diff dumpdir/$the_file /$TCdat/dumpdir/$the_file 2>&1 >/dev/null
+		diff dumpdir/$the_file /$TCdat/dumpdir/$the_file >/dev/null 2>&1
 		if [ $? -ne 0 ]; then
 			tst_resm TFAIL \
 				 "Diff of the $the_file backup files failed!"
@@ -180,7 +180,7 @@ test_cpio()
 		else
 			tst_resm TINFO "$the_file cpio read passed."
 		fi
-		diff $TCdat/dumpdir/$the_file $the_file 2>&1 >/dev/null
+		diff $TCdat/dumpdir/$the_file $the_file >/dev/null 2>&1
 		if [ $? -ne 0 ]; then
 			tst_resm TFAIL \
 				 "Diff of the $the_file cpio files failed!"
@@ -213,7 +213,7 @@ test_dd()
 		else
 			tst_resm TINFO "$the_file dd read passed."
 		fi
-		diff $TCdat/$the_file $the_file 2>&1 >/dev/null
+		diff $TCdat/$the_file $the_file >/dev/null 2>&1
 		if [ $? -ne 0 ]; then
 			tst_resm TFAIL "Diff of the $the_file dd files failed!"
 			return
-- 
2.14.1


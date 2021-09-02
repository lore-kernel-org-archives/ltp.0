From: Petr Vorel <pvorel@suse.cz>
Date: Thu,  2 Sep 2021 18:19:57 +0200
Subject: [LTP] [PATCH 1/1] controllers/cpuacct: Simplify deleting directories
Message-ID: <20210902161957.2140-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

by using rm -rf instead of 2x rmdir and checks for dir presence.

Also move TINFO to print it only when relevant.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/controllers/cpuacct/cpuacct.sh | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/controllers/cpuacct/cpuacct.sh b/testcases/kernel/controllers/cpuacct/cpuacct.sh
index b2347e801..99258c266 100755
--- a/testcases/kernel/controllers/cpuacct/cpuacct.sh
+++ b/testcases/kernel/controllers/cpuacct/cpuacct.sh
@@ -119,13 +119,10 @@ setup()
 
 cleanup()
 {
-	tst_res TINFO "removing created directories"
 
 	if [ "$testpath" ]; then
-		if [ -d "$testpath/subgroup_1" ]; then
-			rmdir $testpath/subgroup_*
-		fi
-		rmdir $testpath
+		tst_res TINFO "removing created directories"
+		rm -rf $testpath
 	fi
 
 	if [ "$mounted" -ne 1 ]; then
-- 
2.33.0


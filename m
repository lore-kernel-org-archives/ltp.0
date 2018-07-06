From: Yixin Zhang <yixin.zhang@intel.com>
Date: Fri,  6 Jul 2018 15:36:51 +0800
Subject: [LTP] [PATCH ltp] stress.part1: sync change of fs_inod01 from 'fs'
Message-ID: <20180706073651.12942-1-yixin.zhang@intel.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

There is another fs_inod01 in the test case scenario 'fs', and the
iteration is increased from 1 to 10 in commit
b0458a3c838c86faf2d8855c097628c0c435532a, so implement the same change
here.

Signed-off-by: Yixin Zhang <yixin.zhang@intel.com>
---
 runtest/stress.part1 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/runtest/stress.part1 b/runtest/stress.part1
index 423d25e38..af6fce511 100644
--- a/runtest/stress.part1
+++ b/runtest/stress.part1
@@ -157,7 +157,7 @@ rwtest05 export LTPROOT; rwtest -N rwtest05 -c -q -i 50 -T 64b 500b:/tmp/rwtest0
 #iogen01 iogen -i 120s -s read,write 500b:doio.f1.$$ 1000b:doio.f2.$$ | doio -akv -n 2
 iogen01 export LTPROOT; rwtest -N iogen01 -i 120s -s read,write -Da -Dv -n 2 500b:doio.f1.$$ 1000b:doio.f2.$$
 
-fs_inod01 fs_inod $TMPDIR 10 10 1
+fs_inod01 fs_inod $TMPDIR 10 10 10
 linker01 linktest.sh 1000 1000
 openfile01 openfile -f10 -t10
 inode01 inode01
-- 
2.14.1


From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 29 Aug 2019 20:11:46 +0200
Subject: [LTP] [PATCH] memcg_stress_test.sh: Respect LTP_TIMEOUT_MUL set by
 user
Message-ID: <20190829181146.20261-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

While it's good to increase the default LTP_TIMEOUT_MUL value, give user
a chance to change it.

Fixes: 877b445c9 ("memcg_stress_test.sh: ported to newlib")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh b/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
index 5b19cc292..0d3ded112 100755
--- a/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
+++ b/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
@@ -17,7 +17,7 @@ TST_NEEDS_CMDS="mount umount cat kill mkdir rmdir grep awk cut"
 
 # Each test case runs for 900 secs when everything fine
 # therefore the default 5 mins timeout is not enough.
-LTP_TIMEOUT_MUL=7
+LTP_TIMEOUT_MUL=${LTP_TIMEOUT_MUL:-7}
 
 . cgroup_lib.sh
 
-- 
2.22.1


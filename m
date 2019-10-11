From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 11 Oct 2019 11:54:41 +0200
Subject: [LTP] [PATCH v5 4/5] memcg_stress_test.sh: use TST_TIMEOUT (replace
 LTP_TIMEOUT_MUL)
In-Reply-To: <20191011095442.10541-1-pvorel@suse.cz>
References: <20191011095442.10541-1-pvorel@suse.cz>
Message-ID: <20191011095442.10541-5-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

keeping the same timeout

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh b/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
index 5b19cc292..ad8605e16 100755
--- a/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
+++ b/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
@@ -17,7 +17,7 @@ TST_NEEDS_CMDS="mount umount cat kill mkdir rmdir grep awk cut"
 
 # Each test case runs for 900 secs when everything fine
 # therefore the default 5 mins timeout is not enough.
-LTP_TIMEOUT_MUL=7
+TST_TIMEOUT=2100
 
 . cgroup_lib.sh
 
-- 
2.23.0


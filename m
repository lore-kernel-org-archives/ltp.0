From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 14 Jun 2018 12:04:36 +0200
Subject: [LTP] [PATCH 1/1] tst_test.sh: Add default trap to INT
Message-ID: <20180614100436.28558-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

+ remove it's definition from network stress tests already
converted to the new API.

Trap function can be overwritten in tests, if needed.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/tst_test.sh                           | 3 +++
 testcases/network/stress/interface/if4-addr-change  | 2 --
 testcases/network/stress/ns-tools/tst_net_stress.sh | 1 -
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index d27b4afd6..a8585bafd 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -32,6 +32,9 @@ export TST_TMPDIR_RHOST=0
 
 . tst_ansi_color.sh
 
+# default trap function
+trap "tst_brk TBROK 'test interrupted'" INT
+
 _tst_do_exit()
 {
 	local ret=0
diff --git a/testcases/network/stress/interface/if4-addr-change b/testcases/network/stress/interface/if4-addr-change
index 8ed3ce3a8..5ab67751e 100644
--- a/testcases/network/stress/interface/if4-addr-change
+++ b/testcases/network/stress/interface/if4-addr-change
@@ -34,8 +34,6 @@ do_cleanup()
 	tst_wait_ipv6_dad
 }
 
-trap "tst_brk TBROK 'test interrupted'" INT
-
 test_body()
 {
 	local cnt=0
diff --git a/testcases/network/stress/ns-tools/tst_net_stress.sh b/testcases/network/stress/ns-tools/tst_net_stress.sh
index e5c2672a3..2a9120e11 100644
--- a/testcases/network/stress/ns-tools/tst_net_stress.sh
+++ b/testcases/network/stress/ns-tools/tst_net_stress.sh
@@ -40,7 +40,6 @@ netstress_setup()
 {
 	TST_NEEDS_ROOT=1
 	tst_check_cmds pgrep pkill
-	trap "tst_brk TBROK 'test interrupted'" INT
 }
 
 # Cleanup for tests using netstress.
-- 
2.17.1


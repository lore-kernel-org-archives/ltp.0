From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Date: Tue, 13 Jul 2021 18:15:56 +0200
Subject: [LTP] [PATCH] controllers/memcg: document non-hierarchical on v5.11
Message-ID: <20210713161556.63096-1-krzysztof.kozlowski@canonical.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Since kernel v5.11, there is no non-hierarchical mode, so mention it in
the code.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../kernel/controllers/memcg/functional/memcg_lib.sh | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
index 3d04c3a60700..873b637c88f9 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
@@ -124,13 +124,17 @@ memcg_setup()
 	ROD mkdir /dev/memcg
 	ROD mount -t cgroup -omemory memcg /dev/memcg
 
-	# The default value for memory.use_hierarchy is 0 and some of tests
-	# (memcg_stat_test.sh and memcg_use_hierarchy_test.sh) expect it so
-	# while there are distributions (RHEL7U0Beta for example) that sets
-	# it to 1.
+	# For kernels older than v5.11 the default value for
+	# memory.use_hierarchy is 0 and some of tests (memcg_stat_test.sh and
+	# memcg_use_hierarchy_test.sh) expect it so while there are
+	# distributions (RHEL7U0Beta for example) that sets it to 1.
 	# Note: If there are already subgroups created it is not possible,
 	# to set this back to 0.
 	# This seems to be the default for all systems using systemd.
+	#
+	# Starting with kernel v5.11, the non-hierarchical mode is not
+	# available. See Linux kernel commit bef8620cd8e0 ("mm: memcg:
+	# deprecate the non-hierarchical mode").
 	orig_memory_use_hierarchy=$(cat /dev/memcg/memory.use_hierarchy)
 	if [ -z "$orig_memory_use_hierarchy" ];then
 		tst_res TINFO "cat /dev/memcg/ failed"
-- 
2.27.0


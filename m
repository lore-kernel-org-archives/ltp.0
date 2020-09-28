From: Po-Hsu Lin <po-hsu.lin@canonical.com>
Date: Mon, 28 Sep 2020 13:40:43 +0800
Subject: [LTP] [PATCH] cpuset_inherit_test: compatibility fix for DASH
Message-ID: <20200928054043.17058-1-po-hsu.lin@canonical.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The /bin/sh was symbolically link to dash in Ubuntu, in which the
"let" expression does not work, it will complain about:
    cpuset_inherit_testset.sh: let: not found

Fix it with double parentheses arithmetic expansion to improve the
compatibility.

Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
---
 .../cpuset/cpuset_inherit_test/cpuset_inherit_testset.sh        | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/controllers/cpuset/cpuset_inherit_test/cpuset_inherit_testset.sh b/testcases/kernel/controllers/cpuset/cpuset_inherit_test/cpuset_inherit_testset.sh
index 86856c3fb..73eed2cb9 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_inherit_test/cpuset_inherit_testset.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_inherit_test/cpuset_inherit_testset.sh
@@ -106,7 +106,7 @@ inherit_test()
 test_cpus()
 {
 	cfile_name="cpus"
-	let "num=$nr_cpus-1"
+	num=$((nr_cpus-1))
 	cpu_string="0-$num"
 	if [ $nr_cpus -eq 1 ]; then
 		cpu_string="0"
-- 
2.17.1


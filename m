From: Punit Agrawal <punit.agrawal@arm.com>
Date: Wed, 11 Jul 2018 13:29:24 +0100
Subject: [LTP] [PATCH 3/4] memcg_lib.sh: Check for killall
In-Reply-To: <20180711122925.24278-1-punit.agrawal@arm.com>
References: <20180711122925.24278-1-punit.agrawal@arm.com>
Message-ID: <20180711122925.24278-4-punit.agrawal@arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
---
 testcases/kernel/controllers/memcg/functional/memcg_lib.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
index 7892f78c3..838706e1a 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
@@ -34,6 +34,9 @@ if [ $? -ne 0 ]; then
 	tst_brkm TBROK "getconf PAGESIZE failed"
 fi
 
+# Check for dependencies
+tst_check_cmds killall
+
 # Post 4.16 kernel updates stat in batch (> 32 pages) every time
 PAGESIZES=$(( $PAGESIZE * 33 ))
 
-- 
2.17.1


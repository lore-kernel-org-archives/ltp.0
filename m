From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Date: Fri,  2 Jul 2021 14:53:36 +0200
Subject: [LTP] [PATCH v3 3/5] controllers/memcg: accept non-zero
 max_usage_in_bytes after reset
In-Reply-To: <20210702125338.43248-1-krzysztof.kozlowski@canonical.com>
References: <20210702125338.43248-1-krzysztof.kozlowski@canonical.com>
Message-ID: <20210702125338.43248-4-krzysztof.kozlowski@canonical.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Several Linux kernel versions report a non-zero max_usage_in_bytes after
resetting the counter.  For example v5.4, v5.8, v5.10, v5.11, v5.12 and
5.13.0-rc5:

    memcg_max_usage_in_bytes_test 4 TINFO: Test reset memory.memsw.max_usage_in_bytes
    memcg_max_usage_in_bytes_test 4 TINFO: Running memcg_process --mmap-anon -s 4194304
    memcg_max_usage_in_bytes_test 4 TINFO: Warming up pid: 1416
    memcg_max_usage_in_bytes_test 4 TINFO: Process is still here after warm up: 1416
    memcg_max_usage_in_bytes_test 4 TFAIL: memory.memsw.max_usage_in_bytes is 4325376, 4194304 expected
    memcg_max_usage_in_bytes_test 4 TFAIL: memory.memsw.max_usage_in_bytes is 122880, 0 expected

It seems that recent Linux kernel caches the statistics more
aggressively (especially on multi-CPU systems) and the batch updates of
32 pages are visible in usage_in_bytes.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../memcg/functional/memcg_max_usage_in_bytes_test.sh           | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/controllers/memcg/functional/memcg_max_usage_in_bytes_test.sh b/testcases/kernel/controllers/memcg/functional/memcg_max_usage_in_bytes_test.sh
index 8831f1937070..2d494ac3a78f 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_max_usage_in_bytes_test.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_max_usage_in_bytes_test.sh
@@ -37,7 +37,7 @@ test_max_usage_in_bytes()
 
 	if [ $check_after_reset -eq 1 ]; then
 		echo 0 > $item
-		check_mem_stat $item 0
+		check_mem_stat $item 0 $PAGESIZES
 	fi
 
 	stop_memcg_process
-- 
2.27.0


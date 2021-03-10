From: Zhao Gongyi <zhaogongyi@huawei.com>
Date: Wed, 10 Mar 2021 10:03:48 +0800
Subject: [LTP] [PATCH] max_map_count: Add judgment of abnormal situation
Message-ID: <20210310020348.2077-1-zhaogongyi@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

When max_iters < max_maps, there is no post processing,
and the test will report "TBROK: Test haven't reported results".

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---------------
v1->v2: modify comparison span of the judgment.
---------------

---
 testcases/kernel/mem/tunable/max_map_count.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/testcases/kernel/mem/tunable/max_map_count.c b/testcases/kernel/mem/tunable/max_map_count.c
index aa70fde59..cf2df338a 100644
--- a/testcases/kernel/mem/tunable/max_map_count.c
+++ b/testcases/kernel/mem/tunable/max_map_count.c
@@ -164,6 +164,9 @@ static void max_map_count_test(void)
 		max_iters = MAX_MAP_COUNT;

 	max_maps = MAP_COUNT_DEFAULT;
+	if (max_iters < max_maps)
+		tst_brk(TCONF, "test requires more free memory");
+
 	while (max_maps <= max_iters) {
 		set_sys_tune("max_map_count", max_maps, 1);

--
2.17.1


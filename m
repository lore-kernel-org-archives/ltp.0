From: Cui Bixuan <cuibixuan@huawei.com>
Date: Fri, 16 Dec 2016 16:25:52 +0800
Subject: [LTP] [PATCH] max_map_count: fix a mistake and support it for
 aarch64_be
In-Reply-To: <56DD6138.9060109@huawei.com>
References: <56DD6138.9060109@huawei.com>
Message-ID: <5853A510.1090406@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

There is a mistake for if (strcmp()) for skipping in aarch64.
And there is the same error in aarch64be, so add it.

Signed-off-by: Cui Bixuan <cuibixuan@huawei.com>
---
 testcases/kernel/mem/tunable/max_map_count.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/mem/tunable/max_map_count.c b/testcases/kernel/mem/tunable/max_map_count.c
index eb7486f..ca322da 100644
--- a/testcases/kernel/mem/tunable/max_map_count.c
+++ b/testcases/kernel/mem/tunable/max_map_count.c
@@ -139,7 +139,7 @@ static bool filter_map(const char *line)
 		return true;
 #elif defined(__arm__)
 	/* Skip it when run it in aarch64 */
-	if (strcmp(un.machine, "aarch64"))
+	if ((!strcmp(un.machine, "aarch64")) || (!strcmp(un.machine, "aarch64_be")))
 		return false;

 	/* Older arm kernels didn't label their vdso maps */
-- 
2.6.2

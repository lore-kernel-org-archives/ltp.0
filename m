From: the_hoang0709@yahoo.com <the_hoang0709@yahoo.com>
Date: Sat, 17 Dec 2016 11:30:22 +0700
Subject: [LTP] [PATCH v3] Fix mistake in strcmp() for skipping in aarch64
Message-ID: <20161217043022.6148-1-the_hoang0709@yahoo.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Vertigo <the_hoang0709@yahoo.com>

Fix mistake in strcmp() for skipping in aarch64.
And there is the same error in aarch64be, so add it.

Signed-off-by: Vertigo <the_hoang0709@yahoo.com>
---
 testcases/kernel/mem/tunable/max_map_count.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/mem/tunable/max_map_count.c b/testcases/kernel/mem/tunable/max_map_count.c
index eb7486f..75a5098 100644
--- a/testcases/kernel/mem/tunable/max_map_count.c
+++ b/testcases/kernel/mem/tunable/max_map_count.c
@@ -139,7 +139,8 @@ static bool filter_map(const char *line)
 		return true;
 #elif defined(__arm__)
 	/* Skip it when run it in aarch64 */
-	if (strcmp(un.machine, "aarch64"))
+	if ((!strcmp(un.machine, "aarch64"))
+	|| (!strcmp(un.machine, "aarch64_be")))
 		return false;
 
 	/* Older arm kernels didn't label their vdso maps */
-- 
2.10.1.windows.1


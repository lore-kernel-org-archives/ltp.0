From: Martin Doucha <mdoucha@suse.cz>
Date: Wed, 27 Jan 2021 12:56:06 +0100
Subject: [LTP] [PATCH] Fix tst_pollute_memory() safety margin for huge
 systems
Message-ID: <20210127115606.28985-1-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

tst_pollute_memory() still has OOM issues on system with huge amounts of RAM.
Set safety margin to the largest value of:
- 2 * min_free_kbytes
- 128MB
- 4096 pages
- Free RAM / 128 (to account for memory allocation overhead)

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 lib/tst_memutils.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/tst_memutils.c b/lib/tst_memutils.c
index dd09db490..7cdb3dbe0 100644
--- a/lib/tst_memutils.c
+++ b/lib/tst_memutils.c
@@ -20,8 +20,11 @@ void tst_pollute_memory(size_t maxsize, int fillchar)
 	struct sysinfo info;
 
 	SAFE_SYSINFO(&info);
-	safety = MAX(4096 * SAFE_SYSCONF(_SC_PAGESIZE), 128 * 1024 * 1024);
+	SAFE_FILE_SCANF("/proc/sys/vm/min_free_kbytes", "%zd", &safety);
+	safety = MAX(2048 * safety, 128 * 1024 * 1024);
+	safety = MAX(safety, 4096 * SAFE_SYSCONF(_SC_PAGESIZE));
 	safety /= info.mem_unit;
+	safety = MAX(safety, info.freeram / 128);
 
 	if (info.freeswap > safety)
 		safety = 0;
-- 
2.29.2


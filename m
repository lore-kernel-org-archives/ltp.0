From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed,  3 May 2017 14:42:33 +0200
Subject: [LTP] [RFC] [PATCH] syscalls/move_pages12: Two fixes.
Message-ID: <20170503124233.18585-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

* Do not multiply free ram with 1024

  - Since we get overflow even on fairly modest
    machine with a few GB of RAM and the test
    will always report "Not enough RAM".

* Drop caches before the test

  - Otherwise the move_pages() syscalls may
    fail with ENOMEM.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/move_pages/move_pages12.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/move_pages/move_pages12.c b/testcases/kernel/syscalls/move_pages/move_pages12.c
index eeec489..b3ebb7c 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages12.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages12.c
@@ -139,13 +139,17 @@ static void setup(void)
 
 	pgsz = (int)get_page_size();
 	SAFE_FILE_LINES_SCANF(PATH_MEMINFO, "Hugepagesize: %d", &hpsz);
-	hpsz *= 1024;
+
+	SAFE_FILE_PRINTF("/proc/sys/vm/drop_caches", "1");
 
 	SAFE_FILE_LINES_SCANF(PATH_MEMINFO, "MemFree: %d", &memfree);
-	memfree *= 1024;
+	tst_res(TINFO, "Free RAM %d kB", memfree);
+
 	if (4 * hpsz > memfree)
 		tst_brk(TBROK, "Not enough free RAM");
 
+	hpsz *= 1024;
+
 	SAFE_FILE_SCANF(PATH_NR_HUGEPAGES, "%ld", &orig_hugepages);
 	SAFE_FILE_PRINTF(PATH_NR_HUGEPAGES, "%ld", orig_hugepages + 4);
 
-- 
2.7.3


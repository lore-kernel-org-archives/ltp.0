From: Zou Wei <zou_wei@huawei.com>
Date: Tue, 14 Jan 2020 20:19:16 +0800
Subject: [LTP] [PATCH] syscalls/madvise06: Change drop_caches file checking
 mode
Message-ID: <1579004356-19797-1-git-send-email-zou_wei@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The madvise06 case will be failed if merge the linux kernel lts patch on the below:

https://lore.kernel.org/linux-mm/20191031221602.9375-1-hannes@cmpxchg.org/
Currently, the drop_caches proc file and sysctl read back the last
value written, suggesting this is somehow a stateful setting instead
of a one-time command. Make it write-only, like e.g. compact_memory.

The commit id of the lts patch is: 204cb79ad42f015312a5bbd7012d09c93d9b46fb

Reported-by: Zou Wei <zou_wei@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 testcases/kernel/syscalls/madvise/madvise06.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/madvise/madvise06.c b/testcases/kernel/syscalls/madvise/madvise06.c
index 37840d0..329f558 100644
--- a/testcases/kernel/syscalls/madvise/madvise06.c
+++ b/testcases/kernel/syscalls/madvise/madvise06.c
@@ -49,7 +49,7 @@ static void setup(void)

 	pg_sz = getpagesize();

-	check_path(drop_caches_fname);
+	access(drop_caches_fname, W_OK);
 	tst_res(TINFO, "dropping caches");
 	sync();
 	SAFE_FILE_PRINTF(drop_caches_fname, "3");
--
2.6.2


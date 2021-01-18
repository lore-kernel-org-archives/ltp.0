From: Martin Doucha <mdoucha@suse.cz>
Date: Mon, 18 Jan 2021 17:32:40 +0100
Subject: [LTP] [PATCH] tst_pollute_memory(): Set minimal safety margin to
 64MB
Message-ID: <20210118163240.29558-1-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

4096 pages amounts to 16MB on x86_64 or 256MB on PPC64. 16MB is not enough
to avoid OOM killer on some systems so set the safety margin to either 64MB
or 4096 pages, whichever is higher.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Here's my proposed fix for the OOM issues with ioctl_sg01. I can't reproduce
the issue on my x86_64 VMs/machines so please confirm that it works.

Don't forget to run `make clean` after applying this patch because ioctl_sg01
will not be rebuilt automatically due to weak dependency on libltp.a.

 lib/tst_memutils.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/tst_memutils.c b/lib/tst_memutils.c
index f134d90c9..c20c94a00 100644
--- a/lib/tst_memutils.c
+++ b/lib/tst_memutils.c
@@ -20,7 +20,8 @@ void tst_pollute_memory(size_t maxsize, int fillchar)
 	struct sysinfo info;
 
 	SAFE_SYSINFO(&info);
-	safety = 4096 * SAFE_SYSCONF(_SC_PAGESIZE) / info.mem_unit;
+	safety = MAX(4096 * SAFE_SYSCONF(_SC_PAGESIZE), 64 * 1024 * 1024);
+	safety /= info.mem_unit;
 
 	if (info.freeswap > safety)
 		safety = 0;
-- 
2.29.2


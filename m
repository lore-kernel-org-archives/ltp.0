From: Xinpeng Liu <liuxp11@chinatelecom.cn>
Date: Mon, 25 Jan 2021 18:24:47 +0800
Subject: [LTP] [PATCH 1/2] syscalls/ioctl: ioctl_sg01.c: ioctl_sg01 invoked
 oom-killer
Message-ID: <1611570288-23040-1-git-send-email-liuxp11@chinatelecom.cn>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Kernel version is 5.4.81+,the available RAM is less than free,as follow:
[root@liuxp mywork]# head /proc/meminfo
MemTotal:       198101744 kB
MemFree:        189303148 kB
MemAvailable:   188566732 kB

So use available RAM to avoid OOM killer.

Signed-off-by: Xinpeng Liu <liuxp11@chinatelecom.cn>
---
 lib/tst_memutils.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/lib/tst_memutils.c b/lib/tst_memutils.c
index dd09db4..21df9a8 100644
--- a/lib/tst_memutils.c
+++ b/lib/tst_memutils.c
@@ -10,14 +10,33 @@
 
 #define TST_NO_DEFAULT_MAIN
 #include "tst_test.h"
+#include "tst_safe_stdio.h"
 
 #define BLOCKSIZE (16 * 1024 * 1024)
 
+static unsigned long get_available_ram(void)
+{
+	char buf[60]; /* actual lines we expect are ~30 chars or less */
+	unsigned long available_kb = 0;
+	FILE *fp;
+
+	fp = SAFE_FOPEN("/proc/meminfo","r");
+	while (fgets(buf, sizeof(buf), fp)) {
+		if (sscanf(buf, "MemAvailable: %lu %*s\n", &available_kb) == 1){
+			break;
+		}
+	}
+	SAFE_FCLOSE(fp);
+
+	return 1024 * available_kb;
+}
+
 void tst_pollute_memory(size_t maxsize, int fillchar)
 {
 	size_t i, map_count = 0, safety = 0, blocksize = BLOCKSIZE;
 	void **map_blocks;
 	struct sysinfo info;
+	unsigned long available_ram = get_available_ram();
 
 	SAFE_SYSINFO(&info);
 	safety = MAX(4096 * SAFE_SYSCONF(_SC_PAGESIZE), 128 * 1024 * 1024);
@@ -26,15 +45,19 @@ void tst_pollute_memory(size_t maxsize, int fillchar)
 	if (info.freeswap > safety)
 		safety = 0;
 
+	/*"MemAvailable" field maybe not exist, or freeram less than available_ram*/
+	if(available_ram == 0 || info.freeram < available_ram)
+		available_ram = info.freeram;
+
 	/* Not enough free memory to avoid invoking OOM killer */
-	if (info.freeram <= safety)
+	if (available_ram <= safety)
 		return;
 
 	if (!maxsize)
 		maxsize = SIZE_MAX;
 
-	if (info.freeram - safety < maxsize / info.mem_unit)
-		maxsize = (info.freeram - safety) * info.mem_unit;
+	if (available_ram - safety < maxsize / info.mem_unit)
+		maxsize = (available_ram - safety) * info.mem_unit;
 
 	blocksize = MIN(maxsize, blocksize);
 	map_count = maxsize / blocksize;
-- 
1.8.3.1


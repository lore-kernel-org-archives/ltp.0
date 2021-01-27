From: liuxp11@chinatelecom.cn <liuxp11@chinatelecom.cn>
Date: Wed, 27 Jan 2021 14:20:28 +0800
Subject: [LTP] [PATCH v2 1/2] syscalls/ioctl: ioctl_sg01.c: ioctl_sg01
 invoked oom-killer
References: <1611580694-4000-1-git-send-email-liuxp11@chinatelecom.cn>
Message-ID: <202101271420280317517@chinatelecom.cn>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

sorry,
unsigned long available_ram = SAFE_READ_MEMINFO("MemAvailable:"); 
--->unsigned long available_ram = 1024 * SAFE_READ_MEMINFO("MemAvailable:"); 
From: Xinpeng Liu
Date: 2021-01-25 21:18
To: ltp
CC: Xinpeng Liu
Subject: [PATCH v2 1/2] syscalls/ioctl: ioctl_sg01.c: ioctl_sg01 invoked oom-killer
Kernel version is 5.4.81+,the available RAM is less than free,as follow:
[root@liuxp mywork]# head /proc/meminfo
MemTotal:       198101744 kB
MemFree:        189303148 kB
MemAvailable:   188566732 kB
 
So use available RAM to avoid OOM killer.
---
lib/tst_memutils.c | 11 ++++++++---
1 file changed, 8 insertions(+), 3 deletions(-)
 
diff --git a/lib/tst_memutils.c b/lib/tst_memutils.c
index dd09db4..8596005 100644
--- a/lib/tst_memutils.c
+++ b/lib/tst_memutils.c
@@ -18,6 +18,7 @@ void tst_pollute_memory(size_t maxsize, int fillchar)
size_t i, map_count = 0, safety = 0, blocksize = BLOCKSIZE;
void **map_blocks;
struct sysinfo info;
+ unsigned long available_ram = SAFE_READ_MEMINFO("MemAvailable:");
SAFE_SYSINFO(&info);
safety = MAX(4096 * SAFE_SYSCONF(_SC_PAGESIZE), 128 * 1024 * 1024);
@@ -26,15 +27,19 @@ void tst_pollute_memory(size_t maxsize, int fillchar)
if (info.freeswap > safety)
safety = 0;
+ /*"MemAvailable" field maybe not exist, or freeram less than available_ram*/
+ if(available_ram == 0 || info.freeram < available_ram)
+ available_ram = info.freeram;
+
/* Not enough free memory to avoid invoking OOM killer */
- if (info.freeram <= safety)
+ if (available_ram <= safety)
return;
if (!maxsize)
maxsize = SIZE_MAX;
- if (info.freeram - safety < maxsize / info.mem_unit)
- maxsize = (info.freeram - safety) * info.mem_unit;
+ if (available_ram - safety < maxsize / info.mem_unit)
+ maxsize = (available_ram - safety) * info.mem_unit;
blocksize = MIN(maxsize, blocksize);
map_count = maxsize / blocksize;
-- 
1.8.3.1
 
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210127/85153326/attachment.htm>

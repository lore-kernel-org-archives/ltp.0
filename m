From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 24 May 2017 13:34:04 +0200
Subject: [LTP] [COMMITTED] [PATCH 2/2] lib,
	testcases: Make use of MIN() and MAX()
In-Reply-To: <20170524113404.8894-1-chrubis@suse.cz>
References: <20170524113404.8894-1-chrubis@suse.cz>
Message-ID: <20170524113404.8894-2-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Produced by variations on coccinelle spatch:

@@
expression E1,E2;
@@

- (E1 > E2 ? E1 : E2)
+ MAX(E1, E2)

@@
expression E1,E2;
identifier V;
@@

- if (E1 < E2)
- V = E1;
- else
- V = E2;
+ V = MIN(E1, E2);

...

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 lib/tst_device.c                                   |  4 ++--
 .../controllers/cpuset/cpuset_lib/libbitmask.c     | 10 +++++-----
 .../controllers/cpuset/cpuset_lib/libcpuset.c      | 23 ++++++++++------------
 testcases/kernel/fs/doio/growfiles.c               |  5 +----
 testcases/kernel/fs/inode/inode02.c                |  5 +----
 testcases/kernel/mem/cpuset/cpuset01.c             |  2 +-
 testcases/kernel/mem/mtest01/mtest01.c             |  5 +----
 testcases/kernel/syscalls/brk/brk01.c              |  5 +----
 testcases/kernel/syscalls/mprotect/mprotect02.c    |  8 +++-----
 .../network/can/filter-tests/can_rcv_own_msgs.c    |  5 ++---
 10 files changed, 27 insertions(+), 45 deletions(-)

diff --git a/lib/tst_device.c b/lib/tst_device.c
index 5c91a54..936bbfd 100644
--- a/lib/tst_device.c
+++ b/lib/tst_device.c
@@ -41,7 +41,7 @@
 #define LOOP_CONTROL_FILE "/dev/loop-control"
 
 #define DEV_FILE "test_dev.img"
-#define DEV_SIZE_MB 256
+#define DEV_SIZE_MB 256u
 
 static char dev_path[1024];
 static int device_acquired;
@@ -205,7 +205,7 @@ const char *tst_acquire_device__(unsigned int size)
 	unsigned int acq_dev_size;
 	uint64_t ltp_dev_size;
 
-	acq_dev_size = size > DEV_SIZE_MB ? size : DEV_SIZE_MB;
+	acq_dev_size = MAX(size, DEV_SIZE_MB);
 
 	dev = getenv("LTP_DEV");
 
diff --git a/testcases/kernel/controllers/cpuset/cpuset_lib/libbitmask.c b/testcases/kernel/controllers/cpuset/cpuset_lib/libbitmask.c
index 57faf78..dbae375 100644
--- a/testcases/kernel/controllers/cpuset/cpuset_lib/libbitmask.c
+++ b/testcases/kernel/controllers/cpuset/cpuset_lib/libbitmask.c
@@ -28,6 +28,7 @@
 #include <stdint.h>
 
 #include "bitmask.h"
+#include "tst_minmax.h"
 
 struct bitmask {
 	unsigned int size;
@@ -112,7 +113,6 @@ void bitmask_free(struct bitmask *bmp)
 
 #define HEXCHUNKSZ 32		/* hex binary format shows 32 bits per chunk */
 #define HEXCHARSZ 8		/* hex ascii format has up to 8 chars per chunk */
-#define max(a,b) ((a) > (b) ? (a) : (b))
 
 /*
  * Write hex word representation of bmp to buf, 32 bits per
@@ -139,7 +139,7 @@ int bitmask_displayhex(char *buf, int buflen, const struct bitmask *bmp)
 
 		for (bit = HEXCHUNKSZ - 1; bit >= 0; bit--)
 			val = val << 1 | _getbit(bmp, chunk * HEXCHUNKSZ + bit);
-		cnt += snprintf(buf + cnt, max(buflen - cnt, 0), "%s%0*x",
+		cnt += snprintf(buf + cnt, MAX(buflen - cnt, 0), "%s%0*x",
 				sep, HEXCHARSZ, val);
 		sep = ",";
 	}
@@ -158,12 +158,12 @@ int bitmask_displayhex(char *buf, int buflen, const struct bitmask *bmp)
 static inline int emit(char *buf, int buflen, int rbot, int rtop, int len)
 {
 	if (len > 0)
-		len += snprintf(buf + len, max(buflen - len, 0), ",");
+		len += snprintf(buf + len, MAX(buflen - len, 0), ",");
 	if (rbot == rtop)
-		len += snprintf(buf + len, max(buflen - len, 0), "%d", rbot);
+		len += snprintf(buf + len, MAX(buflen - len, 0), "%d", rbot);
 	else
 		len +=
-		    snprintf(buf + len, max(buflen - len, 0), "%d-%d", rbot,
+		    snprintf(buf + len, MAX(buflen - len, 0), "%d-%d", rbot,
 			     rtop);
 	return len;
 }
diff --git a/testcases/kernel/controllers/cpuset/cpuset_lib/libcpuset.c b/testcases/kernel/controllers/cpuset/cpuset_lib/libcpuset.c
index 83ff5cd..e46bd2e 100644
--- a/testcases/kernel/controllers/cpuset/cpuset_lib/libcpuset.c
+++ b/testcases/kernel/controllers/cpuset/cpuset_lib/libcpuset.c
@@ -138,9 +138,6 @@ static const char *mapfile = "/var/run/cpunodemap";
 /* The primary source for the cpunodemap[] is available below here. */
 static const char *sysdevices = "/sys/devices/system";
 
-#define max(a,b) ((a) > (b) ? (a) : (b))
-#define min(a,b) ((a) < (b) ? @ : (b))
-
 /* small buffer size - for reading boolean flags or map file (1 or 2 ints) */
 #define SMALL_BUFSZ 16
 
@@ -2499,7 +2496,7 @@ int cpuset_nuke(const char *relpath, unsigned int seconds)
 		if (secs_loop < 10)
 			secs_loop++;
 
-		secs_loop = min(secs_left, secs_loop);
+		secs_loop = MIN(secs_left, secs_loop);
 	}
 
 took_too_long:
@@ -3484,39 +3481,39 @@ int cpuset_export(const struct cpuset *cp, char *buf, int buflen)
 	int n = 0;
 
 	if (cp->cpu_exclusive)
-		n += snprintf(buf + n, max(buflen - n, 0), "cpu_exclusive\n");
+		n += snprintf(buf + n, MAX(buflen - n, 0), "cpu_exclusive\n");
 
 	if (cp->mem_exclusive)
-		n += snprintf(buf + n, max(buflen - n, 0), "mem_exclusive\n");
+		n += snprintf(buf + n, MAX(buflen - n, 0), "mem_exclusive\n");
 
 	if (cp->notify_on_release)
-		n += snprintf(buf + n, max(buflen - n, 0),
+		n += snprintf(buf + n, MAX(buflen - n, 0),
 			      "notify_on_release\n");
 
 	if (cp->memory_pressure_enabled)
-		n += snprintf(buf + n, max(buflen - n, 0),
+		n += snprintf(buf + n, MAX(buflen - n, 0),
 			      "memory_pressure_enabled\n");
 
 	if (cp->memory_migrate)
-		n += snprintf(buf + n, max(buflen - n, 0), "memory_migrate\n");
+		n += snprintf(buf + n, MAX(buflen - n, 0), "memory_migrate\n");
 
 	if (cp->memory_spread_page)
-		n += snprintf(buf + n, max(buflen - n, 0),
+		n += snprintf(buf + n, MAX(buflen - n, 0),
 			      "memory_spread_page\n");
 
 	if (cp->memory_spread_slab)
-		n += snprintf(buf + n, max(buflen - n, 0),
+		n += snprintf(buf + n, MAX(buflen - n, 0),
 			      "memory_spread_slab\n");
 
 	if ((tmp = sprint_mask_buf(cp->cpus)) == NULL)
 		return -1;
-	n += snprintf(buf + n, max(buflen - n, 0), "cpus %s\n", tmp);
+	n += snprintf(buf + n, MAX(buflen - n, 0), "cpus %s\n", tmp);
 	free(tmp);
 	tmp = NULL;
 
 	if ((tmp = sprint_mask_buf(cp->mems)) == NULL)
 		return -1;
-	n += snprintf(buf + n, max(buflen - n, 0), "mems %s\n", tmp);
+	n += snprintf(buf + n, MAX(buflen - n, 0), "mems %s\n", tmp);
 	free(tmp);
 	tmp = NULL;
 
diff --git a/testcases/kernel/fs/doio/growfiles.c b/testcases/kernel/fs/doio/growfiles.c
index bbad230..02df1b2 100644
--- a/testcases/kernel/fs/doio/growfiles.c
+++ b/testcases/kernel/fs/doio/growfiles.c
@@ -2756,10 +2756,7 @@ int check_file(int fd, int cf_inter, char *filename, int no_file_check)
 
 		rd_cnt = 0;
 		while (rd_cnt < fsize) {
-			if (fsize - rd_cnt > MAX_FC_READ)
-				rd_size = MAX_FC_READ;
-			else
-				rd_size = fsize - rd_cnt;
+			rd_size = MIN(MAX_FC_READ, fsize - rd_cnt);
 
 #if NEWIO
 			ret = lio_read_buffer(fd, io_type, buf, rd_size,
diff --git a/testcases/kernel/fs/inode/inode02.c b/testcases/kernel/fs/inode/inode02.c
index 0e42085..78495ec 100644
--- a/testcases/kernel/fs/inode/inode02.c
+++ b/testcases/kernel/fs/inode/inode02.c
@@ -346,10 +346,7 @@ int tree()
 
 	ch_ret_val = check();
 
-	if (gen_ret_val > ch_ret_val)
-		exit_val = ch_ret_val;
-	else
-		exit_val = gen_ret_val;
+	exit_val = MIN(ch_ret_val, gen_ret_val);
 
 	status = fclose(list_stream);
 	if (status != 0) {
diff --git a/testcases/kernel/mem/cpuset/cpuset01.c b/testcases/kernel/mem/cpuset/cpuset01.c
index 558420f..e6e3c01 100644
--- a/testcases/kernel/mem/cpuset/cpuset01.c
+++ b/testcases/kernel/mem/cpuset/cpuset01.c
@@ -109,7 +109,7 @@ static void testcpuset(void)
 		}
 		if (set_mempolicy(MPOL_BIND, nmask, MAXNODES) == -1)
 			tst_brkm(TBROK | TERRNO, cleanup, "set_mempolicy");
-		exit(mem_hog_cpuset(ncpus > 1 ? ncpus : 1));
+		exit(mem_hog_cpuset(MAX(ncpus, 1)));
 	}
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		tst_count = 0;
diff --git a/testcases/kernel/mem/mtest01/mtest01.c b/testcases/kernel/mem/mtest01/mtest01.c
index 6225d7d..ca9073a 100644
--- a/testcases/kernel/mem/mtest01/mtest01.c
+++ b/testcases/kernel/mem/mtest01/mtest01.c
@@ -250,10 +250,7 @@ int main(int argc, char *argv[])
 			pid_list[i] = pid;
 		}
 	}
-	if (maxbytes > THREE_GB)
-		alloc_bytes = THREE_GB;
-	else
-		alloc_bytes = maxbytes;
+	alloc_bytes = MIN(THREE_GB, maxbytes);
 #endif
 
 	if (pid == 0) {
diff --git a/testcases/kernel/syscalls/brk/brk01.c b/testcases/kernel/syscalls/brk/brk01.c
index 3b38f1e..775bc15 100644
--- a/testcases/kernel/syscalls/brk/brk01.c
+++ b/testcases/kernel/syscalls/brk/brk01.c
@@ -179,10 +179,7 @@ void setup(void)
 	 * never attempt to take more than a * 1/4 of memory (by single test)
 	 */
 
-	if (ulim_sz < usr_mem_sz)
-		max_size = ulim_sz;
-	else
-		max_size = usr_mem_sz;
+	max_size = MIN(ulim_sz, usr_mem_sz);
 
 	max_size = max_size / (2 * ncpus);
 
diff --git a/testcases/kernel/syscalls/mprotect/mprotect02.c b/testcases/kernel/syscalls/mprotect/mprotect02.c
index a513493..31455c7 100644
--- a/testcases/kernel/syscalls/mprotect/mprotect02.c
+++ b/testcases/kernel/syscalls/mprotect/mprotect02.c
@@ -59,7 +59,8 @@ int main(int ac, char **av)
 {
 	int lc;
 
-	int bytes_to_write, fd, num_bytes;
+	int bytes_to_write, fd;
+	unsigned int num_bytes;
 	pid_t pid;
 
 	tst_parse_opts(ac, av, NULL, NULL);
@@ -76,10 +77,7 @@ int main(int ac, char **av)
 
 		do {
 
-			if (num_bytes > strlen(buf))
-				bytes_to_write = strlen(buf);
-			else
-				bytes_to_write = num_bytes;
+			bytes_to_write = MIN(strlen(buf), num_bytes);
 
 			num_bytes -=
 			    SAFE_WRITE(cleanup, 1, fd, buf, bytes_to_write);
diff --git a/testcases/network/can/filter-tests/can_rcv_own_msgs.c b/testcases/network/can/filter-tests/can_rcv_own_msgs.c
index 2f9cbf2..8ad51d2 100644
--- a/testcases/network/can/filter-tests/can_rcv_own_msgs.c
+++ b/testcases/network/can/filter-tests/can_rcv_own_msgs.c
@@ -53,14 +53,13 @@
 #include <net/if.h>
 #include "config.h"
 #include "tst_res_flags.h"
+#include "tst_minmax.h"
 
 #ifdef HAVE_LINUX_CAN_H
 
 #include <linux/can.h>
 #include <linux/can/raw.h>
 
-#define max(a, b) ((a) > (b) ? (a) : (b))
-
 struct rxs {
 	int s;
 	int t;
@@ -70,7 +69,7 @@ struct rxs test_sockets(int s, int t, canid_t can_id)
 {
 	fd_set rdfs;
 	struct timeval tv;
-	int m = max(s, t) + 1;
+	int m = MAX(s, t) + 1;
 	int have_rx = 1;
 	struct can_frame frame;
 	struct rxs rx;
-- 
2.10.2


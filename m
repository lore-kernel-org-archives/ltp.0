From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 28 Nov 2018 18:46:43 +0200
Subject: [LTP] [PATCH v4 4/6] syscalls/readahead02: Convert to tst_timer
	helpers
In-Reply-To: <20181128164645.783-1-amir73il@gmail.com>
References: <20181128164645.783-1-amir73il@gmail.com>
Message-ID: <20181128164645.783-5-amir73il@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

To avoid usinf wall clock and get rid of gettimeofday boiler plate code.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 .../kernel/syscalls/readahead/readahead02.c   | 22 +++++++------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/testcases/kernel/syscalls/readahead/readahead02.c b/testcases/kernel/syscalls/readahead/readahead02.c
index 0acdad482..24f045900 100644
--- a/testcases/kernel/syscalls/readahead/readahead02.c
+++ b/testcases/kernel/syscalls/readahead/readahead02.c
@@ -16,7 +16,6 @@
 #include <sys/mman.h>
 #include <sys/stat.h>
 #include <sys/types.h>
-#include <sys/time.h>
 #include <errno.h>
 #include <stdio.h>
 #include <stdlib.h>
@@ -25,6 +24,7 @@
 #include <fcntl.h>
 #include "config.h"
 #include "tst_test.h"
+#include "tst_timer.h"
 #include "lapi/syscalls.h"
 
 static char testfile[PATH_MAX] = "testfile";
@@ -130,17 +130,15 @@ static void create_testfile(void)
  * @cached: returns cached kB from /proc/meminfo
  */
 static void read_testfile(int do_readahead, const char *fname, size_t fsize,
-			  unsigned long *read_bytes, long *usec,
+			  unsigned long *read_bytes, long long *usec,
 			  unsigned long *cached)
 {
 	int fd;
 	size_t i = 0;
 	long read_bytes_start;
 	unsigned char *p, tmp;
-	unsigned long time_start_usec, time_end_usec;
 	unsigned long cached_start, max_ra_estimate = 0;
 	off_t offset = 0;
-	struct timeval now;
 
 	fd = SAFE_OPEN(fname, O_RDONLY);
 
@@ -180,9 +178,7 @@ static void read_testfile(int do_readahead, const char *fname, size_t fsize,
 			tst_res(TFAIL, "offset has changed to: %lu", offset);
 	}
 
-	if (gettimeofday(&now, NULL) == -1)
-		tst_brk(TBROK | TERRNO, "gettimeofday failed");
-	time_start_usec = now.tv_sec * 1000000 + now.tv_usec;
+	tst_timer_start(CLOCK_MONOTONIC);
 	read_bytes_start = get_bytes_read();
 
 	p = SAFE_MMAP(NULL, fsize, PROT_READ, MAP_SHARED | MAP_POPULATE, fd, 0);
@@ -201,10 +197,8 @@ static void read_testfile(int do_readahead, const char *fname, size_t fsize,
 	SAFE_MUNMAP(p, fsize);
 
 	*read_bytes = get_bytes_read() - read_bytes_start;
-	if (gettimeofday(&now, NULL) == -1)
-		tst_brk(TBROK | TERRNO, "gettimeofday failed");
-	time_end_usec = now.tv_sec * 1000000 + now.tv_usec;
-	*usec = time_end_usec - time_start_usec;
+	tst_timer_stop();
+	*usec = tst_timer_elapsed_us();
 
 	SAFE_CLOSE(fd);
 }
@@ -212,7 +206,7 @@ static void read_testfile(int do_readahead, const char *fname, size_t fsize,
 static void test_readahead(void)
 {
 	unsigned long read_bytes, read_bytes_ra;
-	long usec, usec_ra;
+	long long usec, usec_ra;
 	unsigned long cached_max, cached_low, cached, cached_ra;
 	char proc_io_fname[128];
 	sprintf(proc_io_fname, "/proc/%u/io", getpid());
@@ -253,8 +247,8 @@ static void test_readahead(void)
 	else
 		cached_ra = 0;
 
-	tst_res(TINFO, "read_testfile(0) took: %ld usec", usec);
-	tst_res(TINFO, "read_testfile(1) took: %ld usec", usec_ra);
+	tst_res(TINFO, "read_testfile(0) took: %lli usec", usec);
+	tst_res(TINFO, "read_testfile(1) took: %lli usec", usec_ra);
 	if (has_file(proc_io_fname, 0)) {
 		tst_res(TINFO, "read_testfile(0) read: %ld bytes", read_bytes);
 		tst_res(TINFO, "read_testfile(1) read: %ld bytes",
-- 
2.17.1


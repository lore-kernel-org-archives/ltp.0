From: Li Wang <liwang@redhat.com>
Date: Mon,  6 Sep 2021 19:41:43 +0800
Subject: [LTP] [PATCH v3] copy_file_range03: comparing timestamp by
 tst_timespec_diff_us
Message-ID: <20210906114143.3230967-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The st_mtime field is defined as st_mtim.tv_sec for backward
compatibility in struct stat, which might not precise enough
for timestamp comparing.

Here switch to timespec diff (with include nanosecond changes) to
get rid of this kind of rare faliure:

   7	tst_test.c:1345: TINFO: Timeout per run is 0h 05m 00s
   8	copy_file_range.h:36: TINFO: Testing libc copy_file_range()
   9	copy_file_range03.c:48: TPASS: copy_file_range sucessfully updated the timestamp
   10	tst_test.c:1345: TINFO: Timeout per run is 0h 05m 00s
   11	copy_file_range.h:39: TINFO: Testing __NR_copy_file_range syscall
   12	copy_file_range03.c:46: TFAIL: copy_file_range did not update timestamp.

Also, raise the sleep time to 1.5 sec to make test more robust.

Acked-by: Yang Xu <xuyang2018.jy@fujitsu.com>
Signed-off-by: Li Wang <liwang@redhat.com>
Cc: Cyril Hrubis <chrubis@suse.cz>
---

Notes:
    v2 --> v3
      relax the diff_us to 30 seconds

 .../copy_file_range/copy_file_range03.c       | 22 +++++++++++--------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/testcases/kernel/syscalls/copy_file_range/copy_file_range03.c b/testcases/kernel/syscalls/copy_file_range/copy_file_range03.c
index 253eb57ad..21a5d553b 100644
--- a/testcases/kernel/syscalls/copy_file_range/copy_file_range03.c
+++ b/testcases/kernel/syscalls/copy_file_range/copy_file_range03.c
@@ -12,26 +12,28 @@
 #define _GNU_SOURCE
 
 #include "tst_test.h"
+#include "tst_timer.h"
 #include "copy_file_range.h"
 
 static int fd_src;
 static int fd_dest;
 
-unsigned long get_timestamp(int fd)
+struct timespec get_timestamp(int fd)
 {
 	struct stat filestat;
 
 	fstat(fd, &filestat);
-	return filestat.st_mtime;
+	return filestat.st_mtim;
 }
 
 static void verify_copy_file_range_timestamp(void)
 {
 	loff_t offset;
-	unsigned long timestamp, updated_timestamp;
+	struct timespec timestamp1, timestamp2;
+	long long diff_us;
 
-	timestamp = get_timestamp(fd_dest);
-	usleep(1000000);
+	timestamp1 = get_timestamp(fd_dest);
+	usleep(1500000);
 
 	offset = 0;
 	TEST(sys_copy_file_range(fd_src, &offset,
@@ -40,12 +42,14 @@ static void verify_copy_file_range_timestamp(void)
 		tst_brk(TBROK | TTERRNO,
 				"copy_file_range unexpectedly failed");
 
-	updated_timestamp = get_timestamp(fd_dest);
+	timestamp2 = get_timestamp(fd_dest);
 
-	if (timestamp == updated_timestamp)
-		tst_brk(TFAIL, "copy_file_range did not update timestamp.");
+	diff_us = tst_timespec_diff_us(timestamp2, timestamp1);
 
-	tst_res(TPASS, "copy_file_range sucessfully updated the timestamp");
+	if (diff_us >= 1000000 && diff_us <= 30000000)
+		tst_res(TPASS, "copy_file_range sucessfully updated the timestamp");
+	else
+		tst_brk(TFAIL, "diff_us = %lld, copy_file_range might not update timestamp", diff_us);
 }
 
 static void cleanup(void)
-- 
2.31.1


From: Li Wang <liwang@redhat.com>
Date: Thu,  2 Sep 2021 18:45:51 +0800
Subject: [LTP] [RFC PATCH] copy_file_range03: comparing timestamp with
 tst_timespec_diff
Message-ID: <20210902104551.58293-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The st_mtime field is defined as st_mtim.tv_sec for backward
compatibility in struct stat, which might not precise enough
for timestamp comparing.

Similar issue as:
  https://lists.linux.it/pipermail/ltp/2020-November/019982.html

Here switch to timespec diff (with compare nanosecond as well) to
get rid of this kind of rare faliure:

   7	tst_test.c:1345: TINFO: Timeout per run is 0h 05m 00s
   8	copy_file_range.h:36: TINFO: Testing libc copy_file_range()
   9	copy_file_range03.c:48: TPASS: copy_file_range sucessfully updated the timestamp
   10	tst_test.c:1345: TINFO: Timeout per run is 0h 05m 00s
   11	copy_file_range.h:39: TINFO: Testing __NR_copy_file_range syscall
   12	copy_file_range03.c:46: TFAIL: copy_file_range did not update timestamp.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 .../syscalls/copy_file_range/copy_file_range03.c  | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/syscalls/copy_file_range/copy_file_range03.c b/testcases/kernel/syscalls/copy_file_range/copy_file_range03.c
index 253eb57ad..5d055e6ba 100644
--- a/testcases/kernel/syscalls/copy_file_range/copy_file_range03.c
+++ b/testcases/kernel/syscalls/copy_file_range/copy_file_range03.c
@@ -12,25 +12,26 @@
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
+	struct timespec timestamp1, timestamp2, diff;
 
-	timestamp = get_timestamp(fd_dest);
+	timestamp1 = get_timestamp(fd_dest);
 	usleep(1000000);
 
 	offset = 0;
@@ -40,9 +41,11 @@ static void verify_copy_file_range_timestamp(void)
 		tst_brk(TBROK | TTERRNO,
 				"copy_file_range unexpectedly failed");
 
-	updated_timestamp = get_timestamp(fd_dest);
+	timestamp2 = get_timestamp(fd_dest);
 
-	if (timestamp == updated_timestamp)
+	diff = tst_timespec_diff(timestamp1, timestamp2);
+
+	if (!diff.tv_sec && !diff.tv_nsec)
 		tst_brk(TFAIL, "copy_file_range did not update timestamp.");
 
 	tst_res(TPASS, "copy_file_range sucessfully updated the timestamp");
-- 
2.31.1


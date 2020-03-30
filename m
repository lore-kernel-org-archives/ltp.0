From: Jozef Pupava <jpupava@suse.com>
Date: Mon, 30 Mar 2020 12:12:22 +0200
Subject: [LTP] [PATCH v2 2/2] Fix calculations and defined constants
In-Reply-To: <20200330101222.25371-1-jpupava@suse.com>
References: <20200330101222.25371-1-jpupava@suse.com>
Message-ID: <20200330101222.25371-3-jpupava@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

-define BUF_SIZE as BUFSIZ is defined in glibc and can be different
 on different systems
-BUF_SIZE is smaller than BLOCKSIZE to ensure correct offset
-smaller MAXBLKS will keep short test run (10-13s)
-fix data_blocks calculation to avoid zero value
-calculate f_bavail with f_bsize as filesystems which don't support
 tail packing have f_frsize == f_bsize

Acked-by: Martin Doucha <mdoucha@suse.cz>
Signed-off-by: Jozef Pupava <jpupava@suse.com>
---
 testcases/kernel/syscalls/fsync/fsync02.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/testcases/kernel/syscalls/fsync/fsync02.c b/testcases/kernel/syscalls/fsync/fsync02.c
index 9506b4868..fcdc14f89 100644
--- a/testcases/kernel/syscalls/fsync/fsync02.c
+++ b/testcases/kernel/syscalls/fsync/fsync02.c
@@ -20,11 +20,12 @@
 #include "tst_test.h"
 
 #define BLOCKSIZE 8192
-#define MAXBLKS 262144
+#define MAXBLKS 65536
 #define TIME_LIMIT 120
+#define BUF_SIZE 2048
 
 char tempfile[40] = "";
-char pbuf[BUFSIZ];
+char pbuf[BUF_SIZE];
 int fd;
 off_t max_blks = MAXBLKS;
 
@@ -40,14 +41,14 @@ static void setup(void) {
 		tst_brk(TBROK, "fstatvfs failed");
 	}
 
-	f_bavail = (stat_buf.f_bavail * stat_buf.f_frsize) / BLOCKSIZE;
+	f_bavail = (stat_buf.f_bavail * stat_buf.f_bsize) / BLOCKSIZE;
 	if (f_bavail && (f_bavail < MAXBLKS)) {
 		max_blks = f_bavail;
 	}
 
 #ifdef LARGEFILE
 	SAFE_FCNTL(fd, F_SETFL, O_LARGEFILE);
-	SAFE_WRITE(1, fd, pbuf, BUFSIZ);
+	SAFE_WRITE(1, fd, pbuf, BUF_SIZE);
 #endif
 }
 
@@ -60,17 +61,15 @@ static void run(void) {
 	double time_delta;
 	long int random_number;
 
-	while (max_block <= data_blocks) {
-		random_number = rand();
-		max_block = random_number % max_blks;
-		data_blocks = random_number % 1000 + 1;
-	}
+	random_number = rand();
+	max_block = random_number % max_blks + 1;
+	data_blocks = random_number % max_block;
 
 	for (i = 1; i <= data_blocks; i++) {
 		offset = i * ((BLOCKSIZE * max_block) / data_blocks);
-		offset -= BUFSIZ;
+		offset -= BUF_SIZE;
 		SAFE_LSEEK(fd, offset, SEEK_SET);
-		SAFE_WRITE(1, fd, pbuf, BUFSIZ);
+		SAFE_WRITE(1, fd, pbuf, BUF_SIZE);
 	}
 	time_start = time(0);
 
-- 
2.25.0


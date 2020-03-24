From: Jozef Pupava <jpupava@suse.cz>
Date: Tue, 24 Mar 2020 14:38:39 +0100
Subject: [LTP] [PATCH 2/2] Avoid zero or negative int results in calculations
Message-ID: <20200324143839.3647c485@daedruan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Define BUF_SIZE smaller than BLOCKSIZE for possitive offset result

Acked-by: Martin Doucha <mdoucha@suse.cz>
Signed-off-by: Jozef Pupava <jpupava@suse.com>
---
 testcases/kernel/syscalls/fsync/fsync02.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/testcases/kernel/syscalls/fsync/fsync02.c b/testcases/kernel/syscalls/fsync/fsync02.c
index 9506b4868..42a45d0c5 100644
--- a/testcases/kernel/syscalls/fsync/fsync02.c
+++ b/testcases/kernel/syscalls/fsync/fsync02.c
@@ -22,9 +22,10 @@
 #define BLOCKSIZE 8192
 #define MAXBLKS 262144
 #define TIME_LIMIT 120
+#define BUF_SIZE 2048
 
 char tempfile[40] = "";
-char pbuf[BUFSIZ];
+char pbuf[BUF_SIZE];
 int fd;
 off_t max_blks = MAXBLKS;
 
@@ -47,7 +48,7 @@ static void setup(void) {
 
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
2.16.4

From: Cristian Marussi <cristian.marussi@arm.com>
Date: Fri, 30 Apr 2021 15:35:05 +0100
Subject: [LTP] [PATCH] mtest05/mmstress: fix writes operation logic
Message-ID: <20210430143505.3267-1-cristian.marussi@arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

While generating tmpfiles, the map_and_thread() function does not handle
properly incomplete writes that happen to return having written fewer
bytes than requested and instead considers such condition an error straight
away: this behavior hides real errors on writes and results in far from
friendly error reports like these:

mmstress    0  TINFO  :  test1: Test case tests the race condition...
map_and_thread(): write(): Success
mmstress    1  TFAIL  :  mmstress.c:625: TEST 1 Failed

Fix the logic around such write() to allow for incomplete writes to be
properly retried till a real error condition is returned so that a more
meaningful report can be generated:

mmstress    0  TINFO  :  test1: Test case tests the race condition...
map_and_thread(): write(): No space left on device
mmstress    1  TFAIL  :  mmstress.c:625: TEST 1 Failed

While doing that, fix also a couple of minor unrelated issues in the same
map_and_thread() function (malloc retval check and redundant close())

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 testcases/kernel/mem/mtest05/mmstress.c | 30 ++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/mem/mtest05/mmstress.c b/testcases/kernel/mem/mtest05/mmstress.c
index e5d0ce867..c08d6c930 100644
--- a/testcases/kernel/mem/mtest05/mmstress.c
+++ b/testcases/kernel/mem/mtest05/mmstress.c
@@ -289,6 +289,8 @@ int map_and_thread(char *tmpfile,
 	static pthread_t pthread_ids[NUMTHREAD];
 	/* contains ids of the threads created       */
 	void * map_addr = NULL;	/* address where the file is mapped          */
+	size_t written = 0;
+	ssize_t bytes;
 
 	/* Create a file with permissions 0666, and open it with RDRW perms       */
 	/* if the name is not a NULL                                              */
@@ -299,22 +301,38 @@ int map_and_thread(char *tmpfile,
 			  S_IRWXO | S_IRWXU | S_IRWXG))
 		    == -1) {
 			perror("map_and_thread(): open()");
-			close(fd);
 			fflush(NULL);
 			return FAILED;
 		}
 
 		/* Write pagesize * pages_num bytes to the file */
 		empty_buf = malloc(pagesize * pages_num);
-		if (write(fd, empty_buf, pagesize * pages_num) !=
-		    (pagesize * pages_num)) {
-			perror("map_and_thread(): write()");
-			free(empty_buf);
-			fflush(NULL);
+		if (!empty_buf) {
+			perror("map_and_thread(): malloc()");
 			remove_files(tmpfile, NULL);
 			close(fd);
+			fflush(NULL);
 			return FAILED;
 		}
+
+		/* Writing fewer bytes than required is not an error so retry if
+		 * fewer were written; if that happened due to some permanent
+		 * error like ENOSPC the following retry will fail and a proper
+		 * errno will be reported.
+		 */
+		do {
+			bytes = write(fd, empty_buf + written,
+				      pagesize * pages_num - written);
+			if (bytes < 0) {
+				perror("map_and_thread(): write()");
+				free(empty_buf);
+				fflush(NULL);
+				close(fd);
+				remove_files(tmpfile, NULL);
+				return FAILED;
+			}
+			written += bytes;
+		} while (written < pagesize * pages_num);
 		map_type = (fault_type == COW_FAULT) ? MAP_PRIVATE : MAP_SHARED;
 
 		/* Map the file, if the required fault type is COW_FAULT map the file */
-- 
2.17.1


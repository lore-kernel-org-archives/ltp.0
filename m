From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 14 Jun 2019 22:54:03 +0200
Subject: [LTP] [PATCH 2/2] mtest06: fix timestamp in output
In-Reply-To: <67bee9aca637a86b8101b122d149094b50397553.1560545529.git.jstancek@redhat.com>
References: <67bee9aca637a86b8101b122d149094b50397553.1560545529.git.jstancek@redhat.com>
Message-ID: <5a3aa7c62c69fdd2de19adf97ec070cd87ba6ce8.1560545529.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Previous version assumed that each iteration is ~3 seconds long,
even if it takes a lot longer.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/mem/mtest06/mmap1.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/testcases/kernel/mem/mtest06/mmap1.c b/testcases/kernel/mem/mtest06/mmap1.c
index 50d2dafbd952..e16357e3c795 100644
--- a/testcases/kernel/mem/mtest06/mmap1.c
+++ b/testcases/kernel/mem/mtest06/mmap1.c
@@ -218,9 +218,9 @@ static void setup(void)
 static void run(void)
 {
 	pthread_t thid[2];
-	int remaining = tst_timeout_remaining();
-	int elapsed = 0;
+	int start, last_update;
 
+	start = last_update = tst_timeout_remaining();
 	while (tst_timeout_remaining() > STOP_THRESHOLD) {
 		int fd = mkfile(file_size);
 
@@ -236,14 +236,15 @@ static void run(void)
 
 		close(fd);
 
-		if (remaining - tst_timeout_remaining() > PROGRESS_SEC) {
-			remaining = tst_timeout_remaining();
-			elapsed += PROGRESS_SEC;
-			tst_res(TINFO, "[%d] mapped: %lu, sigsegv hit: %lu, "
-				"threads spawned: %lu",	elapsed, map_count,
-				mapped_sigsegv_count, threads_spawned);
-			tst_res(TINFO, "[%d] repeated_reads: %ld, "
-				"data_matched: %lu", elapsed, repeated_reads,
+		if (last_update - tst_timeout_remaining() >= PROGRESS_SEC) {
+			last_update = tst_timeout_remaining();
+			tst_res(TINFO, "[%03d] mapped: %lu, sigsegv hit: %lu, "
+				"threads spawned: %lu",
+				start - tst_timeout_remaining(),
+				map_count, mapped_sigsegv_count,
+				threads_spawned);
+			tst_res(TINFO, "      repeated_reads: %ld, "
+				"data_matched: %lu", repeated_reads,
 				data_matched);
 		}
 	}
-- 
1.8.3.1


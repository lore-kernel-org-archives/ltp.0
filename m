From: Zhao Gongyi <zhaogongyi@huawei.com>
Date: Wed, 14 Apr 2021 17:37:10 +0800
Subject: [LTP] [PATCH] openposix/conformance/interfaces: Correct typos
Message-ID: <20210414093710.6365-1-zhaogongyi@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Typos in the name of the temporary files:
mmap/24-1.c: pts_mmap_24_1_* -> pts_mmap_25_1_*
sem_unlink/2-2.c: sem_unlink_9_1 -> sem_unlink_2_2

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
 .../open_posix_testsuite/conformance/interfaces/mmap/24-1.c     | 2 +-
 .../conformance/interfaces/sem_unlink/2-2.c                     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mmap/24-1.c b/testcases/open_posix_testsuite/conformance/interfaces/mmap/24-1.c
index 3d9e4b180..6cc8349e1 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mmap/24-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mmap/24-1.c
@@ -43,7 +43,7 @@ int main(void)

 	size_t mapped_size = 0;

-	snprintf(tmpfname, sizeof(tmpfname), "pts_mmap_25_1_%d", getpid());
+	snprintf(tmpfname, sizeof(tmpfname), "pts_mmap_24_1_%d", getpid());

 	/* Create shared object */
 	shm_unlink(tmpfname);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sem_unlink/2-2.c b/testcases/open_posix_testsuite/conformance/interfaces/sem_unlink/2-2.c
index dae871d89..1e9096b23 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sem_unlink/2-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sem_unlink/2-2.c
@@ -76,7 +76,7 @@
 #define VERBOSE 1
 #endif

-#define SEM_NAME  "/sem_unlink_9_1"
+#define SEM_NAME  "/sem_unlink_2_2"

 /******************************************************************************/
 /***************************    Test case   ***********************************/
--
2.17.1


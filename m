From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Thu, 19 Jan 2017 17:32:29 +0800
Subject: [LTP] [PATCH 2/2] ltp-aiodio/dio_sparse: Fix usleep in read_sparse()
In-Reply-To: <1484818349-30539-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
References: <1484818349-30539-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
Message-ID: <1484818349-30539-2-git-send-email-fenggw-fnst@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

usleep(100000) sometimes leads to child process being too late
to do the read before being killed by parent process, tune it
to usleep(10) to make sure we do the real test in time.

Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
---
 testcases/kernel/io/ltp-aiodio/common_sparse.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/io/ltp-aiodio/common_sparse.h b/testcases/kernel/io/ltp-aiodio/common_sparse.h
index f7f4ef4..a7f5035 100644
--- a/testcases/kernel/io/ltp-aiodio/common_sparse.h
+++ b/testcases/kernel/io/ltp-aiodio/common_sparse.h
@@ -123,7 +123,7 @@ static void read_sparse(char *filename, int filesize)
 			fprintf(stderr, "Child %i waits for '%s' to appear\n",
 			        getpid(), filename);
 
-		usleep(100000);
+		usleep(10);
 	}
 
 	if (fd == -1) {
-- 
1.8.4.2




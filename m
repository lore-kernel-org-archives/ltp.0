From: Li Wang <liwang@redhat.com>
Date: Mon, 20 Jun 2016 17:53:05 +0800
Subject: [LTP] [PATCH] mem/lib: keep allocating memory until get an error in
	single process
Message-ID: <1466416385-20603-1-git-send-email-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

We occasionally catch errors like:
oom03       0  TINFO  :  start OOM testing for KSM pages.
oom03       0  TINFO  :  expected victim is 3490.
oom03       6  TFAIL  :  mem.c:163: victim unexpectedly ended with retcode: 0, expected: 12
oom03       0  TINFO  :  set overcommit_memory to 0

It cames from the caller testoom(0, 1, ENOMEM, 1). The full reason is that
function child_alloc() go into single process mode, then successfully finish
the memory allocation and return 0.

In this patch, let's make it (in single mode) keep allocating memory with
an incresed length in order to avoid 0 returned.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/mem/lib/mem.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
index 3d853a3..c1f91ce 100644
--- a/testcases/kernel/mem/lib/mem.c
+++ b/testcases/kernel/mem/lib/mem.c
@@ -70,11 +70,17 @@ static void *child_alloc_thread(void *args)
 
 static void child_alloc(int testcase, int lite, int threads)
 {
-	int i;
+	int i, ret;
 	pthread_t *th;
 
 	if (lite) {
-		int ret = alloc_mem(TESTMEM + MB, testcase);
+		long length = TESTMEM + MB;
+
+		/* keep allocating until there's an error */
+		while (!ret) {
+			ret = alloc_mem(length, testcase);
+			length += MB;
+		}
 		exit(ret);
 	}
 
-- 
1.8.3.1


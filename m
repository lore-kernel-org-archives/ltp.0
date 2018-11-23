From: Li Wang <liwang@redhat.com>
Date: Fri, 23 Nov 2018 11:16:04 +0800
Subject: [LTP] [PATCH] shmctl05: extend timeout to 120 seconds
Message-ID: <20181123031604.21400-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This patch is a following to fuzzy sync library update because that
makes shmctl05 cost almost 34 seconds in sampling phase on slow system,
so here prolong test timeout beyond triple of the consumption to avoid
exiting early with warning.

  # ./shmctl05
  tst_test.c:1085: INFO: Timeout per run is 0h 00m 20s
  ../../../../../include/tst_fuzzy_sync.h:589: INFO: Exceeded execution time, requesting exit
  ../../../../../include/tst_fuzzy_sync.h:594: WARN: Still sampling, consider increasing LTP_TIMEOUT_MUL
  shmctl05.c:97: PASS: didn't crash

  Summary:
  passed   1
  failed   0
  skipped  0
  warnings 1

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/syscalls/ipc/shmctl/shmctl05.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl05.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl05.c
index ecae202e8..9df1ab80b 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/shmctl05.c
+++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl05.c
@@ -104,7 +104,7 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
-	.timeout = 20,
+	.timeout = 120,
 	.setup = setup,
 	.test_all = do_test,
 	.cleanup = cleanup,
-- 
2.14.4


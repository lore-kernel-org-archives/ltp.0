From: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Date: Thu, 15 Jul 2021 13:28:13 +0300
Subject: [LTP] [PATCH] crypto/af_alg02: use pthread_tryjoin_np() instead of
 pthread_kill()
Message-ID: <20210715102813.106843-1-aleksei.kodanev@bell-sw.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

musl doesn't return ESRCH for pthread_kill() if thread id is not found.

POSIX only recommends to return ESRCH, and also says that pthread_kill()
produces undefined behavior if tid lifetime has ended [1].

[1]: https://man7.org/linux/man-pages/man3/pthread_kill.3.html

Signed-off-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
---
 testcases/kernel/crypto/af_alg02.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/crypto/af_alg02.c b/testcases/kernel/crypto/af_alg02.c
index 31d30777c..0f5793c16 100644
--- a/testcases/kernel/crypto/af_alg02.c
+++ b/testcases/kernel/crypto/af_alg02.c
@@ -60,7 +60,7 @@ static void run(void)
 
 	TST_CHECKPOINT_WAIT(0);
 
-	while (pthread_kill(thr, 0) != ESRCH) {
+	while (pthread_tryjoin_np(thr, NULL) == EBUSY) {
 		if (tst_timeout_remaining() <= 10) {
 			pthread_cancel(thr);
 			tst_brk(TBROK,
-- 
2.25.1


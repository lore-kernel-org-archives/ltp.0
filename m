From: Matthias Maennich <maennich@google.com>
Date: Thu,  7 Feb 2019 15:51:53 +0000
Subject: [LTP] [PATCH v1] sigpending: use direct syscall
Message-ID: <20190207155153.41816-1-maennich@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Expand coverage to the Android platform.

Signed-off-by: Matthias Maennich <maennich@google.com>
---
 testcases/kernel/syscalls/sigpending/sigpending02.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/sigpending/sigpending02.c b/testcases/kernel/syscalls/sigpending/sigpending02.c
index a38157ae1..ff8b59c8c 100644
--- a/testcases/kernel/syscalls/sigpending/sigpending02.c
+++ b/testcases/kernel/syscalls/sigpending/sigpending02.c
@@ -17,13 +17,14 @@
 #include <sys/types.h>
 
 #include "tst_test.h"
+#include "lapi/syscalls.h"
 
 static void run(void)
 {
 	/* set sigset to point to an invalid location */
 	sigset_t *sigset = (sigset_t *) - 1;
 
-	TEST(sigpending(sigset));
+	TEST(tst_syscall(__NR_rt_sigpending, sigset, NSIG / 8));
 
 	/* check return code */
 	if (TST_RET == -1) {
-- 
2.20.1.611.gfbb209baf1-goog


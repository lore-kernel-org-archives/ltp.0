From: Matthias Maennich <maennich@google.com>
Date: Tue, 12 Feb 2019 16:12:35 +0000
Subject: [LTP] [PATCH v2 1/2] sigpending: use direct syscall
In-Reply-To: <20190212161236.74385-1-maennich@google.com>
References: <20190207155153.41816-1-maennich@google.com>
 <20190212161236.74385-1-maennich@google.com>
Message-ID: <20190212161236.74385-2-maennich@google.com>
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
index a38157ae1..e7ec0d681 100644
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
+	TEST(tst_syscall(__NR_sigpending, sigset));
 
 	/* check return code */
 	if (TST_RET == -1) {
-- 
2.20.1.791.gb4d0f1c61a-goog


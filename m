From: Junchi Chen <junchi.chen@intel.com>
Date: Fri, 31 Aug 2018 21:24:53 +0800
Subject: [LTP] [PATCH ltp] syscalls/bind03: Add version compare according to
	behaviour difference.
Message-ID: <20180831132453.6461-1-junchi.chen@intel.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

ISSUE:
  The case is designed to test the behaviour diverse caused by kernel
  commit 0fb44559ffd6. And it failed for the new behaviour.

ACTION:
  Add a version compare to split part of the test.

Signed-off-by: Junchi Chen <junchi.chen@intel.com>
---
 testcases/kernel/syscalls/bind/bind03.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/bind/bind03.c b/testcases/kernel/syscalls/bind/bind03.c
index 2fe342a54..955a69dd2 100644
--- a/testcases/kernel/syscalls/bind/bind03.c
+++ b/testcases/kernel/syscalls/bind/bind03.c
@@ -13,6 +13,7 @@
 #include <stdlib.h>
 #include <string.h>
 
+#include "tst_kvercmp.h"
 #include "tst_test.h"
 #include "tst_safe_net.h"
 
@@ -37,16 +38,28 @@ void run(void)
 
 	/*
 	 * Once a STREAM UNIX domain socket has been bound, it can't be
-	 * rebound. Expected error is EINVAL.
+	 * rebound.
 	 */
 	if (bind(sock1, (struct sockaddr *)&sun, sizeof(sun)) == 0) {
 		tst_res(TFAIL, "re-binding of socket succeeded");
 		return;
 	}
 
-	if (errno != EINVAL) {
-		tst_res(TFAIL | TERRNO, "expected EINVAL");
-		return;
+	/*
+	 * The behavious diverse according to kernel version
+	 * for v4.10 or later, the expected error is EADDRINUSE,
+	 * otherwise EINVAL.
+	 */
+	if (tst_kvercmp(4, 10, 0) < 0) {
+		if (errno != EINVAL) {
+			tst_res(TFAIL | TERRNO, "expected EINVAL");
+			return;
+		}
+	} else {
+		if (errno != EADDRINUSE) {
+			tst_res(TFAIL | TERRNO, "expected EADDRINUSE");
+			return;
+		}
 	}
 
 	sock2 = SAFE_SOCKET(PF_UNIX, SOCK_STREAM, 0);
-- 
2.17.1


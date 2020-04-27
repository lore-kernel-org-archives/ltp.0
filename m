From: Martin Doucha <mdoucha@suse.cz>
Date: Mon, 27 Apr 2020 16:50:14 +0200
Subject: [LTP] [PATCH] connect02: Handle setsockopt(IP_ADDRFORM) kernel bug
Message-ID: <20200427145014.3530-1-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

setsockopt(IP_ADDRFORM) is broken in kernel 5.6 which results in test failures.
Add the fix commit hash to test tags and check setsockopt() return value
manually so that the test can print the appropriate hints.

Also improve post-fail cleanup.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 testcases/kernel/syscalls/connect/connect02.c | 44 +++++++++++++++++--
 1 file changed, 40 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/connect/connect02.c b/testcases/kernel/syscalls/connect/connect02.c
index 27e2bfddb..cf80213d6 100644
--- a/testcases/kernel/syscalls/connect/connect02.c
+++ b/testcases/kernel/syscalls/connect/connect02.c
@@ -14,6 +14,17 @@
  *  Date:   Tue Sep 26 17:38:50 2017 -0700
  *
  *  net: Set sk_prot_creator when cloning sockets to the right proto
+ *
+ *
+ * Note: This test also detects setsockopt(IP_ADDRFORM) breakage caused by
+ * kernel commit b6f6118901d1. This bug is unrelated to CVE-2018-9568.
+ * Fixed in:
+ *
+ *  commit 82c9ae440857840c56e05d4fb1427ee032531346
+ *  Author: John Haxby <john.haxby@oracle.com>
+ *  Date:   Sat Apr 18 16:30:49 2020 +0100
+ *
+ *  ipv6: fix restrict IPV6_ADDRFORM operation
  */
 
 #include <sys/types.h>
@@ -26,7 +37,7 @@
 #include "tst_net.h"
 #include "tst_taint.h"
 
-static int listenfd;
+static int listenfd = -1, fd = -1, confd1 = -1, confd2 = -1, confd3 = -1;
 static struct sockaddr_in6 bind_addr;
 static struct sockaddr_in bind_addr4, client_addr;
 static struct sockaddr reset_addr;
@@ -52,13 +63,25 @@ static void setup(void)
 
 static void cleanup(void)
 {
-	if (listenfd > 0)
+	if (confd3 >= 0)
+		SAFE_CLOSE(confd3);
+
+	if (confd2 >= 0)
+		SAFE_CLOSE(confd2);
+
+	if (confd1 >= 0)
+		SAFE_CLOSE(confd1);
+
+	if (fd >= 0)
+		SAFE_CLOSE(fd);
+
+	if (listenfd >= 0)
 		SAFE_CLOSE(listenfd);
 }
 
 static void run(void)
 {
-	int i, addrlen, fd, confd1, confd2, confd3;
+	int i, addrlen, optval = AF_INET;
 	struct sockaddr_storage client_addr2;
 
 	for (i = 0; i < 1000; i++) {
@@ -67,7 +90,19 @@ static void run(void)
 			sizeof(client_addr));
 
 		fd = SAFE_ACCEPT(listenfd, NULL, NULL);
-		SAFE_SETSOCKOPT_INT(fd, SOL_IPV6, IPV6_ADDRFORM, AF_INET);
+		TEST(setsockopt(fd, SOL_IPV6, IPV6_ADDRFORM, &optval,
+			sizeof(optval)));
+
+		if (TST_RET == -1) {
+			tst_res(TFAIL | TTERRNO,
+				"setsockopt(IPV6_ADDRFORM) failed");
+			return;
+		}
+
+		if (TST_RET != 0)
+			tst_brk(TBROK | TTERRNO, "setsockopt(IPV6_ADDRFORM) "
+				"returned invalid value");
+
 		SAFE_CONNECT(fd, (struct sockaddr *)&reset_addr,
 			sizeof(reset_addr));
 		SAFE_BIND(fd, (struct sockaddr *)&bind_addr4,
@@ -99,6 +134,7 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "9d538fa60bad"},
+		{"linux-git", "82c9ae440857"},
 		{"CVE", "2018-9568"},
 		{}
 	}
-- 
2.26.0


From: Junchi Chen <junchi.chen@intel.com>
Date: Tue, 11 Sep 2018 18:24:03 +0800
Subject: [LTP] [PATCH ltp] syscalls/bind03: Modified to test errors
	separately.
Message-ID: <20180911102403.7094-1-junchi.chen@intel.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

To avoid mess with the priority of EADDRINUSE and EINVAL, we split the
test to test these two -- one invalid parameter at a time.

Signed-off-by: Junchi Chen <junchi.chen@intel.com>
---
 testcases/kernel/syscalls/bind/bind03.c | 47 +++++++++++++------------
 1 file changed, 24 insertions(+), 23 deletions(-)

diff --git a/testcases/kernel/syscalls/bind/bind03.c b/testcases/kernel/syscalls/bind/bind03.c
index 955a69dd2..dda5ca374 100644
--- a/testcases/kernel/syscalls/bind/bind03.c
+++ b/testcases/kernel/syscalls/bind/bind03.c
@@ -17,58 +17,59 @@
 #include "tst_test.h"
 #include "tst_safe_net.h"
 
-#define SNAME "socket.1"
+#define SNAME_A "socket.1"
+#define SNAME_B "socket.2"
 
 static int sock1, sock2;
 
 void run(void)
 {
-	struct sockaddr_un sun;
+	struct sockaddr_un sun1;
+	struct sockaddr_un sun2;
 
 	sock1 = SAFE_SOCKET(PF_UNIX, SOCK_STREAM, 0);
 
-	memset(&sun, 0, sizeof(sun));
-	sun.sun_family = AF_UNIX;
-	if (sprintf(sun.sun_path, "%s", SNAME) < (int) strlen(SNAME)) {
+	memset(&sun1, 0, sizeof(sun1));
+	memset(&sun2, 0, sizeof(sun2));
+
+	sun1.sun_family = AF_UNIX;
+	sun2.sun_family = AF_UNIX;
+
+	if (sprintf(sun1.sun_path, "%s", SNAME_A) < (int) strlen(SNAME_A)) {
+		tst_res(TFAIL, "sprintf failed");
+		return;
+	}
+
+	if (sprintf(sun2.sun_path, "%s", SNAME_B) < (int) strlen(SNAME_B)) {
 		tst_res(TFAIL, "sprintf failed");
 		return;
 	}
 
-	SAFE_BIND(sock1, (struct sockaddr *)&sun, sizeof(sun));
+	SAFE_BIND(sock1, (struct sockaddr *)&sun1, sizeof(sun1));
 
 	/*
 	 * Once a STREAM UNIX domain socket has been bound, it can't be
 	 * rebound.
 	 */
-	if (bind(sock1, (struct sockaddr *)&sun, sizeof(sun)) == 0) {
+	if (bind(sock1, (struct sockaddr *)&sun2, sizeof(sun2)) == 0) {
 		tst_res(TFAIL, "re-binding of socket succeeded");
 		return;
 	}
 
-	/*
-	 * The behavious diverse according to kernel version
-	 * for v4.10 or later, the expected error is EADDRINUSE,
-	 * otherwise EINVAL.
-	 */
-	if (tst_kvercmp(4, 10, 0) < 0) {
-		if (errno != EINVAL) {
-			tst_res(TFAIL | TERRNO, "expected EINVAL");
-			return;
-		}
-	} else {
-		if (errno != EADDRINUSE) {
-			tst_res(TFAIL | TERRNO, "expected EADDRINUSE");
-			return;
-		}
+	if (errno != EINVAL) {
+		tst_res(TFAIL | TERRNO, "expected EINVAL");
+		return;
 	}
 
+	tst_res(TPASS, "bind() failed with EINVAL as expected");
+
 	sock2 = SAFE_SOCKET(PF_UNIX, SOCK_STREAM, 0);
 
 	/*
 	 * Since a socket is already bound to the pathname, it can't be bound
 	 * to a second socket. Expected error is EADDRINUSE.
 	 */
-	if (bind(sock2, (struct sockaddr *)&sun, sizeof(sun)) == 0) {
+	if (bind(sock2, (struct sockaddr *)&sun1, sizeof(sun1)) == 0) {
 		tst_res(TFAIL, "bind() succeeded with already bound pathname!");
 		return;
 	}
-- 
2.17.1


From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue,  3 Oct 2017 16:20:09 +0200
Subject: [LTP] [COMMITTED] [PATCH 36/40] Make use of SAFE_CONNECT()
In-Reply-To: <20171003142013.25230-1-chrubis@suse.cz>
References: <20171003142013.25230-1-chrubis@suse.cz>
Message-ID: <20171003142013.25230-36-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/connect/connect01.c   |  5 ++---
 testcases/kernel/syscalls/recvmsg/recvmsg01.c   | 13 +++++--------
 testcases/kernel/syscalls/send/send01.c         |  4 ++--
 testcases/kernel/syscalls/sendfile/sendfile02.c |  5 +----
 testcases/kernel/syscalls/sendfile/sendfile04.c |  5 +----
 testcases/kernel/syscalls/sendfile/sendfile05.c |  5 +----
 testcases/kernel/syscalls/sendfile/sendfile06.c |  5 +----
 testcases/kernel/syscalls/sendmsg/sendmsg01.c   |  4 ++--
 testcases/kernel/syscalls/sendto/sendto01.c     |  4 ++--
 9 files changed, 17 insertions(+), 33 deletions(-)

diff --git a/testcases/kernel/syscalls/connect/connect01.c b/testcases/kernel/syscalls/connect/connect01.c
index af6035435..c0f711b09 100644
--- a/testcases/kernel/syscalls/connect/connect01.c
+++ b/testcases/kernel/syscalls/connect/connect01.c
@@ -53,6 +53,7 @@
 #include <netinet/in.h>
 
 #include "test.h"
+#include "safe_macros.h"
 
 char *TCID = "connect01";
 int testno;
@@ -216,9 +217,7 @@ void cleanup1(void)
 void setup2(void)
 {
 	setup1();		/* get a socket in s */
-	if (connect(s, (const struct sockaddr *)&sin1, sizeof(sin1)) < 0)
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "socket setup failed connect test %d", testno);
+	SAFE_CONNECT(cleanup, s, (const struct sockaddr *)&sin1, sizeof(sin1));
 }
 
 pid_t start_server(struct sockaddr_in *sin0)
diff --git a/testcases/kernel/syscalls/recvmsg/recvmsg01.c b/testcases/kernel/syscalls/recvmsg/recvmsg01.c
index 13bd58f4b..4e19157e7 100644
--- a/testcases/kernel/syscalls/recvmsg/recvmsg01.c
+++ b/testcases/kernel/syscalls/recvmsg/recvmsg01.c
@@ -56,6 +56,7 @@
 #include <netinet/in.h>
 
 #include "test.h"
+#include "safe_macros.h"
 
 char *TCID = "recvmsg01";
 int testno;
@@ -299,10 +300,8 @@ void setup1(void)
 		tst_brkm(TBROK | TERRNO, cleanup, "socket setup failed");
 	if (tdat[testno].type == SOCK_STREAM) {
 		if (tdat[testno].domain == PF_INET) {
-			if (connect(s, (struct sockaddr *)&sin1, sizeof(sin1)) <
-			    0)
-				tst_brkm(TBROK | TERRNO, cleanup,
-					 "connect failed");
+			SAFE_CONNECT(cleanup, s, (struct sockaddr *)&sin1,
+				     sizeof(sin1));
 			/* Wait for something to be readable, else we won't detect EFAULT on recv */
 			FD_ZERO(&rdfds);
 			FD_SET(s, &rdfds);
@@ -313,10 +312,8 @@ void setup1(void)
 				tst_brkm(TBROK, cleanup,
 					 "client setup1 failed - no message ready in 2 sec");
 		} else if (tdat[testno].domain == PF_UNIX) {
-			if (connect(s, (struct sockaddr *)&sun1, sizeof(sun1)) <
-			    0)
-				tst_brkm(TBROK | TERRNO, cleanup,
-					 "UD connect failed");
+			SAFE_CONNECT(cleanup, s, (struct sockaddr *)&sun1,
+				     sizeof(sun1));
 		}
 	}
 }
diff --git a/testcases/kernel/syscalls/send/send01.c b/testcases/kernel/syscalls/send/send01.c
index 6f71300ce..80a20098a 100644
--- a/testcases/kernel/syscalls/send/send01.c
+++ b/testcases/kernel/syscalls/send/send01.c
@@ -42,6 +42,7 @@
 #include <netinet/in.h>
 
 #include "test.h"
+#include "safe_macros.h"
 
 char *TCID = "send01";
 int testno;
@@ -328,8 +329,7 @@ static void setup1(void)
 	s = socket(tdat[testno].domain, tdat[testno].type, tdat[testno].proto);
 	if (s < 0)
 		tst_brkm(TBROK | TERRNO, cleanup, "socket setup failed");
-	if (connect(s, (const struct sockaddr *)&sin1, sizeof(sin1)) < 0)
-		tst_brkm(TBROK | TERRNO, cleanup, "connect failed");
+	SAFE_CONNECT(cleanup, s, (const struct sockaddr *)&sin1, sizeof(sin1));
 }
 
 static void cleanup1(void)
diff --git a/testcases/kernel/syscalls/sendfile/sendfile02.c b/testcases/kernel/syscalls/sendfile/sendfile02.c
index 111b2741a..c2a7e7d0f 100644
--- a/testcases/kernel/syscalls/sendfile/sendfile02.c
+++ b/testcases/kernel/syscalls/sendfile/sendfile02.c
@@ -256,10 +256,7 @@ int create_server(void)
 			 strerror(errno));
 		return -1;
 	}
-	if (connect(s, (struct sockaddr *)&sin1, sizeof(sin1)) < 0) {
-		tst_brkm(TBROK, cleanup, "call to connect() failed: %s",
-			 strerror(errno));
-	}
+	SAFE_CONNECT(cleanup, s, (struct sockaddr *)&sin1, sizeof(sin1));
 	return s;
 
 }
diff --git a/testcases/kernel/syscalls/sendfile/sendfile04.c b/testcases/kernel/syscalls/sendfile/sendfile04.c
index 13389150c..09869c2c6 100644
--- a/testcases/kernel/syscalls/sendfile/sendfile04.c
+++ b/testcases/kernel/syscalls/sendfile/sendfile04.c
@@ -253,10 +253,7 @@ int create_server(void)
 			 strerror(errno));
 		return -1;
 	}
-	if (connect(s, (struct sockaddr *)&sin1, sizeof(sin1)) < 0) {
-		tst_brkm(TBROK, cleanup, "call to connect() failed: %s",
-			 strerror(errno));
-	}
+	SAFE_CONNECT(cleanup, s, (struct sockaddr *)&sin1, sizeof(sin1));
 	return s;
 
 }
diff --git a/testcases/kernel/syscalls/sendfile/sendfile05.c b/testcases/kernel/syscalls/sendfile/sendfile05.c
index 1c700a61f..85e296744 100644
--- a/testcases/kernel/syscalls/sendfile/sendfile05.c
+++ b/testcases/kernel/syscalls/sendfile/sendfile05.c
@@ -218,10 +218,7 @@ int create_server(void)
 			 strerror(errno));
 		return -1;
 	}
-	if (connect(s, (struct sockaddr *)&sin1, sizeof(sin1)) < 0) {
-		tst_brkm(TBROK, cleanup, "call to connect() failed: %s",
-			 strerror(errno));
-	}
+	SAFE_CONNECT(cleanup, s, (struct sockaddr *)&sin1, sizeof(sin1));
 	return s;
 
 }
diff --git a/testcases/kernel/syscalls/sendfile/sendfile06.c b/testcases/kernel/syscalls/sendfile/sendfile06.c
index 794519549..2d8d6d769 100644
--- a/testcases/kernel/syscalls/sendfile/sendfile06.c
+++ b/testcases/kernel/syscalls/sendfile/sendfile06.c
@@ -200,10 +200,7 @@ static int create_server(void)
 		return -1;
 	}
 
-	if (connect(s, (struct sockaddr *)&sin1, sizeof(sin1)) < 0) {
-		tst_brkm(TBROK, cleanup, "call to connect() failed: %s",
-			 strerror(errno));
-	}
+	SAFE_CONNECT(cleanup, s, (struct sockaddr *)&sin1, sizeof(sin1));
 
 	return s;
 }
diff --git a/testcases/kernel/syscalls/sendmsg/sendmsg01.c b/testcases/kernel/syscalls/sendmsg/sendmsg01.c
index dcf3ab7e8..b79c6f4ac 100644
--- a/testcases/kernel/syscalls/sendmsg/sendmsg01.c
+++ b/testcases/kernel/syscalls/sendmsg/sendmsg01.c
@@ -48,6 +48,7 @@
 #include <netinet/in.h>
 
 #include "test.h"
+#include "safe_macros.h"
 
 char *TCID = "sendmsg01";
 int testno;
@@ -665,8 +666,7 @@ static void setup5(void)
 			 strerror(errno));
 	}
 
-	if (connect(s, (struct sockaddr *)&sin1, sizeof(sin1)) < 0)
-		tst_brkm(TBROK, cleanup, "connect failed: %s", strerror(errno));
+	SAFE_CONNECT(cleanup, s, (struct sockaddr *)&sin1, sizeof(sin1));
 
 	/* slight change destination (port) so connect() is to different
 	 * 5-tuple than already connected
diff --git a/testcases/kernel/syscalls/sendto/sendto01.c b/testcases/kernel/syscalls/sendto/sendto01.c
index ec0766197..813c3d7f8 100644
--- a/testcases/kernel/syscalls/sendto/sendto01.c
+++ b/testcases/kernel/syscalls/sendto/sendto01.c
@@ -41,6 +41,7 @@
 #include <netinet/in.h>
 
 #include "test.h"
+#include "safe_macros.h"
 
 char *TCID = "sendto01";
 int testno;
@@ -398,8 +399,7 @@ static void setup1(void)
 	s = socket(tdat[testno].domain, tdat[testno].type, tdat[testno].proto);
 	if (s < 0)
 		tst_brkm(TBROK | TERRNO, cleanup, "socket setup failed");
-	if (connect(s, (const struct sockaddr *)&sin1, sizeof(sin1)) < 0)
-		tst_brkm(TBROK | TERRNO, cleanup, "connect failed");
+	SAFE_CONNECT(cleanup, s, (const struct sockaddr *)&sin1, sizeof(sin1));
 }
 
 static void cleanup1(void)
-- 
2.13.5


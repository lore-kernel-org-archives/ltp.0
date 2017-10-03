From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue,  3 Oct 2017 17:40:59 +0200
Subject: [LTP] [COMMITTED] [PATCH 12/13] Make use of SAFE_SOCKET()
In-Reply-To: <20171003154100.807-1-chrubis@suse.cz>
References: <20171003154100.807-1-chrubis@suse.cz>
Message-ID: <20171003154100.807-12-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/accept/accept01.c         |  7 ++-----
 testcases/kernel/syscalls/bind/bind01.c             |  7 +++----
 testcases/kernel/syscalls/connect/connect01.c       |  5 ++---
 .../kernel/syscalls/getsockname/getsockname01.c     |  7 ++-----
 testcases/kernel/syscalls/getsockopt/getsockopt01.c |  7 ++-----
 testcases/kernel/syscalls/listen/listen01.c         |  8 +++-----
 testcases/kernel/syscalls/recv/recv01.c             |  5 ++---
 testcases/kernel/syscalls/recvfrom/recvfrom01.c     |  5 ++---
 testcases/kernel/syscalls/recvmsg/recvmsg01.c       |  5 ++---
 testcases/kernel/syscalls/send/send01.c             |  5 ++---
 testcases/kernel/syscalls/sendmsg/sendmsg01.c       | 21 ++++++---------------
 testcases/kernel/syscalls/sendto/sendto01.c         | 10 ++++------
 testcases/kernel/syscalls/setsockopt/setsockopt01.c |  7 ++-----
 testcases/kernel/syscalls/sockioctl/sockioctl01.c   | 14 ++++----------
 14 files changed, 38 insertions(+), 75 deletions(-)

diff --git a/testcases/kernel/syscalls/accept/accept01.c b/testcases/kernel/syscalls/accept/accept01.c
index 5a4966a0c..b50056520 100644
--- a/testcases/kernel/syscalls/accept/accept01.c
+++ b/testcases/kernel/syscalls/accept/accept01.c
@@ -156,11 +156,8 @@ static void cleanup0(void)
 
 static void setup1(void)
 {
-	s = socket(tdat[testno].domain, tdat[testno].type, tdat[testno].proto);
-	if (s < 0) {
-		tst_brkm(TBROK, cleanup, "socket setup failed for accept "
-			 "test %d: %s", testno, strerror(errno));
-	}
+	s = SAFE_SOCKET(cleanup, tdat[testno].domain, tdat[testno].type,
+			tdat[testno].proto);
 	SAFE_BIND(cleanup, s, (struct sockaddr *)&sin0, sizeof(sin0));
 	sinlen = sizeof(fsin1);
 }
diff --git a/testcases/kernel/syscalls/bind/bind01.c b/testcases/kernel/syscalls/bind/bind01.c
index 6a3bc5065..868749368 100644
--- a/testcases/kernel/syscalls/bind/bind01.c
+++ b/testcases/kernel/syscalls/bind/bind01.c
@@ -52,6 +52,7 @@
 #include <netinet/in.h>
 
 #include "test.h"
+#include "safe_macros.h"
 
 char *TCID = "bind01";
 int testno;
@@ -174,10 +175,8 @@ void cleanup(void)
 
 void setup0(void)
 {
-	s = socket(tdat[testno].domain, tdat[testno].type, tdat[testno].proto);
-	if (s < 0)
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "socket() failed for bind test %d", testno);
+	s = SAFE_SOCKET(cleanup, tdat[testno].domain, tdat[testno].type,
+		        tdat[testno].proto);
 }
 
 void cleanup0(void)
diff --git a/testcases/kernel/syscalls/connect/connect01.c b/testcases/kernel/syscalls/connect/connect01.c
index d65af4ae0..2be83cfbb 100644
--- a/testcases/kernel/syscalls/connect/connect01.c
+++ b/testcases/kernel/syscalls/connect/connect01.c
@@ -203,9 +203,8 @@ void cleanup0(void)
 
 void setup1(void)
 {
-	s = socket(tdat[testno].domain, tdat[testno].type, tdat[testno].proto);
-	if (s < 0)
-		tst_brkm(TBROK | TERRNO, cleanup, "socket() failed");
+	s = SAFE_SOCKET(cleanup, tdat[testno].domain, tdat[testno].type,
+		        tdat[testno].proto);
 }
 
 void cleanup1(void)
diff --git a/testcases/kernel/syscalls/getsockname/getsockname01.c b/testcases/kernel/syscalls/getsockname/getsockname01.c
index c46b1763a..cce1543fd 100644
--- a/testcases/kernel/syscalls/getsockname/getsockname01.c
+++ b/testcases/kernel/syscalls/getsockname/getsockname01.c
@@ -168,11 +168,8 @@ void cleanup0(void)
 
 void setup1(void)
 {
-	s = socket(tdat[testno].domain, tdat[testno].type, tdat[testno].proto);
-	if (s < 0) {
-		tst_brkm(TBROK, cleanup, "socket setup failed for getsockname "
-			 "test %d: %s", testno, strerror(errno));
-	}
+	s = SAFE_SOCKET(cleanup, tdat[testno].domain, tdat[testno].type,
+			tdat[testno].proto);
 	SAFE_BIND(cleanup, s, (struct sockaddr *)&sin0, sizeof(sin0));
 	sinlen = sizeof(fsin1);
 }
diff --git a/testcases/kernel/syscalls/getsockopt/getsockopt01.c b/testcases/kernel/syscalls/getsockopt/getsockopt01.c
index b39cfefb5..d1692fcd3 100644
--- a/testcases/kernel/syscalls/getsockopt/getsockopt01.c
+++ b/testcases/kernel/syscalls/getsockopt/getsockopt01.c
@@ -194,11 +194,8 @@ void cleanup0(void)
 
 void setup1(void)
 {
-	s = socket(tdat[testno].domain, tdat[testno].type, tdat[testno].proto);
-	if (s < 0) {
-		tst_brkm(TBROK, cleanup, "socket setup failed for getsockopt: "
-			 "%s", strerror(errno));
-	}
+	s = SAFE_SOCKET(cleanup, tdat[testno].domain, tdat[testno].type,
+			tdat[testno].proto);
 	SAFE_BIND(cleanup, s, (struct sockaddr *)&sin0, sizeof(sin0));
 	sinlen = sizeof(fsin1);
 	optlen = sizeof(optval);
diff --git a/testcases/kernel/syscalls/listen/listen01.c b/testcases/kernel/syscalls/listen/listen01.c
index e421bb46d..d33f209c3 100644
--- a/testcases/kernel/syscalls/listen/listen01.c
+++ b/testcases/kernel/syscalls/listen/listen01.c
@@ -53,6 +53,7 @@
 #include <netinet/in.h>
 
 #include "test.h"
+#include "safe_macros.h"
 
 char *TCID = "listen01";
 int testno;
@@ -140,11 +141,8 @@ void cleanup0(void)
 
 void setup1(void)
 {
-	s = socket(tdat[testno].domain, tdat[testno].type, tdat[testno].proto);
-	if (s < 0) {
-		tst_brkm(TBROK, cleanup, "socket setup failed for listen: "
-			 "%s", strerror(errno));
-	}
+	s = SAFE_SOCKET(cleanup, tdat[testno].domain, tdat[testno].type,
+		        tdat[testno].proto);
 }
 
 void cleanup1(void)
diff --git a/testcases/kernel/syscalls/recv/recv01.c b/testcases/kernel/syscalls/recv/recv01.c
index 3345e51e6..2f09864a5 100644
--- a/testcases/kernel/syscalls/recv/recv01.c
+++ b/testcases/kernel/syscalls/recv/recv01.c
@@ -193,9 +193,8 @@ void setup1(void)
 	struct timeval timeout;
 	int n;
 
-	s = socket(tdat[testno].domain, tdat[testno].type, tdat[testno].proto);
-	if (s < 0)
-		tst_brkm(TBROK | TERRNO, cleanup, "socket setup failed");
+	s = SAFE_SOCKET(cleanup, tdat[testno].domain, tdat[testno].type,
+		        tdat[testno].proto);
 	if (tdat[testno].type == SOCK_STREAM &&
 	    connect(s, (struct sockaddr *)&sin1, sizeof(sin1)) < 0) {
 		tst_brkm(TBROK | TERRNO, cleanup, "connect failed");
diff --git a/testcases/kernel/syscalls/recvfrom/recvfrom01.c b/testcases/kernel/syscalls/recvfrom/recvfrom01.c
index e07879b06..853d1cb9f 100644
--- a/testcases/kernel/syscalls/recvfrom/recvfrom01.c
+++ b/testcases/kernel/syscalls/recvfrom/recvfrom01.c
@@ -215,9 +215,8 @@ void setup1(void)
 	struct timeval timeout;
 	int n;
 
-	s = socket(tdat[testno].domain, tdat[testno].type, tdat[testno].proto);
-	if (s < 0)
-		tst_brkm(TBROK | TERRNO, cleanup, "socket() failed");
+	s = SAFE_SOCKET(cleanup, tdat[testno].domain, tdat[testno].type,
+			tdat[testno].proto);
 	if (tdat[testno].type == SOCK_STREAM &&
 	    connect(s, (struct sockaddr *)&sin1, sizeof(sin1)) < 0) {
 		tst_brkm(TBROK | TERRNO, cleanup, "connect failed");
diff --git a/testcases/kernel/syscalls/recvmsg/recvmsg01.c b/testcases/kernel/syscalls/recvmsg/recvmsg01.c
index 5bdc60cd9..13bcaa4e0 100644
--- a/testcases/kernel/syscalls/recvmsg/recvmsg01.c
+++ b/testcases/kernel/syscalls/recvmsg/recvmsg01.c
@@ -295,9 +295,8 @@ void setup1(void)
 	struct timeval timeout;
 	int n;
 
-	s = socket(tdat[testno].domain, tdat[testno].type, tdat[testno].proto);
-	if (s < 0)
-		tst_brkm(TBROK | TERRNO, cleanup, "socket setup failed");
+	s = SAFE_SOCKET(cleanup, tdat[testno].domain, tdat[testno].type,
+			tdat[testno].proto);
 	if (tdat[testno].type == SOCK_STREAM) {
 		if (tdat[testno].domain == PF_INET) {
 			SAFE_CONNECT(cleanup, s, (struct sockaddr *)&sin1,
diff --git a/testcases/kernel/syscalls/send/send01.c b/testcases/kernel/syscalls/send/send01.c
index 31e8c1758..2e0ae2177 100644
--- a/testcases/kernel/syscalls/send/send01.c
+++ b/testcases/kernel/syscalls/send/send01.c
@@ -325,9 +325,8 @@ static void cleanup0(void)
 
 static void setup1(void)
 {
-	s = socket(tdat[testno].domain, tdat[testno].type, tdat[testno].proto);
-	if (s < 0)
-		tst_brkm(TBROK | TERRNO, cleanup, "socket setup failed");
+	s = SAFE_SOCKET(cleanup, tdat[testno].domain, tdat[testno].type,
+			tdat[testno].proto);
 	SAFE_CONNECT(cleanup, s, (const struct sockaddr *)&sin1, sizeof(sin1));
 }
 
diff --git a/testcases/kernel/syscalls/sendmsg/sendmsg01.c b/testcases/kernel/syscalls/sendmsg/sendmsg01.c
index d7f7b757c..36f6914ff 100644
--- a/testcases/kernel/syscalls/sendmsg/sendmsg01.c
+++ b/testcases/kernel/syscalls/sendmsg/sendmsg01.c
@@ -589,11 +589,8 @@ static void cleanup0(void)
 
 static void setup1(void)
 {
-	s = socket(tdat[testno].domain, tdat[testno].type, tdat[testno].proto);
-	if (s < 0) {
-		tst_brkm(TBROK, cleanup, "socket setup failed: %s",
-			 strerror(errno));
-	}
+	s = SAFE_SOCKET(cleanup, tdat[testno].domain, tdat[testno].type,
+			tdat[testno].proto);
 	if (tdat[testno].type == SOCK_STREAM &&
 	    connect(s, (struct sockaddr *)tdat[testno].to,
 		    tdat[testno].tolen) < 0) {
@@ -618,11 +615,8 @@ static void setup2(void)
 
 static void setup3(void)
 {
-	s = socket(tdat[testno].domain, tdat[testno].type, tdat[testno].proto);
-	if (s < 0) {
-		tst_brkm(TBROK, cleanup, "socket setup failed: %s",
-			 strerror(errno));
-	}
+	s = SAFE_SOCKET(cleanup, tdat[testno].domain, tdat[testno].type,
+		        tdat[testno].proto);
 }
 
 static char tmpfilename[1024];
@@ -659,11 +653,8 @@ static void cleanup4(void)
 
 static void setup5(void)
 {
-	s = socket(tdat[testno].domain, tdat[testno].type, tdat[testno].proto);
-	if (s < 0) {
-		tst_brkm(TBROK, cleanup, "socket setup failed: %s",
-			 strerror(errno));
-	}
+	s = SAFE_SOCKET(cleanup, tdat[testno].domain, tdat[testno].type,
+			tdat[testno].proto);
 
 	SAFE_CONNECT(cleanup, s, (struct sockaddr *)&sin1, sizeof(sin1));
 
diff --git a/testcases/kernel/syscalls/sendto/sendto01.c b/testcases/kernel/syscalls/sendto/sendto01.c
index 5304da691..6fe0274ee 100644
--- a/testcases/kernel/syscalls/sendto/sendto01.c
+++ b/testcases/kernel/syscalls/sendto/sendto01.c
@@ -395,9 +395,8 @@ static void cleanup0(void)
 
 static void setup1(void)
 {
-	s = socket(tdat[testno].domain, tdat[testno].type, tdat[testno].proto);
-	if (s < 0)
-		tst_brkm(TBROK | TERRNO, cleanup, "socket setup failed");
+	s = SAFE_SOCKET(cleanup, tdat[testno].domain, tdat[testno].type,
+			tdat[testno].proto);
 	SAFE_CONNECT(cleanup, s, (const struct sockaddr *)&sin1, sizeof(sin1));
 }
 
@@ -417,7 +416,6 @@ static void setup2(void)
 
 static void setup3(void)
 {
-	s = socket(tdat[testno].domain, tdat[testno].type, tdat[testno].proto);
-	if (s < 0)
-		tst_brkm(TBROK | TERRNO, cleanup, "socket setup failed");
+	s = SAFE_SOCKET(cleanup, tdat[testno].domain, tdat[testno].type,
+		        tdat[testno].proto);
 }
diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt01.c b/testcases/kernel/syscalls/setsockopt/setsockopt01.c
index 36988854b..743c6be14 100644
--- a/testcases/kernel/syscalls/setsockopt/setsockopt01.c
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt01.c
@@ -201,11 +201,8 @@ void cleanup0(void)
 
 void setup1(void)
 {
-	s = socket(tdat[testno].domain, tdat[testno].type, tdat[testno].proto);
-	if (s < 0) {
-		tst_brkm(TBROK, cleanup, "socket setup failed for setsockopt:"
-			 " %s", strerror(errno));
-	}
+	s = SAFE_SOCKET(cleanup, tdat[testno].domain, tdat[testno].type,
+			tdat[testno].proto);
 	SAFE_BIND(cleanup, s, (struct sockaddr *)&sin0, sizeof(sin0));
 }
 
diff --git a/testcases/kernel/syscalls/sockioctl/sockioctl01.c b/testcases/kernel/syscalls/sockioctl/sockioctl01.c
index 79c53e042..486236af9 100644
--- a/testcases/kernel/syscalls/sockioctl/sockioctl01.c
+++ b/testcases/kernel/syscalls/sockioctl/sockioctl01.c
@@ -205,11 +205,8 @@ static void cleanup0(void)
 
 static void setup1(void)
 {
-	s = socket(tdat[testno].domain, tdat[testno].type, tdat[testno].proto);
-	if (s < 0) {
-		tst_brkm(TBROK, cleanup, "socket setup failed: %s",
-			 strerror(errno));
-	}
+	s = SAFE_SOCKET(cleanup, tdat[testno].domain, tdat[testno].type,
+			tdat[testno].proto);
 	SAFE_BIND(cleanup, s, (struct sockaddr *)&sin0, sizeof(sin0));
 	sinlen = sizeof(fsin1);
 
@@ -221,11 +218,8 @@ static void setup1(void)
 
 static void setup2(void)
 {
-	s = socket(tdat[testno].domain, tdat[testno].type, tdat[testno].proto);
-	if (s < 0) {
-		tst_brkm(TBROK, cleanup, "socket setup failed: %s",
-			 strerror(errno));
-	}
+	s = SAFE_SOCKET(cleanup, tdat[testno].domain, tdat[testno].type,
+			tdat[testno].proto);
 	ifc.ifc_len = sizeof(buf);
 	ifc.ifc_buf = buf;
 }
-- 
2.13.5


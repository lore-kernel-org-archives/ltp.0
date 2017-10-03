From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue,  3 Oct 2017 16:20:08 +0200
Subject: [LTP] [COMMITTED] [PATCH 35/40] Make use of SAFE_BIND()
In-Reply-To: <20171003142013.25230-1-chrubis@suse.cz>
References: <20171003142013.25230-1-chrubis@suse.cz>
Message-ID: <20171003142013.25230-35-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/accept/accept01.c           | 5 +----
 testcases/kernel/syscalls/getpeername/getpeername01.c | 7 ++-----
 testcases/kernel/syscalls/getsockname/getsockname01.c | 6 ++----
 testcases/kernel/syscalls/getsockopt/getsockopt01.c   | 6 ++----
 testcases/kernel/syscalls/setsockopt/setsockopt01.c   | 6 ++----
 testcases/kernel/syscalls/sockioctl/sockioctl01.c     | 5 +----
 6 files changed, 10 insertions(+), 25 deletions(-)

diff --git a/testcases/kernel/syscalls/accept/accept01.c b/testcases/kernel/syscalls/accept/accept01.c
index 986415897..5a4966a0c 100644
--- a/testcases/kernel/syscalls/accept/accept01.c
+++ b/testcases/kernel/syscalls/accept/accept01.c
@@ -161,10 +161,7 @@ static void setup1(void)
 		tst_brkm(TBROK, cleanup, "socket setup failed for accept "
 			 "test %d: %s", testno, strerror(errno));
 	}
-	if (bind(s, (struct sockaddr *)&sin0, sizeof(sin0)) < 0) {
-		tst_brkm(TBROK, cleanup, "socket bind failed for accept "
-			 "test %d: %s", testno, strerror(errno));
-	}
+	SAFE_BIND(cleanup, s, (struct sockaddr *)&sin0, sizeof(sin0));
 	sinlen = sizeof(fsin1);
 }
 
diff --git a/testcases/kernel/syscalls/getpeername/getpeername01.c b/testcases/kernel/syscalls/getpeername/getpeername01.c
index fd5d58d57..817cd38ad 100644
--- a/testcases/kernel/syscalls/getpeername/getpeername01.c
+++ b/testcases/kernel/syscalls/getpeername/getpeername01.c
@@ -153,11 +153,8 @@ static void setup3(int i)
 		tst_brkm(TBROK | TERRNO, cleanup,
 			 "socket setup failed for getpeername test %d", i);
 	}
-	if (bind(test_cases[i].sockfd, (struct sockaddr *)&server_addr,
-		 sizeof(server_addr)) < 0) {
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "socket bind failed for getpeername test %d", i);
-	}
+	SAFE_BIND(cleanup, test_cases[i].sockfd,
+		  (struct sockaddr *)&server_addr, sizeof(server_addr));
 }
 
 static void setup4(int i)
diff --git a/testcases/kernel/syscalls/getsockname/getsockname01.c b/testcases/kernel/syscalls/getsockname/getsockname01.c
index c4b6e9b1a..c46b1763a 100644
--- a/testcases/kernel/syscalls/getsockname/getsockname01.c
+++ b/testcases/kernel/syscalls/getsockname/getsockname01.c
@@ -52,6 +52,7 @@
 #include <netinet/in.h>
 
 #include "test.h"
+#include "safe_macros.h"
 
 char *TCID = "getsockname01";
 int testno;
@@ -172,10 +173,7 @@ void setup1(void)
 		tst_brkm(TBROK, cleanup, "socket setup failed for getsockname "
 			 "test %d: %s", testno, strerror(errno));
 	}
-	if (bind(s, (struct sockaddr *)&sin0, sizeof(sin0)) < 0) {
-		tst_brkm(TBROK, cleanup, "socket bind failed for getsockname "
-			 "test %d: %s", testno, strerror(errno));
-	}
+	SAFE_BIND(cleanup, s, (struct sockaddr *)&sin0, sizeof(sin0));
 	sinlen = sizeof(fsin1);
 }
 
diff --git a/testcases/kernel/syscalls/getsockopt/getsockopt01.c b/testcases/kernel/syscalls/getsockopt/getsockopt01.c
index 1195306a0..b39cfefb5 100644
--- a/testcases/kernel/syscalls/getsockopt/getsockopt01.c
+++ b/testcases/kernel/syscalls/getsockopt/getsockopt01.c
@@ -52,6 +52,7 @@
 #include <netinet/in.h>
 
 #include "test.h"
+#include "safe_macros.h"
 
 char *TCID = "getsockopt01";
 int testno;
@@ -198,10 +199,7 @@ void setup1(void)
 		tst_brkm(TBROK, cleanup, "socket setup failed for getsockopt: "
 			 "%s", strerror(errno));
 	}
-	if (bind(s, (struct sockaddr *)&sin0, sizeof(sin0)) < 0) {
-		tst_brkm(TBROK, cleanup, "socket bind failed for getsockopt: "
-			 "%s", strerror(errno));
-	}
+	SAFE_BIND(cleanup, s, (struct sockaddr *)&sin0, sizeof(sin0));
 	sinlen = sizeof(fsin1);
 	optlen = sizeof(optval);
 }
diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt01.c b/testcases/kernel/syscalls/setsockopt/setsockopt01.c
index f25694a96..36988854b 100644
--- a/testcases/kernel/syscalls/setsockopt/setsockopt01.c
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt01.c
@@ -54,6 +54,7 @@
 #include <netinet/in.h>
 
 #include "test.h"
+#include "safe_macros.h"
 
 char *TCID = "setsockopt01";
 int testno;
@@ -205,10 +206,7 @@ void setup1(void)
 		tst_brkm(TBROK, cleanup, "socket setup failed for setsockopt:"
 			 " %s", strerror(errno));
 	}
-	if (bind(s, (struct sockaddr *)&sin0, sizeof(sin0)) < 0) {
-		tst_brkm(TBROK, cleanup, "socket bind failed for setsockopt:"
-			 " %s", strerror(errno));
-	}
+	SAFE_BIND(cleanup, s, (struct sockaddr *)&sin0, sizeof(sin0));
 }
 
 void cleanup1(void)
diff --git a/testcases/kernel/syscalls/sockioctl/sockioctl01.c b/testcases/kernel/syscalls/sockioctl/sockioctl01.c
index ce1831cc8..79c53e042 100644
--- a/testcases/kernel/syscalls/sockioctl/sockioctl01.c
+++ b/testcases/kernel/syscalls/sockioctl/sockioctl01.c
@@ -210,10 +210,7 @@ static void setup1(void)
 		tst_brkm(TBROK, cleanup, "socket setup failed: %s",
 			 strerror(errno));
 	}
-	if (bind(s, (struct sockaddr *)&sin0, sizeof(sin0)) < 0) {
-		tst_brkm(TBROK, cleanup, "socket bind failed for: %s",
-			 strerror(errno));
-	}
+	SAFE_BIND(cleanup, s, (struct sockaddr *)&sin0, sizeof(sin0));
 	sinlen = sizeof(fsin1);
 
 	if (strncmp(tdat[testno].desc, "ATMARK on UDP", 14) == 0) {
-- 
2.13.5


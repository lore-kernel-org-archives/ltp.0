From: Petr Vorel <pvorel@suse.cz>
Date: Sat, 30 Sep 2017 01:10:36 +0200
Subject: [LTP] [PATCH 1/1] syscalls, lib: Use SAFE_{BIND, LISTEN,
	SOCKET} macros
Message-ID: <20170929231036.32262-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

instead of tst_brk{,m}(TBROK, ...)

Patch was made thanks to Coccinelle.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
---
 lib/tst_net.c                                      | 12 ++-----
 testcases/kernel/syscalls/accept/accept01.c        | 12 ++-----
 testcases/kernel/syscalls/connect/connect01.c      | 17 +++------
 .../kernel/syscalls/getpeername/getpeername01.c    |  7 ++--
 .../kernel/syscalls/getsockname/getsockname01.c    | 13 +++----
 .../kernel/syscalls/getsockopt/getsockopt01.c      | 13 +++----
 testcases/kernel/syscalls/listen/listen01.c        |  8 ++---
 testcases/kernel/syscalls/recv/recv01.c            | 17 +++------
 testcases/kernel/syscalls/recvfrom/recvfrom01.c    | 17 +++------
 testcases/kernel/syscalls/recvmsg/recvmsg01.c      | 23 +++---------
 testcases/kernel/syscalls/send/send01.c            | 17 +++------
 testcases/kernel/syscalls/sendfile/sendfile02.c    | 14 ++------
 testcases/kernel/syscalls/sendfile/sendfile04.c    | 14 ++------
 testcases/kernel/syscalls/sendfile/sendfile05.c    | 14 ++------
 testcases/kernel/syscalls/sendfile/sendfile06.c    | 13 ++-----
 testcases/kernel/syscalls/sendmsg/sendmsg01.c      | 42 ++++++----------------
 testcases/kernel/syscalls/sendto/sendto01.c        | 17 +++------
 .../kernel/syscalls/setsockopt/setsockopt01.c      | 13 +++----
 testcases/kernel/syscalls/sockioctl/sockioctl01.c  | 20 ++++-------
 19 files changed, 75 insertions(+), 228 deletions(-)

diff --git a/lib/tst_net.c b/lib/tst_net.c
index f842e94a6..326b92e6f 100644
--- a/lib/tst_net.c
+++ b/lib/tst_net.c
@@ -25,6 +25,7 @@
 #include <netinet/in.h>
 
 #include "test.h"
+#include "safe_macros.h"
 
 unsigned short tst_get_unused_port(void (cleanup_fn)(void),
 	unsigned short family, int type)
@@ -57,16 +58,9 @@ unsigned short tst_get_unused_port(void (cleanup_fn)(void),
 		return -1;
 	}
 
-	sock = socket(addr->sa_family, type, 0);
-	if (sock < 0) {
-		tst_brkm(TBROK | TERRNO, cleanup_fn, "socket failed");
-		return -1;
-	}
+	sock = SAFE_SOCKET(cleanup_fn, addr->sa_family, type, 0);
 
-	if (bind(sock, addr, slen) < 0) {
-		tst_brkm(TBROK | TERRNO, cleanup_fn, "bind failed");
-		return -1;
-	}
+	SAFE_BIND(cleanup_fn, sock, addr, slen);
 
 	if (getsockname(sock, addr, &slen) == -1) {
 		tst_brkm(TBROK | TERRNO, cleanup_fn, "getsockname failed");
diff --git a/testcases/kernel/syscalls/accept/accept01.c b/testcases/kernel/syscalls/accept/accept01.c
index 986415897..b50056520 100644
--- a/testcases/kernel/syscalls/accept/accept01.c
+++ b/testcases/kernel/syscalls/accept/accept01.c
@@ -156,15 +156,9 @@ static void cleanup0(void)
 
 static void setup1(void)
 {
-	s = socket(tdat[testno].domain, tdat[testno].type, tdat[testno].proto);
-	if (s < 0) {
-		tst_brkm(TBROK, cleanup, "socket setup failed for accept "
-			 "test %d: %s", testno, strerror(errno));
-	}
-	if (bind(s, (struct sockaddr *)&sin0, sizeof(sin0)) < 0) {
-		tst_brkm(TBROK, cleanup, "socket bind failed for accept "
-			 "test %d: %s", testno, strerror(errno));
-	}
+	s = SAFE_SOCKET(cleanup, tdat[testno].domain, tdat[testno].type,
+			tdat[testno].proto);
+	SAFE_BIND(cleanup, s, (struct sockaddr *)&sin0, sizeof(sin0));
 	sinlen = sizeof(fsin1);
 }
 
diff --git a/testcases/kernel/syscalls/connect/connect01.c b/testcases/kernel/syscalls/connect/connect01.c
index af6035435..5880b0794 100644
--- a/testcases/kernel/syscalls/connect/connect01.c
+++ b/testcases/kernel/syscalls/connect/connect01.c
@@ -53,6 +53,7 @@
 #include <netinet/in.h>
 
 #include "test.h"
+#include "safe_macros.h"
 
 char *TCID = "connect01";
 int testno;
@@ -230,19 +231,9 @@ pid_t start_server(struct sockaddr_in *sin0)
 	sin0->sin_port = 0; /* pick random free port */
 	sin0->sin_addr.s_addr = INADDR_ANY;
 
-	sfd = socket(PF_INET, SOCK_STREAM, 0);
-	if (sfd < 0) {
-		tst_brkm(TBROK | TERRNO, cleanup, "server socket failed");
-		return -1;
-	}
-	if (bind(sfd, (struct sockaddr *)sin0, sizeof(*sin0)) < 0) {
-		tst_brkm(TBROK | TERRNO, cleanup, "server bind failed");
-		return -1;
-	}
-	if (listen(sfd, 10) < 0) {
-		tst_brkm(TBROK | TERRNO, cleanup, "server listen failed");
-		return -1;
-	}
+	sfd = SAFE_SOCKET(cleanup, PF_INET, SOCK_STREAM, 0);
+	SAFE_BIND(cleanup, sfd, (struct sockaddr *)sin0, sizeof(*sin0));
+	SAFE_LISTEN(cleanup, sfd, 10);
 	if (getsockname(sfd, (struct sockaddr *)sin0, &slen) == -1)
 		tst_brkm(TBROK | TERRNO, cleanup, "getsockname failed");
 
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
index c4b6e9b1a..cce1543fd 100644
--- a/testcases/kernel/syscalls/getsockname/getsockname01.c
+++ b/testcases/kernel/syscalls/getsockname/getsockname01.c
@@ -52,6 +52,7 @@
 #include <netinet/in.h>
 
 #include "test.h"
+#include "safe_macros.h"
 
 char *TCID = "getsockname01";
 int testno;
@@ -167,15 +168,9 @@ void cleanup0(void)
 
 void setup1(void)
 {
-	s = socket(tdat[testno].domain, tdat[testno].type, tdat[testno].proto);
-	if (s < 0) {
-		tst_brkm(TBROK, cleanup, "socket setup failed for getsockname "
-			 "test %d: %s", testno, strerror(errno));
-	}
-	if (bind(s, (struct sockaddr *)&sin0, sizeof(sin0)) < 0) {
-		tst_brkm(TBROK, cleanup, "socket bind failed for getsockname "
-			 "test %d: %s", testno, strerror(errno));
-	}
+	s = SAFE_SOCKET(cleanup, tdat[testno].domain, tdat[testno].type,
+			tdat[testno].proto);
+	SAFE_BIND(cleanup, s, (struct sockaddr *)&sin0, sizeof(sin0));
 	sinlen = sizeof(fsin1);
 }
 
diff --git a/testcases/kernel/syscalls/getsockopt/getsockopt01.c b/testcases/kernel/syscalls/getsockopt/getsockopt01.c
index 1195306a0..d1692fcd3 100644
--- a/testcases/kernel/syscalls/getsockopt/getsockopt01.c
+++ b/testcases/kernel/syscalls/getsockopt/getsockopt01.c
@@ -52,6 +52,7 @@
 #include <netinet/in.h>
 
 #include "test.h"
+#include "safe_macros.h"
 
 char *TCID = "getsockopt01";
 int testno;
@@ -193,15 +194,9 @@ void cleanup0(void)
 
 void setup1(void)
 {
-	s = socket(tdat[testno].domain, tdat[testno].type, tdat[testno].proto);
-	if (s < 0) {
-		tst_brkm(TBROK, cleanup, "socket setup failed for getsockopt: "
-			 "%s", strerror(errno));
-	}
-	if (bind(s, (struct sockaddr *)&sin0, sizeof(sin0)) < 0) {
-		tst_brkm(TBROK, cleanup, "socket bind failed for getsockopt: "
-			 "%s", strerror(errno));
-	}
+	s = SAFE_SOCKET(cleanup, tdat[testno].domain, tdat[testno].type,
+			tdat[testno].proto);
+	SAFE_BIND(cleanup, s, (struct sockaddr *)&sin0, sizeof(sin0));
 	sinlen = sizeof(fsin1);
 	optlen = sizeof(optval);
 }
diff --git a/testcases/kernel/syscalls/listen/listen01.c b/testcases/kernel/syscalls/listen/listen01.c
index e421bb46d..b3dd7125d 100644
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
+			tdat[testno].proto);
 }
 
 void cleanup1(void)
diff --git a/testcases/kernel/syscalls/recv/recv01.c b/testcases/kernel/syscalls/recv/recv01.c
index 9c21dc206..470cf9a19 100644
--- a/testcases/kernel/syscalls/recv/recv01.c
+++ b/testcases/kernel/syscalls/recv/recv01.c
@@ -53,6 +53,7 @@
 #include <netinet/in.h>
 
 #include "test.h"
+#include "safe_macros.h"
 
 char *TCID = "recv01";
 int testno;
@@ -225,19 +226,9 @@ pid_t start_server(struct sockaddr_in *sin0)
 	sin0->sin_port = 0; /* pick random free port */
 	sin0->sin_addr.s_addr = INADDR_ANY;
 
-	sfd = socket(PF_INET, SOCK_STREAM, 0);
-	if (sfd < 0) {
-		tst_brkm(TBROK | TERRNO, cleanup, "server socket failed");
-		return -1;
-	}
-	if (bind(sfd, (struct sockaddr *)sin0, sizeof(*sin0)) < 0) {
-		tst_brkm(TBROK | TERRNO, cleanup, "server bind failed");
-		return -1;
-	}
-	if (listen(sfd, 10) < 0) {
-		tst_brkm(TBROK | TERRNO, cleanup, "server listen failed");
-		return -1;
-	}
+	sfd = SAFE_SOCKET(cleanup, PF_INET, SOCK_STREAM, 0);
+	SAFE_BIND(cleanup, sfd, (struct sockaddr *)sin0, sizeof(*sin0));
+	SAFE_LISTEN(cleanup, sfd, 10);
 	if (getsockname(sfd, (struct sockaddr *)sin0, &slen) == -1)
 		tst_brkm(TBROK | TERRNO, cleanup, "getsockname failed");
 
diff --git a/testcases/kernel/syscalls/recvfrom/recvfrom01.c b/testcases/kernel/syscalls/recvfrom/recvfrom01.c
index 3bcf2a1fc..d95c28f9a 100644
--- a/testcases/kernel/syscalls/recvfrom/recvfrom01.c
+++ b/testcases/kernel/syscalls/recvfrom/recvfrom01.c
@@ -53,6 +53,7 @@
 #include <netinet/in.h>
 
 #include "test.h"
+#include "safe_macros.h"
 
 char *TCID = "recvfrom01";
 int testno;
@@ -254,19 +255,9 @@ pid_t start_server(struct sockaddr_in *sin0)
 	sin0->sin_port = 0; /* pick random free port */
 	sin0->sin_addr.s_addr = INADDR_ANY;
 
-	sfd = socket(PF_INET, SOCK_STREAM, 0);
-	if (sfd < 0) {
-		tst_brkm(TBROK | TERRNO, cleanup, "server socket failed");
-		return -1;
-	}
-	if (bind(sfd, (struct sockaddr *)sin0, sizeof(*sin0)) < 0) {
-		tst_brkm(TBROK | TERRNO, cleanup, "server bind failed");
-		return -1;
-	}
-	if (listen(sfd, 10) < 0) {
-		tst_brkm(TBROK | TERRNO, cleanup, "server listen failed");
-		return -1;
-	}
+	sfd = SAFE_SOCKET(cleanup, PF_INET, SOCK_STREAM, 0);
+	SAFE_BIND(cleanup, sfd, (struct sockaddr *)sin0, sizeof(*sin0));
+	SAFE_LISTEN(cleanup, sfd, 10);
 	if (getsockname(sfd, (struct sockaddr *)sin0, &slen) == -1)
 		tst_brkm(TBROK | TERRNO, cleanup, "getsockname failed");
 
diff --git a/testcases/kernel/syscalls/recvmsg/recvmsg01.c b/testcases/kernel/syscalls/recvmsg/recvmsg01.c
index 13bd58f4b..51b2a0061 100644
--- a/testcases/kernel/syscalls/recvmsg/recvmsg01.c
+++ b/testcases/kernel/syscalls/recvmsg/recvmsg01.c
@@ -56,6 +56,7 @@
 #include <netinet/in.h>
 
 #include "test.h"
+#include "safe_macros.h"
 
 char *TCID = "recvmsg01";
 int testno;
@@ -374,28 +375,14 @@ pid_t start_server(struct sockaddr_in *ssin, struct sockaddr_un *ssun)
 	ssin->sin_addr.s_addr = INADDR_ANY;
 
 	/* set up inet socket */
-	sfd = socket(PF_INET, SOCK_STREAM, 0);
-	if (sfd < 0) {
-		tst_brkm(TBROK | TERRNO, cleanup, "server socket failed");
-		return -1;
-	}
-	if (bind(sfd, (struct sockaddr *)ssin, sizeof(*ssin)) < 0) {
-		tst_brkm(TBROK | TERRNO, cleanup, "server bind failed");
-		return -1;
-	}
-	if (listen(sfd, 10) < 0) {
-		tst_brkm(TBROK | TERRNO, cleanup, "server listen failed");
-		return -1;
-	}
+	sfd = SAFE_SOCKET(cleanup, PF_INET, SOCK_STREAM, 0);
+	SAFE_BIND(cleanup, sfd, (struct sockaddr *)ssin, sizeof(*ssin));
+	SAFE_LISTEN(cleanup, sfd, 10);
 	if (getsockname(sfd, (struct sockaddr *)ssin, &slen) == -1)
 		tst_brkm(TBROK | TERRNO, cleanup, "getsockname failed");
 
 	/* set up UNIX-domain socket */
-	ufd = socket(PF_UNIX, SOCK_STREAM, 0);
-	if (ufd < 0) {
-		tst_brkm(TBROK | TERRNO, cleanup, "server UD socket failed");
-		return -1;
-	}
+	ufd = SAFE_SOCKET(cleanup, PF_UNIX, SOCK_STREAM, 0);
 	if (bind(ufd, (struct sockaddr *)ssun, sizeof(*ssun))) {
 		tst_brkm(TBROK | TERRNO, cleanup, "server UD bind failed");
 		return -1;
diff --git a/testcases/kernel/syscalls/send/send01.c b/testcases/kernel/syscalls/send/send01.c
index 6f71300ce..cef0c90a0 100644
--- a/testcases/kernel/syscalls/send/send01.c
+++ b/testcases/kernel/syscalls/send/send01.c
@@ -42,6 +42,7 @@
 #include <netinet/in.h>
 
 #include "test.h"
+#include "safe_macros.h"
 
 char *TCID = "send01";
 int testno;
@@ -169,19 +170,9 @@ static pid_t start_server(struct sockaddr_in *sin0)
 	sin0->sin_port = 0; /* pick random free port */
 	sin0->sin_addr.s_addr = INADDR_ANY;
 
-	sfd = socket(PF_INET, SOCK_STREAM, 0);
-	if (sfd < 0) {
-		tst_brkm(TBROK | TERRNO, cleanup, "server socket failed");
-		return -1;
-	}
-	if (bind(sfd, (struct sockaddr *)sin0, sizeof(*sin0)) < 0) {
-		tst_brkm(TBROK | TERRNO, cleanup, "server bind failed");
-		return -1;
-	}
-	if (listen(sfd, 10) < 0) {
-		tst_brkm(TBROK | TERRNO, cleanup, "server listen failed");
-		return -1;
-	}
+	sfd = SAFE_SOCKET(cleanup, PF_INET, SOCK_STREAM, 0);
+	SAFE_BIND(cleanup, sfd, (struct sockaddr *)sin0, sizeof(*sin0));
+	SAFE_LISTEN(cleanup, sfd, 10);
 	if (getsockname(sfd, (struct sockaddr *)sin0, &slen) == -1)
 		tst_brkm(TBROK | TERRNO, cleanup, "getsockname failed");
 
diff --git a/testcases/kernel/syscalls/sendfile/sendfile02.c b/testcases/kernel/syscalls/sendfile/sendfile02.c
index ba12308b3..37680839f 100644
--- a/testcases/kernel/syscalls/sendfile/sendfile02.c
+++ b/testcases/kernel/syscalls/sendfile/sendfile02.c
@@ -57,6 +57,7 @@
 #include <unistd.h>
 #include <inttypes.h>
 #include "test.h"
+#include "safe_macros.h"
 
 #ifndef OFF_T
 #define OFF_T off_t
@@ -214,21 +215,12 @@ int create_server(void)
 	static int count = 0;
 	socklen_t slen = sizeof(sin1);
 
-	sockfd = socket(PF_INET, SOCK_DGRAM, 0);
-	if (sockfd < 0) {
-		tst_brkm(TBROK, cleanup, "call to socket() failed: %s",
-			 strerror(errno));
-		return -1;
-	}
+	sockfd = SAFE_SOCKET(cleanup, PF_INET, SOCK_DGRAM, 0);
 	sin1.sin_family = AF_INET;
 	sin1.sin_port = 0; /* pick random free port */
 	sin1.sin_addr.s_addr = INADDR_ANY;
 	count++;
-	if (bind(sockfd, (struct sockaddr *)&sin1, sizeof(sin1)) < 0) {
-		tst_brkm(TBROK, cleanup, "call to bind() failed: %s",
-			 strerror(errno));
-		return -1;
-	}
+	SAFE_BIND(cleanup, sockfd, (struct sockaddr *)&sin1, sizeof(sin1));
 	if (getsockname(sockfd, (struct sockaddr *)&sin1, &slen) == -1)
 		tst_brkm(TBROK | TERRNO, cleanup, "getsockname failed");
 
diff --git a/testcases/kernel/syscalls/sendfile/sendfile04.c b/testcases/kernel/syscalls/sendfile/sendfile04.c
index 822c4688c..45c15df50 100644
--- a/testcases/kernel/syscalls/sendfile/sendfile04.c
+++ b/testcases/kernel/syscalls/sendfile/sendfile04.c
@@ -57,6 +57,7 @@
 #include <netinet/in.h>
 #include <arpa/inet.h>
 #include "test.h"
+#include "safe_macros.h"
 
 #ifndef OFF_T
 #define OFF_T off_t
@@ -212,21 +213,12 @@ int create_server(void)
 	static int count = 0;
 	socklen_t slen = sizeof(sin1);
 
-	sockfd = socket(PF_INET, SOCK_DGRAM, 0);
-	if (sockfd < 0) {
-		tst_brkm(TBROK, cleanup, "call to socket() failed: %s",
-			 strerror(errno));
-		return -1;
-	}
+	sockfd = SAFE_SOCKET(cleanup, PF_INET, SOCK_DGRAM, 0);
 	sin1.sin_family = AF_INET;
 	sin1.sin_port = 0; /* pick random free port */
 	sin1.sin_addr.s_addr = INADDR_ANY;
 	count++;
-	if (bind(sockfd, (struct sockaddr *)&sin1, sizeof(sin1)) < 0) {
-		tst_brkm(TBROK, cleanup, "call to bind() failed: %s",
-			 strerror(errno));
-		return -1;
-	}
+	SAFE_BIND(cleanup, sockfd, (struct sockaddr *)&sin1, sizeof(sin1));
 	if (getsockname(sockfd, (struct sockaddr *)&sin1, &slen) == -1)
 		tst_brkm(TBROK | TERRNO, cleanup, "getsockname failed");
 
diff --git a/testcases/kernel/syscalls/sendfile/sendfile05.c b/testcases/kernel/syscalls/sendfile/sendfile05.c
index 110194b84..d3222c19a 100644
--- a/testcases/kernel/syscalls/sendfile/sendfile05.c
+++ b/testcases/kernel/syscalls/sendfile/sendfile05.c
@@ -52,6 +52,7 @@
 #include <netinet/in.h>
 #include <arpa/inet.h>
 #include "test.h"
+#include "safe_macros.h"
 
 #ifndef OFF_T
 #define OFF_T off_t
@@ -176,21 +177,12 @@ int create_server(void)
 	static int count = 0;
 	socklen_t slen = sizeof(sin1);
 
-	sockfd = socket(PF_INET, SOCK_DGRAM, 0);
-	if (sockfd < 0) {
-		tst_brkm(TBROK, cleanup, "call to socket() failed: %s",
-			 strerror(errno));
-		return -1;
-	}
+	sockfd = SAFE_SOCKET(cleanup, PF_INET, SOCK_DGRAM, 0);
 	sin1.sin_family = AF_INET;
 	sin1.sin_port = 0; /* pick random free port */
 	sin1.sin_addr.s_addr = INADDR_ANY;
 	count++;
-	if (bind(sockfd, (struct sockaddr *)&sin1, sizeof(sin1)) < 0) {
-		tst_brkm(TBROK, cleanup, "call to bind() failed: %s",
-			 strerror(errno));
-		return -1;
-	}
+	SAFE_BIND(cleanup, sockfd, (struct sockaddr *)&sin1, sizeof(sin1));
 	if (getsockname(sockfd, (struct sockaddr *)&sin1, &slen) == -1)
 		tst_brkm(TBROK | TERRNO, cleanup, "getsockname failed");
 
diff --git a/testcases/kernel/syscalls/sendfile/sendfile06.c b/testcases/kernel/syscalls/sendfile/sendfile06.c
index 794519549..b77c193a4 100644
--- a/testcases/kernel/syscalls/sendfile/sendfile06.c
+++ b/testcases/kernel/syscalls/sendfile/sendfile06.c
@@ -154,21 +154,12 @@ static int create_server(void)
 	int s;
 	socklen_t slen = sizeof(sin1);
 
-	sockfd = socket(PF_INET, SOCK_DGRAM, 0);
-	if (sockfd < 0) {
-		tst_brkm(TBROK, cleanup, "call to socket() failed: %s",
-			 strerror(errno));
-		return -1;
-	}
+	sockfd = SAFE_SOCKET(cleanup, PF_INET, SOCK_DGRAM, 0);
 	sin1.sin_family = AF_INET;
 	sin1.sin_port = 0; /* pick random free port */
 	sin1.sin_addr.s_addr = INADDR_ANY;
 
-	if (bind(sockfd, (struct sockaddr *)&sin1, sizeof(sin1)) < 0) {
-		tst_brkm(TBROK, cleanup, "call to bind() failed: %s",
-			 strerror(errno));
-		return -1;
-	}
+	SAFE_BIND(cleanup, sockfd, (struct sockaddr *)&sin1, sizeof(sin1));
 	if (getsockname(sockfd, (struct sockaddr *)&sin1, &slen) == -1)
 		tst_brkm(TBROK | TERRNO, cleanup, "getsockname failed");
 
diff --git a/testcases/kernel/syscalls/sendmsg/sendmsg01.c b/testcases/kernel/syscalls/sendmsg/sendmsg01.c
index dcf3ab7e8..364c7e584 100644
--- a/testcases/kernel/syscalls/sendmsg/sendmsg01.c
+++ b/testcases/kernel/syscalls/sendmsg/sendmsg01.c
@@ -48,6 +48,7 @@
 #include <netinet/in.h>
 
 #include "test.h"
+#include "safe_macros.h"
 
 char *TCID = "sendmsg01";
 int testno;
@@ -425,17 +426,8 @@ static pid_t start_server(struct sockaddr_in *sin0, struct sockaddr_un *sun0)
 	sin0->sin_addr.s_addr = INADDR_ANY;
 
 	/* set up inet socket */
-	sfd = socket(PF_INET, SOCK_STREAM, 0);
-	if (sfd < 0) {
-		tst_brkm(TBROK, cleanup, "server socket failed: %s",
-			 strerror(errno));
-		return -1;
-	}
-	if (bind(sfd, (struct sockaddr *)sin0, sizeof(*sin0)) < 0) {
-		tst_brkm(TBROK, cleanup, "server bind failed: %s",
-			 strerror(errno));
-		return -1;
-	}
+	sfd = SAFE_SOCKET(cleanup, PF_INET, SOCK_STREAM, 0);
+	SAFE_BIND(cleanup, sfd, (struct sockaddr *)sin0, sizeof(*sin0));
 	if (listen(sfd, 10) < 0) {
 		tst_brkm(TBROK, cleanup, "server listen failed: %s",
 			 strerror(errno));
@@ -445,12 +437,7 @@ static pid_t start_server(struct sockaddr_in *sin0, struct sockaddr_un *sun0)
 		tst_brkm(TBROK | TERRNO, cleanup, "getsockname failed");
 
 	/* set up UNIX-domain socket */
-	ufd = socket(PF_UNIX, SOCK_DGRAM, 0);
-	if (ufd < 0) {
-		tst_brkm(TBROK, cleanup, "server UD socket failed: %s",
-			 strerror(errno));
-		return -1;
-	}
+	ufd = SAFE_SOCKET(cleanup, PF_UNIX, SOCK_DGRAM, 0);
 	if (bind(ufd, (struct sockaddr *)sun0, sizeof(*sun0))) {
 		tst_brkm(TBROK, cleanup, "server UD bind failed: %s",
 			 strerror(errno));
@@ -589,11 +576,8 @@ static void cleanup0(void)
 
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
@@ -618,11 +602,8 @@ static void setup2(void)
 
 static void setup3(void)
 {
-	s = socket(tdat[testno].domain, tdat[testno].type, tdat[testno].proto);
-	if (s < 0) {
-		tst_brkm(TBROK, cleanup, "socket setup failed: %s",
-			 strerror(errno));
-	}
+	s = SAFE_SOCKET(cleanup, tdat[testno].domain, tdat[testno].type,
+			tdat[testno].proto);
 }
 
 static char tmpfilename[1024];
@@ -659,11 +640,8 @@ static void cleanup4(void)
 
 static void setup5(void)
 {
-	s = socket(tdat[testno].domain, tdat[testno].type, tdat[testno].proto);
-	if (s < 0) {
-		tst_brkm(TBROK, cleanup, "socket setup failed: %s",
-			 strerror(errno));
-	}
+	s = SAFE_SOCKET(cleanup, tdat[testno].domain, tdat[testno].type,
+			tdat[testno].proto);
 
 	if (connect(s, (struct sockaddr *)&sin1, sizeof(sin1)) < 0)
 		tst_brkm(TBROK, cleanup, "connect failed: %s", strerror(errno));
diff --git a/testcases/kernel/syscalls/sendto/sendto01.c b/testcases/kernel/syscalls/sendto/sendto01.c
index ec0766197..7753a4ffb 100644
--- a/testcases/kernel/syscalls/sendto/sendto01.c
+++ b/testcases/kernel/syscalls/sendto/sendto01.c
@@ -41,6 +41,7 @@
 #include <netinet/in.h>
 
 #include "test.h"
+#include "safe_macros.h"
 
 char *TCID = "sendto01";
 int testno;
@@ -239,19 +240,9 @@ static pid_t start_server(struct sockaddr_in *sin0)
 	sin0->sin_port = 0; /* pick random free port */
 	sin0->sin_addr.s_addr = INADDR_ANY;
 
-	sfd = socket(PF_INET, SOCK_STREAM, 0);
-	if (sfd < 0) {
-		tst_brkm(TBROK | TERRNO, cleanup, "server socket failed");
-		return -1;
-	}
-	if (bind(sfd, (struct sockaddr *)sin0, sizeof(*sin0)) < 0) {
-		tst_brkm(TBROK | TERRNO, cleanup, "server bind failed");
-		return -1;
-	}
-	if (listen(sfd, 10) < 0) {
-		tst_brkm(TBROK | TERRNO, cleanup, "server listen failed");
-		return -1;
-	}
+	sfd = SAFE_SOCKET(cleanup, PF_INET, SOCK_STREAM, 0);
+	SAFE_BIND(cleanup, sfd, (struct sockaddr *)sin0, sizeof(*sin0));
+	SAFE_LISTEN(cleanup, sfd, 10);
 	if (getsockname(sfd, (struct sockaddr *)sin0, &slen) == -1)
 		tst_brkm(TBROK | TERRNO, cleanup, "getsockname failed");
 
diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt01.c b/testcases/kernel/syscalls/setsockopt/setsockopt01.c
index f25694a96..743c6be14 100644
--- a/testcases/kernel/syscalls/setsockopt/setsockopt01.c
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt01.c
@@ -54,6 +54,7 @@
 #include <netinet/in.h>
 
 #include "test.h"
+#include "safe_macros.h"
 
 char *TCID = "setsockopt01";
 int testno;
@@ -200,15 +201,9 @@ void cleanup0(void)
 
 void setup1(void)
 {
-	s = socket(tdat[testno].domain, tdat[testno].type, tdat[testno].proto);
-	if (s < 0) {
-		tst_brkm(TBROK, cleanup, "socket setup failed for setsockopt:"
-			 " %s", strerror(errno));
-	}
-	if (bind(s, (struct sockaddr *)&sin0, sizeof(sin0)) < 0) {
-		tst_brkm(TBROK, cleanup, "socket bind failed for setsockopt:"
-			 " %s", strerror(errno));
-	}
+	s = SAFE_SOCKET(cleanup, tdat[testno].domain, tdat[testno].type,
+			tdat[testno].proto);
+	SAFE_BIND(cleanup, s, (struct sockaddr *)&sin0, sizeof(sin0));
 }
 
 void cleanup1(void)
diff --git a/testcases/kernel/syscalls/sockioctl/sockioctl01.c b/testcases/kernel/syscalls/sockioctl/sockioctl01.c
index 50bdc935a..096f138a9 100644
--- a/testcases/kernel/syscalls/sockioctl/sockioctl01.c
+++ b/testcases/kernel/syscalls/sockioctl/sockioctl01.c
@@ -40,6 +40,7 @@
 #include <net/if.h>
 
 #include "test.h"
+#include "safe_macros.h"
 
 char *TCID = "sockioctl01";
 int testno;
@@ -204,15 +205,9 @@ static void cleanup0(void)
 
 static void setup1(void)
 {
-	s = socket(tdat[testno].domain, tdat[testno].type, tdat[testno].proto);
-	if (s < 0) {
-		tst_brkm(TBROK, cleanup, "socket setup failed: %s",
-			 strerror(errno));
-	}
-	if (bind(s, (struct sockaddr *)&sin0, sizeof(sin0)) < 0) {
-		tst_brkm(TBROK, cleanup, "socket bind failed for: %s",
-			 strerror(errno));
-	}
+	s = SAFE_SOCKET(cleanup, tdat[testno].domain, tdat[testno].type,
+			tdat[testno].proto);
+	SAFE_BIND(cleanup, s, (struct sockaddr *)&sin0, sizeof(sin0));
 	sinlen = sizeof(fsin1);
 
 	if (strncmp(tdat[testno].desc, "ATMARK on UDP", 14) == 0) {
@@ -223,11 +218,8 @@ static void setup1(void)
 
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
2.14.1


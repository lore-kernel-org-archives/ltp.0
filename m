From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 13 Nov 2020 14:14:23 +0100
Subject: [LTP] [PATCH 05/10] syscalls/bind: Make use of TEST_MACROS
In-Reply-To: <20201113131428.13199-1-chrubis@suse.cz>
References: <20201113131428.13199-1-chrubis@suse.cz>
Message-ID: <20201113131428.13199-6-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/bind/bind01.c | 12 +++++-------
 testcases/kernel/syscalls/bind/bind02.c | 11 ++---------
 testcases/kernel/syscalls/bind/bind03.c | 26 ++++---------------------
 testcases/kernel/syscalls/bind/bind04.c |  5 ++---
 testcases/kernel/syscalls/bind/bind05.c |  5 ++---
 5 files changed, 15 insertions(+), 44 deletions(-)

diff --git a/testcases/kernel/syscalls/bind/bind01.c b/testcases/kernel/syscalls/bind/bind01.c
index 2054996ac..ce5cae298 100644
--- a/testcases/kernel/syscalls/bind/bind01.c
+++ b/testcases/kernel/syscalls/bind/bind01.c
@@ -47,14 +47,12 @@ void verify_bind(unsigned int nr)
 {
 	struct test_case *tcase = &tcases[nr];
 
-	TEST(bind(*tcase->socket_fd, tcase->sockaddr, tcase->salen));
-	if (TST_RET != tcase->retval && TST_ERR != tcase->experrno) {
-		tst_res(TFAIL, "%s ; returned"
-			" %ld (expected %d), errno %d (expected"
-			" %d)", tcase->desc, TST_RET, tcase->retval,
-			TST_ERR, tcase->experrno);
+	if (tcase->experrno) {
+		TEST_FAIL(bind(*tcase->socket_fd, tcase->sockaddr, tcase->salen),
+		               tcase->experrno, "%s", tcase->desc);
 	} else {
-		tst_res(TPASS, "%s successful", tcase->desc);
+		TEST_PASS(bind(*tcase->socket_fd, tcase->sockaddr, tcase->salen),
+		          "%s", tcase->desc);
 	}
 }
 
diff --git a/testcases/kernel/syscalls/bind/bind02.c b/testcases/kernel/syscalls/bind/bind02.c
index 65944cbe3..ffde994f8 100644
--- a/testcases/kernel/syscalls/bind/bind02.c
+++ b/testcases/kernel/syscalls/bind/bind02.c
@@ -36,16 +36,9 @@ static void run(void)
 	servaddr.sin_family = AF_INET;
 	servaddr.sin_port = htons(TCP_PRIVILEGED_PORT);
 	servaddr.sin_addr.s_addr = htonl(INADDR_ANY);
-	TEST(bind(sockfd, (struct sockaddr *)&servaddr, sizeof(servaddr)));
+	TEST_FAIL(bind(sockfd, (struct sockaddr *)&servaddr, sizeof(servaddr)),
+	          EACCES, "bind()");
 	SAFE_CLOSE(sockfd);
-
-	if (TST_RET != -1) {
-		tst_res(TFAIL, "bind() returned %li, expected -1", TST_RET);
-	} else if (TST_ERR == EACCES) {
-		tst_res(TPASS | TTERRNO, "bind() failed as expected");
-	} else {
-		tst_res(TFAIL | TTERRNO, "Unexpected error");
-	}
 }
 
 static void setup(void)
diff --git a/testcases/kernel/syscalls/bind/bind03.c b/testcases/kernel/syscalls/bind/bind03.c
index dda5ca374..8e9aeb7b3 100644
--- a/testcases/kernel/syscalls/bind/bind03.c
+++ b/testcases/kernel/syscalls/bind/bind03.c
@@ -51,17 +51,8 @@ void run(void)
 	 * Once a STREAM UNIX domain socket has been bound, it can't be
 	 * rebound.
 	 */
-	if (bind(sock1, (struct sockaddr *)&sun2, sizeof(sun2)) == 0) {
-		tst_res(TFAIL, "re-binding of socket succeeded");
-		return;
-	}
-
-	if (errno != EINVAL) {
-		tst_res(TFAIL | TERRNO, "expected EINVAL");
-		return;
-	}
-
-	tst_res(TPASS, "bind() failed with EINVAL as expected");
+	TEST_FAIL(bind(sock1, (struct sockaddr *)&sun2, sizeof(sun2)),
+	          EINVAL, "re-bind() socket");
 
 	sock2 = SAFE_SOCKET(PF_UNIX, SOCK_STREAM, 0);
 
@@ -69,17 +60,8 @@ void run(void)
 	 * Since a socket is already bound to the pathname, it can't be bound
 	 * to a second socket. Expected error is EADDRINUSE.
 	 */
-	if (bind(sock2, (struct sockaddr *)&sun1, sizeof(sun1)) == 0) {
-		tst_res(TFAIL, "bind() succeeded with already bound pathname!");
-		return;
-	}
-
-	if (errno != EADDRINUSE) {
-		tst_res(TFAIL | TERRNO, "expected to fail with EADDRINUSE");
-		return;
-	}
-
-	tst_res(TPASS, "bind() failed with EADDRINUSE as expected");
+	TEST_FAIL(bind(sock2, (struct sockaddr *)&sun1, sizeof(sun1)),
+	          EADDRINUSE, "bind() with bound pathname");
 }
 
 static void cleanup(void)
diff --git a/testcases/kernel/syscalls/bind/bind04.c b/testcases/kernel/syscalls/bind/bind04.c
index 51f19c6cd..f78520750 100644
--- a/testcases/kernel/syscalls/bind/bind04.c
+++ b/testcases/kernel/syscalls/bind/bind04.c
@@ -118,10 +118,9 @@ static void test_bind(unsigned int n)
 	listen_sock = SAFE_SOCKET(tc->address->sa_family, tc->type,
 		tc->protocol);
 
-	TEST(bind(listen_sock, tc->address, tc->addrlen));
+	TEST_PASS(bind(listen_sock, tc->address, tc->addrlen), "bind()");
 
-	if (TST_RET) {
-		tst_res(TFAIL | TERRNO, "bind() failed");
+	if (!TST_PASS) {
 		SAFE_CLOSE(listen_sock);
 		return;
 	}
diff --git a/testcases/kernel/syscalls/bind/bind05.c b/testcases/kernel/syscalls/bind/bind05.c
index 16c9c711d..194cc3d69 100644
--- a/testcases/kernel/syscalls/bind/bind05.c
+++ b/testcases/kernel/syscalls/bind/bind05.c
@@ -131,10 +131,9 @@ static void test_bind(unsigned int n)
 	tst_res(TINFO, "Testing %s", tc->description);
 	sock = SAFE_SOCKET(tc->address->sa_family, tc->type, tc->protocol);
 
-	TEST(bind(sock, tc->address, tc->addrlen));
+	TEST_PASS(bind(sock, tc->address, tc->addrlen), "bind()");
 
-	if (TST_RET) {
-		tst_res(TFAIL | TERRNO, "bind() failed");
+	if (!TST_PASS) {
 		SAFE_CLOSE(sock);
 		return;
 	}
-- 
2.26.2


From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 12 Aug 2019 16:39:36 +0200
Subject: [LTP] [PATCH v2 06/11] syscalls/accept4_01: Make use of guarded
 buffers.
In-Reply-To: <20190812143941.8119-1-chrubis@suse.cz>
References: <20190812143941.8119-1-chrubis@suse.cz>
Message-ID: <20190812143941.8119-7-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 .../kernel/syscalls/accept4/accept4_01.c      | 24 +++++++++++--------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/testcases/kernel/syscalls/accept4/accept4_01.c b/testcases/kernel/syscalls/accept4/accept4_01.c
index dd289cf6d..29e18f27d 100644
--- a/testcases/kernel/syscalls/accept4/accept4_01.c
+++ b/testcases/kernel/syscalls/accept4/accept4_01.c
@@ -35,7 +35,7 @@
 #define USE_SOCKETCALL 1
 #endif
 
-static struct sockaddr_in conn_addr;
+static struct sockaddr_in *conn_addr, *accept_addr;
 static int listening_fd;
 
 #if !(__GLIBC_PREREQ(2, 10))
@@ -80,10 +80,10 @@ static int create_listening_socket(void)
 
 static void setup(void)
 {
-	memset(&conn_addr, 0, sizeof(struct sockaddr_in));
-	conn_addr.sin_family = AF_INET;
-	conn_addr.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
-	conn_addr.sin_port = htons(PORT_NUM);
+	memset(conn_addr, 0, sizeof(*conn_addr));
+	conn_addr->sin_family = AF_INET;
+	conn_addr->sin_addr.s_addr = htonl(INADDR_LOOPBACK);
+	conn_addr->sin_port = htons(PORT_NUM);
 
 	listening_fd = create_listening_socket();
 }
@@ -108,18 +108,17 @@ static void verify_accept4(unsigned int nr)
 	struct test_case *tcase = &tcases[nr];
 	int connfd, acceptfd;
 	int fdf, flf, fdf_pass, flf_pass, fd_cloexec, fd_nonblock;
-	struct sockaddr_in claddr;
 	socklen_t addrlen;
 
 	connfd = SAFE_SOCKET(AF_INET, SOCK_STREAM, 0);
-	SAFE_CONNECT(connfd, (struct sockaddr *)&conn_addr, sizeof(conn_addr));
-	addrlen = sizeof(claddr);
+	SAFE_CONNECT(connfd, (struct sockaddr *)conn_addr, sizeof(*conn_addr));
+	addrlen = sizeof(*accept_addr);
 
 #if !(__GLIBC_PREREQ(2, 10))
-	TEST(accept4_01(listening_fd, (struct sockaddr *)&claddr, &addrlen,
+	TEST(accept4_01(listening_fd, (struct sockaddr *)accept_addr, &addrlen,
 				tcase->cloexec | tcase->nonblock));
 #else
-	TEST(accept4(listening_fd, (struct sockaddr *)&claddr, &addrlen,
+	TEST(accept4(listening_fd, (struct sockaddr *)accept_addr, &addrlen,
 				tcase->cloexec | tcase->nonblock));
 #endif
 	if (TST_RET == -1) {
@@ -163,4 +162,9 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.test = verify_accept4,
+	.bufs = (struct tst_buffers []) {
+		{&conn_addr, .size = sizeof(*conn_addr)},
+		{&accept_addr, .size = sizeof(*accept_addr)},
+		{},
+	}
 };
-- 
2.21.0


From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 26 Mar 2019 16:33:56 +0100
Subject: [LTP] [PATCH 3/4] syscalls/accept4: convert to new library
In-Reply-To: <20190325232012.67123-4-sspatil@android.com>
References: <20190325232012.67123-1-sspatil@android.com>
 <20190325232012.67123-4-sspatil@android.com>
Message-ID: <20190326153356.GB11086@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with small cleanup and simplification, thanks.

diff --git a/testcases/kernel/syscalls/accept4/accept4_01.c b/testcases/kernel/syscalls/accept4/accept4_01.c
index 036457571..c423b2a7d 100644
--- a/testcases/kernel/syscalls/accept4/accept4_01.c
+++ b/testcases/kernel/syscalls/accept4/accept4_01.c
@@ -25,18 +25,18 @@
 #define PORT_NUM 33333
 
 #ifndef SOCK_CLOEXEC
-#define SOCK_CLOEXEC    O_CLOEXEC
+# define SOCK_CLOEXEC    O_CLOEXEC
 #endif
 #ifndef SOCK_NONBLOCK
-#define SOCK_NONBLOCK   O_NONBLOCK
+# define SOCK_NONBLOCK   O_NONBLOCK
 #endif
 
 #if defined(SYS_ACCEPT4)	/* the socketcall() number */
 #define USE_SOCKETCALL 1
 #endif
 
-struct sockaddr_in conn_addr;
-int listening_fd;
+static struct sockaddr_in conn_addr;
+static int listening_fd;
 
 #if !(__GLIBC_PREREQ(2, 10))
 static int
@@ -78,7 +78,7 @@ static int create_listening_socket(void)
 	return lfd;
 }
 
-void setup(void)
+static void setup(void)
 {
 	memset(&conn_addr, 0, sizeof(struct sockaddr_in));
 	conn_addr.sin_family = AF_INET;
@@ -88,7 +88,7 @@ void setup(void)
 	listening_fd = create_listening_socket();
 }
 
-void cleanup(void)
+static void cleanup(void)
 {
 	SAFE_CLOSE(listening_fd);
 }
@@ -103,11 +103,11 @@ static struct test_case {
 	{ SOCK_CLOEXEC, SOCK_NONBLOCK },
 };
 
-void verify_accept4(unsigned int nr)
+static void verify_accept4(unsigned int nr)
 {
 	struct test_case *tcase = &tcases[nr];
 	int connfd, acceptfd;
-	int fdf, flf, fdf_pass, flf_pass;
+	int fdf, flf, fdf_pass, flf_pass, fd_cloexec, fd_nonblock;
 	struct sockaddr_in claddr;
 	socklen_t addrlen;
 
@@ -133,27 +133,29 @@ void verify_accept4(unsigned int nr)
 
 	/* Test to see if O_CLOEXEC is as expected */
 	fdf = SAFE_FCNTL(acceptfd, F_GETFD);
-	fdf_pass = !!(fdf & FD_CLOEXEC) == !!(tcase->cloexec & SOCK_CLOEXEC);
-	if (!fdf_pass)
-		tst_res(TFAIL,  "Close-on-exec flag mismatch, %d vs %d",
-			 !!(fdf & FD_CLOEXEC),
-			 !!(tcase->cloexec & SOCK_CLOEXEC));
+	fd_cloexec = !!(fdf & FD_CLOEXEC);
+	fdf_pass = fd_cloexec == !!tcase->cloexec;
+	if (!fdf_pass) {
+		tst_res(TFAIL, "Close-on-exec flag mismatch, %d vs %d",
+			fd_cloexec, !!tcase->cloexec);
+	}
 
 	/* Test to see if O_NONBLOCK is as expected */
 	flf = SAFE_FCNTL(acceptfd, F_GETFL);
-	flf_pass = !!(flf & O_NONBLOCK) == !!(tcase->nonblock & SOCK_NONBLOCK);
-	if (!flf_pass)
+	fd_nonblock = !!(flf & O_NONBLOCK);
+	flf_pass = fd_nonblock == !!tcase->nonblock;
+	if (!flf_pass) {
 		tst_res(TFAIL, "nonblock flag mismatch, %d vs %d",
-			 !!(fdf & O_NONBLOCK),
-			 !!(tcase->nonblock & SOCK_NONBLOCK));
+		        fd_nonblock, !!tcase->nonblock);
+	}
 
 	SAFE_CLOSE(acceptfd);
 	SAFE_CLOSE(connfd);
 
-	if (fdf_pass && flf_pass)
-		tst_res(TPASS, "Test passed: Close-on-exec %d, nonblock %d",
-				fdf_pass, flf_pass);
-
+	if (fdf_pass && flf_pass) {
+		tst_res(TPASS, "Close-on-exec %d, nonblock %d",
+				fd_cloexec, fd_nonblock);
+	}
 }
 
 static struct tst_test test = {

-- 
Cyril Hrubis
chrubis@suse.cz

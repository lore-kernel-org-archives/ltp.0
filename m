From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 4 Oct 2019 14:36:36 +0200
Subject: [LTP] [PATCH v2 1/4] Update syscalls/bind02 to new API
In-Reply-To: <20190926151331.25070-2-mdoucha@suse.cz>
References: <20190926151331.25070-1-mdoucha@suse.cz>
 <20190926151331.25070-2-mdoucha@suse.cz>
Message-ID: <20191004123636.GA5442@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with minor changes, thanks.

* The new test library runs the test in a forked process, there is no
  need to reset the effective GID and UID in the cleanup anymore, so
  I've removed the cleanup function.

* Changed the test to explicitly test for -1 as a return value. We have
  to be pedantic here. We had bugs where syscalls returned non-zero
  value which was != -1 which broke programs that were explicitly
  testing for -1.

+ Minor things such as:
  - using TTERRNO instead of TERRNO, which means that you print the
    value of TST_ERR instead of errno which could be clobbered because
    you call close() after bind()
  - declared run() and setup() as a static functions
  - make use of SAFE_CLOSE() instead of close()

Full diff:

diff --git a/testcases/kernel/syscalls/bind/bind02.c b/testcases/kernel/syscalls/bind/bind02.c
index 532831265..65944cbe3 100644
--- a/testcases/kernel/syscalls/bind/bind02.c
+++ b/testcases/kernel/syscalls/bind/bind02.c
@@ -26,7 +26,7 @@
 #define TCP_PRIVILEGED_PORT 463
 #define TEST_USERNAME "nobody"
 
-void run(void)
+static void run(void)
 {
 	struct sockaddr_in servaddr;
 	int sockfd;
@@ -37,18 +37,18 @@ void run(void)
 	servaddr.sin_port = htons(TCP_PRIVILEGED_PORT);
 	servaddr.sin_addr.s_addr = htonl(INADDR_ANY);
 	TEST(bind(sockfd, (struct sockaddr *)&servaddr, sizeof(servaddr)));
-	close(sockfd);
+	SAFE_CLOSE(sockfd);
 
-	if (!TST_RET) {
-		tst_res(TFAIL, "bind() succeeded unexpectedly");
+	if (TST_RET != -1) {
+		tst_res(TFAIL, "bind() returned %li, expected -1", TST_RET);
 	} else if (TST_ERR == EACCES) {
-		tst_res(TPASS, "bind() failed as expected");
+		tst_res(TPASS | TTERRNO, "bind() failed as expected");
 	} else {
-		tst_res(TFAIL | TERRNO, "Unexpected error");
+		tst_res(TFAIL | TTERRNO, "Unexpected error");
 	}
 }
 
-void setup(void)
+static void setup(void)
 {
 	struct passwd *pw;
 	struct group *gr;
@@ -62,15 +62,8 @@ void setup(void)
 	SAFE_SETEUID(pw->pw_uid);
 }
 
-void cleanup(void)
-{
-	SAFE_SETEGID(0);
-	SAFE_SETEUID(0);
-}
-
 static struct tst_test test = {
 	.test_all = run,
 	.needs_root = 1,
 	.setup = setup,
-	.cleanup = cleanup
 };

-- 
Cyril Hrubis
chrubis@suse.cz

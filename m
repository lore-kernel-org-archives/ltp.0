From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 16 Jun 2017 15:57:09 +0800
Subject: [LTP] [PATCH] syscalls/fcntl35.c: fix wrong fds[0] && cleanup
Message-ID: <1497599829-21718-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/fcntl/fcntl35.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/syscalls/fcntl/fcntl35.c b/testcases/kernel/syscalls/fcntl/fcntl35.c
index 087e779..b984584 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl35.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl35.c
@@ -46,7 +46,7 @@
 
 static int pipe_max_unpriv;
 static int test_max_unpriv = 4096;
-struct passwd *pw;
+static struct passwd *pw;
 static struct tcase {
 	int exp_sz;
 	int exp_usr;
@@ -78,7 +78,7 @@ static void cleanup(void)
 static int verify_pipe_size(int exp_pip_sz, char *desp)
 {
 	int get_size;
-	int fds[0];
+	int fds[2];
 
 	SAFE_PIPE(fds);
 
@@ -109,11 +109,9 @@ end:
 
 static void do_test(unsigned int n)
 {
-	pid_t pid;
 	struct tcase *tc = &tcases[n];
 
-	pid = SAFE_FORK();
-	if (!pid) {
+	if (!SAFE_FORK()) {
 		if (tc->exp_usr)
 			SAFE_SETUID(pw->pw_uid);
 
-- 
1.8.3.1




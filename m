From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 14 May 2021 10:07:08 +0200
Subject: [LTP] [PATCH] syscalls/unshare02: Fix failures on Debian
Message-ID: <20210514080708.20036-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The order of checks in kernel is not defined and on Debian we end up
getting eperm even before the flags are checked which fails the invalid
flags testcase.

The fix is simple, we change the test to setuid() only for the EPERM
test.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/unshare/unshare02.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/testcases/kernel/syscalls/unshare/unshare02.c b/testcases/kernel/syscalls/unshare/unshare02.c
index e9bd9ed2c..9b222fae2 100644
--- a/testcases/kernel/syscalls/unshare/unshare02.c
+++ b/testcases/kernel/syscalls/unshare/unshare02.c
@@ -30,6 +30,8 @@
 
 #ifdef HAVE_UNSHARE
 
+static uid_t nobody_uid;
+
 static struct test_case_t {
 	int mode;
 	int expected_error;
@@ -42,20 +44,19 @@ static struct test_case_t {
 static void run(unsigned int i)
 {
 	pid_t pid = SAFE_FORK();
-	if (pid == 0)
+	if (pid == 0) {
+		if (tc[i].expected_error == EPERM)
+			SAFE_SETUID(nobody_uid);
+
 		TST_EXP_FAIL(unshare(tc[i].mode), tc[i].expected_error,
 			     "unshare(%s)", tc[i].desc);
+	}
 }
 
 static void setup(void)
 {
 	struct passwd *ltpuser = SAFE_GETPWNAM("nobody");
-	SAFE_SETEUID(ltpuser->pw_uid);
-}
-
-static void cleanup(void)
-{
-	SAFE_SETEUID(0);
+	nobody_uid = ltpuser->pw_uid;
 }
 
 static struct tst_test test = {
@@ -63,7 +64,6 @@ static struct tst_test test = {
 	.forks_child = 1,
 	.needs_tmpdir = 1,
 	.needs_root = 1,
-	.cleanup = cleanup,
 	.setup = setup,
 	.test = run,
 };
-- 
2.26.3


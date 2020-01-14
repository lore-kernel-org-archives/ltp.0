From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 14 Jan 2020 13:48:59 +0100
Subject: [LTP] [PATCH] syscalls/statx05: Fix failures on s390 & old libc
Message-ID: <20200114124900.22223-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

When encryption is not enabled in the kernel e4crypt fails with non-zero
exit value. The value is then stored to long via the TEST() macro. The
problem is that WEXITSTATUS() does not work with long on big endian s390
on older libc[1][2]. And while this is not our bug, it also does not
make sense to misuse the TEST() macro for catching return value from
tst_test().

[1] https://sourceware.org/bugzilla/show_bug.cgi?id=19613
[2] https://sourceware.org/git/gitweb.cgi?p=glibc.git;h=b49ab5f4503f36dcbf43f821f817da66b2931fe6

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/statx/statx05.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/statx/statx05.c b/testcases/kernel/syscalls/statx/statx05.c
index dd77e255c..42911fc17 100644
--- a/testcases/kernel/syscalls/statx/statx05.c
+++ b/testcases/kernel/syscalls/statx/statx05.c
@@ -88,6 +88,7 @@ static void setup(void)
 {
 	char opt_bsize[32];
 	const char *const extra_opts[] = {"-O encrypt", opt_bsize, NULL};
+	int ret;
 
 	snprintf(opt_bsize, sizeof(opt_bsize), "-b %i", getpagesize());
 
@@ -98,12 +99,12 @@ static void setup(void)
 	SAFE_MKDIR(TESTDIR_FLAGGED, 0777);
 	SAFE_MKDIR(TESTDIR_UNFLAGGED, 0777);
 
-	TEST(tst_system("echo qwery | e4crypt add_key "TESTDIR_FLAGGED));
+	ret = tst_system("echo qwery | e4crypt add_key "TESTDIR_FLAGGED);
 
-	if (WEXITSTATUS(TST_RET) == 127)
+	if (WEXITSTATUS(ret) == 127)
 		tst_brk(TCONF, "e4crypt not installed!");
 
-	if (WEXITSTATUS(TST_RET))
+	if (WEXITSTATUS(ret))
 		tst_brk(TCONF, "e4crypt failed (CONFIG_EXT4_ENCRYPTION not set?)");
 }
 
-- 
2.23.0


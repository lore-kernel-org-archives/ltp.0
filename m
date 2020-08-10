From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 10 Aug 2020 14:24:36 +0200
Subject: [LTP] [PATCH V9 1/2] syscalls/utimensat: Migrate to new test
 framework
In-Reply-To: <af2744945213682a2e378a275bd73ad174e2896a.1596799223.git.viresh.kumar@linaro.org>
References: <af2744945213682a2e378a275bd73ad174e2896a.1596799223.git.viresh.kumar@linaro.org>
Message-ID: <20200810122436.GA11869@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with a minor change, thanks.

I have moved the errno update to the setup with:

diff --git a/testcases/kernel/syscalls/utimensat/utimensat01.c b/testcases/kernel/syscalls/utimensat/utimensat01.c
index 617565e52..7e4fb9f25 100644
--- a/testcases/kernel/syscalls/utimensat/utimensat01.c
+++ b/testcases/kernel/syscalls/utimensat/utimensat01.c
@@ -104,12 +104,6 @@ static inline int sys_utimensat(int dirfd, const char *pathname,
 	return tst_syscall(__NR_utimensat, dirfd, pathname, times, flags);
 }
 
-static void setup(void)
-{
-	bad_addr = tst_get_bad_addr(NULL);
-	SAFE_MKDIR(TEST_DIR, 0700);
-}
-
 static void update_error(struct test_case *tc)
 {
 	if (tc->exp_err != -1)
@@ -171,8 +165,6 @@ static void run(unsigned int i)
 	void *tsp = NULL;
 	struct stat sb;
 
-	update_error(tc);
-
 	if (tc->dirfd != AT_FDCWD)
 		dfd = SAFE_OPEN(TEST_DIR, tc->oflags);
 
@@ -242,6 +234,17 @@ close:
 		SAFE_CLOSE(fd);
 }
 
+static void setup(void)
+{
+	size_t i;
+
+	bad_addr = tst_get_bad_addr(NULL);
+	SAFE_MKDIR(TEST_DIR, 0700);
+
+	for (i = 0; i < ARRAY_SIZE(tcase); i++)
+		update_error(&tcase[i]);
+}
+
 static struct tst_test test = {
 	.test = run,
 	.tcnt = ARRAY_SIZE(tcase),

-- 
Cyril Hrubis
chrubis@suse.cz

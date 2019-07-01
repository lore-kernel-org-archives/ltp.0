From: Li Wang <liwang@redhat.com>
Date: Mon,  1 Jul 2019 18:03:43 +0800
Subject: [LTP] [RFC PATCH] lib: add tst_no_corefile to avoid corefile dumping
Message-ID: <20190701100343.3406-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Li Wang <liwang@redhat.com>
Cc: Jan Stancek <jstancek@redhat.com>
---
 include/tst_safe_macros.h                        | 16 ++++++++++++++++
 testcases/kernel/security/umip/umip_basic_test.c |  2 ++
 testcases/kernel/syscalls/ipc/shmat/shmat01.c    | 16 +++-------------
 3 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index 53a888c80..110e2984f 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -394,6 +394,22 @@ static inline int safe_setrlimit(const char *file, const int lineno,
 #define SAFE_SETRLIMIT(resource, rlim) \
 	safe_setrlimit(__FILE__, __LINE__, (resource), (rlim))
 
+/*
+ * Crash is expected, avoid dumping corefile.
+ * 1 is a special value, that disables core-to-pipe.
+ * At the same time it is small enough value for
+ * core-to-file, so it skips creating cores as well.
+ */
+static inline void tst_no_corefile(void)
+{
+       struct rlimit r;
+
+       r.rlim_cur = 1;
+       r.rlim_max = 1;
+       SAFE_SETRLIMIT(RLIMIT_CORE, &r);
+       tst_res(TINFO, "Avoid dumping corefile in following test");
+}
+
 typedef void (*sighandler_t)(int);
 static inline sighandler_t safe_signal(const char *file, const int lineno,
 				       int signum, sighandler_t handler)
diff --git a/testcases/kernel/security/umip/umip_basic_test.c b/testcases/kernel/security/umip/umip_basic_test.c
index c34d4a1f6..0a86f0727 100644
--- a/testcases/kernel/security/umip/umip_basic_test.c
+++ b/testcases/kernel/security/umip/umip_basic_test.c
@@ -86,6 +86,8 @@ static void verify_umip_instruction(unsigned int n)
 
 	pid = SAFE_FORK();
 	if (pid == 0) {
+		tst_no_corefile();
+
 		switch (n) {
 		case 0:
 			asm_sgdt();
diff --git a/testcases/kernel/syscalls/ipc/shmat/shmat01.c b/testcases/kernel/syscalls/ipc/shmat/shmat01.c
index aa9dfd4e5..415af01ec 100644
--- a/testcases/kernel/syscalls/ipc/shmat/shmat01.c
+++ b/testcases/kernel/syscalls/ipc/shmat/shmat01.c
@@ -59,19 +59,9 @@ static void *expected_addr(void *in_addr, void *out_addr)
 
 static void do_child(int *in_addr, int expect_crash)
 {
-	if (expect_crash) {
-		/*
-		 * Crash is expected, avoid dumping corefile.
-		 * 1 is a special value, that disables core-to-pipe.
-		 * At the same time it is small enough value for
-		 * core-to-file, so it skips creating cores as well.
-		*/
-		struct rlimit r;
-
-		r.rlim_cur = 1;
-		r.rlim_max = 1;
-		SAFE_SETRLIMIT(RLIMIT_CORE, &r);
-	}
+	if (expect_crash)
+		tst_no_corefile();
+
 	*in_addr = 10;
 
 	exit(0);
-- 
2.20.1


From: Li Wang <liwang@redhat.com>
Date: Wed, 25 Oct 2017 11:30:05 +0800
Subject: [LTP] [PATCH 1/2] ltp: typos correction
Message-ID: <20171025033006.32463-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Li Wang <liwang@redhat.com>
---
 include/tst_safe_macros.h                                     | 2 +-
 testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep02.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index 9562005..ed9c73c 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -406,7 +406,7 @@ static inline sighandler_t safe_signal(const char *file, const int lineno,
 #define SAFE_EXECL(file, arg, ...) do {				\
        execl((file), (arg), ##__VA_ARGS__);			\
        tst_brk_(__FILE__, __LINE__, TBROK | TERRNO,		\
-                "execlp(%s, %s, ...) failed", file, arg); 	\
+                "execl(%s, %s, ...) failed", file, arg); 	\
        } while (0)
 
 int safe_getpriority(const char *file, const int lineno, int which, id_t who);
diff --git a/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep02.c b/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep02.c
index f114013..f52d853 100644
--- a/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep02.c
+++ b/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep02.c
@@ -36,7 +36,7 @@ int sample_fn(int clk_id, long long usec)
 
 	if (TEST_RETURN != 0) {
 		tst_res(TFAIL | TERRNO,
-			"nanosleep() returned %li", TEST_RETURN);
+			"clock_nanosleep() returned %li", TEST_RETURN);
 		return 1;
 	}
 
@@ -44,6 +44,6 @@ int sample_fn(int clk_id, long long usec)
 }
 
 static struct tst_test test = {
-	.tid = "nanosleep()",
+	.tid = "clock_nanosleep()",
 	.sample = sample_fn,
 };
-- 
2.9.3


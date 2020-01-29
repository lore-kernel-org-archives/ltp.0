From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Wed, 29 Jan 2020 16:28:34 +0530
Subject: [LTP] [PATCH] syscalls/io_pgetevents: Use tst_syscall() instead of
 syscall()
Message-ID: <846e4f42d5112c2f945c391644949a14756f53f6.1580295508.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Use the preferred helper tst_syscall() instead of syscall(), as it also
takes care of error handling.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 include/lapi/io_pgetevents.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/lapi/io_pgetevents.h b/include/lapi/io_pgetevents.h
index 9c7f0ec9d813..3c9d5b2d7618 100644
--- a/include/lapi/io_pgetevents.h
+++ b/include/lapi/io_pgetevents.h
@@ -21,7 +21,8 @@ int io_pgetevents(io_context_t ctx, long min_nr, long max_nr,
 		 struct io_event *events, struct timespec *timeout,
 		 sigset_t *sigmask)
 {
-	return syscall(__NR_io_pgetevents, ctx, min_nr, max_nr, events, timeout, sigmask);
+	return tst_syscall(__NR_io_pgetevents, ctx, min_nr, max_nr, events,
+			   timeout, sigmask);
 }
 #endif /* HAVE_IO_PGETEVENTS */
 #endif /* HAVE_LIBAIO */
-- 
2.21.0.rc0.269.g1a574e7a288b


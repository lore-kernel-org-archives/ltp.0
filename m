From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Tue, 31 Aug 2021 10:10:02 +0100
Subject: [LTP] [PATCH v2 1/4] API: Add tst_printf to avoid specifying the
 output FD in tests
In-Reply-To: <YSz36VZ18+N4YsM/@yuki>
References: <YSz36VZ18+N4YsM/@yuki>
Message-ID: <20210831091005.25361-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

In bpf_common.h we have to print the verifier log with
dprintf(STDERR_FILENO, ...)  because it is usually too large for
tst_{res,brk}(). As these functions use sprintf() and write() to allow
printing in signal handlers.

We can hide the STDERR_FILENO part in the library. Just incase we want
to change the fileno at some point.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---

V2: Add this patch and use tst_printf

 include/tst_test.h | 3 +++
 lib/tst_test.c     | 9 +++++++++
 2 files changed, 12 insertions(+)

diff --git a/include/tst_test.h b/include/tst_test.h
index 27ebed94e..5e3619698 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -79,6 +79,9 @@ void tst_brk_(const char *file, const int lineno, int ttype,
 		tst_brk_(__FILE__, __LINE__, (ttype), (arg_fmt), ##__VA_ARGS__);\
 	})
 
+void tst_printf(const char *const fmt, ...)
+		__attribute__((nonnull(1), format (printf, 1, 2)));
+
 /* flush stderr and stdout */
 void tst_flush(void);
 
diff --git a/lib/tst_test.c b/lib/tst_test.c
index b61aa8b03..4224353da 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -360,6 +360,15 @@ void tst_brk_(const char *file, const int lineno, int ttype,
 	va_end(va);
 }
 
+void tst_printf(const char *const fmt, ...)
+{
+	va_list va;
+
+	va_start(va, fmt);
+	vdprintf(STDERR_FILENO, fmt, va);
+	va_end(va);
+}
+
 static void check_child_status(pid_t pid, int status)
 {
 	int ret;
-- 
2.31.1


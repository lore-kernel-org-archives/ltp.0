From: Martin Doucha <mdoucha@suse.cz>
Date: Thu,  5 Mar 2020 16:14:58 +0100
Subject: [LTP] [PATCH v2 1/2] Add TST_ASSERT_SYSCALL*() macros
Message-ID: <20200305151459.30341-1-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

These macros take care of the standard return value checking boilerplate
in cases where the test cannot continue after error.

- TST_ASSERT_SYSCALL() calls tst_brk() if retval != 0
- TST_ASSERT_SYSCALL_FD() calls tst_brk() if retval < 0

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Changes since v1: Added support for call args pretty printing in error message

 include/tst_test.h | 47 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/include/tst_test.h b/include/tst_test.h
index 8508c2e38..e423ceacc 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -281,6 +281,53 @@ extern void *TST_RET_PTR;
 		TST_ERR = errno; \
 	} while (0)
 
+/* assert that syscall returned only 0 and nothing else */
+#define TST_ASSERT_SYSCALL(SCALL) \
+	TST_ASSERT_SYSCALL_IMPL(SCALL, __FILE__, __LINE__, #SCALL)
+
+#define TST_ASSERT_SYSCALL_IMPL(SCALL, FILENAME, LINENO, CALLSTR, ...) \
+	({ \
+		int _tst_ret; \
+		errno = 0; \
+		_tst_ret = SCALL; \
+		if (_tst_ret == -1) { \
+			int _tst_ttype = errno == ENOTSUP ? TCONF : TBROK; \
+			tst_brk_(FILENAME, LINENO, _tst_ttype | TERRNO, \
+				CALLSTR " failed", ##__VA_ARGS__); \
+		} \
+		if (_tst_ret != 0) { \
+			tst_brk_(FILENAME, LINENO, TBROK | TERRNO, \
+				CALLSTR " returned invalid value %d", \
+				##__VA_ARGS__, _tst_ret); \
+		} \
+		_tst_ret; \
+	})
+
+/*
+ * assert that syscall returned any non-negative value (e.g. valid file
+ * descriptor)
+ */
+#define TST_ASSERT_SYSCALL_FD(SCALL) \
+	TST_ASSERT_SYSCALL_FD_IMPL(SCALL, __FILE__, __LINE__, #SCALL)
+
+#define TST_ASSERT_SYSCALL_FD_IMPL(SCALL, FILENAME, LINENO, CALLSTR, ...) \
+	({ \
+		int _tst_ret; \
+		errno = 0; \
+		_tst_ret = SCALL; \
+		if (_tst_ret == -1) { \
+			int _tst_ttype = errno == ENOTSUP ? TCONF : TBROK; \
+			tst_brk_(FILENAME, LINENO, _tst_ttype | TERRNO, \
+				CALLSTR " failed", ##__VA_ARGS__); \
+		} \
+		if (_tst_ret < 0) { \
+			tst_brk_(FILENAME, LINENO, TBROK | TERRNO, \
+				CALLSTR " returned invalid value %d", \
+				##__VA_ARGS__, _tst_ret); \
+		} \
+		_tst_ret; \
+	})
+
 /*
  * Functions to convert ERRNO to its name and SIGNAL to its name.
  */
-- 
2.25.1


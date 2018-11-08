From: Jan Stancek <jstancek@redhat.com>
Date: Thu,  8 Nov 2018 21:59:02 +0100
Subject: [LTP] [PATCH 2/2] lib: build check parameters for tst_brk()
In-Reply-To: <88db8a4def940c63ec2836cec1d0041db00ffd4c.1541710635.git.jstancek@redhat.com>
References: <88db8a4def940c63ec2836cec1d0041db00ffd4c.1541710635.git.jstancek@redhat.com>
Message-ID: <d3ce5d3247f7f09cfabd288b40893bb631fb190f.1541710635.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This patch adds simple build-check that allows only
TFAIL, TBROK and TCONF as parameter for tst_brk().

TFAIL is currently quite commonly used as a shortcut for
TFAIL + exit() by many tests. I kept it for now, since
it doesn't go against current doc description.

Per kernel comments this approach works fine for simple
cases, which should be sufficient for LTP, e.g. we don't
pass TBROK as a paramter to inlined function, that passes
it further down to tst_brk().

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 include/tst_common.h | 3 +++
 include/tst_test.h   | 7 +++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/tst_common.h b/include/tst_common.h
index 27924766ef6e..358f2a76ecda 100644
--- a/include/tst_common.h
+++ b/include/tst_common.h
@@ -65,4 +65,7 @@
 	ERET;								\
 })
 
+#define BUILD_BUG_ON(condition) \
+	do { ((void)sizeof(char[1 - 2 * !!(condition)])); } while (0)
+
 #endif /* TST_COMMON_H__ */
diff --git a/include/tst_test.h b/include/tst_test.h
index 2ebf746eb720..cd936eb792bd 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -69,8 +69,11 @@ void tst_brk_(const char *file, const int lineno, int ttype,
               const char *fmt, ...)
               __attribute__ ((format (printf, 4, 5)));
 
-#define tst_brk(ttype, arg_fmt, ...) \
-	tst_brk_(__FILE__, __LINE__, (ttype), (arg_fmt), ##__VA_ARGS__)
+#define tst_brk(ttype, arg_fmt, ...)						\
+	({									\
+		BUILD_BUG_ON(!((ttype) & (TBROK | TCONF | TFAIL)));		\
+		tst_brk_(__FILE__, __LINE__, (ttype), (arg_fmt), ##__VA_ARGS__);\
+	})
 
 /* flush stderr and stdout */
 void tst_flush(void);
-- 
1.8.3.1


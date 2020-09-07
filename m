From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon,  7 Sep 2020 17:01:53 +0200
Subject: [LTP] [PATCH v2 06/10] lib/tst_assert: Add TST_ASSERT_ULONG()
In-Reply-To: <20200907150157.23886-1-chrubis@suse.cz>
References: <20200907150157.23886-1-chrubis@suse.cz>
Message-ID: <20200907150157.23886-7-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
Reviewed-by: Martin Doucha <mdoucha@suse.cz>
---
 include/tst_assert.h |  9 +++++++++
 lib/tst_assert.c     | 14 ++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/tst_assert.h b/include/tst_assert.h
index 9969a8169..dcb62dfea 100644
--- a/include/tst_assert.h
+++ b/include/tst_assert.h
@@ -21,6 +21,15 @@ void tst_assert_int(const char *file, const int lineno,
 #define TST_ASSERT_FILE_INT(path, prefix, val) \
 	tst_assert_file_int(__FILE__, __LINE__, path, prefix, val)
 
+/*
+ * Same as tst_assert_int() but for unsigned long.
+ */
+void tst_assert_ulong(const char *file, const int lineno,
+                      const char *path, unsigned long val);
+
+#define TST_ASSERT_ULONG(path, val) \
+	tst_assert_ulong(__FILE__, __LINE__, path, val)
+
 /*
  * Asserts that integer value stored in the prefix field of file pointed by path
  * equals to the value passed to this function. This is mostly useful for
diff --git a/lib/tst_assert.c b/lib/tst_assert.c
index c7908f64f..9b8ebc167 100644
--- a/lib/tst_assert.c
+++ b/lib/tst_assert.c
@@ -23,6 +23,20 @@ void tst_assert_int(const char *file, const int lineno, const char *path, int va
 	tst_res_(file, lineno, TFAIL, "%s != %d got %d", path, val, sys_val);
 }
 
+void tst_assert_ulong(const char *file, const int lineno, const char *path, unsigned long val)
+{
+	unsigned long sys_val;
+
+	safe_file_scanf(file, lineno, NULL, path, "%lu", &sys_val);
+
+	if (val == sys_val) {
+		tst_res_(file, lineno, TPASS, "%s = %lu", path, val);
+		return;
+	}
+
+	tst_res_(file, lineno, TFAIL, "%s != %lu got %lu", path, val, sys_val);
+}
+
 void tst_assert_file_int(const char *file, const int lineno, const char *path, const char *prefix, int val)
 {
 	int sys_val;
-- 
2.26.2


From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 3 Aug 2016 16:59:25 +0200
Subject: [LTP] [PATCH] tst_test: Add option parsing helpers.
Message-ID: <20160803145925.GA31921@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add two helpers for parsing integers and floags, these are intended to
be used in the test setup to parse options from struct tst_option.

static char *str_threads;
static int threads;
...

static struct tst_options[] = {
	{"t:", &str_threads, "Number of threads"},
	...
	{NULL, NULL, NULL}
};

static void setup(void)
{
	if (tst_parse_int(str_threads, &threads, 1, INT_MAX))
		tst_brk(TBROK, "Invalid number of threads '%s'", str_threads);

	...
}

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 doc/test-writing-guidelines.txt | 51 +++++++++++++++++++++++++++++++++++++++++
 include/tst_test.h              | 10 ++++++++
 lib/tst_test.c                  | 47 +++++++++++++++++++++++++++++++++++++
 3 files changed, 108 insertions(+)

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index db12d18..ef8d256 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -512,6 +512,57 @@ non-'NULL' value if option was present. The 'help' is a short help string.
 NOTE: The test parameters must not collide with common test parameters defined
       in the library the currently used ones are +-i+, +-I+, +-C+, and +-h+.
 
+[source,c]
+-------------------------------------------------------------------------------
+int tst_parse_int(const char *str, int *val, int min, int max);
+int tst_parse_float(const char *str, float *val, float min, float max);
+-------------------------------------------------------------------------------
+
+Helpers for parsing the the strings returned in the 'struct tst_options'.
+
+Both return zero on success and 'errno', mostly 'EINVAL' or 'ERANGE', on
+failure.
+
+Both functions are no-op if 'str' is 'NULL'.
+
+The valid range for result includes both 'min' and 'max'.
+
+.Example Usage
+[source,c]
+-------------------------------------------------------------------------------
+#include <limits.h>
+#include "tst_test.h"
+
+static char *str_threads;
+static int threads = 10;
+
+static struct tst_options[] = {
+	{"t:", &str_threads, "Number of threads (default 10)"},
+	...
+	{NULL, NULL, NULL}
+};
+
+static void setup(void)
+{
+	if (tst_parse_int(str_threads, &threads, 1, INT_MAX))
+		tst_brk(TBROK, "Invalid number of threads '%s'", str_threads);
+
+	...
+}
+
+static void test_threads(void)
+{
+	...
+
+	for (i = 0; i < threads; i++) {
+		...
+	}
+
+	...
+}
+-------------------------------------------------------------------------------
+
+
 2.2.6 Runtime kernel version detection
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
diff --git a/include/tst_test.h b/include/tst_test.h
index c89e51f..eefd6f8 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -70,6 +70,16 @@ struct tst_option {
 	char *help;
 };
 
+/*
+ * Options parsing helpers.
+ *
+ * If str is NULL these are No-op.
+ *
+ * On failure non-zero (errno) is returned.
+ */
+int tst_parse_int(const char *str, int *val, int min, int max);
+int tst_parse_float(const char *str, float *val, float min, float max);
+
 struct tst_test {
 	/* test id usually the same as test filename without file suffix */
 	const char *tid;
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 26fff97..e66b713 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -442,6 +442,53 @@ static void parse_opts(int argc, char *argv[])
 	}
 }
 
+int tst_parse_int(const char *str, int *val, int min, int max)
+{
+	long rval;
+	char *end;
+
+	if (!str)
+		return 0;
+
+	errno = 0;
+	rval = strtol(str, &end, 10);
+
+	if (str == end || *end != '\0')
+		return EINVAL;
+
+	if (errno)
+		return errno;
+
+	if (rval > (long)max || rval < (long)min)
+		return ERANGE;
+
+	*val = (int)rval;
+	return 0;
+}
+
+int tst_parse_float(const char *str, float *val, float min, float max)
+{
+	double rval;
+	char *end;
+
+	if (!str)
+		return 0;
+
+	errno = 0;
+	rval = strtod(str, &end);
+
+	if (str == end || *end != '\0')
+		return EINVAL;
+
+	if (errno)
+		return errno;
+
+	if (rval > (double)max || rval < (double)min)
+		return ERANGE;
+
+	*val = (float)rval;
+	return 0;
+}
 
 static void do_exit(int ret)
 {
-- 
2.7.3


-- 
Cyril Hrubis
chrubis@suse.cz

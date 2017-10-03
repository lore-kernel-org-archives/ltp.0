From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Tue,  3 Oct 2017 15:55:20 +0200
Subject: [LTP] [RFC PATCH] newlib: Allow sub-tests to be specified in a list
Message-ID: <20171003135520.19580-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Allows the user to define a linked list of test functions. So instead of
using test(i) and dispatching a different function depending on the value of
i. They just write the functions using a macro and point tst_test.tests to the
first function (or rather the first functions meta-data structure).

Using a linked list instead of an array means that the user does not have to
list the function names at the bottom of the file, although they do have to
specify the next function to link to. Using a structure to store the function
name allows the library to report which sub test failed to return a result by
name instead of an index number.

On the negative side, using a macro to define the function and meta data for
the sub test is a little bit magical. It is also annoying to have to specify
both the current test name and the next test.
---

I decided to look into this because I would have probably avoided most of the
problems with cve-2017-7308 if such a feature existed and I had used it.

 include/tst_test.h        | 27 +++++++++++++++++++++++++++
 lib/newlib_tests/test17.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 lib/tst_test.c            | 27 ++++++++++++++++++++++++++-
 3 files changed, 98 insertions(+), 1 deletion(-)
 create mode 100644 lib/newlib_tests/test17.c

diff --git a/include/tst_test.h b/include/tst_test.h
index ad468e8cf..ee14bfce7 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -104,6 +104,32 @@ int tst_parse_int(const char *str, int *val, int min, int max);
 int tst_parse_long(const char *str, long *val, long min, long max);
 int tst_parse_float(const char *str, float *val, float min, float max);
 
+struct tst_func {
+	char *name;
+	void (*func)(void);
+	struct tst_func *next;
+};
+
+#define TST_DEFINE_LAST(tname)			\
+	void tname##_func_(void);		\
+	static struct tst_func tname = {	\
+		.name = #tname,			\
+		.func = tname##_func_,		\
+		.next = NULL,			\
+	};					\
+	void tname##_func_(void)	\
+
+#define TST_DEFINE(tname, nextt)		\
+	void tname##_func_(void);		\
+	static struct tst_func nextt;		\
+	static struct tst_func tname = {	\
+		.name = #tname,			\
+		.func = tname##_func_,		\
+		.next = &nextt,			\
+	};					\
+	void tname##_func_(void)	\
+
+
 struct tst_test {
 	/* test id usually the same as test filename without file suffix */
 	const char *tid;
@@ -149,6 +175,7 @@ struct tst_test {
 
 	void (*test)(unsigned int test_nr);
 	void (*test_all)(void);
+	struct tst_func *tests;
 
 	/* Sampling function for timer measurement testcases */
 	int (*sample)(int clk_id, long long usec);
diff --git a/lib/newlib_tests/test17.c b/lib/newlib_tests/test17.c
new file mode 100644
index 000000000..30fce41ee
--- /dev/null
+++ b/lib/newlib_tests/test17.c
@@ -0,0 +1,45 @@
+/*
+ * Copyright (c) 2017 Richard Palethorpe <rpalethorpe@suse.com>
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ */
+
+/* Test test_arr
+ */
+
+#include "tst_test.h"
+
+TST_DEFINE(a_test, another_test)
+{
+	tst_res(TPASS, "A test which passes");
+}
+
+TST_DEFINE(another_test, a_fail)
+{
+	tst_res(TPASS, "Another pass");
+}
+
+TST_DEFINE(a_fail, a_warning)
+{
+	tst_res(TFAIL, "A test which fails");
+}
+
+TST_DEFINE_LAST(a_warning)
+{
+	tst_res(TWARN, "A test which warns");
+}
+
+static struct tst_test test = {
+	.tests = &a_test,
+};
diff --git a/lib/tst_test.c b/lib/tst_test.c
index a627242a6..202883223 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -659,6 +659,9 @@ static void assert_test_fn(void)
 	if (tst_test->sample)
 		cnt++;
 
+	if (tst_test->tests)
+		cnt++;
+
 	if (!cnt)
 		tst_brk(TBROK, "No test function speficied");
 
@@ -670,6 +673,7 @@ static void assert_test_fn(void)
 
 	if (!tst_test->test && tst_test->tcnt)
 		tst_brk(TBROK, "You can define tcnt only for test()");
+
 }
 
 static void do_setup(int argc, char *argv[])
@@ -796,8 +800,9 @@ static void run_tests(void)
 {
 	unsigned int i;
 	struct results saved_results;
+	struct tst_func *test;
 
-	if (!tst_test->test) {
+	if (tst_test->test_all) {
 		saved_results = *results;
 		tst_test->test_all();
 
@@ -812,6 +817,26 @@ static void run_tests(void)
 		return;
 	}
 
+	if (tst_test->tests) {
+		for (test = tst_test->tests; test; test = test->next) {
+			saved_results = *results;
+			test->func();
+
+			if (getpid() != main_pid) {
+				exit(0);
+			}
+
+			tst_reap_children();
+
+			if (results_equal(&saved_results, results)) {
+				tst_brk(TBROK,
+					"Test %s did not report a result!",
+					test->name);
+			}
+		}
+		return;
+	}
+
 	for (i = 0; i < tst_test->tcnt; i++) {
 		saved_results = *results;
 		tst_test->test(i);
-- 
2.14.1


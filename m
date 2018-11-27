From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 27 Nov 2018 14:21:17 +0100
Subject: [LTP] [PATCH v2] lib: Add library function for parsing kernel config
Message-ID: <20181127132117.21326-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This is meant as last resort action for disabling tests if certain
kernel funcitonality was not present, in general case runtime checks are
prefered.

For functionality that can be build as a module tst_check_driver() is
most likely better fit since it will also insert requested kernel module
into kernel if needed.

For newly added syscalls kernel version comparsion and/or checking errno
is prefered.

However in rare cases certain core kernel functionality cannot be
detected in any other way than checking the kernel config, which is
where this API gets into the play.

The path to the kernel config could be specified by KCONFIG_PATH
environment variable, which also takes precedence before the
autodetection that attempts to read the config from known locations.

The required kernel options are passed as an array of strings via the
.needs_kconfigs pointer in the tst_test structure. The purpose of this
is twofold, one is that the test can disable itself at runtime if given
functionality is missing from kernel .config and second is about being
able to propagate this information to the testrunner (this could be done
once we figure out how export the information from the structure to the
test runner) then we can avoid running tests on unsuitable
configurations from the start.

There are two different ways how to specify the required kernel options
either by stating the config name i.e. "CONFIG_FOO" which is considered
present in kernel if set to a certain value and "CONFIG_FOO=bar" which
requires the config option to be strictly set to a desired value.

The code has been also split into parsing phase that simply picks up the
config option values from the config and to evaluation which does the
actual checks and aborts the test if needed. This makes it easier to
expand the domain language for specifying the required options, if we
ever need to match against subset of values this should be reasonably
easy to implement.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
Acked-by: Sandeep Patil <sspatil@google.com>
CC: Pengfei Xu <pengfei.xu@intel.com>
CC: automated-testing@yoctoproject.org
---
 doc/test-writing-guidelines.txt  |  35 ++++
 include/tst_kconfig.h            |  57 +++++++
 include/tst_test.h               |   6 +
 lib/newlib_tests/.gitignore      |   1 +
 lib/newlib_tests/config01        |   4 +
 lib/newlib_tests/config02        |   4 +
 lib/newlib_tests/config03        |   4 +
 lib/newlib_tests/config04        |   4 +
 lib/newlib_tests/config05        |   3 +
 lib/newlib_tests/test_kconfig.c  |  23 +++
 lib/newlib_tests/test_kconfig.sh |  11 ++
 lib/tst_kconfig.c                | 284 +++++++++++++++++++++++++++++++
 lib/tst_test.c                   |   4 +
 13 files changed, 440 insertions(+)
 create mode 100644 include/tst_kconfig.h
 create mode 100644 lib/newlib_tests/config01
 create mode 100644 lib/newlib_tests/config02
 create mode 100644 lib/newlib_tests/config03
 create mode 100644 lib/newlib_tests/config04
 create mode 100644 lib/newlib_tests/config05
 create mode 100644 lib/newlib_tests/test_kconfig.c
 create mode 100755 lib/newlib_tests/test_kconfig.sh
 create mode 100644 lib/tst_kconfig.c

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index d0b91c362..681f650b9 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -1504,6 +1504,41 @@ static struct tst_test test = {
 	.save_restore = save_restore,
 };
 
+2.2.28 Parsing kernel .config
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+Generally testcases should attempt to autodetect as much kernel features as
+possible based on the currently running kernel. We do have tst_check_driver()
+to check if functionality that could be compiled as kernel module is present
+on the system, disabled syscalls can be detected by checking for 'ENOSYS'
+errno etc.
+
+However in rare cases core kernel features couldn't be detected based on the
+kernel userspace API and we have to resort on kernel .config parsing.
+
+For this cases the test should set the 'NULL' terminated needs_kconfig array
+of kernel config options required for the test. The config option can be
+specified either as plain "CONFIG_FOO" in which case it's sufficient for the
+test continue if it's set to any value (typically =y or =m). Or with a value
+as "CONFIG_FOO=bar" in which case the value has to match as well. The test is
+aborted with 'TCONF' if any of the required options wasn't set.
+
+[source,c]
+-------------------------------------------------------------------------------
+#include "tst_test.h"
+
+static const char *kconfigs[] = {
+	"CONFIG_X86_INTEL_UMIP",
+	NULL
+};
+
+static struct tst_test test = {
+	...
+	.needs_kconfigs = kconfigs,
+	...
+};
+-------------------------------------------------------------------------------
+
 
 2.3 Writing a testcase in shell
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
diff --git a/include/tst_kconfig.h b/include/tst_kconfig.h
new file mode 100644
index 000000000..90e0a71c5
--- /dev/null
+++ b/include/tst_kconfig.h
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2018 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+#ifndef TST_KCONFIG_H__
+#define TST_KCONFIG_H__
+
+
+struct tst_kconfig_res {
+	char match;
+	char *value;
+};
+
+/**
+ * Reads a kernel config and parses it for values defined in kconfigs array.
+ *
+ * The path to the kernel config should be autodetected in most of the cases as
+ * the code looks for know locations. It can be explicitely set/overrided with
+ * the KCONFIG_PATH environment variable as well.
+ *
+ * The kcofings array is expected to contain strings in a format "CONFIG_FOO"
+ * or "CONFIG_FOO=bar". The result array has to be suitably sized to fit the
+ * results.
+ *
+ * @param kconfigs array of config strings to look for
+ * @param results array to store results to
+ * @param cnt size of the arrays
+ *
+ * The match in the tst_kconfig_res structure is set as follows:
+ *
+ *  'm' - config option set to m
+ *  'y' - config option set to y
+ *  'v' - config option set to other value
+ *  'n' - config option is not set
+ *   0  - config option not found
+ *
+ * In the case that match is set to 'v' the value points to a newly allocated
+ * string that holds the value.
+ */
+void tst_kconfig_read(const char *const kconfigs[],
+		      struct tst_kconfig_res results[], size_t cnt);
+
+/**
+ * Checks if required kernel configuration options are set in the kernel
+ * config and exits the test with TCONF if at least one is missing.
+ *
+ * The config options can be passed in two different formats, either
+ * "CONFIG_FOO" in which case the option has to be set in order to continue the
+ * test or with an explicit value "CONFIG_FOO=bar" in which case the value has
+ * to match.
+ *
+ * @param kconfigs NULL-terminated array of config strings needed for the testrun.
+ */
+void tst_kconfig_check(const char *const kconfigs[]);
+
+#endif	/* TST_KCONFIG_H__ */
diff --git a/include/tst_test.h b/include/tst_test.h
index 2ebf746eb..f21687c06 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -182,6 +182,12 @@ struct tst_test {
 	 * before setup and restore after cleanup
 	 */
 	const char * const *save_restore;
+
+	/*
+	 * NULL terminated array of kernel config options required for the
+	 * test.
+	 */
+	const char *const *needs_kconfigs;
 };
 
 /*
diff --git a/lib/newlib_tests/.gitignore b/lib/newlib_tests/.gitignore
index c702644f0..645ba349e 100644
--- a/lib/newlib_tests/.gitignore
+++ b/lib/newlib_tests/.gitignore
@@ -24,3 +24,4 @@ test19
 tst_expiration_timer
 test_exec
 test_exec_child
+test_kconfig
diff --git a/lib/newlib_tests/config01 b/lib/newlib_tests/config01
new file mode 100644
index 000000000..96d68d836
--- /dev/null
+++ b/lib/newlib_tests/config01
@@ -0,0 +1,4 @@
+# Test should PASS in this case
+CONFIG_MMU=y
+CONFIG_EXT4_FS=m
+CONFIG_PGTABLE_LEVELS=4
diff --git a/lib/newlib_tests/config02 b/lib/newlib_tests/config02
new file mode 100644
index 000000000..2de45cff8
--- /dev/null
+++ b/lib/newlib_tests/config02
@@ -0,0 +1,4 @@
+# Unset CONFIG_MMU
+# CONFIG_MMU is not set
+CONFIG_EXT4_FS=m
+CONFIG_PGTABLE_LEVELS=4
diff --git a/lib/newlib_tests/config03 b/lib/newlib_tests/config03
new file mode 100644
index 000000000..1a3b9e648
--- /dev/null
+++ b/lib/newlib_tests/config03
@@ -0,0 +1,4 @@
+# Wrong number of page table levels
+CONFIG_MMU=y
+CONFIG_EXT4_FS=m
+CONFIG_PGTABLE_LEVELS=44
diff --git a/lib/newlib_tests/config04 b/lib/newlib_tests/config04
new file mode 100644
index 000000000..cce7051ae
--- /dev/null
+++ b/lib/newlib_tests/config04
@@ -0,0 +1,4 @@
+# Unexpected CONFIG_EXT4_FS compiled in
+CONFIG_MMU=y
+CONFIG_EXT4_FS=y
+CONFIG_PGTABLE_LEVELS=4
diff --git a/lib/newlib_tests/config05 b/lib/newlib_tests/config05
new file mode 100644
index 000000000..a9d7bab4d
--- /dev/null
+++ b/lib/newlib_tests/config05
@@ -0,0 +1,3 @@
+# Everything is wrong
+CONFIG_EXT4_FS=y
+CONFIG_PGTABLE_LEVELS=44
diff --git a/lib/newlib_tests/test_kconfig.c b/lib/newlib_tests/test_kconfig.c
new file mode 100644
index 000000000..d9c662fc5
--- /dev/null
+++ b/lib/newlib_tests/test_kconfig.c
@@ -0,0 +1,23 @@
+/*
+ * Copyright (c) 2018 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+#include "tst_test.h"
+#include "tst_kconfig.h"
+
+static void do_test(void)
+{
+	tst_res(TPASS, "Test passed!");
+}
+
+static const char *kconfigs[] = {
+	"CONFIG_MMU",
+	"CONFIG_EXT4_FS=m",
+	"CONFIG_PGTABLE_LEVELS=4",
+	NULL
+};
+
+static struct tst_test test = {
+	.test_all = do_test,
+	.needs_kconfigs = kconfigs,
+};
diff --git a/lib/newlib_tests/test_kconfig.sh b/lib/newlib_tests/test_kconfig.sh
new file mode 100755
index 000000000..4b83c3542
--- /dev/null
+++ b/lib/newlib_tests/test_kconfig.sh
@@ -0,0 +1,11 @@
+#!/bin/sh
+
+echo "Attempting to parse currently running kernel config"
+./test_kconfig
+echo
+
+for i in config0*; do
+	head -n 1 "$i"
+	KCONFIG_PATH="$i" ./test_kconfig
+	echo
+done
diff --git a/lib/tst_kconfig.c b/lib/tst_kconfig.c
new file mode 100644
index 000000000..3683f48c4
--- /dev/null
+++ b/lib/tst_kconfig.c
@@ -0,0 +1,284 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2018 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+#include <stdlib.h>
+#include <stdio.h>
+#include <ctype.h>
+#include <sys/utsname.h>
+
+#define TST_NO_DEFAULT_MAIN
+#include "tst_test.h"
+#include "tst_kconfig.h"
+
+static const char *kconfig_path(char *path_buf, size_t path_buf_len)
+{
+	const char *path = getenv("KCONFIG_PATH");
+	struct utsname un;
+
+	if (path) {
+		if (!access(path, F_OK))
+			return path;
+
+		tst_res(TWARN, "KCONFIG_PATH='%s' does not exist", path);
+	}
+
+	if (!access("/proc/config.gz", F_OK))
+		return "/proc/config.gz";
+
+	uname(&un);
+
+	/* Debian and derivatives */
+	snprintf(path_buf, path_buf_len, "/boot/config-%s", un.release);
+
+	if (!access(path_buf, F_OK))
+		return path_buf;
+
+	/* Clear Linux */
+	snprintf(path_buf, path_buf_len, "/lib/kernel/config-%s", un.release);
+
+	if (!access(path_buf, F_OK))
+		return path_buf;
+
+	tst_res(TINFO, "Couldn't locate kernel config!");
+
+	return NULL;
+}
+
+static char is_gzip;
+
+static FILE *open_kconfig(void)
+{
+	FILE *fp;
+	char buf[1024];
+	char path_buf[1024];
+	const char *path = kconfig_path(path_buf, sizeof(path_buf));
+
+	if (!path)
+		return NULL;
+
+	tst_res(TINFO, "Parsing kernel config '%s'", path);
+
+	is_gzip = !!strstr(path, ".gz");
+
+	if (is_gzip) {
+		snprintf(buf, sizeof(buf), "zcat '%s'", path);
+		fp = popen(buf, "r");
+	} else {
+		fp = fopen(path, "r");
+	}
+
+	if (!fp)
+		tst_brk(TBROK | TERRNO, "Failed to open '%s'", path);
+
+	return fp;
+}
+
+static void close_kconfig(FILE *fp)
+{
+	if (is_gzip)
+		pclose(fp);
+	else
+		fclose(fp);
+}
+
+struct match {
+	/* match len, string length up to \0 or = */
+	size_t len;
+	/* if set part of conf string after = */
+	const char *val;
+	/* if set the config option was matched already */
+	int match;
+};
+
+static int is_set(const char *str, const char *val)
+{
+	size_t vlen = strlen(val);
+
+	while (isspace(*str))
+		str++;
+
+	if (strncmp(str, val, vlen))
+		return 0;
+
+	switch (str[vlen]) {
+	case ' ':
+	case '\n':
+	case '\0':
+		return 1;
+	break;
+	default:
+		return 0;
+	}
+}
+
+static inline int match(struct match *match, const char *conf,
+                        struct tst_kconfig_res *result, const char *line)
+{
+	if (match->match)
+		return 0;
+
+	const char *cfg = strstr(line, "CONFIG_");
+
+	if (!cfg)
+		return 0;
+
+	if (strncmp(cfg, conf, match->len))
+		return 0;
+
+	const char *val = &cfg[match->len];
+
+	switch (cfg[match->len]) {
+	case '=':
+		break;
+	case ' ':
+		if (is_set(val, "is not set")) {
+			result->match = 'n';
+			goto match;
+		}
+	/* fall through */
+	default:
+		return 0;
+	}
+
+	if (is_set(val, "=y")) {
+		result->match = 'y';
+		goto match;
+	}
+
+	if (is_set(val, "=m")) {
+		result->match = 'm';
+		goto match;
+	}
+
+	result->match = 'v';
+	result->value = strndup(val+1, strlen(val)-2);
+
+match:
+	match->match = 1;
+	return 1;
+}
+
+void tst_kconfig_read(const char *const *kconfigs,
+                      struct tst_kconfig_res results[], size_t cnt)
+{
+	struct match matches[cnt];
+	FILE *fp;
+	unsigned int i, j;
+	char buf[1024];
+
+	for (i = 0; i < cnt; i++) {
+		const char *val = strchr(kconfigs[i], '=');
+
+		if (strncmp("CONFIG_", kconfigs[i], 7))
+			tst_brk(TBROK, "Invalid config string '%s'", kconfigs[i]);
+
+		matches[i].match = 0;
+		matches[i].len = strlen(kconfigs[i]);
+
+		if (val) {
+			matches[i].val = val + 1;
+			matches[i].len -= strlen(val);
+		}
+
+		results[i].match = 0;
+		results[i].value = NULL;
+	}
+
+	fp = open_kconfig();
+	if (!fp)
+		tst_brk(TBROK, "Cannot parse kernel .config");
+
+	while (fgets(buf, sizeof(buf), fp)) {
+		for (i = 0; i < cnt; i++) {
+			if (match(&matches[i], kconfigs[i], &results[i], buf)) {
+				for (j = 0; j < cnt; j++) {
+					if (matches[j].match)
+						break;
+				}
+
+				if (j == cnt)
+					goto exit;
+			}
+		}
+
+	}
+
+exit:
+	close_kconfig(fp);
+}
+
+static size_t array_len(const char *const kconfigs[])
+{
+	size_t i = 0;
+
+	while (kconfigs[++i]);
+
+	return i;
+}
+
+static int compare_res(struct tst_kconfig_res *res, const char *kconfig,
+                       char match, const char *val)
+{
+	if (res->match != match) {
+		tst_res(TINFO, "Needs kernel %s, have %c", kconfig, res->match);
+		return 1;
+	}
+
+	if (match != 'v')
+		return 0;
+
+	if (strcmp(res->value, val)) {
+		tst_res(TINFO, "Needs kernel %s, have %s", kconfig, res->value);
+		return 1;
+	}
+
+	return 0;
+}
+
+void tst_kconfig_check(const char *const kconfigs[])
+{
+	size_t cnt = array_len(kconfigs);
+	struct tst_kconfig_res results[cnt];
+	unsigned int i;
+	int abort_test = 0;
+
+	tst_kconfig_read(kconfigs, results, cnt);
+
+	for (i = 0; i < cnt; i++) {
+		if (results[i].match == 0) {
+			tst_res(TINFO, "Missing kernel %s", kconfigs[i]);
+			abort_test = 1;
+			continue;
+		}
+
+		if (results[i].match == 'n') {
+			tst_res(TINFO, "Kernel %s is not set", kconfigs[i]);
+			abort_test = 1;
+			continue;
+		}
+
+		const char *val = strchr(kconfigs[i], '=');
+
+		if (val) {
+			char match = 'v';
+			val++;
+
+			if (!strcmp(val, "y"))
+				match = 'y';
+
+			if (!strcmp(val, "m"))
+				match = 'm';
+
+			if (compare_res(&results[i], kconfigs[i], match, val))
+				abort_test = 1;
+
+		}
+
+		free(results[i].value);
+	}
+
+	if (abort_test)
+		tst_brk(TCONF, "Aborting due to unsuitable kernel config, see above!");
+}
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 661fbbfce..da3e0c8a0 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -36,6 +36,7 @@
 #include "tst_clocks.h"
 #include "tst_timer.h"
 #include "tst_sys_conf.h"
+#include "tst_kconfig.h"
 
 #include "old_resource.h"
 #include "old_device.h"
@@ -770,6 +771,9 @@ static void do_setup(int argc, char *argv[])
 	if (tst_test->tconf_msg)
 		tst_brk(TCONF, "%s", tst_test->tconf_msg);
 
+	if (tst_test->needs_kconfigs)
+		tst_kconfig_check(tst_test->needs_kconfigs);
+
 	assert_test_fn();
 
 	tid = get_tid(argv);
-- 
2.18.1


From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 24 Jan 2017 20:47:30 +0100
Subject: [LTP] [PATCH v3 1/1] test.sh: colorize test type in the output
Message-ID: <20170124194730.13542-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

By default colorize unless using pipe or redirect to file.

It's possible to force behaviour with LTP_COLORIZE_OUTPUT environment
variable:
y or 1: allways colorize
n or 0: never colorize

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
v2->v3:
* Colorized only test type and (mostly) following colon.
* Removed space after test type in tst_test.sh
* Added magenta, now the only duplicite color is red. Not using gray as it might not be seen. If you don't like blue for TINFO I'd prefer not colorize it at all.
---
 doc/colorized-output.txt        | 10 ++++++
 include/tst_ansi_colors.h       | 35 +++++++++++++++++++++
 lib/tst_ansi_colors.c           | 67 +++++++++++++++++++++++++++++++++++++++++
 lib/tst_res.c                   | 31 +++++++++++++++----
 lib/tst_test.c                  | 23 ++++++++++----
 testcases/lib/test.sh           | 13 ++++++--
 testcases/lib/tst_ansi_color.sh | 56 ++++++++++++++++++++++++++++++++++
 testcases/lib/tst_test.sh       | 11 +++++--
 8 files changed, 229 insertions(+), 17 deletions(-)
 create mode 100644 doc/colorized-output.txt
 create mode 100644 include/tst_ansi_colors.h
 create mode 100644 lib/tst_ansi_colors.c
 create mode 100644 testcases/lib/tst_ansi_color.sh

diff --git a/doc/colorized-output.txt b/doc/colorized-output.txt
new file mode 100644
index 000000000..c1859ccfb
--- /dev/null
+++ b/doc/colorized-output.txt
@@ -0,0 +1,10 @@
+Colorized output
+================
+
+1. Usage
+--------
+By default LTP colorizes it's output unless using pipe or redirect to file.
+
+It's possible to force behaviour with LTP_COLORIZE_OUTPUT environment variable:
+y or 1: always colorize
+n or 0: never colorize
diff --git a/include/tst_ansi_colors.h b/include/tst_ansi_colors.h
new file mode 100644
index 000000000..832c4ee9a
--- /dev/null
+++ b/include/tst_ansi_colors.h
@@ -0,0 +1,35 @@
+/*
+ * Copyright (c) 2017 Petr Vorel <pvorel@suse.cz>
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
+#ifndef TST_ANSI_COLORS_H__
+#define TST_ANSI_COLORS_H__
+/*
+ * NOTE: these colors should match colors defined in tst_flag2color() in
+ * testcases/lib/test.sh
+ */
+#define ANSI_COLOR_BLUE		"\e[1;34m"
+#define ANSI_COLOR_GREEN	"\e[1;32m"
+#define ANSI_COLOR_MAGENTA	"\e[1;35m"
+#define ANSI_COLOR_RED		"\e[1;31m"
+#define ANSI_COLOR_YELLOW	"\e[1;33m"
+
+#define ANSI_COLOR_RESET	"\e[00m"
+
+char* tst_ttype2color(int ttype);
+int tst_color_enabled(void);
+
+#endif	/* TST_ANSI_COLORS_H__ */
diff --git a/lib/tst_ansi_colors.c b/lib/tst_ansi_colors.c
new file mode 100644
index 000000000..da90e5ed0
--- /dev/null
+++ b/lib/tst_ansi_colors.c
@@ -0,0 +1,67 @@
+/*
+ * Copyright (c) 2017 Petr Vorel <pvorel@suse.cz>
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
+#include <unistd.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include "tst_res_flags.h"
+#include "tst_ansi_colors.h"
+
+char* tst_ttype2color(int ttype)
+{
+	switch (TTYPE_RESULT(ttype)) {
+	case TPASS:
+		return ANSI_COLOR_GREEN;
+	break;
+	case TFAIL:
+		return ANSI_COLOR_RED;
+	break;
+	case TBROK:
+		return ANSI_COLOR_RED;
+	break;
+	case TCONF:
+		return ANSI_COLOR_YELLOW;
+	break;
+	case TWARN:
+		return ANSI_COLOR_MAGENTA;
+	break;
+	case TINFO:
+		return ANSI_COLOR_BLUE;
+	break;
+	default:
+		return "";
+	}
+}
+
+int tst_color_enabled(void)
+{
+	char *env = getenv("LTP_COLORIZE_OUTPUT");
+
+	if (env) {
+		if (!strcmp(env, "n") || !strcmp(env, "0"))
+			return 0;
+
+		if (!strcmp(env, "y") || !strcmp(env, "1"))
+			return 1;
+	}
+
+	if (isatty(STDOUT_FILENO) == 0)
+		return 0;
+
+	return 1;
+}
diff --git a/lib/tst_res.c b/lib/tst_res.c
index 61daaeb49..52dfb2001 100644
--- a/lib/tst_res.c
+++ b/lib/tst_res.c
@@ -50,6 +50,7 @@
 #include "test.h"
 #include "usctest.h"
 #include "ltp_priv.h"
+#include "tst_ansi_colors.h"
 
 long TEST_RETURN;
 int TEST_ERRNO;
@@ -254,7 +255,7 @@ static void tst_print(const char *tcid, int tnum, int ttype, const char *tmesg)
 	const char *type;
 	int ttype_result = TTYPE_RESULT(ttype);
 	char message[USERMESG];
-	size_t size;
+	size_t size = 0;
 
 	/*
 	 * Save the test result type by ORing ttype into the current exit value
@@ -280,15 +281,33 @@ static void tst_print(const char *tcid, int tnum, int ttype, const char *tmesg)
 	 * Build the result line and print it.
 	 */
 	type = strttype(ttype);
+
 	if (T_mode == VERBOSE) {
-		size = snprintf(message, sizeof(message),
-				"%-8s %4d  %s  :  %s", tcid, tnum, type, tmesg);
+		size += snprintf(message + size, sizeof(message) - size,
+				"%-8s %4d  ", tcid, tnum);
 	} else {
-		size = snprintf(message, sizeof(message),
-				"%-8s %4d       %s  :  %s",
-				tcid, tnum, type, tmesg);
+		size += snprintf(message + size, sizeof(message) - size,
+				"%-8s %4d       ", tcid, tnum);
+	}
+
+	if (size >= sizeof(message)) {
+		printf("%s: %i: line too long\n", __func__, __LINE__);
+		abort();
+	}
+
+	if (tst_color_enabled())
+		size += snprintf(message + size, sizeof(message) - size,
+		"%s%s%s  :  %s", tst_ttype2color(ttype), type, ANSI_COLOR_RESET, tmesg);
+	else
+		size += snprintf(message + size, sizeof(message) - size,
+		"%s  :  %s", type, tmesg);
+
+	if (size >= sizeof(message)) {
+		printf("%s: %i: line too long\n", __func__, __LINE__);
+		abort();
 	}
 
+
 	if (size >= sizeof(message)) {
 		printf("%s: %i: line too long\n", __func__, __LINE__);
 		abort();
diff --git a/lib/tst_test.c b/lib/tst_test.c
index c48d71877..84f62a9fa 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -29,6 +29,7 @@
 #include "tst_test.h"
 #include "tst_device.h"
 #include "lapi/futex.h"
+#include "tst_ansi_colors.h"
 
 #include "old_resource.h"
 #include "old_device.h"
@@ -194,20 +195,30 @@ static void print_result(const char *file, const int lineno, int ttype,
 	if (ttype & TTERRNO)
 		str_errno = tst_strerrno(TEST_ERRNO);
 
-	ret = snprintf(str, size, "%s:%i: %s: ", file, lineno, res);
+	ret = snprintf(str, size, "%s:%i: ", file, lineno);
+	str += ret;
+	size -= ret;
 
+	if (tst_color_enabled())
+		ret = snprintf(str, size, "%s%s: %s", tst_ttype2color(ttype),
+			       res, ANSI_COLOR_RESET);
+	else
+		ret = snprintf(str, size, "%s: ", res);
 	str += ret;
 	size -= ret;
 
 	ret = vsnprintf(str, size, fmt, va);
-
 	str += ret;
 	size -= ret;
 
-	if (str_errno)
-		snprintf(str, size, ": %s\n", str_errno);
-	else
-		snprintf(str, size, "\n");
+	if (str_errno) {
+		ret = snprintf(str, size, ": %s", str_errno);
+		str += ret;
+		size -= ret;
+	}
+
+	snprintf(str, size, "\n");
+
 
 	fputs(buf, stderr);
 }
diff --git a/testcases/lib/test.sh b/testcases/lib/test.sh
index 76b706267..887ffeb15 100644
--- a/testcases/lib/test.sh
+++ b/testcases/lib/test.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 #
-# Copyright (c) Linux Test Project, 2014
+# Copyright (c) Linux Test Project, 2014-2017
 #
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License as published by
@@ -25,6 +25,8 @@ export LTP_RET_VAL=0
 export TST_COUNT=1
 export TST_LIB_LOADED=1
 
+. tst_ansi_color.sh
+
 # Exit values map
 tst_flag2mask()
 {
@@ -41,13 +43,18 @@ tst_flag2mask()
 
 tst_resm()
 {
-	tst_flag2mask "$1"
+	local ttype="$1"
+
+	tst_flag2mask "$ttype"
 	local mask=$?
 	LTP_RET_VAL=$((LTP_RET_VAL|mask))
 
 	local ret=$1
 	shift
-	echo "$TCID $TST_COUNT $ret : $@"
+
+	printf "$TCID $TST_COUNT "
+	tst_print_colored $ret "$ret:"
+	echo " $@"
 
 	case "$ret" in
 	TPASS|TFAIL)
diff --git a/testcases/lib/tst_ansi_color.sh b/testcases/lib/tst_ansi_color.sh
new file mode 100644
index 000000000..81c1c8cd2
--- /dev/null
+++ b/testcases/lib/tst_ansi_color.sh
@@ -0,0 +1,56 @@
+#!/bin/sh
+#
+# Copyright (c) Linux Test Project, 2017
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License along
+# with this program; if not, write to the Free Software Foundation, Inc.,
+# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+# Written by  Petr Vorel <pvorel@suse.cz>
+
+tst_flag2color()
+{
+	# NOTE: these colors should match colors defined in include/tst_ansi_colors.h
+	local ansi_color_blue='\e[1;34m'
+	local ansi_color_green='\e[1;32m'
+	local ansi_color_magenta='\e[1;35m'
+	local ansi_color_red='\e[1;31m'
+	local ansi_color_yellow='\e[1;33m'
+
+	case "$1" in
+	TPASS) printf $ansi_color_green;;
+	TFAIL) printf $ansi_color_red;;
+	TBROK) printf $ansi_color_red;;
+	TWARN) printf $ansi_color_magenta;;
+	TINFO) printf $ansi_color_blue;;
+	TCONF) printf $ansi_color_yellow;;
+	esac
+}
+
+tst_color_enabled()
+{
+	[ "$LTP_COLORIZE_OUTPUT" = "n" ] || [ "$LTP_COLORIZE_OUTPUT" = "0" ] && return 0
+	[ "$LTP_COLORIZE_OUTPUT" = "y" ] || [ "$LTP_COLORIZE_OUTPUT" = "1" ] && return 1
+	[ -t 1 ] || return 0
+	return 1
+}
+
+tst_print_colored()
+{
+	tst_color_enabled
+	local color=$?
+
+	[ "$color" = "1" ] && tst_flag2color "$1"
+	printf "$@"
+	[ "$color" = "1" ] && printf '\e[00m'
+}
diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index b54bbbf45..ea652189b 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 #
-# Copyright (c) Linux Test Project, 2014-2016
+# Copyright (c) Linux Test Project, 2014-2017
 #
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License as published by
@@ -29,6 +29,8 @@ export TST_CONF=0
 export TST_COUNT=1
 export TST_ITERATIONS=1
 
+. tst_ansi_color.sh
+
 tst_do_exit()
 {
 	local ret=0
@@ -96,9 +98,14 @@ tst_res()
 	local res=$1
 	shift
 
+	tst_color_enabled
+	local color=$?
+
 	tst_inc_res "$res"
 
-	echo "$TST_ID $TST_COUNT $res : $@"
+	printf "$TCID $TST_COUNT "
+	tst_print_colored $res "$ret: "
+	echo "$@"
 }
 
 tst_brk()
-- 
2.11.0


From: Petr Vorel <petr.vorel@gmail.com>
Date: Thu,  5 Jan 2017 09:57:11 +0100
Subject: [LTP] [RFC PATCH 1/1] test.sh: colorize the output
Message-ID: <20170105085711.8903-1-petr.vorel@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
---
Hi, I know you're busy with release and this is just a toy for interactive
running. But it you find it useful for upstream, I'll try to polish it and
implement TODO.

TODO:
* Create environment variable or getopt switch for enabling/disabling
  colors (instead of macro USE_ANSCI_COLOR), default off. Work in
  similar way like ls (--color[=WHEN], WHEN can be 'always' (default if
  omitted), 'auto', or 'never').
* DRY: Keep default definition only on one place => generate with make?
* Allow user to define colors (overwrite with environment variables).
---
 include/ansi_colors.h | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 lib/tst_res.c         | 33 ++++++++++++++++++++++++++++++---
 lib/tst_test.c        | 29 ++++++++++++++++++++++++-----
 testcases/lib/test.sh | 25 ++++++++++++++++++++++++-
 4 files changed, 129 insertions(+), 9 deletions(-)
 create mode 100644 include/ansi_colors.h

diff --git a/include/ansi_colors.h b/include/ansi_colors.h
new file mode 100644
index 000000000..3db86a677
--- /dev/null
+++ b/include/ansi_colors.h
@@ -0,0 +1,51 @@
+/*
+ * Copyright (c) 2017 Petr Vorel <petr.vorel@gmail.com>
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
+/*
+ * NOTE: these colors should match colors defined in tst_flag2color() in
+ * testcases/lib/test.sh
+ */
+#define ANSI_COLOR_BLUE	"\e[1;34m"
+#define ANSI_COLOR_GREEN	"\e[1;32m"
+#define ANSI_COLOR_RED		"\e[1;31m"
+#define ANSI_COLOR_YELLOW	"\e[1;33m"
+#define ANSI_COLOR_RESET	"\E[00m"
+
+static inline char* ttype2color(int ttype) {
+	switch (TTYPE_RESULT(ttype)) {
+	case TPASS:
+		return ANSI_COLOR_GREEN;
+	break;
+	case TFAIL:
+		return ANSI_COLOR_RED;
+	break;
+	case TBROK:
+		return ANSI_COLOR_YELLOW;
+	break;
+	case TCONF:
+		return ANSI_COLOR_YELLOW;
+	break;
+	case TWARN:
+		return ANSI_COLOR_YELLOW;
+	break;
+	case TINFO:
+		return ANSI_COLOR_GREEN;
+	break;
+	default:
+		return "";
+	}
+}
diff --git a/lib/tst_res.c b/lib/tst_res.c
index 261dec0fb..501a3f64d 100644
--- a/lib/tst_res.c
+++ b/lib/tst_res.c
@@ -50,6 +50,7 @@
 #include "test.h"
 #include "usctest.h"
 #include "ltp_priv.h"
+#include "ansi_colors.h"
 
 long TEST_RETURN;
 int TEST_ERRNO;
@@ -63,6 +64,8 @@ int TEST_ERRNO;
 #define TRUE         1
 #define FALSE        0
 
+#define USE_ANSCI_COLOR
+
 /*
  * EXPAND_VAR_ARGS - Expand the variable portion (arg_fmt) of a result
  *                   message into the specified string.
@@ -254,7 +257,7 @@ static void tst_print(const char *tcid, int tnum, int ttype, const char *tmesg)
 	const char *type;
 	int ttype_result = TTYPE_RESULT(ttype);
 	char message[USERMESG];
-	size_t size;
+	size_t size = 0;
 
 	/*
 	 * Save the test result type by ORing ttype into the current exit value
@@ -280,11 +283,23 @@ static void tst_print(const char *tcid, int tnum, int ttype, const char *tmesg)
 	 * Build the result line and print it.
 	 */
 	type = strttype(ttype);
+
+#ifdef USE_ANSCI_COLOR
+	char *color = ttype2color(ttype);
+
+	size += snprintf(message + size, sizeof(message) - size, color);
+
+	if (size >= sizeof(message)) {
+		printf("%s: %i: line too long\n", __func__, __LINE__);
+		abort();
+	}
+#endif
+
 	if (T_mode == VERBOSE) {
-		size = snprintf(message, sizeof(message),
+		size += snprintf(message + size, sizeof(message) - size,
 				"%-8s %4d  %s  :  %s", tcid, tnum, type, tmesg);
 	} else {
-		size = snprintf(message, sizeof(message),
+		size += snprintf(message + size, sizeof(message) - size,
 				"%-8s %4d       %s  :  %s",
 				tcid, tnum, type, tmesg);
 	}
@@ -305,6 +320,8 @@ static void tst_print(const char *tcid, int tnum, int ttype, const char *tmesg)
 		abort();
 	}
 
+
+
 	if (ttype & TTERRNO) {
 		size += snprintf(message + size, sizeof(message) - size,
 				 ": TEST_ERRNO=%s(%i): %s",
@@ -324,6 +341,16 @@ static void tst_print(const char *tcid, int tnum, int ttype, const char *tmesg)
 				 strerror(TEST_RETURN));
 	}
 
+#ifdef USE_ANSCI_COLOR
+	if (size >= sizeof(message)) {
+		printf("%s: %i: line too long\n", __func__, __LINE__);
+		abort();
+	}
+
+	size += snprintf(message + size, sizeof(message) - size,
+			 ANSI_COLOR_RESET);
+#endif
+
 	if (size + 1 >= sizeof(message)) {
 		printf("%s: %i: line too long\n", __func__, __LINE__);
 		abort();
diff --git a/lib/tst_test.c b/lib/tst_test.c
index c48d71877..17e686c9b 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -29,6 +29,7 @@
 #include "tst_test.h"
 #include "tst_device.h"
 #include "lapi/futex.h"
+#include "ansi_colors.h"
 
 #include "old_resource.h"
 #include "old_device.h"
@@ -58,6 +59,8 @@ extern unsigned int tst_max_futexes;
 
 #define IPC_ENV_VAR "LTP_IPC_PATH"
 
+#define USE_ANSCI_COLOR
+
 static char ipc_path[1024];
 const char *tst_ipc_path = ipc_path;
 char *const tst_ipc_envp[] = {ipc_path, NULL};
@@ -194,20 +197,36 @@ static void print_result(const char *file, const int lineno, int ttype,
 	if (ttype & TTERRNO)
 		str_errno = tst_strerrno(TEST_ERRNO);
 
-	ret = snprintf(str, size, "%s:%i: %s: ", file, lineno, res);
+#ifdef USE_ANSCI_COLOR
+	char *color = ttype2color(ttype);
 
+	ret = snprintf(str, size, "%s", color);
+	str += ret;
+	size -= ret;
+#endif
+
+	ret = snprintf(str, size, "%s:%i: %s: ", file, lineno, res);
 	str += ret;
 	size -= ret;
 
 	ret = vsnprintf(str, size, fmt, va);
+	str += ret;
+	size -= ret;
+
+	if (str_errno) {
+		ret = snprintf(str, size, ": %s", str_errno);
+		str += ret;
+		size -= ret;
+	}
 
+#ifdef USE_ANSCI_COLOR
+	ret = snprintf(str, size, ANSI_COLOR_RESET);
 	str += ret;
 	size -= ret;
+#endif
+
+	snprintf(str, size, "\n");
 
-	if (str_errno)
-		snprintf(str, size, ": %s\n", str_errno);
-	else
-		snprintf(str, size, "\n");
 
 	fputs(buf, stderr);
 }
diff --git a/testcases/lib/test.sh b/testcases/lib/test.sh
index 76b706267..535ea8724 100644
--- a/testcases/lib/test.sh
+++ b/testcases/lib/test.sh
@@ -39,15 +39,38 @@ tst_flag2mask()
 	esac
 }
 
+tst_flag2color()
+{
+	# NOTE: these colors should match colors defined in include/ansi_colors.h
+	local blue='\e[1;34m'
+	local green='\e[1;32m'
+	local red='\e[1;31m'
+	local yellow='\e[1;33m'
+
+	case "$1" in
+	TPASS) printf $green;;
+	TFAIL) printf $red;;
+	TBROK) printf $yellow;;
+	TWARN) printf $yellow;;
+	TINFO) printf $blue;;
+	TCONF) printf $yellow;;
+	*) tst_brkm TBROK "Invalid resm type '$1'";;
+	esac
+}
+
 tst_resm()
 {
-	tst_flag2mask "$1"
+	local ttype="$1"
+	tst_flag2mask "$ttype"
 	local mask=$?
 	LTP_RET_VAL=$((LTP_RET_VAL|mask))
 
 	local ret=$1
 	shift
+
+	tst_flag2color "$ttype"
 	echo "$TCID $TST_COUNT $ret : $@"
+	printf '\E[00m'
 
 	case "$ret" in
 	TPASS|TFAIL)
-- 
2.11.0


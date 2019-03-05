From: Mark Salyzyn <salyzyn@android.com>
Date: Tue,  5 Mar 2019 08:24:10 -0800
Subject: [LTP] [PATCH] select: tests offer choice of syscall path:
Message-ID: <20190305162410.127713-1-salyzyn@android.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Switch between libc library, __newselect syscall, select syscall or
pselect6 syscall for selection of select() tests.  This provides
filled in coverage of all the possible select alternatives.

CC flags can be one of:

-DSYSCALL_SELECT_LIBC        // use select() libc library function
-DSYSCALL_SELECT__NEWSELECT  // use __NR__newselect system call
-DSYSCALL_SELECT_SELECT      // use __NR_select system call
-DSYSCALL_SELECT_PSELECT6    // use __NR_pselect6 system call worker
<default>                    // chose a _defined_ system call

Signed-off-by: Mark Salyzyn <salyzyn@android.com>
Cc: kernel-team@android.com
Cc: ltp@lists.linux.it
---
 testcases/kernel/syscalls/select/.gitignore |  12 ++
 testcases/kernel/syscalls/select/Makefile   |  22 ++++
 testcases/kernel/syscalls/select/select.h   | 130 ++++++++++++++++++++
 testcases/kernel/syscalls/select/select01.c |   7 +-
 testcases/kernel/syscalls/select/select02.c |   5 +-
 testcases/kernel/syscalls/select/select03.c |   7 +-
 testcases/kernel/syscalls/select/select04.c |   5 +-
 7 files changed, 174 insertions(+), 14 deletions(-)
 create mode 100644 testcases/kernel/syscalls/select/select.h

diff --git a/testcases/kernel/syscalls/select/.gitignore b/testcases/kernel/syscalls/select/.gitignore
index 9d64cb8b8a1b..c6e92c8e8efe 100644
--- a/testcases/kernel/syscalls/select/.gitignore
+++ b/testcases/kernel/syscalls/select/.gitignore
@@ -1,4 +1,16 @@
 /select01
+/select01_SYS__newselect
+/select01_SYS_select
+/select01_SYS_pselect6
 /select02
+/select02_SYS__newselect
+/select02_SYS_select
+/select02_SYS_pselect6
 /select03
+/select03_SYS__newselect
+/select03_SYS_select
+/select03_SYS_pselect6
 /select04
+/select04_SYS__newselect
+/select04_SYS_select
+/select04_SYS_pselect6
diff --git a/testcases/kernel/syscalls/select/Makefile b/testcases/kernel/syscalls/select/Makefile
index aed044fd09eb..40b7c5c09cce 100644
--- a/testcases/kernel/syscalls/select/Makefile
+++ b/testcases/kernel/syscalls/select/Makefile
@@ -18,7 +18,29 @@
 
 top_srcdir		?= ../../../..
 
+%_SYS__newselect: %_SYS__newselect.o
+	$(LINK.o) $^ $(LOADLIBES) $(LDLIBS) -o $@
+%_SYS_select: %_SYS_select.o
+	$(LINK.o) $^ $(LOADLIBES) $(LDLIBS) -o $@
+%_SYS_pselect6: %_SYS_pselect6.o
+	$(LINK.o) $^ $(LOADLIBES) $(LDLIBS) -o $@
+
+%_SYS__newselect.o: %.c select.h
+	$(COMPILE.c) -DSYSCALL_SELECT__NEWSELECT $(OUTPUT_OPTION) $<
+%_SYS_select.o: %.c select.h
+	$(COMPILE.c) -DSYSCALL_SELECT_SELECT $(OUTPUT_OPTION) $<
+%_SYS_pselect6.o: %.c select.h
+	$(COMPILE.c) -DSYSCALL_SELECT_PSELECT6 $(OUTPUT_OPTION) $<
+
+select01 select02 select03 select04: select.h
+select01 select02 select03 select04: CFLAGS+=-DSYSCALL_SELECT_LIBC
 select04: LDLIBS+=-lrt
+select04_SYS_%: LDLIBS+=-lrt
+
+MAKE_TARGETS := $(notdir $(patsubst %.c,%,$(wildcard $(abs_srcdir:%=%/)*.c))) \
+ $(notdir $(patsubst %.c,%_SYS__newselect,$(wildcard $(abs_srcdir:%=%/)*.c))) \
+ $(notdir $(patsubst %.c,%_SYS_select,$(wildcard $(abs_srcdir:%=%/)*.c)))     \
+ $(notdir $(patsubst %.c,%_SYS_pselect6,$(wildcard $(abs_srcdir:%=%/)*.c)))
 
 include $(top_srcdir)/include/mk/testcases.mk
 
diff --git a/testcases/kernel/syscalls/select/select.h b/testcases/kernel/syscalls/select/select.h
new file mode 100644
index 000000000000..9f8766951d5e
--- /dev/null
+++ b/testcases/kernel/syscalls/select/select.h
@@ -0,0 +1,130 @@
+/*
+ * Copyright (c) 2019 Google, Inc.
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
+#ifndef SELECT_H__
+#define SELECT_H__
+
+#include <stdlib.h>
+#include <sys/select.h>
+#include <sys/time.h>
+#include <sys/types.h>
+#include <unistd.h>
+
+#define str_expand(s) str(s)
+#define str(s) #s
+
+#if defined(SYSCALL_SELECT_LIBC)
+
+// bionic and GNU libc actually use pselect6 instead, others?
+#define SELECT_TEST_SYSCALL select
+#define SELECT_TEST_FILENAME(x) x
+
+#else
+
+#ifndef TCONF
+#include "test.h"
+#endif
+#ifndef tst_brkm
+#include <stdio.h>
+#define tst_brkm(a1, a2, whatever...) \
+	{ \
+		printf("BROK : "); \
+		printf(whatever); \
+		printf("\n"); \
+		_exit(0); \
+	}
+#endif
+
+#include "lapi/syscalls.h"
+
+#define undefined __LTP__NR_INVALID_SYSCALL
+
+#ifndef __NR_select
+#define __NR_select undefined
+#endif
+#if defined(__LP64__)
+#define select_sys_select(n, inp, outp, exp, tvp) \
+	return ltp_syscall(__NR_select, n, inp, outp, exp, tvp)
+#else
+struct compat_sel_arg_struct {
+	long _n;
+	long _inp;
+	long _outp;
+	long _exp;
+	long _tvp;
+};
+#define select_sys_select(n, inp, outp, exp, tvp) \
+	struct compat_sel_arg_struct arg; \
+\
+	arg._n = (long)n; \
+	arg._inp = (long)inp; \
+	arg._outp = (long)outp; \
+	arg._exp = (long)exp; \
+	arg._tvp = (long)tvp; \
+	return ltp_syscall(__NR_select, &arg)
+#endif
+
+#ifndef __NR__newselect
+#define __NR__newselect undefined
+#endif
+#define select_sys__newselect(n, inp, outp, exp, tvp) \
+	return ltp_syscall(__NR__newselect, n, inp, outp, exp, tvp)
+
+#define select_sys_pselect6(n, inp, outp, exp, tvp) \
+	int ret; \
+	struct timespec ts; \
+\
+	ts.tv_sec = tvp->tv_sec; \
+	ts.tv_nsec = tvp->tv_usec * 1000; \
+	ret = ltp_syscall(__NR_pselect6, n, inp, outp, exp, &ts, NULL); \
+	tvp->tv_sec = ts.tv_sec; \
+	tvp->tv_usec = ts.tv_nsec / 1000; \
+	return ret
+
+#if defined(SYSCALL_SELECT__NEWSELECT)
+#define SELECT_TEST_SYSCALL _newselect
+#elif defined(SYSCALL_SELECT_SELECT)
+#define SELECT_TEST_SYSCALL select
+#elif defined(SYSCALL_SELECT_PSELECT6)
+#define SELECT_TEST_SYSCALL pselect6
+#else
+/* automatically select between newselect, select or pselect6 if available */
+#if __NR__newselect != __LTP__NR_INVALID_SYSCALL
+#define SELECT_TEST_SYSCALL _newselect
+#elif __NR_select != __LTP__NR_INVALID_SYSCALL
+#define SELECT_TEST_SYSCALL select
+#else
+#define SELECT_TEST_SYSCALL pselect6
+#endif
+#endif
+
+#define __MY_select(x) select_sys_ ## x
+#define _MY_select(x) __MY_select(x)
+#define MY_select _MY_select(SELECT_TEST_SYSCALL)
+
+int select(int __fd_count, fd_set* __read_fds, fd_set* __write_fds,
+	   fd_set* __exception_fds, struct timeval* __timeout)
+{
+	MY_select(__fd_count, __read_fds, __write_fds, __exception_fds,
+		  __timeout);
+}
+
+#define SELECT_TEST_FILENAME(x) x "_SYS_" str_expand(SELECT_TEST_SYSCALL)
+
+#endif /* ! SYSCALL_SELECT_LIBC */
+
+#endif  /* SELECT_H__ */
diff --git a/testcases/kernel/syscalls/select/select01.c b/testcases/kernel/syscalls/select/select01.c
index e9100c78e9b5..2447c62485bb 100644
--- a/testcases/kernel/syscalls/select/select01.c
+++ b/testcases/kernel/syscalls/select/select01.c
@@ -43,17 +43,16 @@
 #include <signal.h>
 #include <string.h>
 #include <sys/param.h>
-#include <sys/types.h>
-#include <sys/time.h>
 
 #include "test.h"
+#include "select.h"
 
-#define FILENAME	"select01"
+#define FILENAME	SELECT_TEST_FILENAME("select01")
 
 static void setup(void);
 static void cleanup(void);
 
-char *TCID = "select01";
+char *TCID = FILENAME;
 int TST_TOTAL = 1;
 
 int Fd = -1;
diff --git a/testcases/kernel/syscalls/select/select02.c b/testcases/kernel/syscalls/select/select02.c
index 7aa0107c0ce1..cd7d9592288c 100644
--- a/testcases/kernel/syscalls/select/select02.c
+++ b/testcases/kernel/syscalls/select/select02.c
@@ -43,15 +43,14 @@
 #include <fcntl.h>
 #include <signal.h>
 #include <sys/param.h>
-#include <sys/types.h>
-#include <sys/time.h>
 
 #include "test.h"
 #include "safe_macros.h"
+#include "select.h"
 
 static void setup(void);
 
-char *TCID = "select02";
+char *TCID = SELECT_TEST_FILENAME("select02");
 int TST_TOTAL = 1;
 
 int Fd[2];
diff --git a/testcases/kernel/syscalls/select/select03.c b/testcases/kernel/syscalls/select/select03.c
index da7fdb094173..42573a6b3666 100644
--- a/testcases/kernel/syscalls/select/select03.c
+++ b/testcases/kernel/syscalls/select/select03.c
@@ -43,19 +43,18 @@
 #include <fcntl.h>
 #include <signal.h>
 #include <sys/param.h>
-#include <sys/types.h>
-#include <sys/time.h>
 #include <sys/stat.h>
 
 #include "test.h"
 #include "safe_macros.h"
+#include "select.h"
 
-#define FILENAME	"select03"
+#define FILENAME	SELECT_TEST_FILENAME("select03")
 
 static void setup(void);
 static void cleanup(void);
 
-char *TCID = "select03";
+char *TCID = FILENAME;
 int TST_TOTAL = 1;
 
 int Fd;
diff --git a/testcases/kernel/syscalls/select/select04.c b/testcases/kernel/syscalls/select/select04.c
index 86bdffcdff15..e1e19ee4c530 100644
--- a/testcases/kernel/syscalls/select/select04.c
+++ b/testcases/kernel/syscalls/select/select04.c
@@ -21,11 +21,10 @@
  */
 #include <unistd.h>
 #include <errno.h>
-#include <sys/time.h>
-#include <sys/types.h>
 #include <fcntl.h>
 
 #include "tst_timer_test.h"
+#include "select.h"
 
 static int fds[2];
 
@@ -66,7 +65,7 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
-	.scall = "select()",
+	.scall = str_expand(SELECT_TEST_SYSCALL) "()",
 	.sample = sample_fn,
 	.setup = setup,
 	.cleanup = cleanup,
-- 
2.21.0.352.gf09ad66450-goog


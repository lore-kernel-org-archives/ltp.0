From: Petr Vorel <pvorel@suse.cz>
Date: Wed,  4 Mar 2020 19:38:05 +0100
Subject: [LTP] [PATCH 1/2] lib: Add safe timerfd macros
Message-ID: <20200304183806.17672-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

SAFE_TIMERFD_CREATE(), SAFE_TIMERFD_GETTIME() and SAFE_TIMERFD_SETTIME()

Added only to new C API.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes v1->v2:
* patch based on 1st and 2nd patch from Cyril's patchset "[01/12] lib:
* Move tst_clock_name() to tst_clock.c" (now posted only these 2)
https://patchwork.ozlabs.org/project/ltp/list/?series=162390&state=*
* Move implementation code to C file
* drop version check. BTW I was wrong, timerfd_create() requires flags
  to be zero (I had code in timerfd_settime()). And this is correctly
  handled in old tests (old tests which use non-zero flag already
  require correctly 2.6.27 instead of 2.6.25).
* check return for == -1 (instead of < 0)

NOTE: I decided ignore errno reset (and not use TEST()), as I agree with
Cyril ("Generally the syscalls in libc have single macro definition that
is used everywhere to copy the error from the errno variable. If that
piece of code is buggy half of the test in LTP would fail anyway.")

Kind regards,
Petr

 include/tst_safe_timerfd.h | 32 +++++++++++++++++++++
 lib/tst_safe_timerfd.c     | 59 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 91 insertions(+)
 create mode 100644 include/tst_safe_timerfd.h
 create mode 100644 lib/tst_safe_timerfd.c

diff --git a/include/tst_safe_timerfd.h b/include/tst_safe_timerfd.h
new file mode 100644
index 000000000..526f12838
--- /dev/null
+++ b/include/tst_safe_timerfd.h
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 Petr Vorel <pvorel@suse.cz>
+ */
+
+#ifndef TST_SAFE_TIMERFD_H__
+#define TST_SAFE_TIMERFD_H__
+
+#include "lapi/timerfd.h"
+
+int safe_timerfd_create(const char *file, const int lineno,
+				      int clockid, int flags);
+
+#define SAFE_TIMERFD_CREATE(clockid, flags)\
+	safe_timerfd_create(__FILE__, __LINE__, (clockid), (flags))
+
+int safe_timerfd_gettime(const char *file, const int lineno,
+				int fd, struct itimerspec *curr_value);
+
+#define SAFE_TIMERFD_GETTIME(fd, curr_value)\
+	safe_timerfd_gettime(__FILE__, __LINE__, (fd), (curr_value))
+
+int safe_timerfd_settime(const char *file, const int lineno,
+				int fd, int flags,
+				const struct itimerspec *new_value,
+				struct itimerspec *old_value);
+
+#define SAFE_TIMERFD_SETTIME(fd, flags, new_value, old_value)\
+	safe_timerfd_settime(__FILE__, __LINE__, (fd), (flags), (new_value), \
+						 (old_value))
+
+#endif /* SAFE_TIMERFD_H__ */
diff --git a/lib/tst_safe_timerfd.c b/lib/tst_safe_timerfd.c
new file mode 100644
index 000000000..80de87ad3
--- /dev/null
+++ b/lib/tst_safe_timerfd.c
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 Petr Vorel <pvorel@suse.cz>
+ */
+
+#include <errno.h>
+
+#include "tst_safe_timerfd.h"
+#include "lapi/timerfd.h"
+#include "tst_clocks.h"
+#define TST_NO_DEFAULT_MAIN
+#include "tst_test.h"
+
+#define TTYPE (errno == ENOTSUP ? TCONF : TBROK)
+
+int safe_timerfd_create(const char *file, const int lineno,
+				      int clockid, int flags)
+{
+	int fd;
+
+	fd = timerfd_create(clockid, flags);
+
+	if (fd == -1) {
+		tst_brk(TTYPE | TERRNO, "%s:%d timerfd_create(%s) failed",
+			file, lineno, tst_clock_name(clockid));
+	}
+
+	return fd;
+}
+
+int safe_timerfd_gettime(const char *file, const int lineno,
+				int fd, struct itimerspec *curr_value)
+{
+	int rval;
+
+	rval = timerfd_gettime(fd, curr_value);
+	if (rval == -1) {
+		tst_brk(TTYPE | TERRNO, "%s:%d timerfd_gettime() failed",
+			file, lineno);
+	}
+
+	return rval;
+}
+
+int safe_timerfd_settime(const char *file, const int lineno,
+				int fd, int flags,
+				const struct itimerspec *new_value,
+				struct itimerspec *old_value)
+{
+	int rval;
+
+	rval = timerfd_settime(fd, flags, new_value, old_value);
+	if (rval == -1) {
+		tst_brk(TTYPE | TERRNO, "%s:%d timerfd_settime() failed",
+			file, lineno);
+	}
+
+	return rval;
+}
-- 
2.25.1


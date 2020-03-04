From: Petr Vorel <pvorel@suse.cz>
Date: Wed,  4 Mar 2020 16:12:00 +0100
Subject: [LTP] [PATCH 1/2] lib: Add safe timerfd macros
Message-ID: <20200304151201.19117-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

SAFE_TIMERFD_CREATE(), SAFE_TIMERFD_GETTIME() and SAFE_TIMERFD_SETTIME()

Added only to new C API.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

NOTE: ENOSYS is handled by ltp_syscall in lapi/timerfd.h.
+ I wonder include/tst_safe_timerfd.h and lapi/timerfd.h shouldn't be
merged into single file.

Kind regards,
Petr

 include/tst_safe_timerfd.h | 73 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)
 create mode 100644 include/tst_safe_timerfd.h

diff --git a/include/tst_safe_timerfd.h b/include/tst_safe_timerfd.h
new file mode 100644
index 000000000..4019527d6
--- /dev/null
+++ b/include/tst_safe_timerfd.h
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 Petr Vorel <pvorel@suse.cz>
+ */
+
+#ifndef TST_SAFE_TIMERFD_H__
+#define TST_SAFE_TIMERFD_H__
+
+#include <errno.h>
+#include "lapi/timerfd.h"
+#include "tst_test.h"
+
+#define TTYPE (errno == ENOTSUP ? TCONF : TBROK)
+
+static inline int safe_timerfd_create(const char *file, const int lineno,
+				      int clockid, int flags)
+{
+	int fd;
+
+	fd = timerfd_create(clockid, flags);
+
+	if (fd < 0) {
+		tst_brk(TTYPE | TERRNO, "%s:%d: timerfd_create() failed",
+			file, lineno);
+	}
+
+	return fd;
+}
+
+static inline int safe_timerfd_gettime(const char *file, const int lineno,
+				int fd, struct itimerspec *curr_value)
+{
+	int rval;
+
+	rval = timerfd_gettime(fd, curr_value);
+	if (rval < 0) {
+		tst_brk(TTYPE | TERRNO, "%s:%d: timerfd_gettime() failed",
+			file, lineno);
+	}
+
+	return rval;
+}
+
+static inline int safe_timerfd_settime(const char *file, const int lineno,
+				int fd, int flags,
+				const struct itimerspec *new_value,
+				struct itimerspec *old_value)
+{
+	int rval;
+
+	if (tst_kvercmp(2, 6, 26) <= 0)
+		flags = 0;
+
+	rval = timerfd_settime(fd, flags, new_value, old_value);
+	if (rval < 0) {
+		tst_brk(TTYPE | TERRNO, "%s:%d: timerfd_settime() failed",
+			file, lineno);
+	}
+
+	return rval;
+}
+
+#define SAFE_TIMERFD_CREATE(clockid, flags)\
+	safe_timerfd_create(__FILE__, __LINE__, (clockid), (flags))
+
+#define SAFE_TIMERFD_GETTIME(fd, curr_value)\
+	safe_timerfd_gettime(__FILE__, __LINE__, (fd), (curr_value))
+
+#define SAFE_TIMERFD_SETTIME(fd, flags, new_value, old_value)\
+	safe_timerfd_settime(__FILE__, __LINE__, (fd), (flags), (new_value), \
+						 (old_value))
+
+#endif /* SAFE_TIMERFD_H__ */
-- 
2.25.1


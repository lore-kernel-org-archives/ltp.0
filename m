From: Jakub Racek <jracek@redhat.com>
Date: Mon,  6 Mar 2017 18:45:38 +0100
Subject: [LTP] [PATCH v2 4/6] Added fallocate() flags and wrapper to lapi
In-Reply-To: <1488822340-29259-1-git-send-email-jracek@redhat.com>
References: <1488822340-29259-1-git-send-email-jracek@redhat.com>
Message-ID: <1488822340-29259-5-git-send-email-jracek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Jakub Racek <jracek@redhat.com>
---
 include/lapi/fallocate.h | 66 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)
 create mode 100644 include/lapi/fallocate.h

diff --git a/include/lapi/fallocate.h b/include/lapi/fallocate.h
new file mode 100644
index 0000000..79d0b7b
--- /dev/null
+++ b/include/lapi/fallocate.h
@@ -0,0 +1,66 @@
+/*
+ * Copyright (c) International Business Machines  Corp., 2007
+ * Copyright (c) 2014 Fujitsu Ltd.
+ *
+ * This program is free software;  you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU Library General Public License for more details.
+ *
+ */
+
+#ifndef FALLOCATE_H
+#define FALLOCATE_H
+
+#include <sys/types.h>
+#include <endian.h>
+#include "config.h"
+#include "lapi/abisize.h"
+#include "linux_syscall_numbers.h"
+
+#ifndef SEEK_HOLE
+# define SEEK_HOLE 4
+#endif
+
+#ifndef FALLOC_FL_KEEP_SIZE
+# define FALLOC_FL_KEEP_SIZE 0x01
+#endif
+
+#ifndef FALLOC_FL_PUNCH_HOLE
+# define FALLOC_FL_PUNCH_HOLE 0x02
+#endif
+
+#ifndef FALLOC_FL_COLLAPSE_RANGE
+# define FALLOC_FL_COLLAPSE_RANGE 0x08
+#endif
+
+#ifndef FALLOC_FL_ZERO_RANGE
+# define FALLOC_FL_ZERO_RANGE 0x10
+#endif
+
+#ifndef FALLOC_FL_INSERT_RANGE
+# define FALLOC_FL_INSERT_RANGE 0x20
+#endif
+
+#if !defined(HAVE_FALLOCATE)
+static inline long fallocate(int fd, int mode, loff_t offset, loff_t len)
+{
+	/* Deal with 32bit ABIs that have 64bit syscalls. */
+# if LTP_USE_64_ABI
+	return ltp_syscall(__NR_fallocate, fd, mode, offset, len);
+# else
+	return (long)ltp_syscall(__NR_fallocate, fd, mode,
+				 __LONG_LONG_PAIR((off_t) (offset >> 32),
+						  (off_t) offset),
+				 __LONG_LONG_PAIR((off_t) (len >> 32),
+						  (off_t) len));
+# endif
+}
+#endif
+
+#endif /* FALLOCATE_H */
-- 
1.8.3.1


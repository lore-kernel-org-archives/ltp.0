From: Greg Hackmann <ghackmann@google.com>
Date: Wed,  7 Nov 2018 13:22:13 -0800
Subject: [LTP] [PATCH v2] getrlimit/getrlimit03: new test for underlying
	syscall variants
In-Reply-To: <20181106194725.GA11344@rei.lan>
References: <20181106194725.GA11344@rei.lan>
Message-ID: <20181107212213.129534-1-ghackmann@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Depending on the architecture, Linux provides up to three syscalls that
have been used to implement getrlimit(2) in different libc
implementations.  These syscalls differ in the size and signedness of
rlim_t.

This test compares the results returned by all three syscalls, confirming
that they either match or were appropriately capped at the respective
RLIM_INFINITY constant.

Signed-off-by: Greg Hackmann <ghackmann@google.com>
---
v2: use tst_syscall() to correctly handle kernels that don't have the
prlimit64 syscall

 .../kernel/syscalls/getrlimit/getrlimit03.c   | 195 ++++++++++++++++++
 1 file changed, 195 insertions(+)
 create mode 100644 testcases/kernel/syscalls/getrlimit/getrlimit03.c

diff --git a/testcases/kernel/syscalls/getrlimit/getrlimit03.c b/testcases/kernel/syscalls/getrlimit/getrlimit03.c
new file mode 100644
index 000000000..2f08e14b7
--- /dev/null
+++ b/testcases/kernel/syscalls/getrlimit/getrlimit03.c
@@ -0,0 +1,195 @@
+/*
+ * Copyright (c) 2018 Google, Inc.
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
+ * along with this program, if not, see <http://www.gnu.org/licenses/>.
+ */
+
+/**
+ * Architectures may provide up to three syscalls that have been used to
+ * implement getrlimit(2) in different libc implementations.  These syscalls
+ * differ in the size and signedness of rlim_t:
+ *
+ * - __NR_getrlimit uses long or unsigned long, depending on the
+ *   architecture
+ *
+ * - __NR_ugetrlimit uses unsigned long, and only exists on
+ *   architectures where __NR_getrlimit is signed
+ *
+ * - __NR_prlimit64 uses uint64_t
+ *
+ * This test compares the results returned by all three syscalls, confirming
+ * that they either match or were appropriately capped at the respective
+ * RLIM_INFINITY constant.
+ */
+
+#include <inttypes.h>
+#include <stdint.h>
+#include <sys/time.h>
+#include <sys/resource.h>
+
+#include "tst_test.h"
+#include "lapi/syscalls.h"
+
+/**
+ * Linux provides an "old" getrlimit syscall handler that uses signed long,
+ * and a "new" getrlimit syscall handler that uses unsigned long.
+ *
+ * The underlying syscall names vary across architectures, depending on whether
+ * the architecture predates the "new" handler.  For clarity, this test
+ * will call them getrlimit_long and getlimit_ulong internally.
+ */
+#define SIGNED_GETRLIMIT (__NR_ugetrlimit != __LTP__NR_INVALID_SYSCALL)
+#if SIGNED_GETRLIMIT
+#define __NR_getrlimit_ulong		__NR_ugetrlimit
+#define __NR_getrlimit_ulong_str	"__NR_ugetrlimit"
+#else
+#define __NR_getrlimit_ulong		__NR_getrlimit
+#define __NR_getrlimit_ulong_str	"__NR_getrlimit"
+#endif
+
+struct rlimit64 {
+	uint64_t rlim_cur;
+	uint64_t rlim_max;
+};
+const uint64_t RLIM_INFINITY_U64 = UINT64_MAX;
+
+static int getrlimit_u64(int resource, struct rlimit64 *rlim)
+{
+	return tst_syscall(__NR_prlimit64, 0, resource, NULL, rlim);
+}
+
+struct rlimit_ulong {
+	unsigned long rlim_cur;
+	unsigned long rlim_max;
+};
+const unsigned long RLIM_INFINITY_UL = ULONG_MAX;
+
+static int getrlimit_ulong(int resource, struct rlimit_ulong *rlim)
+{
+	return syscall(__NR_getrlimit_ulong, resource, rlim);
+}
+
+#if SIGNED_GETRLIMIT
+struct rlimit_long {
+	long rlim_cur;
+	long rlim_max;
+};
+const long RLIM_INFINITY_L = LONG_MAX;
+
+static int getrlimit_long(int resource, struct rlimit_long *rlim)
+{
+	return syscall(__NR_getrlimit, resource, rlim);
+}
+#endif
+
+static int compare_retval(int resource, int ret_u64, int errno_u64,
+			  int ret_other, int errno_other,
+			  const char *other_syscall)
+{
+	if (ret_u64 != ret_other || errno_u64 != errno_other) {
+		tst_res(TFAIL, "__NR_prlimit64(%d) returned %d (%s) but %s(%d) returned %d (%s)",
+			resource, ret_u64, tst_strerrno(errno_u64),
+			other_syscall, resource, ret_other,
+			tst_strerrno(errno_other));
+		return -1;
+	}
+
+	return 0;
+}
+
+static int compare_u64_ulong(int resource, uint64_t val_u64,
+			     unsigned long val_ul, const char *kind)
+{
+	if ((val_u64 > RLIM_INFINITY_UL && val_ul != RLIM_INFINITY_UL) ||
+	    (val_u64 <= RLIM_INFINITY_UL && val_ul != val_u64)) {
+		tst_res(TFAIL, "__NR_prlimit64(%d) had %s = %" PRIx64 " but " __NR_getrlimit_ulong_str "(%d) had %s = %lx",
+			resource, kind, val_u64,
+			resource, kind, val_ul);
+		return -1;
+	}
+
+	return 0;
+}
+
+#if SIGNED_GETRLIMIT
+static int compare_u64_long(int resource, uint64_t val_u64, long val_l,
+			    const char *kind)
+{
+	if ((val_u64 > (uint64_t)RLIM_INFINITY_L && val_l != RLIM_INFINITY_L) ||
+	    (val_u64 <= (uint64_t)RLIM_INFINITY_L && val_l != (long)val_u64)) {
+		tst_res(TFAIL, "__NR_prlimit64(%d) had %s = %" PRIx64 " but __NR_getrlimit(%d) had %s = %lx",
+			resource, kind, val_u64,
+			resource, kind, val_l);
+		return -1;
+	}
+
+	return 0;
+}
+#endif
+
+static void run(unsigned int resource)
+{
+	struct rlimit64 rlim_u64;
+	int ret_u64;
+	int errno_u64;
+
+	struct rlimit_ulong rlim_ul;
+	int ret_ul;
+	int errno_ul;
+
+#if SIGNED_GETRLIMIT
+	struct rlimit_long rlim_l;
+	int ret_l;
+	int errno_l;
+#endif
+
+	errno = 0;
+	ret_u64 = getrlimit_u64(resource, &rlim_u64);
+	errno_u64 = errno;
+
+	errno = 0;
+	ret_ul = getrlimit_ulong(resource, &rlim_ul);
+	errno_ul = errno;
+
+	if (compare_retval(resource, ret_u64, errno_u64, ret_ul, errno_ul,
+			   __NR_getrlimit_ulong_str) ||
+	    compare_u64_ulong(resource, rlim_u64.rlim_cur, rlim_ul.rlim_cur,
+			      "rlim_cur") ||
+	    compare_u64_ulong(resource, rlim_u64.rlim_max, rlim_ul.rlim_max,
+			      "rlim_max"))
+		return;
+
+#if SIGNED_GETRLIMIT
+	errno = 0;
+	ret_l = getrlimit_long(resource, &rlim_l);
+	errno_l = errno;
+
+	if (compare_retval(resource, ret_u64, errno_u64, ret_l, errno_l,
+			   "__NR_getrlimit") ||
+	    compare_u64_long(resource, rlim_u64.rlim_cur, rlim_l.rlim_cur,
+			     "rlim_cur") ||
+	    compare_u64_long(resource, rlim_u64.rlim_max, rlim_l.rlim_max,
+			     "rlim_max"))
+		return;
+#endif
+
+	tst_res(TPASS, "getrlimit(%u) was consistent during all syscalls",
+		resource);
+}
+
+static struct tst_test test = {
+	.tcnt = RLIM_NLIMITS,
+	.test = run,
+};
+
-- 
2.19.1.930.g4563a0d9d0-goog


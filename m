From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 24 May 2017 13:34:03 +0200
Subject: [LTP] [COMMITTED] [PATCH 1/2] Unify MIN()/MAX() implementation +
	cleanup
Message-ID: <20170524113404.8894-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The oldlib tests had defined MIN() and MAX() macros via <sys/param.h>
that was included from usctest.h that is included from test.h.

This patch adds tst_minmax.h that has safer versions of these macros
(expressions passed to the macros are evaluated only once) which is
then included from both tst_test.h and test.h.

Some of the testcases were relying on the usctest.h to include
sys/param.h or indirecly include limits.h which is included from
sys/param.h. This patch fixes such tests to include respective headers
directly.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/old/test.h                                 |  1 +
 include/old/usctest.h                              |  2 --
 include/tst_minmax.h                               | 37 ++++++++++++++++++++++
 include/tst_test.h                                 |  1 +
 lib/get_path.c                                     |  6 +---
 testcases/kernel/fs/ftest/ftest01.c                |  1 +
 testcases/kernel/fs/ftest/ftest05.c                |  1 +
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c |  2 ++
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c |  2 ++
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c |  2 ++
 .../kernel/mem/hugetlb/hugeshmat/hugeshmat01.c     |  1 +
 .../kernel/mem/hugetlb/hugeshmat/hugeshmat02.c     |  1 +
 .../kernel/mem/hugetlb/hugeshmat/hugeshmat03.c     |  1 +
 .../kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c   |  1 +
 .../kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c   |  1 +
 .../kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c   |  1 +
 .../kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c     |  1 +
 .../kernel/mem/hugetlb/hugeshmget/hugeshmget01.c   |  1 +
 .../kernel/mem/hugetlb/hugeshmget/hugeshmget02.c   |  2 +-
 .../kernel/mem/hugetlb/hugeshmget/hugeshmget03.c   |  1 +
 .../kernel/mem/hugetlb/hugeshmget/hugeshmget05.c   |  1 +
 testcases/kernel/mem/ksm/ksm06.c                   |  1 +
 testcases/kernel/mem/tunable/overcommit_memory.c   |  1 +
 testcases/kernel/mem/vma/vma02.c                   |  1 +
 testcases/kernel/mem/vma/vma04.c                   |  1 +
 testcases/kernel/syscalls/cma/process_vm_readv03.c |  1 +
 .../kernel/syscalls/cma/process_vm_writev02.c      |  1 +
 testcases/kernel/syscalls/futex/futex_wake01.c     |  1 +
 .../kernel/syscalls/getrusage/getrusage03_child.c  |  1 +
 testcases/kernel/syscalls/inotify/inotify02.c      |  1 +
 .../kernel/syscalls/move_pages/move_pages08.c      |  1 +
 testcases/kernel/syscalls/pselect/pselect01.c      |  2 --
 testcases/kernel/syscalls/sendmsg/sendmsg02.c      |  1 +
 testcases/kernel/syscalls/setgroups/setgroups02.c  |  1 +
 testcases/kernel/syscalls/setgroups/setgroups04.c  |  1 +
 testcases/kernel/syscalls/vmsplice/vmsplice02.c    |  1 +
 testcases/network/lib6/asapi_01.c                  |  4 ---
 testcases/network/lib6/getaddrinfo_01.c            |  1 +
 38 files changed, 74 insertions(+), 14 deletions(-)
 create mode 100644 include/tst_minmax.h

diff --git a/include/old/test.h b/include/old/test.h
index b36764d..137ebb1 100644
--- a/include/old/test.h
+++ b/include/old/test.h
@@ -62,6 +62,7 @@
 #include "tst_clone.h"
 #include "old_device.h"
 #include "old_tmpdir.h"
+#include "tst_minmax.h"
 
 /*
  * Ensure that NUMSIGS is defined.
diff --git a/include/old/usctest.h b/include/old/usctest.h
index 9241d78..9b9446d 100644
--- a/include/old/usctest.h
+++ b/include/old/usctest.h
@@ -34,8 +34,6 @@
 #ifndef __USCTEST_H__
 #define __USCTEST_H__
 
-#include <sys/param.h>
-
 /*
  * Ensure that PATH_MAX is defined
  */
diff --git a/include/tst_minmax.h b/include/tst_minmax.h
new file mode 100644
index 0000000..838c3a8
--- /dev/null
+++ b/include/tst_minmax.h
@@ -0,0 +1,37 @@
+/*
+ * Copyright (c) 2017 Cyril Hrubis <chrubis@suse.cz>
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
+#ifndef TST_MINMAX_H__
+#define TST_MINMAX_H__
+
+#ifndef MIN
+# define MIN(a, b) ({ \
+	typeof(a) _a = (a); \
+	typeof(b) _b = (b); \
+	_a < _b ? _a : _b; \
+})
+#endif /* MIN */
+
+#ifndef MAX
+# define MAX(a, b) ({ \
+	typeof(a) _a = @; \
+	typeof(b) _b = (b); \
+	_a > _b ? _a : _b; \
+})
+#endif /* MAX */
+
+#endif	/* TST_MINMAX_H__ */
diff --git a/include/tst_test.h b/include/tst_test.h
index 335c826..eec8e12 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -38,6 +38,7 @@
 #include "tst_kvercmp.h"
 #include "tst_clone.h"
 #include "tst_kernel.h"
+#include "tst_minmax.h"
 
 /*
  * Reports testcase result.
diff --git a/lib/get_path.c b/lib/get_path.c
index cb8a3b5..aafbc2c 100644
--- a/lib/get_path.c
+++ b/lib/get_path.c
@@ -31,8 +31,6 @@
   * $PATH.
   */
 
-#include "test.h"
-
 #include <stdio.h>
 #include <string.h>
 #include <stdlib.h>
@@ -40,9 +38,7 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 
-#ifndef MIN
-#define MIN(a, b) ((a)<(b)?@:(b))
-#endif
+#include "test.h"
 
 static int file_exist(const char *path)
 {
diff --git a/testcases/kernel/fs/ftest/ftest01.c b/testcases/kernel/fs/ftest/ftest01.c
index f4fcd60..2dfc92a 100644
--- a/testcases/kernel/fs/ftest/ftest01.c
+++ b/testcases/kernel/fs/ftest/ftest01.c
@@ -52,6 +52,7 @@
 #include <sys/types.h>
 #include <sys/wait.h>
 #include <sys/stat.h>
+#include <sys/param.h>
 #include <errno.h>
 #include <fcntl.h>
 #include <signal.h>
diff --git a/testcases/kernel/fs/ftest/ftest05.c b/testcases/kernel/fs/ftest/ftest05.c
index fe3145c..da15c97 100644
--- a/testcases/kernel/fs/ftest/ftest05.c
+++ b/testcases/kernel/fs/ftest/ftest05.c
@@ -61,6 +61,7 @@
 #include <signal.h>
 #include <unistd.h>
 #include <inttypes.h>
+#include <sys/param.h>
 #include "test.h"
 #include "libftest.h"
 
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c
index da8bdb1..71418f1 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c
@@ -58,6 +58,8 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
+#include <limits.h>
+#include <sys/param.h>
 
 #include "test.h"
 #include "hugetlb.h"
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
index d31609d..157ff28 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
@@ -51,6 +51,8 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
+#include <limits.h>
+#include <sys/param.h>
 
 #include "test.h"
 #include "safe_macros.h"
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
index e1f2986..9401650 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
@@ -59,6 +59,8 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
+#include <limits.h>
+#include <sys/param.h>
 
 #include "test.h"
 #include "safe_macros.h"
diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c
index cfb4d72..3208f5c 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c
@@ -56,6 +56,7 @@
  *	none
  */
 
+#include <limits.h>
 #include "hugetlb.h"
 #include "safe_macros.h"
 #include "mem.h"
diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c
index e644178..a8546b1 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c
@@ -51,6 +51,7 @@
  */
 
 #include <pwd.h>
+#include <limits.h>
 #include "hugetlb.h"
 #include "safe_macros.h"
 #include "mem.h"
diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c
index a0cea9a..48f454c 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c
@@ -57,6 +57,7 @@
  *	test must be run at root
  */
 
+#include <limits.h>
 #include "hugetlb.h"
 #include "safe_macros.h"
 #include "mem.h"
diff --git a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
index a54077a..f1e9195 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
@@ -61,6 +61,7 @@
  *	none
  */
 
+#include <limits.h>
 #include "test.h"
 #include "safe_macros.h"
 #include "mem.h"
diff --git a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c
index f5ae366..785c5ca 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c
@@ -53,6 +53,7 @@
  */
 
 #include <pwd.h>
+#include <limits.h>
 #include "test.h"
 #include "safe_macros.h"
 #include "mem.h"
diff --git a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c
index bb2b7e7..1e73027 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c
@@ -60,6 +60,7 @@
 
 #include <sys/types.h>
 #include <sys/wait.h>
+#include <limits.h>
 #include "test.h"
 #include "safe_macros.h"
 #include "mem.h"
diff --git a/testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c b/testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c
index 0ebcca6..45ff286 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c
@@ -58,6 +58,7 @@
  */
 
 #include <setjmp.h>
+#include <limits.h>
 #include "hugetlb.h"
 #include "safe_macros.h"
 #include "mem.h"
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c
index 2367c4d..9da79c1 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c
@@ -58,6 +58,7 @@
  *	none
  */
 
+#include <limits.h>
 #include "hugetlb.h"
 #include "safe_macros.h"
 #include "mem.h"
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c
index 5f2cb31..8b18466 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c
@@ -50,7 +50,7 @@
  * RESTRICTIONS
  *	none
  */
-
+#include <limits.h>
 #include "hugetlb.h"
 #include "safe_macros.h"
 #include "mem.h"
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c
index 402313a..481e26b 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c
@@ -52,6 +52,7 @@
  *	none
  */
 
+#include <limits.h>
 #include "hugetlb.h"
 #include "safe_macros.h"
 #include "mem.h"
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c
index 1a96c3c..8ec4b9e 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c
@@ -60,6 +60,7 @@
 
 #include <sys/types.h>
 #include <sys/wait.h>
+#include <limits.h>
 #include "hugetlb.h"
 #include "safe_macros.h"
 #include "mem.h"
diff --git a/testcases/kernel/mem/ksm/ksm06.c b/testcases/kernel/mem/ksm/ksm06.c
index 2092746..cc34024 100644
--- a/testcases/kernel/mem/ksm/ksm06.c
+++ b/testcases/kernel/mem/ksm/ksm06.c
@@ -43,6 +43,7 @@
 #include <signal.h>
 #include <stdio.h>
 #include <unistd.h>
+#include <limits.h>
 #include "numa_helper.h"
 #include "test.h"
 #include "safe_macros.h"
diff --git a/testcases/kernel/mem/tunable/overcommit_memory.c b/testcases/kernel/mem/tunable/overcommit_memory.c
index 79a3034..5d45fd6 100644
--- a/testcases/kernel/mem/tunable/overcommit_memory.c
+++ b/testcases/kernel/mem/tunable/overcommit_memory.c
@@ -79,6 +79,7 @@
 #include <errno.h>
 #include <stdio.h>
 #include <stdlib.h>
+#include <limits.h>
 #include "test.h"
 #include "safe_macros.h"
 #include "mem.h"
diff --git a/testcases/kernel/mem/vma/vma02.c b/testcases/kernel/mem/vma/vma02.c
index d3c436a..ae35b2a 100644
--- a/testcases/kernel/mem/vma/vma02.c
+++ b/testcases/kernel/mem/vma/vma02.c
@@ -41,6 +41,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
+#include <limits.h>
 #include "test.h"
 #include "safe_macros.h"
 #include "numa_helper.h"
diff --git a/testcases/kernel/mem/vma/vma04.c b/testcases/kernel/mem/vma/vma04.c
index f4f3809..5e2cc91 100644
--- a/testcases/kernel/mem/vma/vma04.c
+++ b/testcases/kernel/mem/vma/vma04.c
@@ -45,6 +45,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
+#include <limits.h>
 #include "test.h"
 #include "safe_macros.h"
 #include "numa_helper.h"
diff --git a/testcases/kernel/syscalls/cma/process_vm_readv03.c b/testcases/kernel/syscalls/cma/process_vm_readv03.c
index 102bcd9..17f0a5d 100644
--- a/testcases/kernel/syscalls/cma/process_vm_readv03.c
+++ b/testcases/kernel/syscalls/cma/process_vm_readv03.c
@@ -28,6 +28,7 @@
 #include <string.h>
 #include <time.h>
 #include <unistd.h>
+#include <limits.h>
 
 #include "test.h"
 #include "safe_macros.h"
diff --git a/testcases/kernel/syscalls/cma/process_vm_writev02.c b/testcases/kernel/syscalls/cma/process_vm_writev02.c
index c37c02c..04cf6d1 100644
--- a/testcases/kernel/syscalls/cma/process_vm_writev02.c
+++ b/testcases/kernel/syscalls/cma/process_vm_writev02.c
@@ -26,6 +26,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
+#include <limits.h>
 
 #include "test.h"
 #include "safe_macros.h"
diff --git a/testcases/kernel/syscalls/futex/futex_wake01.c b/testcases/kernel/syscalls/futex/futex_wake01.c
index b5f1904..42ea6f6 100644
--- a/testcases/kernel/syscalls/futex/futex_wake01.c
+++ b/testcases/kernel/syscalls/futex/futex_wake01.c
@@ -21,6 +21,7 @@
   */
 
 #include <errno.h>
+#include <limits.h>
 
 #include "test.h"
 #include "futextest.h"
diff --git a/testcases/kernel/syscalls/getrusage/getrusage03_child.c b/testcases/kernel/syscalls/getrusage/getrusage03_child.c
index 24a6f33..972c38e4 100644
--- a/testcases/kernel/syscalls/getrusage/getrusage03_child.c
+++ b/testcases/kernel/syscalls/getrusage/getrusage03_child.c
@@ -31,6 +31,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
+#include <limits.h>
 
 #include "test.h"
 #include "safe_macros.h"
diff --git a/testcases/kernel/syscalls/inotify/inotify02.c b/testcases/kernel/syscalls/inotify/inotify02.c
index fde104f..4c51d2b 100644
--- a/testcases/kernel/syscalls/inotify/inotify02.c
+++ b/testcases/kernel/syscalls/inotify/inotify02.c
@@ -38,6 +38,7 @@
 #include <errno.h>
 #include <string.h>
 #include <sys/syscall.h>
+#include <limits.h>
 #include "test.h"
 #include "linux_syscall_numbers.h"
 #include "inotify.h"
diff --git a/testcases/kernel/syscalls/move_pages/move_pages08.c b/testcases/kernel/syscalls/move_pages/move_pages08.c
index e0705a2..66544eb 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages08.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages08.c
@@ -54,6 +54,7 @@
 #include <sys/wait.h>
 #include <unistd.h>
 #include <errno.h>
+#include <limits.h>
 #include "test.h"
 #include "move_pages_support.h"
 
diff --git a/testcases/kernel/syscalls/pselect/pselect01.c b/testcases/kernel/syscalls/pselect/pselect01.c
index 9a6a309..1e8ecce 100644
--- a/testcases/kernel/syscalls/pselect/pselect01.c
+++ b/testcases/kernel/syscalls/pselect/pselect01.c
@@ -51,8 +51,6 @@ static struct tcase tcases[] = {
 	{{1, 0},          1},
 };
 
-#define MIN(a, b) ((a) < (b) ? @ : (b))
-
 /*
  * The threshold per one syscall is computed as a sum of:
  *
diff --git a/testcases/kernel/syscalls/sendmsg/sendmsg02.c b/testcases/kernel/syscalls/sendmsg/sendmsg02.c
index 0285352..aa3c88d 100644
--- a/testcases/kernel/syscalls/sendmsg/sendmsg02.c
+++ b/testcases/kernel/syscalls/sendmsg/sendmsg02.c
@@ -41,6 +41,7 @@
 #include <sys/wait.h>
 #include <errno.h>
 #include <signal.h>
+#include <limits.h>
 #include "config.h"
 #include "test.h"
 #include "safe_macros.h"
diff --git a/testcases/kernel/syscalls/setgroups/setgroups02.c b/testcases/kernel/syscalls/setgroups/setgroups02.c
index d7667b9..de23a4a 100644
--- a/testcases/kernel/syscalls/setgroups/setgroups02.c
+++ b/testcases/kernel/syscalls/setgroups/setgroups02.c
@@ -69,6 +69,7 @@
 #include <errno.h>
 #include <pwd.h>
 #include <grp.h>
+#include <sys/param.h>
 
 #include "test.h"
 
diff --git a/testcases/kernel/syscalls/setgroups/setgroups04.c b/testcases/kernel/syscalls/setgroups/setgroups04.c
index 2af410f..971c86b 100644
--- a/testcases/kernel/syscalls/setgroups/setgroups04.c
+++ b/testcases/kernel/syscalls/setgroups/setgroups04.c
@@ -62,6 +62,7 @@
  *
  */
 #include <sys/types.h>
+#include <sys/param.h>
 #include <unistd.h>
 #include <errno.h>
 #include <pwd.h>
diff --git a/testcases/kernel/syscalls/vmsplice/vmsplice02.c b/testcases/kernel/syscalls/vmsplice/vmsplice02.c
index bd14b00..f8af0ac 100644
--- a/testcases/kernel/syscalls/vmsplice/vmsplice02.c
+++ b/testcases/kernel/syscalls/vmsplice/vmsplice02.c
@@ -33,6 +33,7 @@
 #include <unistd.h>
 #include <fcntl.h>
 #include <sys/uio.h>
+#include <limits.h>
 
 #include "test.h"
 #include "safe_macros.h"
diff --git a/testcases/network/lib6/asapi_01.c b/testcases/network/lib6/asapi_01.c
index ff310ea..a34b8ae 100644
--- a/testcases/network/lib6/asapi_01.c
+++ b/testcases/network/lib6/asapi_01.c
@@ -373,10 +373,6 @@ static void isocketpair(int pf, int type, int proto, int fd[2])
 	fd[1] = connect_fd;
 }
 
-#ifndef MAX
-#define MAX(a, b) ((a) >= (b) ? (a) : (b))
-#endif /* MAX */
-
 static void csum_test(void)
 {
 	fd_set rset, rset_save;
diff --git a/testcases/network/lib6/getaddrinfo_01.c b/testcases/network/lib6/getaddrinfo_01.c
index bbf8f77..db252a9 100644
--- a/testcases/network/lib6/getaddrinfo_01.c
+++ b/testcases/network/lib6/getaddrinfo_01.c
@@ -24,6 +24,7 @@
 #include <sys/socket.h>
 #include <netdb.h>
 #include <arpa/inet.h>
+#include <sys/param.h>
 
 #include "test.h"
 
-- 
2.10.2


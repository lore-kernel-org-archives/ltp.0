From: Xie Ziyao <xieziyao@huawei.com>
Date: Thu, 3 Jun 2021 11:36:11 +0800
Subject: [LTP] [PATCH 3/3] syscalls/sendfile: Remove unnecessary header files
In-Reply-To: <20210603033611.15619-1-xieziyao@huawei.com>
References: <20210603033611.15619-1-xieziyao@huawei.com>
Message-ID: <20210603033611.15619-4-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Remove unnecessary header files for sendfile{03, 04, 05, 07}

Signed-off-by: Xie Ziyao <xieziyao@huawei.com>
---
 testcases/kernel/syscalls/sendfile/sendfile03.c | 3 ---
 testcases/kernel/syscalls/sendfile/sendfile04.c | 9 ---------
 testcases/kernel/syscalls/sendfile/sendfile05.c | 9 ---------
 testcases/kernel/syscalls/sendfile/sendfile07.c | 9 ---------
 4 files changed, 30 deletions(-)

diff --git a/testcases/kernel/syscalls/sendfile/sendfile03.c b/testcases/kernel/syscalls/sendfile/sendfile03.c
index 8783a6c34..3b93dc62e 100644
--- a/testcases/kernel/syscalls/sendfile/sendfile03.c
+++ b/testcases/kernel/syscalls/sendfile/sendfile03.c
@@ -18,9 +18,6 @@
  * - out_fd opened with O_RDONLY
  */

-#include <stdio.h>
-#include <errno.h>
-#include <fcntl.h>
 #include <sys/sendfile.h>

 #include "tst_test.h"
diff --git a/testcases/kernel/syscalls/sendfile/sendfile04.c b/testcases/kernel/syscalls/sendfile/sendfile04.c
index 67d004c74..97e79eadd 100644
--- a/testcases/kernel/syscalls/sendfile/sendfile04.c
+++ b/testcases/kernel/syscalls/sendfile/sendfile04.c
@@ -18,16 +18,7 @@
  * - a protected buffer is created by mmap with specifying protection
  */

-#include <stdio.h>
-#include <errno.h>
-#include <fcntl.h>
-#include <sys/stat.h>
 #include <sys/sendfile.h>
-#include <sys/types.h>
-#include <sys/socket.h>
-#include <sys/mman.h>
-#include <netinet/in.h>
-#include <arpa/inet.h>

 #include "tst_test.h"

diff --git a/testcases/kernel/syscalls/sendfile/sendfile05.c b/testcases/kernel/syscalls/sendfile/sendfile05.c
index 99c91f660..684536396 100644
--- a/testcases/kernel/syscalls/sendfile/sendfile05.c
+++ b/testcases/kernel/syscalls/sendfile/sendfile05.c
@@ -16,16 +16,7 @@
  * Call sendfile with offset = -1.
  */

-#include <stdio.h>
-#include <errno.h>
-#include <fcntl.h>
-#include <sys/stat.h>
 #include <sys/sendfile.h>
-#include <sys/types.h>
-#include <sys/socket.h>
-#include <sys/mman.h>
-#include <netinet/in.h>
-#include <arpa/inet.h>

 #include "tst_test.h"

diff --git a/testcases/kernel/syscalls/sendfile/sendfile07.c b/testcases/kernel/syscalls/sendfile/sendfile07.c
index e8bf022a7..c75dea768 100644
--- a/testcases/kernel/syscalls/sendfile/sendfile07.c
+++ b/testcases/kernel/syscalls/sendfile/sendfile07.c
@@ -12,16 +12,7 @@
  * when passing full out_fd opened with O_NONBLOCK.
  */

-#include <stdio.h>
-#include <errno.h>
-#include <fcntl.h>
-#include <sys/stat.h>
 #include <sys/sendfile.h>
-#include <sys/types.h>
-#include <sys/socket.h>
-#include <sys/mman.h>
-#include <netinet/in.h>
-#include <arpa/inet.h>

 #include "tst_test.h"

--
2.17.1


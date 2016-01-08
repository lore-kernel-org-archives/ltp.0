From: Khem Raj <raj.khem@gmail.com>
Date: Fri,  8 Jan 2016 08:11:41 +0000
Subject: [LTP] [PATCH 21/31] Include sys/types.h for MREMAP_MAYMOVE
	definition
In-Reply-To: <1452240711-51180-1-git-send-email-raj.khem@gmail.com>
References: <1452240711-51180-1-git-send-email-raj.khem@gmail.com>
Message-ID: <1452240711-51180-21-git-send-email-raj.khem@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Fixes errors like
error: 'MREMAP_MAYMOVE' undeclared (first use in this function)

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 testcases/kernel/syscalls/mremap/mremap01.c | 5 +++--
 testcases/kernel/syscalls/mremap/mremap02.c | 5 +++--
 testcases/kernel/syscalls/mremap/mremap03.c | 5 +++--
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/syscalls/mremap/mremap01.c b/testcases/kernel/syscalls/mremap/mremap01.c
index d63d1e4..46438d1 100644
--- a/testcases/kernel/syscalls/mremap/mremap01.c
+++ b/testcases/kernel/syscalls/mremap/mremap01.c
@@ -74,12 +74,13 @@
  * RESTRICTIONS:
  *  None.
  */
+#define _GNU_SOURCE
 #include <unistd.h>
 #include <errno.h>
-#define __USE_GNU
 #include <sys/mman.h>
-#undef __USE_GNU
+#undef _GNU_SOURCE
 #include <fcntl.h>
+#include <sys/types.h>
 
 #include "test.h"
 
diff --git a/testcases/kernel/syscalls/mremap/mremap02.c b/testcases/kernel/syscalls/mremap/mremap02.c
index 5a51b9a..6808d9b 100644
--- a/testcases/kernel/syscalls/mremap/mremap02.c
+++ b/testcases/kernel/syscalls/mremap/mremap02.c
@@ -72,12 +72,13 @@
  * RESTRICTIONS:
  *  None.
  */
+#define _GNU_SOURCE
 #include <errno.h>
 #include <unistd.h>
 #include <fcntl.h>
-#define __USE_GNU
 #include <sys/mman.h>
-#undef __USE_GNU
+#include <sys/types.h>
+#undef _GNU_SOURCE
 
 #include "test.h"
 
diff --git a/testcases/kernel/syscalls/mremap/mremap03.c b/testcases/kernel/syscalls/mremap/mremap03.c
index 12e3829..4b34a6a 100644
--- a/testcases/kernel/syscalls/mremap/mremap03.c
+++ b/testcases/kernel/syscalls/mremap/mremap03.c
@@ -73,12 +73,13 @@
  * RESTRICTIONS:
  *  None.
  */
+#define _GNU_SOURCE
 #include <errno.h>
 #include <unistd.h>
 #include <fcntl.h>
-#define __USE_GNU
 #include <sys/mman.h>
-#undef __USE_GNU
+#include <sys/types.h>
+#undef _GNU_SOURCE
 
 #include "test.h"
 
-- 
2.7.0


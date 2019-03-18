From: Petr Vorel <petr.vorel@gmail.com>
Date: Mon, 18 Mar 2019 04:23:29 +0100
Subject: [LTP] [PATCH 4/5] mremap: Define _GNU_SOURCE to get MREMAP_MAYMOVE
	on MUSL
In-Reply-To: <20190318032330.3346-1-petr.vorel@gmail.com>
References: <20190318032330.3346-1-petr.vorel@gmail.com>
Message-ID: <20190318032330.3346-5-petr.vorel@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Unlike glibc and uclibc (which define MREMAP_MAYMOVE under __USE_MISC)
MUSL requires _GNU_SOURCE.
+ Remove __USE_GNU

Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
---
 testcases/kernel/syscalls/mremap/mremap01.c | 4 ++--
 testcases/kernel/syscalls/mremap/mremap02.c | 3 +--
 testcases/kernel/syscalls/mremap/mremap03.c | 3 +--
 testcases/kernel/syscalls/mremap/mremap04.c | 3 +--
 4 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/testcases/kernel/syscalls/mremap/mremap01.c b/testcases/kernel/syscalls/mremap/mremap01.c
index 16519a23c..4c795fee5 100644
--- a/testcases/kernel/syscalls/mremap/mremap01.c
+++ b/testcases/kernel/syscalls/mremap/mremap01.c
@@ -74,11 +74,11 @@
  * RESTRICTIONS:
  *  None.
  */
+
+#define _GNU_SOURCE
 #include <unistd.h>
 #include <errno.h>
-#define __USE_GNU
 #include <sys/mman.h>
-#undef __USE_GNU
 #include <fcntl.h>
 
 #include "test.h"
diff --git a/testcases/kernel/syscalls/mremap/mremap02.c b/testcases/kernel/syscalls/mremap/mremap02.c
index 5a51b9aff..2dabc6847 100644
--- a/testcases/kernel/syscalls/mremap/mremap02.c
+++ b/testcases/kernel/syscalls/mremap/mremap02.c
@@ -72,12 +72,11 @@
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
 
 #include "test.h"
 
diff --git a/testcases/kernel/syscalls/mremap/mremap03.c b/testcases/kernel/syscalls/mremap/mremap03.c
index 4c9c7b069..02b79bc47 100644
--- a/testcases/kernel/syscalls/mremap/mremap03.c
+++ b/testcases/kernel/syscalls/mremap/mremap03.c
@@ -73,12 +73,11 @@
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
 
 #include "test.h"
 
diff --git a/testcases/kernel/syscalls/mremap/mremap04.c b/testcases/kernel/syscalls/mremap/mremap04.c
index c25dbfeb4..53902df73 100644
--- a/testcases/kernel/syscalls/mremap/mremap04.c
+++ b/testcases/kernel/syscalls/mremap/mremap04.c
@@ -77,11 +77,10 @@
  * RESTRICTIONS:
  *  None.
  */
+#define _GNU_SOURCE
 #include <errno.h>
 #include <unistd.h>
-#define __USE_GNU
 #include <sys/mman.h>
-#undef __USE_GNU
 #include <sys/ipc.h>
 #include <sys/shm.h>
 
-- 
2.20.1


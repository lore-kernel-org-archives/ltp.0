From: Jozef Pupava <jpupava@suse.cz>
Date: Wed, 25 Mar 2020 11:01:48 +0100
Subject: [LTP] [PATCH] Replace deprecated <strings.h> with <string.h>
Message-ID: <20200325110148.07f0a740@daedruan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

I guess this won't really solve anything, just the issue.

Closes: #521

Signed-off-by: Jozef Pupava <jpupava@suse.com>
---
 testcases/kernel/containers/share/ns_create.c                           | 2 +-
 testcases/kernel/fs/fsx-linux/fsx-linux.c                               | 2 +-
 .../open_posix_testsuite/conformance/interfaces/sem_timedwait/3-1.c     | 2 +-
 .../open_posix_testsuite/conformance/interfaces/sem_timedwait/7-1.c     | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/containers/share/ns_create.c b/testcases/kernel/containers/share/ns_create.c
index 1d0339e71..4a4007c3a 100644
--- a/testcases/kernel/containers/share/ns_create.c
+++ b/testcases/kernel/containers/share/ns_create.c
@@ -30,7 +30,7 @@
 #include <sys/stat.h>
 #include <unistd.h>
 #include <string.h>
-#include <strings.h>
+#include <string.h>
 #include <errno.h>
 #include "test.h"
 #include "lapi/namespaces_constants.h"
diff --git a/testcases/kernel/fs/fsx-linux/fsx-linux.c b/testcases/kernel/fs/fsx-linux/fsx-linux.c
index 02f3eb827..4a20f4da6 100644
--- a/testcases/kernel/fs/fsx-linux/fsx-linux.c
+++ b/testcases/kernel/fs/fsx-linux/fsx-linux.c
@@ -43,7 +43,7 @@
 #include <sys/param.h>
 #include <limits.h>
 #include <time.h>
-#include <strings.h>
+#include <string.h>
 #include <sys/time.h>
 #endif
 #include <fcntl.h>
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sem_timedwait/3-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sem_timedwait/3-1.c
index dd42bbd91..97bdbff5d 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sem_timedwait/3-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sem_timedwait/3-1.c
@@ -20,7 +20,7 @@
 #endif
 #include <semaphore.h>
 #include <stdio.h>
-#include <strings.h>
+#include <string.h>
 #include <time.h>
 #include <unistd.h>
 #include "posixtest.h"
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sem_timedwait/7-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sem_timedwait/7-1.c
index 79de0af7f..da2cd3084 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sem_timedwait/7-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sem_timedwait/7-1.c
@@ -21,7 +21,7 @@
 #endif
 #include <semaphore.h>
 #include <stdio.h>
-#include <strings.h>
+#include <string.h>
 #include <time.h>
 #include <unistd.h>
 #include "posixtest.h"
-- 
2.16.4

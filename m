From: Khem Raj <raj.khem@gmail.com>
Date: Thu, 21 Jul 2016 21:26:36 -0700
Subject: [LTP] [PATCH V3 03/23] Remove including error.h, its unused
In-Reply-To: <20160722042656.22346-1-raj.khem@gmail.com>
References: <20160722042656.22346-1-raj.khem@gmail.com>
Message-ID: <20160722042656.22346-3-raj.khem@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 testcases/kernel/syscalls/faccessat/faccessat01.c   | 1 -
 testcases/kernel/syscalls/fallocate/fallocate01.c   | 1 -
 testcases/kernel/syscalls/fchmodat/fchmodat01.c     | 1 -
 testcases/kernel/syscalls/fchownat/fchownat01.c     | 1 -
 testcases/kernel/syscalls/fchownat/fchownat02.c     | 1 -
 testcases/kernel/syscalls/fstatat/fstatat01.c       | 1 -
 testcases/kernel/syscalls/futimesat/futimesat01.c   | 1 -
 testcases/kernel/syscalls/linkat/linkat01.c         | 1 -
 testcases/kernel/syscalls/linkat/linkat02.c         | 1 -
 testcases/kernel/syscalls/mkdirat/mkdirat01.c       | 1 -
 testcases/kernel/syscalls/mknodat/mknodat01.c       | 1 -
 testcases/kernel/syscalls/mknodat/mknodat02.c       | 1 -
 testcases/kernel/syscalls/openat/openat01.c         | 1 -
 testcases/kernel/syscalls/readlinkat/readlinkat01.c | 1 -
 testcases/kernel/syscalls/renameat/renameat01.c     | 1 -
 testcases/kernel/syscalls/symlinkat/symlinkat01.c   | 1 -
 testcases/kernel/syscalls/unlinkat/unlinkat01.c     | 1 -
 17 files changed, 17 deletions(-)

diff --git a/testcases/kernel/syscalls/faccessat/faccessat01.c b/testcases/kernel/syscalls/faccessat/faccessat01.c
index c9ab020..622dfd3 100644
--- a/testcases/kernel/syscalls/faccessat/faccessat01.c
+++ b/testcases/kernel/syscalls/faccessat/faccessat01.c
@@ -37,7 +37,6 @@
 #include <sys/stat.h>
 #include <fcntl.h>
 #include <unistd.h>
-#include <error.h>
 #include <stdlib.h>
 #include <errno.h>
 #include <string.h>
diff --git a/testcases/kernel/syscalls/fallocate/fallocate01.c b/testcases/kernel/syscalls/fallocate/fallocate01.c
index e72b123..c99e799 100644
--- a/testcases/kernel/syscalls/fallocate/fallocate01.c
+++ b/testcases/kernel/syscalls/fallocate/fallocate01.c
@@ -96,7 +96,6 @@
 #include <fcntl.h>
 #include <sys/syscall.h>
 #include <unistd.h>
-#include <error.h>
 #include <inttypes.h>
 #include <sys/utsname.h>
 
diff --git a/testcases/kernel/syscalls/fchmodat/fchmodat01.c b/testcases/kernel/syscalls/fchmodat/fchmodat01.c
index 0b35bf9..6bf66d8 100644
--- a/testcases/kernel/syscalls/fchmodat/fchmodat01.c
+++ b/testcases/kernel/syscalls/fchmodat/fchmodat01.c
@@ -37,7 +37,6 @@
 #include <sys/stat.h>
 #include <fcntl.h>
 #include <unistd.h>
-#include <error.h>
 #include <stdlib.h>
 #include <errno.h>
 #include <string.h>
diff --git a/testcases/kernel/syscalls/fchownat/fchownat01.c b/testcases/kernel/syscalls/fchownat/fchownat01.c
index b361253..9f4ecde 100644
--- a/testcases/kernel/syscalls/fchownat/fchownat01.c
+++ b/testcases/kernel/syscalls/fchownat/fchownat01.c
@@ -28,7 +28,6 @@
 #include <sys/stat.h>
 #include <fcntl.h>
 #include <unistd.h>
-#include <error.h>
 #include <stdlib.h>
 #include <errno.h>
 #include <string.h>
diff --git a/testcases/kernel/syscalls/fchownat/fchownat02.c b/testcases/kernel/syscalls/fchownat/fchownat02.c
index 6b0304c..d19f3f3 100644
--- a/testcases/kernel/syscalls/fchownat/fchownat02.c
+++ b/testcases/kernel/syscalls/fchownat/fchownat02.c
@@ -26,7 +26,6 @@
 #include <sys/stat.h>
 #include <fcntl.h>
 #include <unistd.h>
-#include <error.h>
 #include <stdlib.h>
 #include <errno.h>
 #include <string.h>
diff --git a/testcases/kernel/syscalls/fstatat/fstatat01.c b/testcases/kernel/syscalls/fstatat/fstatat01.c
index 128f6dd..840d7b6 100644
--- a/testcases/kernel/syscalls/fstatat/fstatat01.c
+++ b/testcases/kernel/syscalls/fstatat/fstatat01.c
@@ -28,7 +28,6 @@
 #include <sys/stat.h>
 #include <sys/time.h>
 #include <fcntl.h>
-#include <error.h>
 #include <stdlib.h>
 #include <errno.h>
 #include <string.h>
diff --git a/testcases/kernel/syscalls/futimesat/futimesat01.c b/testcases/kernel/syscalls/futimesat/futimesat01.c
index 858212f..514cfcf 100644
--- a/testcases/kernel/syscalls/futimesat/futimesat01.c
+++ b/testcases/kernel/syscalls/futimesat/futimesat01.c
@@ -28,7 +28,6 @@
 #include <sys/stat.h>
 #include <sys/time.h>
 #include <fcntl.h>
-#include <error.h>
 #include <stdlib.h>
 #include <errno.h>
 #include <string.h>
diff --git a/testcases/kernel/syscalls/linkat/linkat01.c b/testcases/kernel/syscalls/linkat/linkat01.c
index fc0687b..0e82f7f 100644
--- a/testcases/kernel/syscalls/linkat/linkat01.c
+++ b/testcases/kernel/syscalls/linkat/linkat01.c
@@ -49,7 +49,6 @@
 #include <sys/time.h>
 #include <fcntl.h>
 #include <unistd.h>
-#include <error.h>
 #include <stdlib.h>
 #include <errno.h>
 #include <string.h>
diff --git a/testcases/kernel/syscalls/linkat/linkat02.c b/testcases/kernel/syscalls/linkat/linkat02.c
index 5fdf7e2..6766b5a 100644
--- a/testcases/kernel/syscalls/linkat/linkat02.c
+++ b/testcases/kernel/syscalls/linkat/linkat02.c
@@ -23,7 +23,6 @@
 #include <sys/stat.h>
 #include <fcntl.h>
 #include <unistd.h>
-#include <error.h>
 #include <stdlib.h>
 #include <errno.h>
 #include <string.h>
diff --git a/testcases/kernel/syscalls/mkdirat/mkdirat01.c b/testcases/kernel/syscalls/mkdirat/mkdirat01.c
index 7e15947..a323ed5 100644
--- a/testcases/kernel/syscalls/mkdirat/mkdirat01.c
+++ b/testcases/kernel/syscalls/mkdirat/mkdirat01.c
@@ -30,7 +30,6 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <fcntl.h>
-#include <error.h>
 #include <stdlib.h>
 #include <errno.h>
 #include <string.h>
diff --git a/testcases/kernel/syscalls/mknodat/mknodat01.c b/testcases/kernel/syscalls/mknodat/mknodat01.c
index 26e5538..2e13c77 100644
--- a/testcases/kernel/syscalls/mknodat/mknodat01.c
+++ b/testcases/kernel/syscalls/mknodat/mknodat01.c
@@ -29,7 +29,6 @@
 #include <sys/types.h>
 #include <fcntl.h>
 #include <sys/stat.h>
-#include <error.h>
 #include <stdlib.h>
 #include <errno.h>
 #include <string.h>
diff --git a/testcases/kernel/syscalls/mknodat/mknodat02.c b/testcases/kernel/syscalls/mknodat/mknodat02.c
index 7913872..0216aa2 100644
--- a/testcases/kernel/syscalls/mknodat/mknodat02.c
+++ b/testcases/kernel/syscalls/mknodat/mknodat02.c
@@ -29,7 +29,6 @@
 #include <sys/types.h>
 #include <fcntl.h>
 #include <sys/stat.h>
-#include <error.h>
 #include <stdlib.h>
 #include <errno.h>
 #include <string.h>
diff --git a/testcases/kernel/syscalls/openat/openat01.c b/testcases/kernel/syscalls/openat/openat01.c
index 85f9a91..0441c3a 100644
--- a/testcases/kernel/syscalls/openat/openat01.c
+++ b/testcases/kernel/syscalls/openat/openat01.c
@@ -29,7 +29,6 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <fcntl.h>
-#include <error.h>
 #include <stdlib.h>
 #include <errno.h>
 #include <string.h>
diff --git a/testcases/kernel/syscalls/readlinkat/readlinkat01.c b/testcases/kernel/syscalls/readlinkat/readlinkat01.c
index 97a49e8..985890e 100644
--- a/testcases/kernel/syscalls/readlinkat/readlinkat01.c
+++ b/testcases/kernel/syscalls/readlinkat/readlinkat01.c
@@ -29,7 +29,6 @@
 #include <sys/stat.h>
 #include <sys/time.h>
 #include <fcntl.h>
-#include <error.h>
 #include <stdlib.h>
 #include <errno.h>
 #include <string.h>
diff --git a/testcases/kernel/syscalls/renameat/renameat01.c b/testcases/kernel/syscalls/renameat/renameat01.c
index 18b83d8..f6797da 100644
--- a/testcases/kernel/syscalls/renameat/renameat01.c
+++ b/testcases/kernel/syscalls/renameat/renameat01.c
@@ -42,7 +42,6 @@
 #include <sys/stat.h>
 #include <sys/time.h>
 #include <fcntl.h>
-#include <error.h>
 #include <stdlib.h>
 #include <errno.h>
 #include <string.h>
diff --git a/testcases/kernel/syscalls/symlinkat/symlinkat01.c b/testcases/kernel/syscalls/symlinkat/symlinkat01.c
index 5c238d8..e09ca10 100644
--- a/testcases/kernel/syscalls/symlinkat/symlinkat01.c
+++ b/testcases/kernel/syscalls/symlinkat/symlinkat01.c
@@ -37,7 +37,6 @@
 #include <sys/stat.h>
 #include <sys/time.h>
 #include <fcntl.h>
-#include <error.h>
 #include <stdlib.h>
 #include <errno.h>
 #include <string.h>
diff --git a/testcases/kernel/syscalls/unlinkat/unlinkat01.c b/testcases/kernel/syscalls/unlinkat/unlinkat01.c
index 5559650..cfc9c4d 100644
--- a/testcases/kernel/syscalls/unlinkat/unlinkat01.c
+++ b/testcases/kernel/syscalls/unlinkat/unlinkat01.c
@@ -29,7 +29,6 @@
 #include <sys/stat.h>
 #include <sys/time.h>
 #include <fcntl.h>
-#include <error.h>
 #include <stdlib.h>
 #include <errno.h>
 #include <string.h>
-- 
2.9.0


From: Petr Vorel <petr.vorel@gmail.com>
Date: Mon, 18 Mar 2019 04:23:27 +0100
Subject: [LTP] [PATCH 2/5] {rt_,
	}sigaction: Define _GNU_SOURCE to get SA_NOMASK on MUSL
In-Reply-To: <20190318032330.3346-1-petr.vorel@gmail.com>
References: <20190318032330.3346-1-petr.vorel@gmail.com>
Message-ID: <20190318032330.3346-3-petr.vorel@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Unlike glibc and uclibc (which define SA_NOMASK under __USE_MISC)
MUSL requires _GNU_SOURCE.

_GNU_SOURCE is already used in crash02.c.

Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
---
 testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c | 1 +
 testcases/kernel/syscalls/rt_sigaction/rt_sigaction02.c | 1 +
 testcases/kernel/syscalls/rt_sigaction/rt_sigaction03.c | 1 +
 testcases/kernel/syscalls/sigaction/sigaction02.c       | 2 ++
 testcases/misc/crash/crash01.c                          | 1 +
 5 files changed, 6 insertions(+)

diff --git a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c
index be9e9abb7..fa50af319 100644
--- a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c
+++ b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c
@@ -28,6 +28,7 @@
 /*		sigset_t type.                       			      */
 /******************************************************************************/
 
+#define _GNU_SOURCE
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
diff --git a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction02.c b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction02.c
index 2c4d8799b..09e351957 100644
--- a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction02.c
+++ b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction02.c
@@ -24,6 +24,7 @@
 /*		rt_sigaction Expected EFAULT error check                      */
 /******************************************************************************/
 
+#define _GNU_SOURCE
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
diff --git a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction03.c b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction03.c
index 823fbe6c2..6e7865c07 100644
--- a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction03.c
+++ b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction03.c
@@ -24,6 +24,7 @@
 /*		rt_sigaction Expected EINVAL error check                      */
 /******************************************************************************/
 
+#define _GNU_SOURCE
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
diff --git a/testcases/kernel/syscalls/sigaction/sigaction02.c b/testcases/kernel/syscalls/sigaction/sigaction02.c
index 641a04eca..aaf716b15 100644
--- a/testcases/kernel/syscalls/sigaction/sigaction02.c
+++ b/testcases/kernel/syscalls/sigaction/sigaction02.c
@@ -49,6 +49,8 @@
  *	This test doesn't follow the correct LTP format - PLEASE FIX!
  */
 #define DEBUG 0
+
+#define _GNU_SOURCE
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
diff --git a/testcases/misc/crash/crash01.c b/testcases/misc/crash/crash01.c
index 05745214c..192fbc32c 100644
--- a/testcases/misc/crash/crash01.c
+++ b/testcases/misc/crash/crash01.c
@@ -50,6 +50,7 @@ benchmark.
 
 */
 
+#define _GNU_SOURCE
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-- 
2.20.1


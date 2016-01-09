From: Khem Raj <raj.khem@gmail.com>
Date: Sat,  9 Jan 2016 01:14:12 +0000
Subject: [LTP] [PATCH V2 24/32] rt_sigaction/rt_sigprocmark: Define
	_GNU_SOURCE
In-Reply-To: <1452302060-103643-1-git-send-email-raj.khem@gmail.com>
References: <1452302060-103643-1-git-send-email-raj.khem@gmail.com>
Message-ID: <1452302060-103643-24-git-send-email-raj.khem@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Fixes musl build failure e.g.
error: 'SA_NOMASK' undeclared here (not in a function)

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c     | 1 +
 testcases/kernel/syscalls/rt_sigaction/rt_sigaction02.c     | 2 +-
 testcases/kernel/syscalls/rt_sigaction/rt_sigaction03.c     | 1 +
 testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask01.c | 1 +
 4 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c
index 5cf89cc..bdcb91a 100644
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
index a1da743..8a27a0f 100644
--- a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction02.c
+++ b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction02.c
@@ -23,7 +23,7 @@
 /* Description: This tests the rt_sigaction() syscall                         */
 /*		rt_sigaction Expected EFAULT error check                      */
 /******************************************************************************/
-
+#define _GNU_SOURCE
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
diff --git a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction03.c b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction03.c
index 175d220..e7627cd 100644
--- a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction03.c
+++ b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction03.c
@@ -24,6 +24,7 @@
 /*		rt_sigaction Expected EINVAL error check                      */
 /******************************************************************************/
 
+#define _GNU_SOURCE
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
diff --git a/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask01.c b/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask01.c
index 74e5a61..75c57fc 100644
--- a/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask01.c
+++ b/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask01.c
@@ -39,6 +39,7 @@
 /*		    sigsetsize should indicate the size of a sigset_t type.   */
 /******************************************************************************/
 
+#define _GNU_SOURCE
 #include <stdio.h>
 #include <signal.h>
 #include <errno.h>
-- 
2.7.0


From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 17 Jan 2020 12:37:13 +0100
Subject: [LTP] [PATCH 1/3] pidfd_send_signal: Build with _GNU_SOURCE
In-Reply-To: <20200117113715.22786-1-pvorel@suse.cz>
References: <20200117113715.22786-1-pvorel@suse.cz>
Message-ID: <20200117113715.22786-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This adds missing O_CLOEXEC and O_DIRECTORY on old distros,
where it's (in glibc) guarded under __USE_GNU.

This was needed on SLES 11 (glibc 2.11).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .../kernel/syscalls/pidfd_send_signal/pidfd_send_signal01.c      | 1 +
 .../kernel/syscalls/pidfd_send_signal/pidfd_send_signal02.c      | 1 +
 .../kernel/syscalls/pidfd_send_signal/pidfd_send_signal03.c      | 1 +
 3 files changed, 3 insertions(+)

diff --git a/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal01.c b/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal01.c
index f03905894..b529551d2 100644
--- a/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal01.c
+++ b/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal01.c
@@ -9,6 +9,7 @@
  * struct is passed.
  */
 
+#define _GNU_SOURCE
 #include <signal.h>
 #include <stdlib.h>
 #include "tst_safe_pthread.h"
diff --git a/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal02.c b/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal02.c
index c933ada84..74914523f 100644
--- a/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal02.c
+++ b/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal02.c
@@ -21,6 +21,7 @@
  *    -> EPERM
  */
 
+#define _GNU_SOURCE
 #include <pwd.h>
 #include <signal.h>
 #include "tst_safe_pthread.h"
diff --git a/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal03.c b/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal03.c
index 19d943d06..3420afbb9 100644
--- a/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal03.c
+++ b/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal03.c
@@ -15,6 +15,7 @@
  * child using the pidfd of the first one.
  */
 
+#define _GNU_SOURCE
 #include <signal.h>
 #include <stdio.h>
 #include <unistd.h>
-- 
2.24.1


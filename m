From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 16 Jul 2019 16:32:38 +0200
Subject: [LTP] [COMMITTED] [PATCH] syscalls/prctl07: Fix build.
Message-ID: <20190716143238.483-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Ideally this is last fix for prctl07.

Since I've changed the check_proc_capamb() to use macro definition
instead of raw integer value we depend on sys/capability.h being
included to compile the code.

So this commit changes:

The sys/capability.h is included under HAVE_SYS_CAPABILITY_H now and so
the function is ifdefed out if we don't have that header.

Also it looks like HAVE_LIBCAP is not defined unless libcap supports
cap_compare() which should be fixed. The check for libcap and
cap_compare() has to be uncoupled but that has to be done in a sepratate
patch.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/prctl/prctl07.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/prctl/prctl07.c b/testcases/kernel/syscalls/prctl/prctl07.c
index 37d77df33..79f7710a8 100644
--- a/testcases/kernel/syscalls/prctl/prctl07.c
+++ b/testcases/kernel/syscalls/prctl/prctl07.c
@@ -25,7 +25,7 @@
 #include <sys/prctl.h>
 #include <stdlib.h>
 #include "config.h"
-#ifdef HAVE_LIBCAP
+#ifdef HAVE_SYS_CAPABILITY_H
 # include <sys/capability.h>
 #endif
 #include "lapi/syscalls.h"
@@ -35,7 +35,8 @@
 
 #define PROC_STATUS "/proc/self/status"
 
-static inline void check_proc_capamb(char *message, int flag)
+#ifdef HAVE_SYS_CAPABILITY_H
+static void check_proc_capamb(char *message, int flag)
 {
 	int cap_num;
 	char CapAmb[20];
@@ -62,6 +63,7 @@ static inline void check_proc_capamb(char *message, int flag)
 			"%s, CapAmb in %s doesn't have CAP_NET_BIND_SERVICE",
 			message, PROC_STATUS);
 }
+#endif
 
 static inline void check_cap_raise(unsigned int cap, char *message, int fail_flag)
 {
-- 
2.21.0


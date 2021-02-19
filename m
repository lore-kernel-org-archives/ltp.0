From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 19 Feb 2021 15:47:03 +0100
Subject: [LTP] [PATCH 1/2] libclone: Move test.h include to C file
In-Reply-To: <20210219144704.20433-1-pvorel@suse.cz>
References: <20210219144704.20433-1-pvorel@suse.cz>
Message-ID: <20210219144704.20433-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

so that libclone.h can be used in new API tests.

This requires to include test.sh earlier in mqns_helper.h.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/containers/libclone/libclone.c | 1 +
 testcases/kernel/containers/libclone/libclone.h | 1 -
 testcases/kernel/containers/mqns/mqns_helper.h  | 2 +-
 3 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/containers/libclone/libclone.c b/testcases/kernel/containers/libclone/libclone.c
index 239674ff8..8ffde0ffc 100644
--- a/testcases/kernel/containers/libclone/libclone.c
+++ b/testcases/kernel/containers/libclone/libclone.c
@@ -15,6 +15,7 @@
 *
 ***************************************************************************/
 #include "libclone.h"
+#include "test.h"
 
 int do_clone_tests(unsigned long clone_flags,
 		   int (*fn1) (void *arg), void *arg1,
diff --git a/testcases/kernel/containers/libclone/libclone.h b/testcases/kernel/containers/libclone/libclone.h
index b8740f1bc..354555a26 100644
--- a/testcases/kernel/containers/libclone/libclone.h
+++ b/testcases/kernel/containers/libclone/libclone.h
@@ -27,7 +27,6 @@
 #include <sys/syscall.h>
 #include <signal.h>
 #include "lapi/syscalls.h"
-#include "test.h"
 #include "lapi/namespaces_constants.h"
 
 #define T_UNSHARE 0
diff --git a/testcases/kernel/containers/mqns/mqns_helper.h b/testcases/kernel/containers/mqns/mqns_helper.h
index 605378d48..463330ce6 100644
--- a/testcases/kernel/containers/mqns/mqns_helper.h
+++ b/testcases/kernel/containers/mqns/mqns_helper.h
@@ -21,9 +21,9 @@
 #include <sys/types.h>
 #include <mqueue.h>
 #include "../libclone/libclone.h"
+#include "test.h"
 #include "lapi/syscalls.h"
 #include "safe_macros.h"
-#include "test.h"
 
 static int dummy_child(void *v)
 {
-- 
2.30.1


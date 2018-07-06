From: Yixin Zhang <yixin.zhang@intel.com>
Date: Fri,  6 Jul 2018 17:03:25 +0800
Subject: [LTP] [PATCH ltp] syscalls/ipc/msgstress/msgstress{01, 02, 03,
	04}: update TCID
Message-ID: <20180706090325.9923-1-yixin.zhang@intel.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The tests are renamed from kernel/syscalls/ipc/msgctl/msgctl08-11 in
commmit 3e882e3e4c2d7601e66d67977a8ce4c4f88f8099.
Update TCID in source files accordingly.

Signed-off-by: Yixin Zhang <yixin.zhang@intel.com>
---
 testcases/kernel/syscalls/ipc/msgstress/msgstress01.c | 2 +-
 testcases/kernel/syscalls/ipc/msgstress/msgstress02.c | 2 +-
 testcases/kernel/syscalls/ipc/msgstress/msgstress03.c | 4 ++--
 testcases/kernel/syscalls/ipc/msgstress/msgstress04.c | 4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/syscalls/ipc/msgstress/msgstress01.c b/testcases/kernel/syscalls/ipc/msgstress/msgstress01.c
index 7bcec501b..6e7f0c1f2 100644
--- a/testcases/kernel/syscalls/ipc/msgstress/msgstress01.c
+++ b/testcases/kernel/syscalls/ipc/msgstress/msgstress01.c
@@ -41,7 +41,7 @@
 #include "ipcmsg.h"
 #include "../lib/libmsgctl.h"
 
-char *TCID = "msgctl08";
+char *TCID = "msgstress01";
 int TST_TOTAL = 1;
 
 #ifndef CONFIG_COLDFIRE
diff --git a/testcases/kernel/syscalls/ipc/msgstress/msgstress02.c b/testcases/kernel/syscalls/ipc/msgstress/msgstress02.c
index 3d6a6e1d7..1e63c56a3 100644
--- a/testcases/kernel/syscalls/ipc/msgstress/msgstress02.c
+++ b/testcases/kernel/syscalls/ipc/msgstress/msgstress02.c
@@ -39,7 +39,7 @@
 #include "ipcmsg.h"
 #include "../lib/libmsgctl.h"
 
-char *TCID = "msgctl09";
+char *TCID = "msgstress02";
 int TST_TOTAL = 1;
 
 #define MAXNREPS	1000
diff --git a/testcases/kernel/syscalls/ipc/msgstress/msgstress03.c b/testcases/kernel/syscalls/ipc/msgstress/msgstress03.c
index f0f873f46..a8328f830 100644
--- a/testcases/kernel/syscalls/ipc/msgstress/msgstress03.c
+++ b/testcases/kernel/syscalls/ipc/msgstress/msgstress03.c
@@ -21,7 +21,7 @@
 
 /*
  * Get and manipulate a message queue.
- * Same as msgctl08 but gets the actual msgmni value under procfs.
+ * Same as msgctl08(msgstress01) but gets the actual msgmni value under procfs.
  */
 
 #define _XOPEN_SOURCE 500
@@ -42,7 +42,7 @@
 #include "ipcmsg.h"
 #include "../lib/libmsgctl.h"
 
-char *TCID = "msgctl10";
+char *TCID = "msgstress03";
 int TST_TOTAL = 1;
 
 #define MAXNPROCS	10000	/*These should be sufficient */
diff --git a/testcases/kernel/syscalls/ipc/msgstress/msgstress04.c b/testcases/kernel/syscalls/ipc/msgstress/msgstress04.c
index 89099a7c7..f15b0481d 100644
--- a/testcases/kernel/syscalls/ipc/msgstress/msgstress04.c
+++ b/testcases/kernel/syscalls/ipc/msgstress/msgstress04.c
@@ -21,7 +21,7 @@
 
 /*
  * Get and manipulate a message queue.
- * Same as msgctl09 but gets the actual msgmni value under procfs.
+ * Same as msgctl09(msgstress02) but gets the actual msgmni value under procfs.
  */
 
 #define _XOPEN_SOURCE 500
@@ -40,7 +40,7 @@
 #include "ipcmsg.h"
 #include "../lib/libmsgctl.h"
 
-char *TCID = "msgctl11";
+char *TCID = "msgstress04";
 int TST_TOTAL = 1;
 
 #define MAXNREPS	1000
-- 
2.14.1


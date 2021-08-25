From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 25 Aug 2021 10:09:31 +0200
Subject: [LTP] [PATCH 1/3] lib: Move IPC_ENV_VAR definition into header
In-Reply-To: <20210825080933.12949-1-pvorel@suse.cz>
References: <20210825080933.12949-1-pvorel@suse.cz>
Message-ID: <20210825080933.12949-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

thus it can be used in tests instead of duplicate definition.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 include/tst_test.h                          | 2 ++
 lib/tst_test.c                              | 2 --
 testcases/kernel/syscalls/execle/execle01.c | 2 --
 testcases/kernel/syscalls/execve/execve01.c | 2 --
 testcases/kernel/syscalls/prctl/prctl06.h   | 1 -
 5 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/include/tst_test.h b/include/tst_test.h
index ce4e007cf..27ebed94e 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -275,6 +275,8 @@ struct tst_test {
 void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
                     __attribute__ ((noreturn));
 
+#define IPC_ENV_VAR "LTP_IPC_PATH"
+
 /*
  * Does library initialization for child processes started by exec()
  *
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 1bdea769a..b61aa8b03 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -71,8 +71,6 @@ static int ipc_fd;
 extern void *tst_futexes;
 extern unsigned int tst_max_futexes;
 
-#define IPC_ENV_VAR "LTP_IPC_PATH"
-
 static char ipc_path[1064];
 const char *tst_ipc_path = ipc_path;
 
diff --git a/testcases/kernel/syscalls/execle/execle01.c b/testcases/kernel/syscalls/execle/execle01.c
index f10813cca..917dc892f 100644
--- a/testcases/kernel/syscalls/execle/execle01.c
+++ b/testcases/kernel/syscalls/execle/execle01.c
@@ -16,8 +16,6 @@
 
 #include "tst_test.h"
 
-#define IPC_ENV_VAR "LTP_IPC_PATH"
-
 static void verify_execle(void)
 {
 	pid_t pid;
diff --git a/testcases/kernel/syscalls/execve/execve01.c b/testcases/kernel/syscalls/execve/execve01.c
index 9331c9480..2b12c7666 100644
--- a/testcases/kernel/syscalls/execve/execve01.c
+++ b/testcases/kernel/syscalls/execve/execve01.c
@@ -17,8 +17,6 @@
 
 #include "tst_test.h"
 
-#define IPC_ENV_VAR "LTP_IPC_PATH"
-
 static void verify_execve(void)
 {
 	pid_t pid;
diff --git a/testcases/kernel/syscalls/prctl/prctl06.h b/testcases/kernel/syscalls/prctl/prctl06.h
index 227ce3006..510fefa60 100644
--- a/testcases/kernel/syscalls/prctl/prctl06.h
+++ b/testcases/kernel/syscalls/prctl/prctl06.h
@@ -17,7 +17,6 @@
 #include "tst_test.h"
 
 #define PROC_STATUS        "/proc/self/status"
-#define IPC_ENV_VAR        "LTP_IPC_PATH"
 #define MNTPOINT           "mntpoint"
 #define TESTBIN            "prctl06_execve"
 #define TEST_REL_BIN_DIR   MNTPOINT"/"
-- 
2.32.0


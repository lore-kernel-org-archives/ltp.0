From: Jorik Cronenberg <jcronenberg@suse.de>
Date: Wed, 22 Jan 2020 14:42:38 +0100
Subject: [LTP] [PATCH 1/2] lib: Add timeout to TST_PROCESS_STATE_WAIT
Message-ID: <20200122134239.28844-1-jcronenberg@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add the possibility to add a timeout to TST_PROCESS_STATE_WAIT.
Like checkpoints add TST_PROCESS_STATE_WAIT2()
for specifying a timeout. The original TST_PROCESS_STATE_WAIT()
works the same as before. Timeout can be specified in milliseconds.

Signed-off-by: Jorik Cronenberg <jcronenberg@suse.de>
---
 include/tst_process_state.h | 12 ++++++++----
 lib/tst_process_state.c     | 19 ++++++++++++++-----
 2 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/include/tst_process_state.h b/include/tst_process_state.h
index fab0491d9..27a8ffc36 100644
--- a/include/tst_process_state.h
+++ b/include/tst_process_state.h
@@ -47,9 +47,13 @@
  */
 #ifdef TST_TEST_H__
 
+#define TST_PROCESS_STATE_WAIT2(pid, state, msec_timeout) \
+	tst_process_state_wait(__FILE__, __LINE__, NULL, \
+	                       (pid), (state), msec_timeout)
+
 #define TST_PROCESS_STATE_WAIT(pid, state) \
 	tst_process_state_wait(__FILE__, __LINE__, NULL, \
-	                       (pid), (state))
+	                       (pid), (state), 0)
 #else
 /*
  * The same as above but does not use tst_brkm() interface.
@@ -65,8 +69,8 @@ int tst_process_state_wait2(pid_t pid, const char state);
 	                        (pid), (state))
 #endif
 
-void tst_process_state_wait(const char *file, const int lineno,
-                            void (*cleanup_fn)(void),
-                            pid_t pid, const char state);
+int tst_process_state_wait(const char *file, const int lineno,
+                            void (*cleanup_fn)(void), pid_t pid,
+			    const char state, unsigned int msec_timeout);
 
 #endif /* TST_PROCESS_STATE__ */
diff --git a/lib/tst_process_state.c b/lib/tst_process_state.c
index 7a7824959..32b44992c 100644
--- a/lib/tst_process_state.c
+++ b/lib/tst_process_state.c
@@ -28,11 +28,12 @@
 #include "test.h"
 #include "tst_process_state.h"
 
-void tst_process_state_wait(const char *file, const int lineno,
-                            void (*cleanup_fn)(void),
-                            pid_t pid, const char state)
+int tst_process_state_wait(const char *file, const int lineno,
+                            void (*cleanup_fn)(void), pid_t pid,
+			    const char state, unsigned int msec_timeout)
 {
 	char proc_path[128], cur_state;
+	unsigned int msecs = 0;
 
 	snprintf(proc_path, sizeof(proc_path), "/proc/%i/stat", pid);
 
@@ -41,10 +42,18 @@ void tst_process_state_wait(const char *file, const int lineno,
 		                "%*i %*s %c", &cur_state);
 
 		if (state == cur_state)
-			return;
+			break;
 
-		usleep(10000);
+		usleep(1000);
+		msecs += 1;
+
+		if (msecs >= msec_timeout) {
+			errno = ETIMEDOUT;
+			return -1;
+		}
 	}
+
+	return 0;
 }
 
 int tst_process_state_wait2(pid_t pid, const char state)
-- 
2.24.1


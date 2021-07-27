From: Xie Ziyao <xieziyao@huawei.com>
Date: Tue, 27 Jul 2021 20:45:05 +0800
Subject: [LTP] [PATCH 1/3] tst_process_state: Add tst_process_state_wait2 to
 newlib
In-Reply-To: <20210727124507.28356-1-xieziyao@huawei.com>
References: <20210727124507.28356-1-xieziyao@huawei.com>
Message-ID: <20210727124507.28356-2-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add tst_process_state_wait2 to newlib for epoll_pwait01.

Signed-off-by: Xie Ziyao <xieziyao@huawei.com>
---
 include/tst_process_state.h | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/include/tst_process_state.h b/include/tst_process_state.h
index 81532524a..4641557bd 100644
--- a/include/tst_process_state.h
+++ b/include/tst_process_state.h
@@ -37,14 +37,6 @@
 	tst_process_exit_wait((pid), (msec_timeout))

 #else
-/*
- * The same as above but does not use tst_brkm() interface.
- *
- * This function is intended to be used from child processes.
- *
- * Returns zero on success, non-zero on failure.
- */
-int tst_process_state_wait2(pid_t pid, const char state);

 #define TST_PROCESS_STATE_WAIT(cleanup_fn, pid, state) \
 	tst_process_state_wait(__FILE__, __LINE__, (cleanup_fn), \
@@ -54,6 +46,16 @@ int tst_process_state_wait2(pid_t pid, const char state);
 int tst_process_state_wait(const char *file, const int lineno,
 			   void (*cleanup_fn)(void), pid_t pid,
 			   const char state, unsigned int msec_timeout);
+
+/*
+ * The same as above but does not use tst_brkm() interface.
+ *
+ * This function is intended to be used from child processes.
+ *
+ * Returns zero on success, non-zero on failure.
+ */
+int tst_process_state_wait2(pid_t pid, const char state);
+
 int tst_process_exit_wait(pid_t pid, unsigned int msec_timeout);

 #endif /* TST_PROCESS_STATE__ */
--
2.17.1


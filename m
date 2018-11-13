From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 13 Nov 2018 16:17:44 +0100
Subject: [LTP] [PATCH 2/3] lapi/safe_rt_signal.h: Add.
In-Reply-To: <20181113151745.24676-1-chrubis@suse.cz>
References: <20181113151745.24676-1-chrubis@suse.cz>
Message-ID: <20181113151745.24676-3-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This commits adds SAFE_RT_* calls, the file is created in lapi/ because
these are wrappers around low level kernel syscalls rather than around
the libc interfaces.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/lapi/safe_rt_signal.h | 50 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 include/lapi/safe_rt_signal.h

diff --git a/include/lapi/safe_rt_signal.h b/include/lapi/safe_rt_signal.h
new file mode 100644
index 000000000..67fa44417
--- /dev/null
+++ b/include/lapi/safe_rt_signal.h
@@ -0,0 +1,50 @@
+/*
+ * Copyright (c) 2018 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+#ifndef SAFE_RT_SIGNAL_H__
+#define SAFE_RT_SIGNAL_H__
+
+#include <signal.h>
+#include "lapi/rt_sigaction.h"
+
+static inline int safe_rt_sigaction(const char *file, const int lineno,
+                                    int signum, const struct sigaction *act,
+                                    struct sigaction *oact, size_t sigsetsize)
+{
+	int ret;
+
+	ret = ltp_rt_sigaction(signum, act, oact, sigsetsize);
+	if (ret < 0) {
+		tst_brk(TBROK | TERRNO,
+			"%s:%d: ltp_rt_sigaction(%i, %p, %p, %zu) failed",
+			file, lineno, signum, act, oact, sigsetsize);
+	}
+
+	return ret;
+}
+
+#define SAFE_RT_SIGACTION(signum, act, oldact, sigsetsize) \
+	safe_rt_sigaction(__FILE__, __LINE__, signum, act, oldact, sigsetsize)
+
+
+static inline int safe_rt_sigprocmask(const char *file, const int lineno,
+                                      int how, const sigset_t *set,
+                                      sigset_t *oldset, size_t sigsetsize)
+{
+	int ret;
+
+	ret = tst_syscall(__NR_rt_sigprocmask, how, set, oldset, sigsetsize);
+	if (ret < 0) {
+		tst_brk(TBROK | TERRNO,
+		        "%s:%d: rt_sigprocmask(%i, %p, %p, %zu) failed",
+			file, lineno, how, set, oldset, sigsetsize);
+	}
+
+	return ret;
+}
+
+#define SAFE_RT_SIGPROCMASK(how, set, oldset, sigsetsize) \
+	safe_rt_sigprocmask(__FILE__, __LINE__, how, set, oldset, sigsetsize)
+
+#endif /* SAFE_RT_SIGNAL_H__ */
-- 
2.16.4


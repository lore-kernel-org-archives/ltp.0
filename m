From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Tue,  8 Sep 2020 11:49:14 +0530
Subject: [LTP] [PATCH 01/16] syscalls: Add common time64 variants structure
In-Reply-To: <cover.1599545766.git.viresh.kumar@linaro.org>
References: <cover.1599545766.git.viresh.kumar@linaro.org>
Message-ID: <7bfadc417d4a40348a0aa742f3c44582a955913a.1599545766.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This adds a common variants structure which all other syscall tests can
use.

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 include/time64_variants.h | 56 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 include/time64_variants.h

diff --git a/include/time64_variants.h b/include/time64_variants.h
new file mode 100644
index 000000000000..934268b0328b
--- /dev/null
+++ b/include/time64_variants.h
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 Linaro Limited. All rights reserved.
+ * Author: Viresh Kumar <viresh.kumar@linaro.org>
+ */
+
+#ifndef TIME64_VARIANTS_H
+#define TIME64_VARIANTS_H
+
+#include <libaio.h>
+#include <signal.h>
+#include <stdio.h>
+#include <sys/poll.h>
+#include <time.h>
+#include "tst_timer.h"
+
+struct tst_ts;
+struct pollfd;
+struct io_event;
+struct sembuf;
+struct mmsghdr;
+
+struct time64_variants {
+	char *desc;
+
+	enum tst_ts_type ts_type;
+	int (*clock_gettime)(clockid_t clk_id, void *ts);
+	int (*clock_settime)(clockid_t clk_id, void *ts);
+	int (*clock_nanosleep)(clockid_t clock_id, int flags, void *request, void *remain);
+
+	int (*timer_gettime)(kernel_timer_t timer, void *its);
+	int (*timer_settime)(kernel_timer_t timerid, int flags, void *its, void *old_its);
+	int (*tfd_gettime)(int fd, void *its);
+	int (*tfd_settime)(int fd, int flags, void *new_value, void *old_value);
+	int (*io_pgetevents)(io_context_t ctx, long min_nr, long max_nr,
+			struct io_event *events, void *timeout, sigset_t *sigmask);
+	int (*mqt_send)(mqd_t mqdes, const char *msg_ptr, size_t msg_len,
+			unsigned int msg_prio, void *abs_timeout);
+	ssize_t (*mqt_receive)(mqd_t mqdes, char *msg_ptr, size_t msg_len,
+			       unsigned int *msg_prio, void *abs_timeout);
+	int (*ppoll)(struct pollfd *fds, nfds_t nfds, void *tmo_p,
+		     const sigset_t *sigmask, size_t sigsetsize);
+	int (*sched_rr_get_interval)(pid_t pid, void *ts);
+	int (*semop)(int semid, struct sembuf *sops, size_t nsops);
+	int (*semtimedop)(int semid, struct sembuf *sops, size_t nsops, void *timeout);
+	int (*sigwait) (const sigset_t * set, siginfo_t * info,
+			 void * timeout);
+	int (*recvmmsg)(int sockfd, struct mmsghdr *msgvec, unsigned int vlen,
+		       unsigned int flags, void *timeout);
+	int (*sendmmsg)(int sockfd, struct mmsghdr *msgvec, unsigned int vlen,
+		    unsigned int flags);
+	int (*utimensat)(int dirfd, const char *pathname, void *times,
+			 int flags);
+};
+
+#endif /* TIME64_VARIANTS_H */
-- 
2.25.0.rc1.19.g042ed3e048af


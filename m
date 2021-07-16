From: Xie Ziyao <xieziyao@huawei.com>
Date: Fri, 16 Jul 2021 18:22:54 +0800
Subject: [LTP] [PATCH 2/5 v2] lapi: Add the prototype for epoll_pwait and
 epoll_pwait2
In-Reply-To: <20210716102257.20882-1-xieziyao@huawei.com>
References: <20210628080424.245911-3-xieziyao@huawei.com>
 <20210716102257.20882-1-xieziyao@huawei.com>
Message-ID: <20210716102257.20882-3-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add the prototype for epoll_pwait and epoll_pwait2 into include/lapi/epoll.h.

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Xie Ziyao <xieziyao@huawei.com>
---
v1->v2:
1. Add the prototype for epoll_pwait and epoll_pwait2 into include/lapi/epoll.h.

 configure.ac         |  1 +
 include/lapi/epoll.h | 37 ++++++++++++++++++++++++++++++++++---
 2 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/configure.ac b/configure.ac
index 25c421de0..5bf3c52ec 100644
--- a/configure.ac
+++ b/configure.ac
@@ -86,6 +86,7 @@ AC_CHECK_FUNCS_ONCE([ \
     close_range \
     copy_file_range \
     epoll_pwait \
+    epoll_pwait2 \
     execveat \
     fallocate \
     fchownat \
diff --git a/include/lapi/epoll.h b/include/lapi/epoll.h
index 899eeb9d4..57f4b9d0f 100644
--- a/include/lapi/epoll.h
+++ b/include/lapi/epoll.h
@@ -1,13 +1,44 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
+/* SPDX-License-Identifier: GPL-2.0-or-later
+ *
  * Copyright (c) 2016 Cyril Hrubis <chrubis@suse.cz>
+ * Copyright (c) 2021 Xie Ziyao <xieziyao@huawei.com>
  */

 #ifndef LAPI_EPOLL_H__
 #define LAPI_EPOLL_H__

+#include "lapi/syscalls.h"
+#include "tst_timer_test.h"
+
 #ifndef EPOLL_CLOEXEC
-# define EPOLL_CLOEXEC 02000000
+#define EPOLL_CLOEXEC 02000000
+#endif
+
+#ifndef HAVE_EPOLL_PWAIT
+int epoll_pwait(int epfd, struct epoll_event *events, int maxevents,
+		int timeout, const sigset_t *sigmask)
+{
+	return tst_syscall(__NR_epoll_pwait, epfd, events, maxevents,
+			   timeout, sigmask, _NSIG / 8);
+}
+#endif
+
+#ifndef HAVE_EPOLL_PWAIT2
+int epoll_pwait2(int epfd, struct epoll_event *events, int maxevents,
+		 const struct timespec *timeout, const sigset_t *sigmask)
+{
+	if (timeout == NULL)
+		return tst_syscall(__NR_epoll_pwait2, epfd, events, maxevents,
+				   NULL, sigmask, _NSIG / 8);
+
+	struct __kernel_timespec ts;
+
+	ts.tv_sec = timeout->tv_sec;
+	ts.tv_nsec = timeout->tv_nsec;
+
+	return tst_syscall(__NR_epoll_pwait2, epfd, events, maxevents,
+			   &ts, sigmask, _NSIG / 8);
+}
 #endif

 #endif /* LAPI_EPOLL_H__ */
--
2.17.1


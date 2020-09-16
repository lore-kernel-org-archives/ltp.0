From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Wed, 16 Sep 2020 16:07:46 +0530
Subject: [LTP] [PATCH V2 01/17] syscalls: utils: Remove local copy of poll.h
 definitions
In-Reply-To: <cover.1600252542.git.viresh.kumar@linaro.org>
References: <cover.1600252542.git.viresh.kumar@linaro.org>
Message-ID: <2c5695ebf7d13bd25651faf09d0fb78bbdd4bc31.1600252542.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The local copy of these definitions and this file conflicts with the
system wide ones and make the builds fail sometimes, for example when
this copy gets included instead of the system wide one.

Remove it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 testcases/kernel/syscalls/utils/poll.h | 27 --------------------------
 1 file changed, 27 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/utils/poll.h

diff --git a/testcases/kernel/syscalls/utils/poll.h b/testcases/kernel/syscalls/utils/poll.h
deleted file mode 100644
index 2cd4929abd40..000000000000
--- a/testcases/kernel/syscalls/utils/poll.h
+++ /dev/null
@@ -1,27 +0,0 @@
-#ifndef __i386_POLL_H
-#define __i386_POLL_H
-
-/* These are specified by iBCS2 */
-#define POLLIN		0x0001
-#define POLLPRI		0x0002
-#define POLLOUT		0x0004
-#define POLLERR		0x0008
-#define POLLHUP		0x0010
-#define POLLNVAL	0x0020
-
-/* The rest seem to be more-or-less nonstandard. Check them! */
-#define POLLRDNORM	0x0040
-#define POLLRDBAND	0x0080
-#define POLLWRNORM	0x0100
-#define POLLWRBAND	0x0200
-#define POLLMSG		0x0400
-#define POLLREMOVE	0x1000
-#define POLLRDHUP       0x2000
-
-struct pollfd {
-	int fd;
-	short events;
-	short revents;
-};
-
-#endif
-- 
2.25.0.rc1.19.g042ed3e048af


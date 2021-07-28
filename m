From: Xie Ziyao <xieziyao@huawei.com>
Date: Wed, 28 Jul 2021 17:29:17 +0800
Subject: [LTP] [PATCH 1/2 v2] lapi: Add epoll_pwait_supported() and
 epoll_pwait2_supported() check
In-Reply-To: <20210728092918.202639-1-xieziyao@huawei.com>
References: <20210728092918.202639-1-xieziyao@huawei.com>
Message-ID: <20210728092918.202639-2-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add the function of checking whether epoll_pwait or epoll_pwait2 is supported.

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Xie Ziyao <xieziyao@huawei.com>
---
 include/lapi/epoll.h | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/include/lapi/epoll.h b/include/lapi/epoll.h
index e5b4387f1..fc068ae20 100644
--- a/include/lapi/epoll.h
+++ b/include/lapi/epoll.h
@@ -14,18 +14,32 @@
 #define EPOLL_CLOEXEC 02000000
 #endif

+static inline void epoll_pwait_supported(void)
+{
+	/* allow the tests to fail early */
+	tst_syscall(__NR_epoll_pwait);
+}
+
 #ifndef HAVE_EPOLL_PWAIT
-int epoll_pwait(int epfd, struct epoll_event *events, int maxevents,
-		int timeout, const sigset_t *sigmask)
+static inline int epoll_pwait(int epfd, struct epoll_event *events,
+			      int maxevents, int timeout,
+			      const sigset_t *sigmask)
 {
 	return tst_syscall(__NR_epoll_pwait, epfd, events, maxevents,
 			   timeout, sigmask, _NSIG / 8);
 }
 #endif

+static inline void epoll_pwait2_supported(void)
+{
+	/* allow the tests to fail early */
+	tst_syscall(__NR_epoll_pwait2);
+}
+
 #ifndef HAVE_EPOLL_PWAIT2
-int epoll_pwait2(int epfd, struct epoll_event *events, int maxevents,
-		 const struct timespec *timeout, const sigset_t *sigmask)
+static inline int epoll_pwait2(int epfd, struct epoll_event *events,
+			       int maxevents, const struct timespec *timeout,
+			       const sigset_t *sigmask)
 {
 	if (timeout == NULL)
 		return tst_syscall(__NR_epoll_pwait2, epfd, events, maxevents,
--
2.17.1


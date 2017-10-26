From: Punit Agrawal <punit.agrawal@arm.com>
Date: Thu, 26 Oct 2017 15:14:41 +0100
Subject: [LTP] [PATCH 12/18] inotify: fix inotify.h breakage
In-Reply-To: <20171026141447.26749-1-punit.agrawal@arm.com>
References: <20171026141447.26749-1-punit.agrawal@arm.com>
Message-ID: <20171026141447.26749-13-punit.agrawal@arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Mark Rutland <mark.rutland@arm.com>

359980f68b: "rename syscall() macro to ltp_syscall()" renamed syscall()
to ltp_syscall, but didn't update all callers. This had the side effect
of making some callers refer to syscall.h's definition of syscall()
instead. This caused some tests to start failing unexpectedly.

This patch fixes up inotify.h to use ltp_syscall.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
---
 testcases/kernel/syscalls/inotify/inotify.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/inotify/inotify.h b/testcases/kernel/syscalls/inotify/inotify.h
index ac731bcb2..a364e1472 100644
--- a/testcases/kernel/syscalls/inotify/inotify.h
+++ b/testcases/kernel/syscalls/inotify/inotify.h
@@ -32,16 +32,16 @@
 
 #if __NR_inotify_init != __LTP__NR_INVALID_SYSCALL
 #define	myinotify_init() \
-	syscall(__NR_inotify_init)
+	ltp_syscall(__NR_inotify_init)
 #else
 #define	myinotify_init() \
-	syscall(__NR_inotify_init1, 0)
+	ltp_syscall(__NR_inotify_init1, 0)
 #endif
 
 #define	myinotify_add_watch(fd, pathname, mask)	\
-	syscall(__NR_inotify_add_watch, fd, pathname, mask)
+	ltp_syscall(__NR_inotify_add_watch, fd, pathname, mask)
 
 #define	myinotify_rm_watch(fd, wd) \
-	syscall(__NR_inotify_rm_watch, fd, wd)
+	ltp_syscall(__NR_inotify_rm_watch, fd, wd)
 
 #endif /* _INOTIFY_H */
-- 
2.14.2


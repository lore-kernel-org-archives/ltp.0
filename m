From: Khem Raj <raj.khem@gmail.com>
Date: Sat,  9 Jan 2016 01:14:16 +0000
Subject: [LTP] [PATCH V2 28/32] rt_sigaction.h: Use sighandler_t instead of
	__sighandler_t
In-Reply-To: <1452302060-103643-1-git-send-email-raj.khem@gmail.com>
References: <1452302060-103643-1-git-send-email-raj.khem@gmail.com>
Message-ID: <1452302060-103643-28-git-send-email-raj.khem@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

When _GNU_SOURCE is used then both typedefs are same and using
sighandler_t makes it work on musl too

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 include/lapi/rt_sigaction.h                      | 2 +-
 testcases/kernel/syscalls/rt_sigsuspend/Makefile | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/lapi/rt_sigaction.h b/include/lapi/rt_sigaction.h
index 3a5a763..870918c 100644
--- a/include/lapi/rt_sigaction.h
+++ b/include/lapi/rt_sigaction.h
@@ -34,7 +34,7 @@
 #define INVAL_SA_PTR ((void *)-1)
 
 struct kernel_sigaction {
-	__sighandler_t k_sa_handler;
+	sighandler_t k_sa_handler;
 	unsigned long sa_flags;
 	void (*sa_restorer) (void);
 	sigset_t sa_mask;
diff --git a/testcases/kernel/syscalls/rt_sigsuspend/Makefile b/testcases/kernel/syscalls/rt_sigsuspend/Makefile
index 37bc3a9..2ca7f7c 100644
--- a/testcases/kernel/syscalls/rt_sigsuspend/Makefile
+++ b/testcases/kernel/syscalls/rt_sigsuspend/Makefile
@@ -19,4 +19,7 @@
 top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
+
+CFLAGS	+= -D_GNU_SOURCE
+
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
-- 
2.7.0


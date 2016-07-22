From: Khem Raj <raj.khem@gmail.com>
Date: Thu, 21 Jul 2016 21:26:44 -0700
Subject: [LTP] [PATCH V3 11/23] lapi: Use sig_t instead of sighandler_t
In-Reply-To: <20160722042656.22346-1-raj.khem@gmail.com>
References: <20160722042656.22346-1-raj.khem@gmail.com>
Message-ID: <20160722042656.22346-11-raj.khem@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

sighandler_t is GNU specific

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 include/lapi/rt_sigaction.h                      | 2 +-
 testcases/kernel/syscalls/rt_sigsuspend/Makefile | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/lapi/rt_sigaction.h b/include/lapi/rt_sigaction.h
index a107786..7efee33 100644
--- a/include/lapi/rt_sigaction.h
+++ b/include/lapi/rt_sigaction.h
@@ -34,7 +34,7 @@
 #define INVAL_SA_PTR ((void *)-1)
 
 struct kernel_sigaction {
-	__sighandler_t k_sa_handler;
+	sig_t k_sa_handler;
 	unsigned long sa_flags;
 	void (*sa_restorer) (void);
 	sigset_t sa_mask;
diff --git a/testcases/kernel/syscalls/rt_sigsuspend/Makefile b/testcases/kernel/syscalls/rt_sigsuspend/Makefile
index 37bc3a9..2ef86f0 100644
--- a/testcases/kernel/syscalls/rt_sigsuspend/Makefile
+++ b/testcases/kernel/syscalls/rt_sigsuspend/Makefile
@@ -19,4 +19,5 @@
 top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
+
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
-- 
2.9.0


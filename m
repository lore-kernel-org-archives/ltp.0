From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Date: Mon, 7 Mar 2016 17:21:53 +0530
Subject: [LTP] [PATCH] rt_sigaction.h: ARC: Provide default sa_restorer
Message-ID: <1457351513-8310-1-git-send-email-vgupta@synopsys.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

LTP tests the raw (non libc) sigaction ABI to kernel such as validation
of various params.

sigaction on ARC relies on default userspace sa restorer to invoke a
sigreturn syscall when returning from a signal handler. Thus libc provides
a default sa restorer.

LTP tests the raw sigaction syscall ABI (w/o libc) hence needs the
restorer userspace infrastructure, which this patch provides for ARC.

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 include/lapi/rt_sigaction.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/include/lapi/rt_sigaction.h b/include/lapi/rt_sigaction.h
index 3a5a763ce094..c7fb04fc25be 100644
--- a/include/lapi/rt_sigaction.h
+++ b/include/lapi/rt_sigaction.h
@@ -145,6 +145,30 @@ static void __attribute__((used)) __sigreturn_stub(void)
 # endif
 #endif /* __sparc__ */
 
+#ifdef __arc__
+
+#undef SA_RESTORER
+#define SA_RESTORER     0x04000000
+
+/*
+ * based on uClibc/libc/sysdeps/linux/arc/sigaction.c
+ */
+static void
+__attribute__ ((optimize("Os"))) __attribute__((used)) restore_rt(void)
+{
+	__asm__ (
+		"mov r8, %0	\n\t"
+#ifdef __ARCHS__
+		"trap_s	0	\n\t"
+#else
+		"trap0	\n\t"
+#endif
+		: /* no outputs */
+		: "i" (__NR_rt_sigreturn)
+		: "r8");
+}
+#endif
+
 /* This is a wrapper for __NR_rt_sigaction syscall.
  * act/oact values of INVAL_SA_PTR is used to pass
  * an invalid pointer to syscall(__NR_rt_sigaction)
@@ -176,8 +200,10 @@ static int ltp_rt_sigaction(int signum, const struct sigaction *act,
 	else if (oact)
 		koact_p = &koact;
 
+#if defined __x86_64__ || defined __arc__
 #ifdef __x86_64__
 	sig_initial(signum);
+#endif
 	kact.sa_flags |= SA_RESTORER;
 	kact.sa_restorer = restore_rt;
 #endif
-- 
2.5.0


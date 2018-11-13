From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 13 Nov 2018 16:17:43 +0100
Subject: [LTP] [PATCH 1/3] lapi/rt_sigaction.h: Make it usable for newlib
	tests
In-Reply-To: <20181113151745.24676-1-chrubis@suse.cz>
References: <20181113151745.24676-1-chrubis@suse.cz>
Message-ID: <20181113151745.24676-2-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

We only need to switch between ltp_syscall() and tst_syscall().

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/lapi/rt_sigaction.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/lapi/rt_sigaction.h b/include/lapi/rt_sigaction.h
index 18236db62..2dbbc7672 100644
--- a/include/lapi/rt_sigaction.h
+++ b/include/lapi/rt_sigaction.h
@@ -177,6 +177,12 @@ __attribute__ ((optimize("Os"))) __attribute__((used)) restore_rt(void)
 }
 #endif
 
+#ifdef TST_TEST_H__
+# define TST_SYSCALL tst_syscall
+#else
+# define TST_SYSCALL ltp_syscall
+#endif
+
 /* This is a wrapper for __NR_rt_sigaction syscall.
  * act/oact values of INVAL_SA_PTR is used to pass
  * an invalid pointer to syscall(__NR_rt_sigaction)
@@ -232,11 +238,11 @@ static int ltp_rt_sigaction(int signum, const struct sigaction *act,
 
 
 #ifdef __sparc__
-	ret = ltp_syscall(__NR_rt_sigaction, signum,
+	ret = TST_SYSCALL(__NR_rt_sigaction, signum,
 			kact_p, koact_p,
 			stub, sigsetsize);
 #else
-	ret = ltp_syscall(__NR_rt_sigaction, signum,
+	ret = TST_SYSCALL(__NR_rt_sigaction, signum,
 			kact_p, koact_p,
 			sigsetsize);
 #endif
-- 
2.16.4


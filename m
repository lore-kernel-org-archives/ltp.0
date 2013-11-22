Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Markos.Chandras@imgtec.com>) id 1Vjrbu-0005HQ-N1
	for ltp-list@lists.sourceforge.net; Fri, 22 Nov 2013 14:21:30 +0000
Received: from multi.imgtec.com ([194.200.65.239])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Vjrbq-0008G7-RO
	for ltp-list@lists.sourceforge.net; Fri, 22 Nov 2013 14:21:30 +0000
From: Markos Chandras <markos.chandras@imgtec.com>
Date: Fri, 22 Nov 2013 14:20:59 +0000
Message-ID: <1385130059-12150-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] ptrace: Fix build problems with glibc-2.18
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

Since glibc-2.18, the struct ptrace_peeksiginfo_args is
also defined in sys/ptrace.h and conflicts with the definition
from the Linux kernel in linux/ptrace.h. We fix this by not
including the linux/ptrace.h header if the sys/ptrace.h header
defines the said struct. Fixes
https://github.com/linux-test-project/ltp/issues/6

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
Build tested on glibc-2.17 and glibc-2.18 systems
---
 configure.ac                              | 4 ++++
 include/config.h.default                  | 3 +++
 testcases/kernel/syscalls/ptrace/ptrace.h | 4 +++-
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 4846afd..d427276 100644
--- a/configure.ac
+++ b/configure.ac
@@ -48,6 +48,10 @@ AC_CHECK_HEADERS([ \
     sys/prctl.h \
 ])
 
+# glibc-2.18 defines ptrace_peeksiginfo_args in sys/ptrace.h which
+# conflicts with the one from linux kernel in linux/ptrace.h
+AC_CHECK_TYPES([struct ptrace_peeksiginfo_args],,,[#include <sys/ptrace.h>])
+
 # Tools knobs
 
 # Expect
diff --git a/include/config.h.default b/include/config.h.default
index 96e25c4..f226333 100644
--- a/include/config.h.default
+++ b/include/config.h.default
@@ -167,6 +167,9 @@
 /* Define to 1 if the system has the type `struct modify_ldt_ldt_s'. */
 #undef HAVE_STRUCT_MODIFY_LDT_LDT_S
 
+/* Define to 1 if the system has the type `struct ptrace_peeksiginfo_args'. */
+#undef HAVE_STRUCT_PTRACE_PEEKSIGINFO_ARG
+
 /* Define to 1 if `signo' is member of `struct signalfd_siginfo'. */
 #undef HAVE_STRUCT_SIGNALFD_SIGINFO_SIGNO
 
diff --git a/testcases/kernel/syscalls/ptrace/ptrace.h b/testcases/kernel/syscalls/ptrace/ptrace.h
index f0767d7..4a43f01 100644
--- a/testcases/kernel/syscalls/ptrace/ptrace.h
+++ b/testcases/kernel/syscalls/ptrace/ptrace.h
@@ -19,7 +19,9 @@
 # include <asm/ptrace.h>
 #endif
 #ifdef HAVE_LINUX_PTRACE_H
-# include <linux/ptrace.h>
+# ifndef HAVE_STRUCT_PTRACE_PEEKSIGINFO_ARGS
+#  include <linux/ptrace.h>
+# endif
 #endif
 #undef FU_ia64_fpreg
 #undef FU_pt_all_user_regs
-- 
1.8.4.3



------------------------------------------------------------------------------
Shape the Mobile Experience: Free Subscription
Software experts and developers: Be at the forefront of tech innovation.
Intel(R) Software Adrenaline delivers strategic insight and game-changing 
conversations that shape the rapidly evolving mobile landscape. Sign up now. 
http://pubads.g.doubleclick.net/gampad/clk?id=63431311&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

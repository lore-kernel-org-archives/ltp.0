Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF5D6C4167B
	for <ltp@archiver.kernel.org>; Tue, 28 Nov 2023 09:16:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1A8133CDA4C
	for <ltp@archiver.kernel.org>; Tue, 28 Nov 2023 10:16:17 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A7B0A3CB700
 for <ltp@lists.linux.it>; Tue, 28 Nov 2023 10:16:06 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 62E6A14052EA
 for <ltp@lists.linux.it>; Tue, 28 Nov 2023 10:15:39 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 955381F74B;
 Tue, 28 Nov 2023 09:15:36 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 5540613AE2;
 Tue, 28 Nov 2023 09:15:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id EEUGE7ivZWUtTgAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Tue, 28 Nov 2023 09:15:36 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 28 Nov 2023 10:15:22 +0100
Message-ID: <20231128091524.340808-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231128091524.340808-1-pvorel@suse.cz>
References: <20231128091524.340808-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Bar: ++++++++++++++++
X-Rspamd-Server: rspamd1
Authentication-Results: smtp-out2.suse.de; dkim=none;
 spf=softfail (smtp-out2.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither
 permitted nor denied by domain of pvorel@suse.cz)
 smtp.mailfrom=pvorel@suse.cz; dmarc=none
X-Rspamd-Queue-Id: 955381F74B
X-Spamd-Result: default: False [16.29 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; DMARC_NA(1.20)[suse.cz];
 BROKEN_CONTENT_TYPE(1.50)[]; R_SPF_SOFTFAIL(4.60)[~all:c];
 NEURAL_SPAM_SHORT(2.90)[0.967]; RCVD_COUNT_THREE(0.00)[3];
 MX_GOOD(-0.01)[]; NEURAL_SPAM_LONG(3.50)[1.000];
 RCPT_COUNT_SEVEN(0.00)[7]; MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,sourceware.org:url];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 R_DKIM_NA(2.20)[]; MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/3] ptrace: Remove old autotools checks
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

ptrace fallbacks in ptrace.h and their autotools checks in
m4/ltp-ptrace.m4 are from 2009. CI shows that they aren't needed for our
current supported systems - the oldest used glibc 2.22 has
<sys/ptrace.h> new enough that it can be used.

m4/ltp-ptrace.m4 even checked <sys/reg.h> and <asm/ptrace.h> for kernel
change from v2.6.27-rc1 (2008), clearly not needed nowadays.

Using only <sys/ptrace.h> instead of both <sys/ptrace.h> and
<linux/ptrace.h> resolves header conflict (documented at
https://sourceware.org/glibc/wiki/Synchronizing_Headers):

$ make check-ptrace05
CHECK testcases/kernel/syscalls/ptrace/ptrace05.c
ptrace05.c: note: in included file (through ptrace.h):
/usr/include/linux/ptrace.h:50:9: warning: preprocessor token PTRACE_GETREGSET redefined
ptrace05.c: note: in included file (through ptrace.h):
/usr/include/sys/ptrace.h:153:9: this was the original definition
ptrace05.c: note: in included file (through ptrace.h):
/usr/include/linux/ptrace.h:51:9: warning: preprocessor token PTRACE_SETREGSET redefined
ptrace05.c: note: in included file (through ptrace.h):
/usr/include/sys/ptrace.h:157:9: this was the original definition
ptrace05.c: note: in included file (through ptrace.h):
/usr/include/linux/ptrace.h:53:9: warning: preprocessor token PTRACE_SEIZE redefined
...

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 configure.ac                                  |  1 -
 m4/ltp-ptrace.m4                              | 26 -------------
 testcases/kernel/controllers/freezer/vfork.c  |  4 +-
 testcases/kernel/syscalls/ptrace/ptrace.h     | 38 -------------------
 testcases/kernel/syscalls/ptrace/ptrace01.c   |  3 +-
 testcases/kernel/syscalls/ptrace/ptrace02.c   |  3 +-
 testcases/kernel/syscalls/ptrace/ptrace03.c   |  3 +-
 testcases/kernel/syscalls/ptrace/ptrace04.c   |  4 +-
 testcases/kernel/syscalls/ptrace/ptrace05.c   |  4 +-
 testcases/kernel/syscalls/ptrace/ptrace06.c   |  5 +--
 testcases/kernel/syscalls/ptrace/ptrace07.c   |  3 +-
 testcases/kernel/syscalls/ptrace/ptrace11.c   |  3 +-
 .../kernel/syscalls/ptrace/simple_tracer.c    |  1 -
 13 files changed, 10 insertions(+), 88 deletions(-)
 delete mode 100644 m4/ltp-ptrace.m4
 delete mode 100644 testcases/kernel/syscalls/ptrace/ptrace.h

diff --git a/configure.ac b/configure.ac
index e1a10a10e..1d7e862d8 100644
--- a/configure.ac
+++ b/configure.ac
@@ -383,7 +383,6 @@ LTP_CHECK_FORTIFY_SOURCE
 LTP_CHECK_KERNEL_DEVEL
 LTP_CHECK_KEYUTILS_SUPPORT
 LTP_CHECK_LIBMNL
-LTP_CHECK_LINUX_PTRACE
 LTP_CHECK_LINUXRANDOM
 LTP_CHECK_NOMMU_LINUX
 LTP_CHECK_SELINUX
diff --git a/m4/ltp-ptrace.m4 b/m4/ltp-ptrace.m4
deleted file mode 100644
index 6f03fa57e..000000000
--- a/m4/ltp-ptrace.m4
+++ /dev/null
@@ -1,26 +0,0 @@
-dnl SPDX-License-Identifier: GPL-2.0-or-later
-dnl Copyright (c) Jiri Palecek 2009
-
-AC_DEFUN([LTP_CHECK_LINUX_PTRACE],
-_LTP_CHECK_LINUX_PTRACE
-)
-
-dnl Check for ptrace support
-dnl in commit 016ae219 in July 2008
-AC_DEFUN([_LTP_CHECK_LINUX_PTRACE],[
-dnl order of headers checked here is significant
-AC_CHECK_HEADERS([ \
-	sys/ptrace.h \
-	sys/reg.h \
-	asm/ptrace.h \
-	linux/ptrace.h \
-])
-save_CPPFLAGS=$CPPFLAGS
-CPPFLAGS="$CPPFLAGS -I$srcdir/testcases/kernel/syscalls/ptrace"
-AC_CHECK_TYPES([struct user_regs_struct, struct pt_regs],,,[#include "ptrace.h"])
-AC_CHECK_DECLS([PTRACE_GETSIGINFO, PTRACE_O_TRACEVFORKDONE, PTRACE_SETOPTIONS],,,[#include "ptrace.h"])
-dnl glibc-2.18 defines ptrace_peeksiginfo_args in sys/ptrace.h which
-dnl conflicts with the one from linux kernel in linux/ptrace.h
-AC_CHECK_TYPES([struct ptrace_peeksiginfo_args],,,[#include <sys/ptrace.h>])
-CPPFLAGS=$save_CPPFLAGS
-])
diff --git a/testcases/kernel/controllers/freezer/vfork.c b/testcases/kernel/controllers/freezer/vfork.c
index 0b25e90c2..9f4359bf8 100644
--- a/testcases/kernel/controllers/freezer/vfork.c
+++ b/testcases/kernel/controllers/freezer/vfork.c
@@ -29,6 +29,7 @@
  * until vfork returns. This can delay delivery of signals to the parent
  * process, even delay or stop system suspend.
  */
+
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
@@ -39,9 +40,8 @@
 #include <sys/types.h>
 #include <sys/wait.h>
 #include <sys/socket.h>
+#include <sys/ptrace.h>
 #include "test.h"
-#include "config.h"
-#include "../../syscalls/ptrace/ptrace.h"
 
 #define str_expand(s) str(s)
 #define str(s) #s
diff --git a/testcases/kernel/syscalls/ptrace/ptrace.h b/testcases/kernel/syscalls/ptrace/ptrace.h
deleted file mode 100644
index 10178a283..000000000
--- a/testcases/kernel/syscalls/ptrace/ptrace.h
+++ /dev/null
@@ -1,38 +0,0 @@
-/*
- * ptrace is a fickle beast and each arch sucks in a different way
- */
-
-#ifndef __LTP_PTRACE_H__
-#define __LTP_PTRACE_H__
-
-#ifdef HAVE_SYS_PTRACE_H
-# include <sys/ptrace.h>
-#endif
-#ifdef HAVE_SYS_REG_H
-# include <sys/reg.h>
-#endif
-#ifdef __ia64__ /* what a pos */
-# define ia64_fpreg FU_ia64_fpreg
-# define pt_all_user_regs FU_pt_all_user_regs
-#endif
-#ifdef HAVE_ASM_PTRACE_H
-# include <asm/ptrace.h>
-#endif
-#ifdef HAVE_LINUX_PTRACE_H
-# ifndef HAVE_STRUCT_PTRACE_PEEKSIGINFO_ARGS
-#  include <linux/ptrace.h>
-# endif
-#endif
-#undef FU_ia64_fpreg
-#undef FU_pt_all_user_regs
-
-#define HAVE_STRUCT_PTRACE_REGS 1
-#if defined(HAVE_STRUCT_PT_REGS)
-typedef struct pt_regs ptrace_regs;
-#elif defined(HAVE_STRUCT_USER_REGS_STRUCT)
-typedef struct user_regs_struct ptrace_regs;
-#else
-#undef HAVE_STRUCT_PTRACE_REGS
-#endif
-
-#endif
diff --git a/testcases/kernel/syscalls/ptrace/ptrace01.c b/testcases/kernel/syscalls/ptrace/ptrace01.c
index 9071bbaba..53ddfb393 100644
--- a/testcases/kernel/syscalls/ptrace/ptrace01.c
+++ b/testcases/kernel/syscalls/ptrace/ptrace01.c
@@ -26,8 +26,7 @@
 #include <errno.h>
 #include <signal.h>
 #include <sys/wait.h>
-#include <config.h>
-#include "ptrace.h"
+#include <sys/ptrace.h>
 #include "tst_test.h"
 
 static struct tcase {
diff --git a/testcases/kernel/syscalls/ptrace/ptrace02.c b/testcases/kernel/syscalls/ptrace/ptrace02.c
index e330f459e..a48ef58a5 100644
--- a/testcases/kernel/syscalls/ptrace/ptrace02.c
+++ b/testcases/kernel/syscalls/ptrace/ptrace02.c
@@ -11,9 +11,8 @@
 #include <signal.h>
 #include <sys/wait.h>
 #include <pwd.h>
-#include <config.h>
 #include <stdlib.h>
-#include "ptrace.h"
+#include <sys/ptrace.h>
 #include "tst_test.h"
 
 uid_t uid;
diff --git a/testcases/kernel/syscalls/ptrace/ptrace03.c b/testcases/kernel/syscalls/ptrace/ptrace03.c
index b2b3fb49d..42ac3e7cf 100644
--- a/testcases/kernel/syscalls/ptrace/ptrace03.c
+++ b/testcases/kernel/syscalls/ptrace/ptrace03.c
@@ -14,9 +14,8 @@
 #include <signal.h>
 #include <sys/wait.h>
 #include <pwd.h>
-#include <config.h>
 #include <stdlib.h>
-#include "ptrace.h"
+#include <sys/ptrace.h>
 #include "tst_test.h"
 
 static pid_t unused_pid;
diff --git a/testcases/kernel/syscalls/ptrace/ptrace04.c b/testcases/kernel/syscalls/ptrace/ptrace04.c
index 0b25e982b..8f1b5c6cc 100644
--- a/testcases/kernel/syscalls/ptrace/ptrace04.c
+++ b/testcases/kernel/syscalls/ptrace/ptrace04.c
@@ -13,9 +13,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
-
-#include <config.h>
-#include "ptrace.h"
+#include <sys/ptrace.h>
 
 #include "test.h"
 #include "spawn_ptrace_child.h"
diff --git a/testcases/kernel/syscalls/ptrace/ptrace05.c b/testcases/kernel/syscalls/ptrace/ptrace05.c
index 54cfa4d7b..541018393 100644
--- a/testcases/kernel/syscalls/ptrace/ptrace05.c
+++ b/testcases/kernel/syscalls/ptrace/ptrace05.c
@@ -33,9 +33,7 @@
 #include <stdio.h>
 #include <string.h>
 #include <unistd.h>
-
-#include <config.h>
-#include "ptrace.h"
+#include <sys/ptrace.h>
 
 #include "test.h"
 #include "lapi/signal.h"
diff --git a/testcases/kernel/syscalls/ptrace/ptrace06.c b/testcases/kernel/syscalls/ptrace/ptrace06.c
index c0cb3b9bd..a1db3bab8 100644
--- a/testcases/kernel/syscalls/ptrace/ptrace06.c
+++ b/testcases/kernel/syscalls/ptrace/ptrace06.c
@@ -16,13 +16,10 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
-
-#include <config.h>
-#include "ptrace.h"
+#include <sys/ptrace.h>
 
 #include "test.h"
 #include "spawn_ptrace_child.h"
-#include "config.h"
 
 /* this should be sizeof(struct user), but that info is only found
  * in the kernel asm/user.h which is not exported to userspace.
diff --git a/testcases/kernel/syscalls/ptrace/ptrace07.c b/testcases/kernel/syscalls/ptrace/ptrace07.c
index 362cee543..a78243671 100644
--- a/testcases/kernel/syscalls/ptrace/ptrace07.c
+++ b/testcases/kernel/syscalls/ptrace/ptrace07.c
@@ -35,9 +35,8 @@
 #include <stdlib.h>
 #include <sys/uio.h>
 #include <sys/wait.h>
+#include <sys/ptrace.h>
 
-#include "config.h"
-#include "ptrace.h"
 #include "tst_safe_macros.h"
 #include "lapi/cpuid.h"
 
diff --git a/testcases/kernel/syscalls/ptrace/ptrace11.c b/testcases/kernel/syscalls/ptrace/ptrace11.c
index c54441671..90154852f 100644
--- a/testcases/kernel/syscalls/ptrace/ptrace11.c
+++ b/testcases/kernel/syscalls/ptrace/ptrace11.c
@@ -16,9 +16,8 @@
 #include <signal.h>
 #include <sys/wait.h>
 #include <pwd.h>
-#include <config.h>
 #include <stdlib.h>
-#include "ptrace.h"
+#include <sys/ptrace.h>
 #include "tst_test.h"
 
 static void verify_ptrace(void)
diff --git a/testcases/kernel/syscalls/ptrace/simple_tracer.c b/testcases/kernel/syscalls/ptrace/simple_tracer.c
index ae1af7c2f..43026e317 100644
--- a/testcases/kernel/syscalls/ptrace/simple_tracer.c
+++ b/testcases/kernel/syscalls/ptrace/simple_tracer.c
@@ -17,7 +17,6 @@
 #include <unistd.h>
 #include <sys/ptrace.h>
 #include <sys/syscall.h>
-#include "ptrace.h"
 
 #include "test.h"
 #include "spawn_ptrace_child.h"
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

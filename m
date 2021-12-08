Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CEEEC433F5
	for <ltp@archiver.kernel.org>; Wed,  8 Dec 2021 08:26:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E0A393C6AA9
	for <ltp@archiver.kernel.org>; Wed,  8 Dec 2021 09:26:44 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C7FD73C21F9
 for <ltp@lists.linux.it>; Wed,  8 Dec 2021 09:26:35 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B62461000DD1
 for <ltp@lists.linux.it>; Wed,  8 Dec 2021 09:26:30 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D2AAB1FE00;
 Wed,  8 Dec 2021 08:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1638951989; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Drui9TB5nPfhxs6yEpkUTZiZDs+6MNKRPVa2huwOP4Y=;
 b=Jz8j+n8b4o9whRffe6QryNlo+NYrVl6z+kI56pCZVcyAxkLUBYfyiLOpPA5vc6Ox9yw3u8
 q8oCV4U37u8aLA7DhTPpmkDNtTql/oa7Ccz3fUqfeupcaFPYKNL4QDV3gYGVgUh0w9cjL1
 jxCCaTWgZiD3CfLAGLe4a279beDklrk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1638951989;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Drui9TB5nPfhxs6yEpkUTZiZDs+6MNKRPVa2huwOP4Y=;
 b=S5G365G9Dq1sP7D1CXdbXS2YFxGJiJ+eXY9+SNUWTFWu2FOydmF2fwmvNNxIOqaEGmGHFn
 g2excYrmLJmHJVBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A6D4D13B49;
 Wed,  8 Dec 2021 08:26:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id BjyJJjVssGEEagAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 08 Dec 2021 08:26:29 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed,  8 Dec 2021 09:26:25 +0100
Message-Id: <20211208082625.26324-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] m4: Fix warnings
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

from autoconf 2.71:

* s/AC_HELP_STRING/AS_HELP_STRING/

Similar replace was done in autoconf commit 5958ce17 ("*
doc/autoconf.texi: Replace AC_HELP_STRING AS_HELP_STRING.")
from 2.58.

* s/AC_TRY_LINK/AC_COMPILE_IFELSE([AC_LANG_PROGRAM/

Similar replace was done in autoconf commit ede91cff ("Modernize
AC_EXEEXT and AC_OBJEXT. Now work with other languages than C and C++.")
from 2.50.

* s/AC_PROG_LEX/AC_PROG_LEX(yywrap)
yywrap argument introduced in 46f384f8 ("Revert to 2.69-compatible
behavior in AC_PROG_LEX (#110346)") from 2.70, but using is is
compatible on older releases (tested on 2.63).

Therefore keep requiring 2.61. Tested on 2.63 (SLES 11 and CentOS 6 both
don't even compile as unsupported, thus we could bump version to 2.63).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Tested:
https://github.com/pevik/ltp/actions/runs/1553085898

Kind regards,
Petr

 configure.ac                       | 26 +++++++++++++-------------
 m4/ltp-clone7args.m4               |  8 +++-----
 m4/ltp-eventfd.m4                  |  8 +++-----
 m4/ltp-kernel_devel.m4             |  6 +++---
 m4/ltp-mremap_fixed.m4             |  6 +++---
 m4/ltp-perf_event_open.m4          |  8 +++-----
 testcases/realtime/m4/check.m4     |  6 +++---
 testcases/realtime/m4/ltp-exp10.m4 |  8 +++-----
 8 files changed, 34 insertions(+), 42 deletions(-)

diff --git a/configure.ac b/configure.ac
index 063a8a9d1..366429b64 100644
--- a/configure.ac
+++ b/configure.ac
@@ -24,7 +24,7 @@ AC_PROG_CC
 # 2.62.
 AC_DEFUN([AC_PROG_AR], [AC_CHECK_TOOL(AR, ar, :)])
 AC_PROG_AR
-AC_PROG_LEX
+AC_PROG_LEX(yywrap)
 AC_PROG_RANLIB
 AC_DEFUN([AC_PROG_STRIP], [AC_CHECK_TOOL(STRIP, strip, :)])
 AC_PROG_STRIP
@@ -216,7 +216,7 @@ AC_CHECK_TYPES([struct xt_entry_match, struct xt_entry_target],,,[
 
 # Bash
 AC_ARG_WITH([bash],
-  [AC_HELP_STRING([--with-bash],
+  [AS_HELP_STRING([--with-bash],
     [have the Bourne Again Shell interpreter])],
   [with_bash=$withval],
   [with_bash=no]
@@ -229,24 +229,24 @@ fi
 
 # metadata
 AC_ARG_ENABLE([metadata],
-  [AC_HELP_STRING([--disable-metadata],
+  [AS_HELP_STRING([--disable-metadata],
 	[Disable metadata generation (both HTML and PDF, default no)])],
   [], [enable_metadata=yes]
 )
 AC_ARG_ENABLE([metadata_html],
-  [AC_HELP_STRING([--disable-metadata-html],
+  [AS_HELP_STRING([--disable-metadata-html],
 	[Disable metadata HTML generation (default no)])],
   [], [enable_metadata_html=yes]
 )
 
 AC_ARG_ENABLE([metadata_pdf],
-  [AC_HELP_STRING([--enable-metadata-pdf],
+  [AS_HELP_STRING([--enable-metadata-pdf],
 	[Enable metadata PDF generation (default no)])],
   [], [enable_metadata_pdf=no]
 )
 
 AC_ARG_WITH([metadata_generator],
-  [AC_HELP_STRING([--with-metadata-generator=asciidoc|asciidoctor],
+  [AS_HELP_STRING([--with-metadata-generator=asciidoc|asciidoctor],
 	[Specify metadata generator to use (default autodetect)])],
   [with_metadata_generator=$withval],
   [with_metadata_generator=detect]
@@ -256,7 +256,7 @@ LTP_DOCPARSE
 
 # Expect
 AC_ARG_WITH([expect],
-  [AC_HELP_STRING([--with-expect],
+  [AS_HELP_STRING([--with-expect],
     [have the Tcl/expect library])],
   [with_expect=$withval],
   [with_expect=no]
@@ -269,7 +269,7 @@ fi
 
 # Numa
 AC_ARG_WITH([numa],
-  AC_HELP_STRING([--without-numa],
+  AS_HELP_STRING([--without-numa],
     [without numa support]),
   [with_numa=$withval],
   [with_numa=yes]
@@ -277,7 +277,7 @@ AC_ARG_WITH([numa],
 
 # Perl
 AC_ARG_WITH([perl],
-  [AC_HELP_STRING([--with-perl],
+  [AS_HELP_STRING([--with-perl],
     [have a perl interpreter])],
   [with_perl=$withval],
   [with_perl=no]
@@ -290,7 +290,7 @@ fi
 
 # Python
 AC_ARG_WITH([python],
-  [AC_HELP_STRING([--with-python],
+  [AS_HELP_STRING([--with-python],
     [have a python interpreter])],
   [with_python=$withval],
   [with_python=no]
@@ -303,7 +303,7 @@ fi
 
 # TI RPC
 AC_ARG_WITH([tirpc],
-  AC_HELP_STRING([--without-tirpc],
+  AS_HELP_STRING([--without-tirpc],
     [without libtirpc support]),
   [with_tirpc=$withval],
   [with_tirpc=yes]
@@ -313,7 +313,7 @@ AC_ARG_WITH([tirpc],
 # Testsuites knobs
 
 AC_ARG_WITH([open-posix-testsuite],
-  [AC_HELP_STRING([--with-open-posix-testsuite],
+  [AS_HELP_STRING([--with-open-posix-testsuite],
     [compile and install the open posix testsuite])],
   [with_open_posix_testsuite=$withval],
   [with_open_posix_testsuite=no]
@@ -326,7 +326,7 @@ fi
 
 # TODO: testcases/realtime requires bash and python.
 AC_ARG_WITH([realtime-testsuite],
-  [AC_HELP_STRING([--with-realtime-testsuite],
+  [AS_HELP_STRING([--with-realtime-testsuite],
     [compile and install the realtime testsuite])],
   [with_realtime_testsuite=$withval],
   [with_realtime_testsuite=no]
diff --git a/m4/ltp-clone7args.m4 b/m4/ltp-clone7args.m4
index ab55c1e33..4962789e5 100644
--- a/m4/ltp-clone7args.m4
+++ b/m4/ltp-clone7args.m4
@@ -5,13 +5,11 @@ AC_DEFUN([LTP_CHECK_CLONE_SUPPORTS_7_ARGS],[
 AH_TEMPLATE(CLONE_SUPPORTS_7_ARGS,
 [Define to 1 if clone() supports 7 arguments.])
 AC_MSG_CHECKING([if clone() supports 7 args])
-AC_TRY_LINK([#define _GNU_SOURCE
+AC_LINK_IFELSE([AC_LANG_PROGRAM([[#define _GNU_SOURCE
 		#include <sched.h>
-		#include <stdlib.h>],
-		[
+		#include <stdlib.h>]], [[
 		#ifndef __ia64__
 		clone(NULL, NULL, 0, NULL, NULL, NULL, NULL);
 		#endif
-		],
-		AC_DEFINE(CLONE_SUPPORTS_7_ARGS) AC_MSG_RESULT(yes), AC_MSG_RESULT(no))
+		]])],[AC_DEFINE(CLONE_SUPPORTS_7_ARGS) AC_MSG_RESULT(yes)],[AC_MSG_RESULT(no)])
 ])
diff --git a/m4/ltp-eventfd.m4 b/m4/ltp-eventfd.m4
index 5d729a33d..580df00a3 100644
--- a/m4/ltp-eventfd.m4
+++ b/m4/ltp-eventfd.m4
@@ -12,12 +12,10 @@ AC_DEFUN([LTP_CHECK_SYSCALL_EVENTFD], [
 		AC_SUBST(AIO_LIBS, "-laio")
 
 		AC_MSG_CHECKING([io_set_eventfd is defined in aio library or aio header])
-		AC_TRY_LINK([#include <stdio.h>
+		AC_LINK_IFELSE([AC_LANG_PROGRAM([[#include <stdio.h>
                              #include <libaio.h>
-		            ],
-		            [io_set_eventfd(NULL, 0); return 0;],
+		            ]], [[io_set_eventfd(NULL, 0); return 0;]])],
 		            [AC_DEFINE(HAVE_IO_SET_EVENTFD, 1, [Define to 1 if you have `io_set_eventfd' function.])
-						AC_MSG_RESULT(yes)],
-		            [AC_MSG_RESULT(no)])
+						AC_MSG_RESULT(yes)],[AC_MSG_RESULT(no)])
 	fi
 ])
diff --git a/m4/ltp-kernel_devel.m4 b/m4/ltp-kernel_devel.m4
index 8a0598e5a..d46d54775 100644
--- a/m4/ltp-kernel_devel.m4
+++ b/m4/ltp-kernel_devel.m4
@@ -9,7 +9,7 @@ AC_DEFUN([LTP_CHECK_KERNEL_DEVEL],[
 AC_MSG_CHECKING([for kernel-devel])
 AC_ARG_WITH(
 	[linux-version],
-	[AC_HELP_STRING([--with-linux-version=VERSION],
+	[AS_HELP_STRING([--with-linux-version=VERSION],
 			[specify the Linux version to build modules for])],
 	[LINUX_VERSION="${withval}"],
 	AS_IF([test "$cross_compiling" = "no"],
@@ -18,7 +18,7 @@ AC_ARG_WITH(
 AC_SUBST(LINUX_VERSION)
 
 AC_ARG_WITH([linux-dir],
-	[AC_HELP_STRING([--with-linux-dir=DIR],
+	[AS_HELP_STRING([--with-linux-dir=DIR],
 			[specify path to kernel-devel directory])],
 	[LINUX_DIR="${withval}"],
 	AS_IF([test -n "$LINUX_VERSION"],
@@ -44,7 +44,7 @@ AC_MSG_RESULT([$WITH_MODULES])
 
 AC_ARG_WITH(
 	[modules],
-	[AC_HELP_STRING([--without-modules],
+	[AS_HELP_STRING([--without-modules],
 			[disable auto-building kernel modules])],
 			[WITH_MODULES="no"],
 			[])
diff --git a/m4/ltp-mremap_fixed.m4 b/m4/ltp-mremap_fixed.m4
index 66548b82b..ff2696909 100644
--- a/m4/ltp-mremap_fixed.m4
+++ b/m4/ltp-mremap_fixed.m4
@@ -6,7 +6,7 @@ AC_DEFUN([LTP_CHECK_MREMAP_FIXED],[
 AH_TEMPLATE(HAVE_MREMAP_FIXED,
 [Define to 1 if you have MREMAP_FIXED in <sys/mman.h>.])
 AC_MSG_CHECKING([for MREMAP_FIXED in <sys/mman.h>])
-AC_TRY_COMPILE([#define _GNU_SOURCE
-                #include <sys/mman.h>], [int flags = MREMAP_FIXED;],
-               AC_DEFINE(HAVE_MREMAP_FIXED) AC_MSG_RESULT(yes), AC_MSG_RESULT(no))
+AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[#define _GNU_SOURCE
+                #include <sys/mman.h>]], [[int flags = MREMAP_FIXED;]])],
+                [AC_DEFINE(HAVE_MREMAP_FIXED) AC_MSG_RESULT(yes)],[AC_MSG_RESULT(no)])
 ])
diff --git a/m4/ltp-perf_event_open.m4 b/m4/ltp-perf_event_open.m4
index 6966cf270..4a488ffa3 100644
--- a/m4/ltp-perf_event_open.m4
+++ b/m4/ltp-perf_event_open.m4
@@ -7,10 +7,8 @@ AC_DEFUN([LTP_CHECK_SYSCALL_PERF_EVENT_OPEN],[
 AH_TEMPLATE(HAVE_PERF_EVENT_ATTR,
 [Define to 1 if you have struct perf_event_attr])
 AC_MSG_CHECKING([for perf_event_attr in linux/perf_event.h])
-AC_TRY_COMPILE([#include <unistd.h>
-		#include <linux/perf_event.h>],
-		[
+AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[#include <unistd.h>
+		#include <linux/perf_event.h>]], [[
 			struct perf_event_attr pe;
-		],
-		AC_DEFINE(HAVE_PERF_EVENT_ATTR) AC_MSG_RESULT(yes), AC_MSG_RESULT(no))
+		]])],[AC_DEFINE(HAVE_PERF_EVENT_ATTR) AC_MSG_RESULT(yes)],[AC_MSG_RESULT(no)])
 ])
diff --git a/testcases/realtime/m4/check.m4 b/testcases/realtime/m4/check.m4
index e60ae1928..d04a2cc73 100644
--- a/testcases/realtime/m4/check.m4
+++ b/testcases/realtime/m4/check.m4
@@ -1,10 +1,10 @@
 AC_DEFUN([REALTIME_CHECK_PRIO_INHERIT],[
 AC_MSG_CHECKING([for PTHREAD_PRIO_INHERIT])
-AC_TRY_COMPILE([
-#include <pthread.h>],[int main(void) {
+AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[
+#include <pthread.h>]], [[int main(void) {
 	pthread_mutexattr_t attr;
 	return pthread_mutexattr_setprotocol(&attr, PTHREAD_PRIO_INHERIT);
-}],[has_priority_inherit="yes"],[])
+}]])],[has_priority_inherit="yes"],[])
 if test "x$has_priority_inherit" = "xyes" ; then
 	AC_DEFINE(HAS_PRIORITY_INHERIT,1,[Define to 1 if you have PTHREAD_PRIO_INHERIT])
 	AC_MSG_RESULT(yes)
diff --git a/testcases/realtime/m4/ltp-exp10.m4 b/testcases/realtime/m4/ltp-exp10.m4
index 3d2320a20..625175c31 100644
--- a/testcases/realtime/m4/ltp-exp10.m4
+++ b/testcases/realtime/m4/ltp-exp10.m4
@@ -26,12 +26,10 @@ AH_TEMPLATE(HAVE_EXP10,
 AC_MSG_CHECKING([for exp10])
 backup_ldlibs="$LIBS"
 LIBS+=" -lm"
-AC_TRY_LINK([#define _GNU_SOURCE
-             #include <math.h>],
-            [
+AC_LINK_IFELSE([AC_LANG_PROGRAM([[#define _GNU_SOURCE
+             #include <math.h>]], [[
              volatile float val;
              exp10(val);
-            ],
-             AC_DEFINE(HAVE_EXP10) AC_MSG_RESULT(yes), AC_MSG_RESULT(no))
+            ]])],[AC_DEFINE(HAVE_EXP10) AC_MSG_RESULT(yes)],[AC_MSG_RESULT(no)])
 LIBS="$backup_ldlibs"
 ])
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

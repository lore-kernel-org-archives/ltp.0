Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ED78C2BA4C
	for <ltp@archiver.kernel.org>; Wed, 26 Jan 2022 12:36:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C11D23C970D
	for <ltp@archiver.kernel.org>; Wed, 26 Jan 2022 13:36:37 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3648B3C9602
 for <ltp@lists.linux.it>; Wed, 26 Jan 2022 13:35:58 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A557C10001B6
 for <ltp@lists.linux.it>; Wed, 26 Jan 2022 13:35:57 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 430D01F3B9;
 Wed, 26 Jan 2022 12:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1643200557; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R5QNaNhZZAW7kyqQFM19dbkSJZ+yv9Y51uJgbz/mWJs=;
 b=LiRwV+JqrUBE02PjkZ29qcZyu400+aU6WkHZKFhQliCesCMuRyPduA6gT9YBd+P/YOf5qB
 ieqinAZepBjP8FnxT+XEfvsYJqmLTbKPDhF4oPWkIYGjcZ3ibwLT5qsP+FYN22+uJu4sBH
 wvEB9na00GxoBjQ1YQvXXAnwSGO8iag=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1643200557;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R5QNaNhZZAW7kyqQFM19dbkSJZ+yv9Y51uJgbz/mWJs=;
 b=uiuuZA1i4+lw9SjWk2VRlJYT5QfisG69QSUhS7yixliDmeSsZzvZ875+Nwbnd/HX8or7xN
 bNchSKGp0OPEcGBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1861713F30;
 Wed, 26 Jan 2022 12:35:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 8DSpBC1A8WGkOQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 26 Jan 2022 12:35:57 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 26 Jan 2022 13:35:47 +0100
Message-Id: <20220126123547.13298-8-pvorel@suse.cz>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220126123547.13298-1-pvorel@suse.cz>
References: <20220126123547.13298-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC PATCH v2 7/7] m4: Fix warnings
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
Cc: automated-testing@yoctoproject.org
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

Due previous keep requiring 2.61. Tested on 2.63 (SLES 11 and CentOS 6
both don't even compile as unsupported, thus we could bump version to 2.63).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
New in v2

 configure.ac                   | 24 ++++++++++++------------
 m4/ltp-kernel_devel.m4         |  6 +++---
 testcases/realtime/m4/check.m4 |  6 +++---
 3 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/configure.ac b/configure.ac
index f83bbe950b..03184e13e3 100644
--- a/configure.ac
+++ b/configure.ac
@@ -219,7 +219,7 @@ AC_CHECK_TYPES([struct __kernel_old_timeval, struct __kernel_old_timespec, struc
 
 # Bash
 AC_ARG_WITH([bash],
-  [AC_HELP_STRING([--with-bash],
+  [AS_HELP_STRING([--with-bash],
     [have the Bourne Again Shell interpreter])],
   [with_bash=$withval],
   [with_bash=no]
@@ -232,24 +232,24 @@ fi
 
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
@@ -259,7 +259,7 @@ LTP_DOCPARSE
 
 # Expect
 AC_ARG_WITH([expect],
-  [AC_HELP_STRING([--with-expect],
+  [AS_HELP_STRING([--with-expect],
     [have the Tcl/expect library])],
   [with_expect=$withval],
   [with_expect=no]
@@ -272,7 +272,7 @@ fi
 
 # Numa
 AC_ARG_WITH([numa],
-  AC_HELP_STRING([--without-numa],
+  AS_HELP_STRING([--without-numa],
     [without numa support]),
   [with_numa=$withval],
   [with_numa=yes]
@@ -280,7 +280,7 @@ AC_ARG_WITH([numa],
 
 # Perl
 AC_ARG_WITH([perl],
-  [AC_HELP_STRING([--with-perl],
+  [AS_HELP_STRING([--with-perl],
     [have a perl interpreter])],
   [with_perl=$withval],
   [with_perl=no]
@@ -293,7 +293,7 @@ fi
 
 # Python
 AC_ARG_WITH([python],
-  [AC_HELP_STRING([--with-python],
+  [AS_HELP_STRING([--with-python],
     [have a python interpreter])],
   [with_python=$withval],
   [with_python=no]
@@ -306,7 +306,7 @@ fi
 
 # TI RPC
 AC_ARG_WITH([tirpc],
-  AC_HELP_STRING([--without-tirpc],
+  AS_HELP_STRING([--without-tirpc],
     [without libtirpc support]),
   [with_tirpc=$withval],
   [with_tirpc=yes]
@@ -316,7 +316,7 @@ AC_ARG_WITH([tirpc],
 # Testsuites knobs
 
 AC_ARG_WITH([open-posix-testsuite],
-  [AC_HELP_STRING([--with-open-posix-testsuite],
+  [AS_HELP_STRING([--with-open-posix-testsuite],
     [compile and install the open posix testsuite])],
   [with_open_posix_testsuite=$withval],
   [with_open_posix_testsuite=no]
@@ -329,7 +329,7 @@ fi
 
 # TODO: testcases/realtime requires bash and python.
 AC_ARG_WITH([realtime-testsuite],
-  [AC_HELP_STRING([--with-realtime-testsuite],
+  [AS_HELP_STRING([--with-realtime-testsuite],
     [compile and install the realtime testsuite])],
   [with_realtime_testsuite=$withval],
   [with_realtime_testsuite=no]
diff --git a/m4/ltp-kernel_devel.m4 b/m4/ltp-kernel_devel.m4
index 8a0598e5a3..d46d54775a 100644
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
diff --git a/testcases/realtime/m4/check.m4 b/testcases/realtime/m4/check.m4
index e60ae19289..d04a2cc73a 100644
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
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

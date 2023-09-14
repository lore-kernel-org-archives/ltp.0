Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2442EDE9BC
	for <ltp@archiver.kernel.org>; Thu, 14 Sep 2023 12:26:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 465B93CADC9
	for <ltp@archiver.kernel.org>; Thu, 14 Sep 2023 14:26:24 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9AA813C65F4
 for <ltp@lists.linux.it>; Thu, 14 Sep 2023 14:26:12 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 01A4820004C
 for <ltp@lists.linux.it>; Thu, 14 Sep 2023 14:26:10 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 58CAA2184E;
 Thu, 14 Sep 2023 12:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1694694370; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=+6CcQLiJOwtdNH/us/hMLBMXkIRkWC3MxChlyA65/O0=;
 b=tPwWxDq0hHWT8xRO4m7g2rKcGG8q8NjRsR+/CskEqnF7i7XFiM3TmIOfcI7mRf+uX0J8JS
 Dz1ZznGHVGOu6tWVMHzodXkbILIVDB7nMJuTHWKWPF7hKG1ymqH3dnr4bfuaEjt6pa363+
 wWdAWMPqaKsTW9G4LTxjmAAFlZWZdhg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1694694370;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=+6CcQLiJOwtdNH/us/hMLBMXkIRkWC3MxChlyA65/O0=;
 b=GZTgKHLykDLGkIop8ZzRnXPUf1gOXU96YZfbt7zx4VyFJ3gweCFP2acaNOFnVBspyMGHsD
 Myfetg5EkAey5aDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 387FB139DB;
 Thu, 14 Sep 2023 12:26:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Xc49DOL7AmVOMAAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Thu, 14 Sep 2023 12:26:10 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Thu, 14 Sep 2023 14:26:09 +0200
Message-Id: <20230914122609.23988-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] Remove libclone library from containers suite
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/containers/Makefile          |   4 -
 testcases/kernel/containers/Makefile.inc      |   6 -
 testcases/kernel/containers/README            |   2 -
 testcases/kernel/containers/libclone/Makefile |  27 ----
 .../kernel/containers/libclone/libclone.c     | 142 ------------------
 .../kernel/containers/libclone/libclone.h     |  81 ----------
 .../kernel/containers/pidns/pidns_helper.h    |  34 -----
 7 files changed, 296 deletions(-)
 delete mode 100644 testcases/kernel/containers/libclone/Makefile
 delete mode 100644 testcases/kernel/containers/libclone/libclone.c
 delete mode 100644 testcases/kernel/containers/libclone/libclone.h
 delete mode 100644 testcases/kernel/containers/pidns/pidns_helper.h

diff --git a/testcases/kernel/containers/Makefile b/testcases/kernel/containers/Makefile
index 4285546e7..c645d8a51 100644
--- a/testcases/kernel/containers/Makefile
+++ b/testcases/kernel/containers/Makefile
@@ -5,12 +5,8 @@ top_srcdir		?= ../../..
 
 include $(top_srcdir)/include/mk/env_pre.mk
 
-LIBDIR			:= libclone
-
 FILTER_OUT_DIRS		:= $(LIBDIR)
 
-LIB			:= $(LIBDIR)/libclone.a
-
 LDLIBS			:= -ldl -lltp
 
 INSTALL_TARGETS		:= *.sh
diff --git a/testcases/kernel/containers/Makefile.inc b/testcases/kernel/containers/Makefile.inc
index 179809bc1..f8a5e1774 100644
--- a/testcases/kernel/containers/Makefile.inc
+++ b/testcases/kernel/containers/Makefile.inc
@@ -20,12 +20,6 @@
 # Ngie Cooper, July 2009
 #
 
-# DO NOT USE THIS FILE FOR containers / libclone!!!
-
-LIBDIR			:= ../libclone
-
-LIBS			:= $(LIBDIR)/libclone.a
-
 CPPFLAGS		+= -I$(abs_srcdir)/$(LIBDIR)
 
 LDFLAGS			+= -L$(abs_builddir)/$(LIBDIR)
diff --git a/testcases/kernel/containers/README b/testcases/kernel/containers/README
index c99cacd98..df909e526 100644
--- a/testcases/kernel/containers/README
+++ b/testcases/kernel/containers/README
@@ -44,7 +44,5 @@ posixmq/*
 	enabled in the kernel without SYSV IPC support.
 utsname/*
 	Contains all the testcases related to utsname tests.
-libclone/*
-	Contains the library API for clone() .
 netns/*
         Contains the testcases related to the network NS tests.
diff --git a/testcases/kernel/containers/libclone/Makefile b/testcases/kernel/containers/libclone/Makefile
deleted file mode 100644
index 13af52b67..000000000
--- a/testcases/kernel/containers/libclone/Makefile
+++ /dev/null
@@ -1,27 +0,0 @@
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2007                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-################################################################################
-
-top_srcdir		?= ../../../..
-
-include $(top_srcdir)/include/mk/testcases.mk
-
-INTERNAL_LIB		:= libclone.a
-
-include $(top_srcdir)/include/mk/lib.mk
diff --git a/testcases/kernel/containers/libclone/libclone.c b/testcases/kernel/containers/libclone/libclone.c
deleted file mode 100644
index db0d9b2a5..000000000
--- a/testcases/kernel/containers/libclone/libclone.c
+++ /dev/null
@@ -1,142 +0,0 @@
-/*
-* Copyright (c) International Business Machines Corp., 2007
-* This program is free software; you can redistribute it and/or modify
-* it under the terms of the GNU General Public License as published by
-* the Free Software Foundation; either version 2 of the License, or
-* (at your option) any later version.
-*
-* This program is distributed in the hope that it will be useful,
-* but WITHOUT ANY WARRANTY; without even the implied warranty of
-* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
-* the GNU General Public License for more details.
-* You should have received a copy of the GNU General Public License
-* along with this program; if not, write to the Free Software
-* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-*
-***************************************************************************/
-#include "libclone.h"
-
-int do_clone_tests(unsigned long clone_flags,
-		   int (*fn1) (void *arg), void *arg1,
-		   int (*fn2) (void *arg), void *arg2)
-{
-	int ret;
-
-	ret = ltp_clone_quick(clone_flags | SIGCHLD, fn1, arg1);
-
-	if (ret == -1) {
-		return -1;
-	}
-	if (fn2)
-		ret = fn2(arg2);
-	else
-		ret = 0;
-
-	return ret;
-}
-
-int do_unshare_tests(unsigned long clone_flags,
-		     int (*fn1) (void *arg), void *arg1,
-		     int (*fn2) (void *arg), void *arg2)
-{
-	int pid, ret = 0;
-	int retpipe[2];
-	char buf[2];
-
-	if (pipe(retpipe) == -1) {
-		perror("pipe");
-		return -1;
-	}
-	pid = fork();
-	if (pid == -1) {
-		perror("fork");
-		close(retpipe[0]);
-		close(retpipe[1]);
-		return -1;
-	}
-	if (pid == 0) {
-		close(retpipe[0]);
-		ret = tst_syscall(SYS_unshare, clone_flags);
-		if (ret == -1) {
-			if (write(retpipe[1], "0", 2) < 0) {
-				perror("unshare:write(retpipe[1], ..)");
-			}
-			close(retpipe[1]);
-			exit(1);
-		} else {
-			if (write(retpipe[1], "1", 2) < 0) {
-				perror("unshare:write(retpipe[1], ..)");
-			}
-		}
-		close(retpipe[1]);
-		ret = fn1(arg1);
-		exit(ret);
-	} else {
-		close(retpipe[1]);
-		if (read(retpipe[0], &buf, 2) < 0) {
-			perror("unshare:read(retpipe[0], ..)");
-		}
-		close(retpipe[0]);
-		if (*buf == '0')
-			return -1;
-		if (fn2)
-			ret = fn2(arg2);
-	}
-
-	return ret;
-}
-
-int do_plain_tests(int (*fn1) (void *arg), void *arg1,
-		   int (*fn2) (void *arg), void *arg2)
-{
-	int ret = 0, pid;
-
-	pid = fork();
-	if (pid == -1) {
-		perror("fork");
-		return -1;
-	}
-	if (pid == 0)
-		exit(fn1(arg1));
-	if (fn2)
-		ret = fn2(arg2);
-	return ret;
-}
-
-int do_clone_unshare_test(int use_clone, unsigned long clone_flags,
-			  int (*fn1) (void *arg), void *arg1)
-{
-	switch (use_clone) {
-	case T_NONE:
-		return do_plain_tests(fn1, arg1, NULL, NULL);
-	case T_CLONE:
-		return do_clone_tests(clone_flags, fn1, arg1, NULL, NULL);
-	case T_UNSHARE:
-		return do_unshare_tests(clone_flags, fn1, arg1, NULL, NULL);
-	default:
-		printf("%s: bad use_clone option: %d\n", __FUNCTION__,
-		       use_clone);
-		return -1;
-	}
-}
-
-/*
- * Run fn1 in a unshared environmnent, and fn2 in the original context
- */
-int do_clone_unshare_tests(int use_clone, unsigned long clone_flags,
-			   int (*fn1) (void *arg), void *arg1,
-			   int (*fn2) (void *arg), void *arg2)
-{
-	switch (use_clone) {
-	case T_NONE:
-		return do_plain_tests(fn1, arg1, fn2, arg2);
-	case T_CLONE:
-		return do_clone_tests(clone_flags, fn1, arg1, fn2, arg2);
-	case T_UNSHARE:
-		return do_unshare_tests(clone_flags, fn1, arg1, fn2, arg2);
-	default:
-		printf("%s: bad use_clone option: %d\n", __FUNCTION__,
-		       use_clone);
-		return -1;
-	}
-}
diff --git a/testcases/kernel/containers/libclone/libclone.h b/testcases/kernel/containers/libclone/libclone.h
deleted file mode 100644
index e92fdca02..000000000
--- a/testcases/kernel/containers/libclone/libclone.h
+++ /dev/null
@@ -1,81 +0,0 @@
-/*
-* Copyright (c) International Business Machines Corp., 2007
-* This program is free software; you can redistribute it and/or modify
-* it under the terms of the GNU General Public License as published by
-* the Free Software Foundation; either version 2 of the License, or
-* (at your option) any later version.
-*
-* This program is distributed in the hope that it will be useful,
-* but WITHOUT ANY WARRANTY; without even the implied warranty of
-* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
-* the GNU General Public License for more details.
-* You should have received a copy of the GNU General Public License
-* along with this program; if not, write to the Free Software
-* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-*
-***************************************************************************/
-#ifndef __LIBCLONE_H
-#define __LIBCLONE_H
-
-#include <stdio.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <string.h>
-#include <errno.h>
-#include <libgen.h>
-#include <sys/syscall.h>
-#include <signal.h>
-#include "lapi/syscalls.h"
-#include "test.h"
-#include "lapi/sched.h"
-
-#define T_UNSHARE 0
-#define T_CLONE 1
-#define T_NONE 2
-
-#ifndef SYS_unshare
-#ifdef __NR_unshare
-#define SYS_unshare __NR_unshare
-#elif __i386__
-#define SYS_unshare 310
-#elif __ia64__
-#define SYS_unshare 1296
-#elif __x86_64__
-#define SYS_unshare 272
-#elif __s390x__ || __s390__
-#define SYS_unshare 303
-#elif __powerpc__
-#define SYS_unshare 282
-#else
-#error "unshare not supported on this architecure."
-#endif
-#endif
-
-#ifndef __NR_unshare
-#define __NR_unshare SYS_unshare
-#endif
-
-/*
- * Run fn1 in a unshared environmnent, and fn2 in the original context
- * Fn2 may be NULL.
- */
-
-int do_clone_tests(unsigned long clone_flags,
-			int(*fn1)(void *arg), void *arg1,
-			int(*fn2)(void *arg), void *arg2);
-
-int do_unshare_tests(unsigned long clone_flags,
-			int (*fn1)(void *arg), void *arg1,
-			int (*fn2)(void *arg), void *arg2);
-
-int do_fork_tests(int (*fn1)(void *arg), void *arg1,
-			int (*fn2)(void *arg), void *arg2);
-
-int do_clone_unshare_test(int use_clone, unsigned long clone_flags,
-			int (*fn1)(void *arg), void *arg1);
-
-int do_clone_unshare_tests(int use_clone, unsigned long clone_flags,
-			int (*fn1)(void *arg), void *arg1,
-			int (*fn2)(void *arg), void *arg2);
-
-#endif
diff --git a/testcases/kernel/containers/pidns/pidns_helper.h b/testcases/kernel/containers/pidns/pidns_helper.h
deleted file mode 100644
index 3b356768f..000000000
--- a/testcases/kernel/containers/pidns/pidns_helper.h
+++ /dev/null
@@ -1,34 +0,0 @@
-/*
-* Copyright (c) International Business Machines Corp., 2007
-* This program is free software; you can redistribute it and/or modify
-* it under the terms of the GNU General Public License as published by
-* the Free Software Foundation; either version 2 of the License, or
-* (at your option) any later version.
-*
-* This program is distributed in the hope that it will be useful,
-* but WITHOUT ANY WARRANTY; without even the implied warranty of
-* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
-* the GNU General Public License for more details.
-*/
-
-#include "../libclone/libclone.h"
-#include "test.h"
-#include "safe_macros.h"
-
-static int dummy_child(void *v)
-{
-	(void) v;
-	return 0;
-}
-
-static int check_newpid(void)
-{
-	int pid, status;
-
-	pid = do_clone_unshare_test(T_CLONE, CLONE_NEWPID, dummy_child, NULL);
-	if (pid == -1)
-		tst_brkm(TCONF | TERRNO, NULL, "CLONE_NEWPID not supported");
-	SAFE_WAIT(NULL, &status);
-
-	return 0;
-}
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

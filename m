Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 659EFC64EC4
	for <ltp@archiver.kernel.org>; Fri,  3 Mar 2023 09:59:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F1AC43CB982
	for <ltp@archiver.kernel.org>; Fri,  3 Mar 2023 10:59:55 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 641863CB973
 for <ltp@lists.linux.it>; Fri,  3 Mar 2023 10:59:38 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9128A2009F3
 for <ltp@lists.linux.it>; Fri,  3 Mar 2023 10:59:36 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BAEC820401;
 Fri,  3 Mar 2023 09:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1677837575; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=qsyib0qXpc86G+nWXSDb8lOiZcvn3Pkufl8MaeFZ8EQ=;
 b=YK3dbZYUFUNcd+XLDqDRn9X7oAc+Gty9ZPCaAZfGR3ri03chlQkS2Pl48wcJczUnXZtSV9
 eVcqtqRQ5OTQItiWbKAGgqj2sGChzuBk2Cf9bla+vWsTmazOzM+sOL7QozormuCuw2pwMZ
 xi37dgBEAwmUA8J4it+Z7x0evwt6gYE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1677837575;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=qsyib0qXpc86G+nWXSDb8lOiZcvn3Pkufl8MaeFZ8EQ=;
 b=ERYFPTe3EX8SXxmEk6OlCAKUKMFuHZDkTttVu22cegWZOqL85rmJSLsJ/wxGEljFT5X+lP
 CFgUSAQkotqX+6Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3DD6A1329E;
 Fri,  3 Mar 2023 09:59:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id DiMVDAfFAWR9fQAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Fri, 03 Mar 2023 09:59:35 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Fri,  3 Mar 2023 10:57:30 +0100
Message-Id: <20230303095730.26049-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] Remove tomoyo testing suite
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

The tomoyo testing suite is built and installed inside the LTP testcases
folder, but it's not used and maintained anymore.
This patch removes it, so we get rid of ltp_clone_quick as well and make
some space in the installation folder.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/security/tomoyo/.gitignore   |   9 -
 testcases/kernel/security/tomoyo/Makefile     |  29 -
 testcases/kernel/security/tomoyo/README       |  58 --
 testcases/kernel/security/tomoyo/include.h    | 379 ----------
 testcases/kernel/security/tomoyo/newns        | Bin 0 -> 22848 bytes
 testcases/kernel/security/tomoyo/newns.c      |  49 --
 testcases/kernel/security/tomoyo/testall.sh   |  46 --
 .../kernel/security/tomoyo/tomoyo_accept_test | Bin 0 -> 46136 bytes
 .../security/tomoyo/tomoyo_accept_test.c      | 146 ----
 .../kernel/security/tomoyo/tomoyo_file_test   | Bin 0 -> 57296 bytes
 .../kernel/security/tomoyo/tomoyo_file_test.c | 304 --------
 .../security/tomoyo/tomoyo_filesystem_test    | Bin 0 -> 88160 bytes
 .../security/tomoyo/tomoyo_filesystem_test.c  | 633 -----------------
 .../security/tomoyo/tomoyo_new_file_test      | Bin 0 -> 84864 bytes
 .../security/tomoyo/tomoyo_new_file_test.c    | 627 -----------------
 .../kernel/security/tomoyo/tomoyo_new_test    | Bin 0 -> 69800 bytes
 .../kernel/security/tomoyo/tomoyo_new_test.c  | 652 ------------------
 .../security/tomoyo/tomoyo_policy_io_test     | Bin 0 -> 49648 bytes
 .../security/tomoyo/tomoyo_policy_io_test.c   | 195 ------
 .../security/tomoyo/tomoyo_policy_memory_test | Bin 0 -> 34080 bytes
 .../tomoyo/tomoyo_policy_memory_test.c        | 358 ----------
 .../security/tomoyo/tomoyo_rewrite_test       | Bin 0 -> 44712 bytes
 .../security/tomoyo/tomoyo_rewrite_test.c     | 169 -----
 23 files changed, 3654 deletions(-)
 delete mode 100644 testcases/kernel/security/tomoyo/.gitignore
 delete mode 100644 testcases/kernel/security/tomoyo/Makefile
 delete mode 100644 testcases/kernel/security/tomoyo/README
 delete mode 100644 testcases/kernel/security/tomoyo/include.h
 create mode 100755 testcases/kernel/security/tomoyo/newns
 delete mode 100644 testcases/kernel/security/tomoyo/newns.c
 delete mode 100644 testcases/kernel/security/tomoyo/testall.sh
 create mode 100755 testcases/kernel/security/tomoyo/tomoyo_accept_test
 delete mode 100644 testcases/kernel/security/tomoyo/tomoyo_accept_test.c
 create mode 100755 testcases/kernel/security/tomoyo/tomoyo_file_test
 delete mode 100644 testcases/kernel/security/tomoyo/tomoyo_file_test.c
 create mode 100755 testcases/kernel/security/tomoyo/tomoyo_filesystem_test
 delete mode 100644 testcases/kernel/security/tomoyo/tomoyo_filesystem_test.c
 create mode 100755 testcases/kernel/security/tomoyo/tomoyo_new_file_test
 delete mode 100644 testcases/kernel/security/tomoyo/tomoyo_new_file_test.c
 create mode 100755 testcases/kernel/security/tomoyo/tomoyo_new_test
 delete mode 100644 testcases/kernel/security/tomoyo/tomoyo_new_test.c
 create mode 100755 testcases/kernel/security/tomoyo/tomoyo_policy_io_test
 delete mode 100644 testcases/kernel/security/tomoyo/tomoyo_policy_io_test.c
 create mode 100755 testcases/kernel/security/tomoyo/tomoyo_policy_memory_test
 delete mode 100644 testcases/kernel/security/tomoyo/tomoyo_policy_memory_test.c
 create mode 100755 testcases/kernel/security/tomoyo/tomoyo_rewrite_test
 delete mode 100644 testcases/kernel/security/tomoyo/tomoyo_rewrite_test.c

diff --git a/testcases/kernel/security/tomoyo/.gitignore b/testcases/kernel/security/tomoyo/.gitignore
deleted file mode 100644
index 698646d93..000000000
--- a/testcases/kernel/security/tomoyo/.gitignore
+++ /dev/null
@@ -1,9 +0,0 @@
-/newns
-/tomoyo_accept_test
-/tomoyo_file_test
-/tomoyo_filesystem_test
-/tomoyo_new_file_test
-/tomoyo_new_test
-/tomoyo_policy_io_test
-/tomoyo_policy_memory_test
-/tomoyo_rewrite_test
diff --git a/testcases/kernel/security/tomoyo/Makefile b/testcases/kernel/security/tomoyo/Makefile
deleted file mode 100644
index 00e4cc3ed..000000000
--- a/testcases/kernel/security/tomoyo/Makefile
+++ /dev/null
@@ -1,29 +0,0 @@
-#
-#    kernel/security/smack testcase Makefile
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
-# Ngie Cooper, July 2009
-#
-
-top_srcdir		?= ../../../..
-
-include $(top_srcdir)/include/mk/testcases.mk
-
-INSTALL_TARGETS		:= testall.sh
-
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/security/tomoyo/README b/testcases/kernel/security/tomoyo/README
deleted file mode 100644
index 0cb538868..000000000
--- a/testcases/kernel/security/tomoyo/README
+++ /dev/null
@@ -1,58 +0,0 @@
-Always look here for latest version of these tests:
-http://sourceforge.jp/projects/tomoyo/svn/view/trunk/2.3.x/tomoyo-tools/kernel_test/?root=tomoyo
-
-These testcases test the TOMOYO Security Module. And they are not part of
-default LTP build/install/run.
-
-A kernel with TOMOYO configured is required to run the TOMOYO testsuite.
-The securityfs filesystem must be mounted at /sys/kernel/security .
-
-Preparation steps are:
-
-1) Download tomoyo-tools package and extract and build and install.
-
-  # wget -O tomoyo-tools.tar.gz 'http://sourceforge.jp/projects/tomoyo/svn/view/trunk/2.3.x/tomoyo-tools.tar.gz?root=tomoyo&view=tar'
-  # tar -zxf tomoyo-tools.tar.gz
-  # make -C tomoyo-tools/ install
-
-  Programs are installed in /usr/sbin/ with prefix "tomoyo-" and
-  /usr/lib/tomoyo/ directory without prefix "tomoyo-".
-
-  You can make a RPM package by "rpmbuild -bb tomoyo-tools/tomoyo-tools.spec" and
-  a DEB package by "alien -k" after "rpmbuild -bb".
-
-2) Run /usr/lib/tomoyo/init_policy .
-
-   This will take several minutes.
-
-   Hiding kernel source directory by "mount -t tmpfs none /usr/src/linux/"
-   would save some time.
-
-   Configuration files are saved in /etc/tomoyo/ directory.
-   You can do "rm -fR /etc/tomoyo/" if you want to uninstall.
-
-3) Reboot the system with TOMOYO enabled kernel.
-
-   To make sure TOMOYO is selected, you can add security=tomoyo to kernel's
-   command line.
-
-4) Build the tests.
-
-   # (extract the tar ball containing the tests.)
-   # make autotools
-   # ./configure
-   # cd testcases/kernel/security/tomoyo/
-   # make
-   # find `/bin/pwd` -type f -perm +100 >> /etc/tomoyo/manager.conf
-   # /usr/sbin/tomoyo-loadpolicy m
-
-Test steps are:
-
-1) Run the tests from the directory you ran "make".
-
-   # ./testall.sh
-
-   Please don't run the tests inside /tmp/ directory, for /tmp/ directory is
-   hidden by "newns" (a wrapper program to run the test in a new namespace).
-
-   You can use "| grep -vF OK" to pick up only failed tests as testall.sh does.
diff --git a/testcases/kernel/security/tomoyo/include.h b/testcases/kernel/security/tomoyo/include.h
deleted file mode 100644
index edaf1170f..000000000
--- a/testcases/kernel/security/tomoyo/include.h
+++ /dev/null
@@ -1,379 +0,0 @@
-/******************************************************************************/
-/*                                                                            */
-/* Copyright (c) Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, 2009      */
-/*                                                                            */
-/* This program is free software;  you can redistribute it and/or modify      */
-/* it under the terms of the GNU General Public License as published by       */
-/* the Free Software Foundation; either version 2 of the License, or          */
-/* (at your option) any later version.                                        */
-/*                                                                            */
-/* This program is distributed in the hope that it will be useful,            */
-/* but WITHOUT ANY WARRANTY;  without even the implied warranty of            */
-/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  */
-/* the GNU General Public License for more details.                           */
-/*                                                                            */
-/* You should have received a copy of the GNU General Public License          */
-/* along with this program;  if not, write to the Free Software               */
-/* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    */
-/*                                                                            */
-/******************************************************************************/
-/*
- * include.h
- *
- * Common functions for testing TOMOYO Linux's kernel.
- *
- * Copyright (C) 2005-2010  NTT DATA CORPORATION
- */
-#include <errno.h>
-#include <fcntl.h>
-#include <linux/kdev_t.h>
-#include <linux/unistd.h>
-#include <pty.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
-#include <sys/socket.h>
-#include <sys/stat.h>
-#include <sys/syscall.h>
-#include <sys/time.h>
-#include <sys/timex.h>
-#include <sys/types.h>
-#include <sys/un.h>
-#include <sys/wait.h>
-#include <time.h>
-#include <unistd.h>
-#include <utime.h>
-#include <sched.h>
-#include <stdarg.h>
-#include <sys/mount.h>
-#include <arpa/inet.h>
-#include <net/if.h>
-#include <linux/ip.h>
-#include <err.h>
-#include "test.h"
-
-/*
- * Some architectures like mips n32 don't have __NR_uselib defined in the
- * system headers.
- */
-#ifdef __NR_uselib
-static inline int uselib(const char *library)
-{
-	return syscall(__NR_uselib, library);
-}
-#else
-static inline int uselib(const char *library)
-{
-	errno = ENOSYS;
-	return -1;
-}
-#endif
-
-/* Is there an architecture without __NR_pivot_root defined? */
-#ifdef __NR_pivot_root
-static inline int pivot_root(const char *new_root, const char *put_old)
-{
-	return syscall(__NR_pivot_root, new_root, put_old);
-}
-#else
-static inline int pivot_root(const char *new_root, const char *put_old)
-{
-	errno = ENOSYS;
-	return -1;
-}
-#endif
-
-/* The sysctl() wrapper is dead and newer arches omit it now. */
-static inline int write_sysctl(const char *path, const char *value)
-{
-	FILE *fp = fopen(path, "w");
-	if (!fp)
-		return 1;
-	fputs(value, fp);
-	fclose(fp);
-	return 0;
-}
-
-static inline int read_sysctl(const char *path, char *value, int len)
-{
-	char scratch[100];
-	FILE *fp = fopen(path, "r");
-	if (!fp)
-		return 1;
-	if (!value) {
-		value = scratch;
-		len = sizeof(scratch);
-	}
-	if (fgets(value, len, fp))
-		/* ignore */;
-	fclose(fp);
-	return 0;
-}
-
-/* Should be a fairly benign path to bang on. */
-#define TEST_SYSCTL_PATH "/proc/sys/net/ipv4/ip_local_port_range"
-
-#define proc_policy_dir              "/sys/kernel/security/tomoyo/"
-#define proc_policy_domain_policy    "/sys/kernel/security/tomoyo/domain_policy"
-#define proc_policy_exception_policy "/sys/kernel/security/tomoyo/exception_policy"
-#define proc_policy_profile          "/sys/kernel/security/tomoyo/profile"
-#define proc_policy_manager          "/sys/kernel/security/tomoyo/manager"
-#define proc_policy_query            "/sys/kernel/security/tomoyo/query"
-#define proc_policy_grant_log        "/sys/kernel/security/tomoyo/grant_log"
-#define proc_policy_reject_log       "/sys/kernel/security/tomoyo/reject_log"
-#define proc_policy_domain_status    "/sys/kernel/security/tomoyo/.domain_status"
-#define proc_policy_process_status   "/sys/kernel/security/tomoyo/.process_status"
-#define proc_policy_self_domain      "/sys/kernel/security/tomoyo/self_domain"
-
-static FILE *profile_fp = NULL;
-static FILE *domain_fp = NULL;
-static FILE *exception_fp = NULL;
-static char self_domain[4096] = "";
-static pid_t pid = 0;
-
-static void clear_status(void)
-{
-	static const char *keywords[] = {
-		"file::execute",
-		"file::open",
-		"file::create",
-		"file::unlink",
-		"file::mkdir",
-		"file::rmdir",
-		"file::mkfifo",
-		"file::mksock",
-		"file::truncate",
-		"file::symlink",
-		"file::rewrite",
-		"file::mkblock",
-		"file::mkchar",
-		"file::link",
-		"file::rename",
-		"file::chmod",
-		"file::chown",
-		"file::chgrp",
-		"file::ioctl",
-		"file::chroot",
-		"file::mount",
-		"file::umount",
-		"file::pivot_root",
-		NULL
-	};
-	int i;
-	FILE *fp = fopen(proc_policy_profile, "r");
-	static char buffer[4096];
-	if (!fp) {
-		fprintf(stderr, "Can't open %s\n", proc_policy_profile);
-		exit(1);
-	}
-	for (i = 0; keywords[i]; i++)
-		fprintf(profile_fp,
-			"255-CONFIG::%s={ mode=disabled }\n",
-			keywords[i]);
-	while (memset(buffer, 0, sizeof(buffer)),
-	       fgets(buffer, sizeof(buffer) - 10, fp)) {
-		const char *mode;
-		char *cp = strchr(buffer, '=');
-		if (!cp)
-			continue;
-		*cp = '\0';
-		mode = cp + 1;
-		cp = strchr(buffer, '-');
-		if (!cp)
-			continue;
-		*cp++ = '\0';
-		if (strcmp(buffer, "0"))
-			continue;
-		fprintf(profile_fp, "255-%s", cp);
-		if (!strcmp(cp, "COMMENT"))
-			mode = "Profile for kernel test\n";
-		else
-			mode = "{ mode=disabled verbose=no }\n";
-		fprintf(profile_fp, "255-%s=%s", cp, mode);
-	}
-	fprintf(profile_fp, "255-PREFERENCE::learning= verbose=no\n");
-	fprintf(profile_fp, "255-PREFERENCE::enforcing= verbose=no\n");
-	fprintf(profile_fp, "255-PREFERENCE::permissive= verbose=no\n");
-	fprintf(profile_fp, "255-PREFERENCE::disabled= verbose=no\n");
-	fprintf(profile_fp, "255-PREFERENCE::learning= max_entry=2048\n");
-	fflush(profile_fp);
-	fclose(fp);
-}
-
-static void tomoyo_test_init(void)
-{
-	pid = getpid();
-	if (access(proc_policy_dir, F_OK)) {
-		fprintf(stderr, "You can't use this program for this kernel."
-			"\n");
-		exit(1);
-	}
-	profile_fp = fopen(proc_policy_profile, "w");
-	if (!profile_fp) {
-		fprintf(stderr, "Can't open %s .\n", proc_policy_profile);
-		exit(1);
-	}
-	setlinebuf(profile_fp);
-	domain_fp = fopen(proc_policy_domain_policy, "w");
-	if (!domain_fp) {
-		fprintf(stderr, "Can't open %s .\n",
-			proc_policy_domain_policy);
-		exit(1);
-	}
-	setlinebuf(domain_fp);
-	exception_fp = fopen(proc_policy_exception_policy, "w");
-	if (!exception_fp) {
-		fprintf(stderr, "Can't open %s .\n",
-			proc_policy_exception_policy);
-		exit(1);
-	}
-	setlinebuf(exception_fp);
-	if (fputc('\n', profile_fp) != '\n' || fflush(profile_fp)) {
-		fprintf(stderr, "You need to register this program to %s to "
-			"run this program.\n", proc_policy_manager);
-		exit(1);
-	}
-	clear_status();
-	{
-		FILE *fp = fopen(proc_policy_self_domain, "r");
-		memset(self_domain, 0, sizeof(self_domain));
-		if (!fp || !fgets(self_domain, sizeof(self_domain) - 1, fp) ||
-		    fclose(fp)) {
-			fprintf(stderr, "Can't open %s .\n",
-				proc_policy_self_domain);
-			exit(1);
-		}
-	}
-	fprintf(domain_fp, "select pid=%u\n", pid);
-	fprintf(domain_fp, "use_profile 255\n");
-	fprintf(domain_fp, "allow_read/write /sys/kernel/security/tomoyo/domain_policy\n");
-	fprintf(domain_fp, "allow_truncate /sys/kernel/security/tomoyo/domain_policy\n");
-	fprintf(domain_fp, "allow_read/write /sys/kernel/security/tomoyo/exception_policy\n");
-	fprintf(domain_fp, "allow_truncate /sys/kernel/security/tomoyo/exception_policy\n");
-	fprintf(domain_fp, "allow_read/write /sys/kernel/security/tomoyo/profile\n");
-	fprintf(domain_fp, "allow_truncate /sys/kernel/security/tomoyo/profile\n");
-}
-
-static void BUG(const char *fmt, ...)
-	__attribute__ ((format(printf, 1, 2)));
-
-static void BUG(const char *fmt, ...)
-{
-	va_list args;
-	printf("BUG: ");
-	va_start(args, fmt);
-	vprintf(fmt, args);
-	va_end(args);
-	putchar('\n');
-	fflush(stdout);
-	while (1)
-		sleep(100);
-}
-
-int write_domain_policy(const char *policy, int is_delete)
-{
-	FILE *fp = fopen(proc_policy_domain_policy, "r");
-	char buffer[8192];
-	int domain_found = 0;
-	int policy_found = 0;
-	memset(buffer, 0, sizeof(buffer));
-	if (!fp) {
-		BUG("Can't read %s", proc_policy_domain_policy);
-		return 0;
-	}
-	if (is_delete)
-		fprintf(domain_fp, "delete ");
-	fprintf(domain_fp, "%s\n", policy);
-	while (fgets(buffer, sizeof(buffer) - 1, fp)) {
-		char *cp = strchr(buffer, '\n');
-		if (cp)
-			*cp = '\0';
-		if (!strncmp(buffer, "<kernel>", 8))
-			domain_found = !strcmp(self_domain, buffer);
-		if (!domain_found)
-			continue;
-		/* printf("<%s>\n", buffer); */
-		if (strcmp(buffer, policy))
-			continue;
-		policy_found = 1;
-		break;
-	}
-	fclose(fp);
-	if (policy_found == is_delete) {
-		BUG("Can't %s %s", is_delete ? "delete" : "append",
-		    policy);
-		return 0;
-	}
-	errno = 0;
-	return 1;
-
-}
-
-int write_exception_policy(const char *policy, int is_delete)
-{
-	FILE *fp = fopen(proc_policy_exception_policy, "r");
-	char buffer[8192];
-	int policy_found = 0;
-	memset(buffer, 0, sizeof(buffer));
-	if (!fp) {
-		BUG("Can't read %s", proc_policy_exception_policy);
-		return 0;
-	}
-	if (is_delete)
-		fprintf(exception_fp, "delete ");
-	fprintf(exception_fp, "%s\n", policy);
-	while (fgets(buffer, sizeof(buffer) - 1, fp)) {
-		char *cp = strchr(buffer, '\n');
-		if (cp)
-			*cp = '\0';
-		if (strcmp(buffer, policy))
-			continue;
-		policy_found = 1;
-		break;
-	}
-	fclose(fp);
-	if (policy_found == is_delete) {
-		BUG("Can't %s %s", is_delete ? "delete" : "append",
-		    policy);
-		return 0;
-	}
-	errno = 0;
-	return 1;
-
-}
-
-int set_profile(const int mode, const char *name)
-{
-	static const char *modes[4] = { "disabled", "learning", "permissive",
-					"enforcing" };
-	FILE *fp = fopen(proc_policy_profile, "r");
-	char buffer[8192];
-	int policy_found = 0;
-	const int len = strlen(name);
-	if (!fp) {
-		BUG("Can't read %s", proc_policy_profile);
-		return 0;
-	}
-	fprintf(profile_fp, "255-CONFIG::%s=%s\n", name, modes[mode]);
-	while (memset(buffer, 0, sizeof(buffer)),
-	       fgets(buffer, sizeof(buffer) - 1, fp)) {
-		char *cp = strchr(buffer, '\n');
-		if (cp)
-			*cp = '\0';
-		if (strncmp(buffer, "255-CONFIG::", 12) ||
-		    strncmp(buffer + 12, name, len) ||
-		    buffer[12 + len] != '=')
-			continue;
-		if (strstr(buffer + 13 + len, modes[mode]))
-			policy_found = 1;
-		break;
-	}
-	fclose(fp);
-	if (!policy_found) {
-		BUG("Can't change profile to 255-CONFIG::%s=%s",
-		    name, modes[mode]);
-		return 0;
-	}
-	errno = 0;
-	return 1;
-}
diff --git a/testcases/kernel/security/tomoyo/newns b/testcases/kernel/security/tomoyo/newns
new file mode 100755
index 0000000000000000000000000000000000000000..e790d2771ced0007ff364304b71dfcb2fb4cfad6
GIT binary patch
literal 22848
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
YdV%r+bMWpuxqSO(NB&TOKmn@$FXt*$UjP6A

literal 0
HcmV?d00001

diff --git a/testcases/kernel/security/tomoyo/newns.c b/testcases/kernel/security/tomoyo/newns.c
deleted file mode 100644
index f888ca31f..000000000
--- a/testcases/kernel/security/tomoyo/newns.c
+++ /dev/null
@@ -1,49 +0,0 @@
-/******************************************************************************/
-/*                                                                            */
-/* Copyright (c) Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, 2009      */
-/*                                                                            */
-/* This program is free software;  you can redistribute it and/or modify      */
-/* it under the terms of the GNU General Public License as published by       */
-/* the Free Software Foundation; either version 2 of the License, or          */
-/* (at your option) any later version.                                        */
-/*                                                                            */
-/* This program is distributed in the hope that it will be useful,            */
-/* but WITHOUT ANY WARRANTY;  without even the implied warranty of            */
-/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  */
-/* the GNU General Public License for more details.                           */
-/*                                                                            */
-/* You should have received a copy of the GNU General Public License          */
-/* along with this program;  if not, write to the Free Software               */
-/* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    */
-/*                                                                            */
-/******************************************************************************/
-
-#define _GNU_SOURCE
-
-#include <stdio.h>
-#include <sys/types.h>
-#include <sys/wait.h>
-#include <sys/mount.h>
-#include <unistd.h>
-#include <sched.h>
-#include <errno.h>
-#include <stdlib.h>
-#include "test.h"
-
-static int child(void *arg)
-{
-	char **argv = (char **)arg;
-	argv++;
-	mount("/tmp/", "/tmp/", "tmpfs", 0, NULL);
-	execvp(argv[0], argv);
-	_exit(1);
-}
-
-int main(int argc, char *argv[])
-{
-	char c = 0;
-	const pid_t pid = ltp_clone_quick(CLONE_NEWNS, child, (void *)argv);
-	while (waitpid(pid, NULL, __WALL) == EOF && errno == EINTR)
-		c++;		/* Dummy. */
-	return 0;
-}
diff --git a/testcases/kernel/security/tomoyo/testall.sh b/testcases/kernel/security/tomoyo/testall.sh
deleted file mode 100644
index b103be6c6..000000000
--- a/testcases/kernel/security/tomoyo/testall.sh
+++ /dev/null
@@ -1,46 +0,0 @@
-#! /bin/sh
-################################################################################
-##                                                                            ##
-## Copyright (c) Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, 2009      ##
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
-cd ${0%/*}
-export PATH=$PWD:${PATH}
-
-echo "Testing all. (All results are reported)"
-newns tomoyo_accept_test
-newns tomoyo_filesystem_test
-newns tomoyo_file_test
-newns tomoyo_rewrite_test
-newns tomoyo_new_file_test
-newns tomoyo_new_test
-echo
-echo
-echo
-echo "Testing all. (Only ERRORS are reported)"
-newns tomoyo_accept_test | grep -vF Done
-newns tomoyo_filesystem_test | grep -vF OK | grep -F '('
-newns tomoyo_file_test | grep -vF OK | grep -F '('
-newns tomoyo_rewrite_test | grep -vF OK | grep -F '('
-newns tomoyo_new_test | grep -vF OK
-echo
-echo
-echo
-echo "Testing policy I/O.  (Only ERRORS are reported)"
-newns tomoyo_policy_io_test | grep -vF OK
-newns tomoyo_new_file_test | grep -vF OK
diff --git a/testcases/kernel/security/tomoyo/tomoyo_accept_test b/testcases/kernel/security/tomoyo/tomoyo_accept_test
new file mode 100755
index 0000000000000000000000000000000000000000..7c7e5e2e84e9020bd690beb5404f31a48cdf2d3b
GIT binary patch
literal 46136
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

literal 0
HcmV?d00001

diff --git a/testcases/kernel/security/tomoyo/tomoyo_accept_test.c b/testcases/kernel/security/tomoyo/tomoyo_accept_test.c
deleted file mode 100644
index 335818a25..000000000
--- a/testcases/kernel/security/tomoyo/tomoyo_accept_test.c
+++ /dev/null
@@ -1,146 +0,0 @@
-/******************************************************************************/
-/* This program is free software;  you can redistribute it and/or modify      */
-/* it under the terms of the GNU General Public License as published by       */
-/* the Free Software Foundation; either version 2 of the License, or          */
-/* (at your option) any later version.                                        */
-/*                                                                            */
-/* This program is distributed in the hope that it will be useful,            */
-/* but WITHOUT ANY WARRANTY;  without even the implied warranty of            */
-/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  */
-/* the GNU General Public License for more details.                           */
-/*                                                                            */
-/* You should have received a copy of the GNU General Public License          */
-/* along with this program;  if not, write to the Free Software               */
-/* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    */
-/*                                                                            */
-/******************************************************************************/
-/*
- * tomoyo_accept_test.c
- *
- * Testing program for security/tomoyo/
- *
- * Copyright (C) 2005-2010  NTT DATA CORPORATION
- */
-#include "include.h"
-
-static void set_level(const int i)
-{
-	set_profile(i, "file::execute");
-	set_profile(i, "file::open");
-	set_profile(i, "file::create");
-	set_profile(i, "file::unlink");
-	set_profile(i, "file::mkdir");
-	set_profile(i, "file::rmdir");
-	set_profile(i, "file::mkfifo");
-	set_profile(i, "file::mksock");
-	set_profile(i, "file::truncate");
-	set_profile(i, "file::symlink");
-	set_profile(i, "file::rewrite");
-	set_profile(i, "file::mkblock");
-	set_profile(i, "file::mkchar");
-	set_profile(i, "file::link");
-	set_profile(i, "file::rename");
-	set_profile(i, "file::chmod");
-	set_profile(i, "file::chown");
-	set_profile(i, "file::chgrp");
-	set_profile(i, "file::ioctl");
-	set_profile(i, "file::chroot");
-	set_profile(i, "file::mount");
-	set_profile(i, "file::umount");
-	set_profile(i, "file::pivot_root");
-}
-
-static void test(int rw_loop, int truncate_loop, int append_loop,
-		 int create_loop)
-{
-	static const int rw_flags[4] = { 0, O_RDONLY, O_WRONLY, O_RDWR };
-	static const int create_flags[3] = { 0, O_CREAT /* nonexistent */ ,
-		O_CREAT /* existent */
-	};
-	static const int truncate_flags[2] = { 0, O_TRUNC };
-	static const int append_flags[2] = { 0, O_APPEND };
-	int level;
-	int flags;
-	int i;
-	int fd;
-	static char buffer[1024];
-	memset(buffer, 0, sizeof(buffer));
-	snprintf(buffer, sizeof(buffer) - 1, "/tmp/file:a=%d:t=%d:c=%d:m=%d",
-		 append_loop, truncate_loop, create_loop, rw_loop);
-	fprintf(exception_fp, "deny_rewrite %s\n", buffer);
-	flags = rw_flags[rw_loop] | truncate_flags[truncate_loop] |
-	    append_flags[append_loop] | create_flags[create_loop];
-	for (i = 1; i < 8; i++)
-		fprintf(domain_fp, "delete %d %s\n", i, buffer);
-	for (level = 0; level < 4; level++) {
-		set_level(0);
-		if (create_loop == 1)
-			unlink(buffer);
-		else
-			close(open(buffer, O_CREAT, 0644));
-		set_level(level);
-		fd = open(buffer, flags, 0644);
-		if (fd != EOF)
-			close(fd);
-		else
-			fprintf(stderr, "%d: open(%04o) failed\n", level,
-				flags);
-		/*
-		   fd = open(buffer, flags, 0644)
-		   if (fd != EOF)
-		   close(fd);
-		   else
-		   fprintf(stderr, "%d: open(%04o) failed\n", level, flags);
-		 */
-		/*
-		   fd = open(buffer, flags, 0644);
-		   if (fd != EOF)
-		   close(fd);
-		   else
-		   fprintf(stderr, "%d: open(%04o) failed\n", level, flags);
-		 */
-	}
-	for (i = 1; i < 8; i++)
-		fprintf(domain_fp, "delete %d %s\n", i, buffer);
-	fprintf(domain_fp, "delete allow_truncate %s\n", buffer);
-	fprintf(domain_fp, "delete allow_create %s 0644\n", buffer);
-	fprintf(domain_fp, "delete allow_rewrite %s\n", buffer);
-	fd = open(buffer, flags, 0644);
-	if (fd != EOF) {
-		close(fd);
-		fprintf(stderr, "%d: open(%04o) didn't fail\n", 3, flags);
-	}
-}
-
-int main(void)
-{
-	tomoyo_test_init();
-	fprintf(profile_fp, "255-PREFERENCE::learning={ verbose=no }\n");
-	fprintf(profile_fp, "255-PREFERENCE::enforcing={ verbose=no }\n");
-	fprintf(profile_fp, "255-PREFERENCE::permissive={ verbose=no }\n");
-	fprintf(profile_fp, "255-PREFERENCE::disabled={ verbose=no }\n");
-	set_profile(0, "file");
-	fprintf(profile_fp, "255-PREFERENCE::learning={ max_entry=2048 }\n");
-	{
-		int append_loop;
-		for (append_loop = 0; append_loop < 2; append_loop++) {
-			int truncate_loop;
-			for (truncate_loop = 0; truncate_loop < 2;
-			     truncate_loop++) {
-				int create_loop;
-				for (create_loop = 0; create_loop < 3;
-				     create_loop++) {
-					int rw_loop;
-					for (rw_loop = 0; rw_loop < 4;
-					     rw_loop++)
-						test(rw_loop, truncate_loop,
-						     append_loop, create_loop);
-				}
-			}
-		}
-	}
-	fprintf(profile_fp, "255-CONFIG::file=disabled\n");
-	printf("Done\n");
-	clear_status();
-	return 0;
-}
diff --git a/testcases/kernel/security/tomoyo/tomoyo_file_test b/testcases/kernel/security/tomoyo/tomoyo_file_test
new file mode 100755
index 0000000000000000000000000000000000000000..8be72a1960c8132995a8b061c74596cda15e33d0
GIT binary patch
literal 57296
zcmeIbd3;sH`3F4b-UMy}31MHwD+EJWvaoN#8z2xQ5SFm1cnMh`5|T8zL9hxaVu?tL
zR;{%bsI}H#t5sWV5fyOPYOS^IwiOrbjVr~C+G^hKcV?b@&%MdT_Wk4ieBRHelbkcp
zJo7xyJoC&mbLO0TX3o~4lGz@|Q4&0Ax?<|NJ^_s~XQdXtq>~mmNu{WOI#Uf(oq$Qg
z5zsk|4J7eND_UZorSl>t-z1MgO!5RYAn_oBRuYSbjFWAii2^od;z<)sQeu^1(&VGA
z;R2Hm&ktxo;saC&AurR!!bkPUchd5mw0sgDwTekB^<&+5l-c@~c>+i=9blwp>2owD
zEyKcNp-RF>#^@yCfCePK%Al3R!nX)~)bl?L)+}nVEiaK>`dR%YmUhUktywc+TyAaU
z=-QgP=1rqFO`0%z!nmBK`kXPk-o2m*O*&`6QuXu|PmCY`?TQgY&U@eo-8;WGt8>ro
z1E@E3pghtrklq#t&r)g}4z_iF90PD<;gCSS({a#0#^T7wF$%{(9B1Ij!7&2IXdDdE
zE@uKBsxe9pLEO#4JrMgXoQ*gS$8a3EIB3^&9Mm}#M|`lZ6OWEb+vbeHbww&A1`|z)
z9ikYe(p(AJm!S_1+OaPa2%Sx&1|#l*qbH8;I7Z^2O?%_W#L*82!)YeccBhWCtM(%T
zPKJj#+Bf^Os|HOzu}iumFtLF{2yGZ2b^_56z9a$utOR(rMMrX0CcrOAfIpl7|5gHg
zFaiG21o+Dm;6n-UUnam;C&1G$JF>%}1o)2=;2%qXpOOH7AOU`F0{r*{{!o{Iepmwf
z`x4OiNkCr%ydOOA;dvlBvKz;Zj_}VWz;hhwh@Rs}NBAEmz;g`hh<<Q_dU34kh(4SE
z|9S#^O#=Km3Gi<w!2dJ>epCYeIdF8Oe?|iOISJ^$od6Fp9m>BO`0luR>|YcB6uk~S
z4Vd^Nad_2KU$MR_q^hfHo150DV6dUFrY=++tXQ{RRc)%Os8!YV4OMljDb!e3v7td#
zhZ>vfD#}Aus-dQ#%AgxIgQ#)6YOcezalP8GzOtrK1*<mIgw)!qP(w|nYTCR(XH_HJ
zM5bCJ5|C=#pvi+(jg58n!P<HVuc@z7YijB$Rby3oC3LEGDb*CJtZ#<C4b7nneQr|K
z6}9zE)TI(KK)z|i`nvi`RRL}gUf5UzZ5ylV$~S<fDg;HU)-+dBi;8t5-xwplwyLTD
z`ZiUR*Vd}?ii)ZxtuX5j4ir#N9?S+Rf=!|F#!zrWc}<;Snv;PEYEH@A88d@pa>nG0
zkHBMd#(`(;hWa|o!%^0Q>;HfM=R|lq;%|?0P|h4U3$K|B%>!z13HGW*78mNzv`4L?
zLm|9U8qhJXiE@o4;;0Mnz9@>Hao#e9gf@tu5zp&sBrFVQkk@Tnq)z)>c=uc&!-aRx
zJNmisoTo_eyYMVq!f+Q}U+-;3o(nH?31&@l;W-9M2)OX>xlFMO@18R)bm2Kak+8yr
z=e$V5Y8T!;|5@k4b8aS~!G)K(9rHH1@Y43gZ*$=}Pm-|Hh3_Fq#Cu%$o-X_iF1*am
zn7!YH=iE!eZ7w|La1!ov;bo4-yaO&g=fe_?xbU1KOL)?S=bTu=b1uBh{h0TP3(vWu
zgrhF}>4HQYcH#Xl{Ball3>W^S3(sp=B-rtnzQ${!1fL7f`Kp8r7k-!^5%+W9&vfDa
zE_{{?Kiq}q+)_fG3!g1W#FJcj-d9KnxbU1~ODJ~Xd0!%7p$k7+kcd~f@HsC0Y8RgO
zA`;fQ@SGD$XmH^<w~<i1{R3a|uH+BTQmS~zk&vhDx#I1Q`W{hj<KF|SZP*7mcRM`*
zi0O4?YdzYAFzhX+IW)CCr_--7%^|7vh)zGxG>4+ryL9^ZOmhfo-LKORGtHr=b&pOT
zWST=x>o%SKHPdYV)&`ya1=Ad2T374z%}jG>X<ew(H!{s3r8S__*D%eYq%}{cuVk7-
zNUL9`FJqcRM{9;oU&J(rj8>)7jZAZ>Xg&Tl5W_BDnnOhEQJr4HG>3-P=XClUrh71b
zM5h-s-IM9Nboy+jIRv!s*XbEdv+K9+(dj8nv&*+`)9Eox^U~7VpwlCmX4h|Bt<yu8
zW|wbWsM7<OW>;?w=yVUJ*~MG)bUKx3UXoh<I_+VaUA;9!r@x$zG`o1K(&-aSpU(90
zuUP;0nD#S$RHxr!nq9f|Ih}ruX?Ee(BRc&&)9kvfcj@%+nP!)5-LKORGtI8rx<{uE
zGR-d9x=p8l%{04aYlBYzf@yZi*3~+FGt=yftqXPfMyA;XTLU_M4b$v;t$8|qCDZJ3
zt$v-pjA?eY)(oA#h-r4QR)zGE;+B6EU;4pwNMC-WxFwW1ytt(-Gq1R%By&<p%dE^m
z383Q8#BSNMG8cBsF3DWoExRnUp<DJ%ncKkAE&G<tJvzQUbH9%7$-GO)4`d!ed}z_|
zfI7_HlYb<<4fZbHeR<|lB#U>KWcrF*UMt>J&>spNBFPi8GJSOXVw9Uvyn9xrADFIr
z7Sk`h`rqK+HNLe#sl)65;Xk4R5bz2R;hqqFxRTgbK<|Ir?euL(s3qZp;L88}@Ta2!
zswMd!^Fc5i1Urs&+wo)c;zNxipkTx3fC`^M^>)Ar$zQBO%`X2bvWr`u2>%lT4B3Gk
zkbTKQHQAGzY>Xv)K0+2I*`Fh1Kh$LBS+ZZ6N?Z%1sl@Mr*nTp#+m64&2B^(N$O#vL
zn<_p9T=+JOCWnva2GpS@R3f|?c?Z>+0F-;=K0dg}ht4k-?|A)_;$L>Vyn#|$UOUu=
zE`69(;TDz%VV5t}S#N|7{L2V0LV8!)-%50`|2j{pgF|2k-4x*v)!&tNjMxm=QDYD1
z(@t|u*6*1$HIn7aLspK-x|3OxBU#1F>S?mBWfmIT3f#%8liDO{o0&B&lJz9B{%W$$
zXV&;gmM<S!51Xu+%o-cX3NY*E$U3}<(2u`tYYY2eBkhAvB)85p)6DRv7y-j?U|7y?
z3x^5M^x{-U%G=0T3C1Uq4}zQ_{1{9H%0s05KX8R-fim0;Jo!h?edIni&cW_54%+Vm
z*hE_k9-l)+z^cMYfbQEwvi&%{|MGqGB~VWTwdOQt{|ZfG82$_h4KN7#hl|NK3Stb=
zlM$j{0lJUQ`~E%m(d*v7Bmcv>Eq^+{xaF<l?e834ST^^GBVT8speG*MqN68{_QW-=
z_unQdg&s0Xsig<@EJA*PKDQhT_2q*OeTht4b(qMuqnd8jBh@-SMBLKiOFyy<#SeY$
zEp9np{80F;V(0PVKYbnQ9g)x_DnSYVwt_``#M0b%X>rT3@D>cXk0+l6jI-(yE&r28
zs;hIloqjpBzy%pawH#aZehUgWC|<{RC7*e=Quk$IXen;_@=$>cF*}YN$RV!VtS4dn
z9&Gx8lW0aQOJDA*_mKb45j4r+<sc1jK>nd^Os-{eI(X3I`~Fj~mk>MLV4Vo|I$|jw
zwC_hG+(zubK?LlJz#gRBLxm{)@O{XFO8c0Z+#NkbYs2}5u1~?&Xpik}ZK34wO<+9y
z2arFJd<;llp~E}B0PZi8zJ<_nLLov)*?=w})Q`|=LZb;SBQ%51UkEKGG=tE3LX!yT
z`sNV2jJQlfy0!xdT~AyFAzjx_gjk92zdr|bJ91fr){l^iZLh+mg=Kn}TDnA!s;po5
z2~<jtK=;EU#VwEBA4V6u??Fh}gD%jrg1xAC`y;-CH$=vtPsy@t-pS$}Pc^@O|4}$y
zQT{vdhmw|~ddw?sc>}{;am#y$KJNwtlOVhwTIyo%gv}2X(C`|65?TTudgO7SM@P_a
zTJ-HeAMTFJz<ub`Q15S_+}iC24{v)-UH*LYo|4_`9O!s#Il5_2(Ab_`($X4U1QknK
zJ~}*rtUj=Qaw{nB2W8=br%^Z1bo;@PgF}RC5U#KX-eE?!q9gEz?%;17g$CAsuq*9S
zmN5)+bQy<_z!u@ZvP!$ss+q+(gUJdr>tT~Mk6D~Pn5+zp0^y&Vth`u(lbCgt$?DB4
zPAUx7YG!>)XBB+8OkupEZP3ESEgzq|s_?wRRju1Uqb3DcO+e4%h;z^*^+Hu<gVhXM
zg8;caLie{>yLvazR;p;n^Py4OpKzKdhHw3}t!>w&?QKqIUYPz?xT3h_;X^YaQA^1`
z(pm-uKpX0F&fzkkTVDXj%EP4up8^=J)DpsfrJgNMtZ2Ol>B5zVN0Hz*z%pJGmMtwl
zFm}wu36uO2@|PT5j(kja_M_&UWpIKqJTEU#g>S(~s{Qux9@?U}@r`bmUyo~V@$U0D
zBYKQFR%*^S!sBR;mXE`=C<_;c-e|_dl@K02mxD89=qW?^8PajK@R+VysBiJ^i!=Sj
zEsuw<0VgGlFcSWZ*~j4!CG@8%mjF6^1qy?8Pl5tt%H5ow>?(L~95jO7dbW?)4<Z%r
zWt!(hWQKiOw>QG8!MFWnTer)P^4j(muq}^;M}C5fKQ0oFcDsBR(7P_q92d?4A%MK%
z-JwkXLDU%6H=qt*MRl&kIJXPM<YPio*pieP=yu%`U%U|>N`0>*K@A8n!MX)7l)azI
zJ_dC?AlUv@Tc|VY_&5qZ{3{Yq1F`WrOTSC#pT`72=&vXJgQV|DdiG0^f3DEq?4qwG
z{qITt7Ywlnf6IaQ2$?vNLa8%_X@iR?pG<F(>E|5TIg`?(9q2ztmaasBi{2sqanfH1
zdem4Cjo&8e6X9MUJp3^;&q3y{f>C49bf1TRd_w1b&UwJUm^%%*ocsC@s%=n`qk4WD
zo6`?<RroX`?Qznljs$&IOW*IH0>vSY{f54u7nKZuXyji{`u?Q<3&%~!&p4=7gPvCi
zL!ZINYvBhCeKqNalm2!~?>opxf`@n=G4wvI&u&9Mf%Fqee=+G>-aM#|fST7DQYU3<
z;?;&Yg~W46Tnb`yb=B7*^$%@~R`!rm=I0{cT!+V-tY?|EoLRk?rLU-09@kvIVb*G9
z{SyPmAzsqV)og@e{XX+6nExvCc~LXhxQmQdP0YW5`S&rO7dUghn_}{pAireyOi%ui
z`v#&m2iN0th!?t&mM1>>B~I1sbB+q9LZAHSjSs`5m=8k0;U-8%?^*@f2kU^vWdwe|
z*XZ^IoLF4@ey|_*a{zY$6<_-3eo%9aeMI;9{O38F|03KALfJQUZ!BqfH~jX;px%DO
z31wlpxfKaLp6H>e^%CfQ=sR#PJ9>schv-9PqoRmoK<N2Z;WAvITRz9IIJf1iC5Jf+
z)x#bJMde3j20`QEmbWop-N)a1smvS2J3iF67Tr<Zq8*=O40?7UCTBYiKyzH=4$ec#
z+8+5waFGsA)*{|J)P|dCaEDV^Pu_pr1^Pp&I1yXH`rxAMeO#%-KZW)5CDdMhkMLUA
z+y^Or3qz@Y20aF#Zr46qwBw!7K3sSy<w1>Y-ot_P&5v*i*#5N>`gV9WKs)Wb^ikI9
z094mjE?iZ3K4zLw;hzUP19$jGC|WBY{ucGzRdAvdx5mTtWqB4={W!c6(opZ_+YVg;
z;*ys44&RO#!^B~lnI=5E8;I~-Ol}4A{_BzXD(6FmEuSr2GPmX5=K8{UI;`!3R^eaK
z2nnqHXJ}Wn<3nh)0va`MDM7DuSvvf@=8c;9W@t%+UJ@~}vKX2eE<}6n25QHV<|kOK
zyFaA8zM{SQ0F2m+nz`&{=H(sOtB?xpDmb_R_6oY~wF1(hdBk3CiM_rDjzg@!vDY>x
z<L$LvduZ8Q+RS)n#T#ZOdFcoJXtRq@g_4$!aRm!^LqYR*ywmOSR5UNH&%2WTx_=C;
zyQ^S4lq#wCirph)`(s_{r3cV3x}kaD_swmAuYL~quJ};5Z%NB>?eH)Xe7&UQt%&=c
zjY72hwxB^Gw!P&8V{PrePeb&5U6CE*zPA_e{x(Yf60RCP_P)0J54T-BDx;wJn&Mrd
zOyAkNFP@qfKG!r-Nz30uIpM*O8g2n?q%l}!S7Q{OUl>G#&<p<_J`Td-U1ga*&O-a)
z9uY1%3gQlNex^+f#6Tci6Ee=nceEYi+`HQj{`iQ|WGAlF`E7?@K`p`;8~AO)d>#k<
zal(}b{)+Gl1E*ko36~hSH{pPRhY%iT;9SCd-U2z(2@f)G31L2u1O6PsNd{g=_$02S
zz&8{Az`)xG9|e49Hz4Tzg2Dfg_$P_~nZZ9m_-+H=MfgDj-$MBJ2EKvtO9s9Q@QOok
z>qP5TBo1Rzq{7W4p+QWtnn~KkB$qQuvzTNtleCOUPG*wEG0723(mp0RkV%@zB)c+6
zE1Be1xOQqondC=I(pDz<29q?GNj}FUEoPDrF-fDD<gb~e-AwYQOwxEJc`cK)o=NUt
zk|s3CjZD&tCb^bL8qy?JFiBgQ<Xk3cPLrI1<T=`+I^8+~>F6!}p14qm{yw+mWe$@i
zyN4}16Hg?HcaLVgq_E|yxh<cUWFMo?7C-crH#{-SPWNHRpZ~hd?{)wBd{)cHg>Ak5
zf_q4(c=BJH-{Y-|xo^=O#^wKU#qas#5%gNh2M54*fxnk-Xl@GmtIKO@Rnxlq=Gsbs
zQ?vOUxU8xvR8zOsKWyyyrYZj6!<w@FYR1wzQ~WA7w4ota|B@XHfyku!lXtMGzPYiY
z%7rz*M7PJw59=;c^Mkqz5&8Aqh2zijuB86$JJ?vYwjB<?cDKW=sa@X=S6x$G-ww&w
z1Y(f*(cYD|Kk&D&m1I=HDlU3$nmC*_OdQs{pI}(4Yig^eOyO$@&G<=wVPicJe!P3&
zUtiT&S5@n$?Nima{Tu2ls|qS>n#$MIR#o~pRyD4{3jzgo_5Mpz)y(p`tdO5p^ABrE
z#fxua#*ZI8tVzu*oj<>5L77b!08=_|ihp5M<A$21CcKg0udJ%8sjAFTvkT{z6wR8V
zxzYM(fKI<K5UL%%xTtVewj`D>o?BLwtu9o}O;vb5V0gC5#Y+vjXlMKK1S_(!3V13r
zyfnCYR_TJ0l_0CE+L&9{jQ0<0#`47`BSN=)afE3m$}IC=>@N)#t(aL7L6<FFx?pB@
z^mPrCqCI2ylHlCgi;L#ClQWAUE}A=|WS%=YcXp{exukTa&PMw~rgnM6#!~^<_GXrT
z<3i`vYzp#q4#1UFwN+@k@&?qn(l!NO@_;dIo?lHfjXB+B4{Ks38);_gg4uKDOqnvQ
z39XYFgHpydXdnyfw?C?E!oHbeh|K#b1~xCB2%esAIX0}P<Jp9CO`D9o&7$40vC6z*
zB0|>S6&7LKu)bnld81`BZ@^d{{WgkWsaOYhwKNs$>MxAcVBOkAyl|r#YU(ROcoj#(
z=*RW-c(Fw%Hq<xQ3Eb>XG}LUY4+S-4E?#HJHAc;CLf^p)F`IKk^&9Fp*XPD|2Y*f~
zUXiJ-stEb<+D^f+=2SW_-U%{24ULehq+6-ls`AD<42P=0_K}TMs;UmXv4Th&PF1!Q
zt108!H@*v_-<m+Wg^P=37cDMYFtcdN6j7qU)yqj6PZv=vjxe4sT9;VDcsj8{ELHn*
zqxx+q-xRE>3pH*o7?U?{lGG;`MySw6s;dg+)--G!hm(E_sy5hAkJpPD%j?!w;l12b
zv|(jE-$4R-ZB4~yYo}AuS8b}OYT!#&E*3K?!dp?AU)noV?`OSZ`kj@(vcB10p+{0U
zh(ENhriol@8_PH7@mM2_%fY1(PNmO=^1AZ1RgGFQ<<?bU&_>y~h}ATOsv2X(BLhPM
zvzzN;a&$qbDhHlj9W=&Lc)P3qLR==xD|2=C^`D9{#=xfK48IHv|1G!r@5+yFFsSff
zl-~ij@c)PPxBkGI{}<)DxbSW|gI^|49J~DM>g(4x`D^O@rf*j1t9FiGQ=XDO+DBtp
zwEyr%hk<i>22SD`ID2Q{w4H(Tbp}q<88|~{;MAOfH!lpFj5BZ+&cNw61LxfgoNzO6
zrp>@9HUsC@44hOma5l}rX*9!2Hs+m(JIuhX9K$>tm)SUIV`rdu>Q%_c!#frDYg^kZ
zjE}ap^~0^5|IN0xlX$9`@lIRYZNMK#%%^~P$J*M)AwGh*1o57C+uAA-@5l6dKVpAt
zTibJp^Kk3P-%j`AKD`9-b9lb76LB7%O}&8l5T2^`!|l>^JXv1N+a?5g_sh9xv2r$L
zI0L(O_U&;xXAnOK$LhD++D4MlhK}jYJNlabFVLB?(=%qL_dB~=mkWK{)L8?jju@Lc
zgd)g~$22Mox%^pK%}USMobJ=__v4pg<$t5C?N#Cn(=)bv&Q3pydXZ-nj!(fu+mXlf
zopc}ZdvMgkP7e$IzI5Ltz_ec`?3ILis~PDTyFD|~`(5Roo$kLPsW5%`_T;(gdEWb-
z)b!!A(*1?${XjA!-B;9Q6v*GfaS}FWnJlX^HQiU%Wj4-dcPZ58g*X>=0fS!i(F-~j
z|GllPOETyo=qe8cUg4dW?%$qNl77VTUX_%p3qhU0Q`iM$0UT^gKb|10MNGc$Qperi
zqICaN)bWbsS?PJ(J1t7TE8ux0H9c>3`tZVZKS+$Ov%0XJd%#<QCmvZ=hOH+mW$Rf+
z_8U=8R6SD9*<Fgk`wVyj@EN{m!1BMx^1thyk?!A}G$VcZRV@FCPKD`{ws$T|e=gwp
zBsG1~?DRaS29k&#MP2-0=X#qm_}xa@8#eQHhi!c&UA(g$SjqU(H01gJ*4B2MG`fAg
z6&_I0AoK~oa=|CCdh!7oRv*~I>QhX8imA{1^gv_!q{4Q}=zetz<h%qqNs#%!@IMRu
z&jSCm!2c}pKMVZN0{{Q9!2Z4gt!#shIYnXMS{R0|Cc-;?0S%?ubkcB>?r+nwUYfrV
zGjJ}#AZrhf&kyJ{=dKKrFLQ?*JOQHBXJ5C~Gxj9~80mGsj5AUKjLaHT#CbNK_gV~_
ztiGJ{G4wN$Ue{_t9ogwPeuEF_G^a=m`ptC2GVkuJvC*|X+qwiaM(}={mU^tV^eHx$
z^6~SHuFvt*fX>11fjTXA#;t=+@3i@r{r|H_)~m-C*e4^PQD@qCf{ka}c$tl>ZM@OO
zSJ?P^8{cZ<-`e<b8^2`ZcWwN+jXQNW<@T}hnKqta<JmS|X5(rbZ?y3hHoo4*x7zr(
zHh$d3FWLBA8-H%&PCab-Ha^qF6Kp)&#>;G6ZR3qLzQV@W+xS)+|JKHj+xR6LziZ>q
zZLE#%I>BGsm~6-jXzXzt&zU(BzpN}-x}?Zo!iDzP{)su`bMiC|PrSb}zHK~I_H7s$
zp@;?8FFks7ym)kM{xqGx0cVph<3SHgCgXwh=U8ssJ8Ay!MfmTs<IQioSxUTr%b@Q`
z5%Yaq27M2sq1cnD-|4uuHTsBsu8Ad!q>TPAW6gu1|I&_Uyp?3|+3`%$1{*z(0BG&0
zyRO*tUwr}*B93)MIGk;GIT>$>a4hjTi*W9miE)Y9=i%_&2nkN#$pBNlep{|LDH-cY
zRniz>^&)*NM+D?^wiAKCAG@OkT!ptdlhjJ!eNJcS)pafgrg<2A8e9z!Mz+WCy@xT+
z<LO+Eq0*Doc^vBR@paB+<aGJ~dEWjwrJR{fYEN<@gm|xol$7E0rX-_Rat&bbyiP!m
zm`Flj^0$!i4khc=e8Av+fIQbT(_0PUDK~5*_#(j{YVbEuG37=I>crEtI69NlQ9hsd
zeN->yp>0T}_};}i^>v(};3p^`nF#N_U{5Xj4Z)8<+~pNr>SUDKb$CxA1_K-fpwlRv
zcxdU!o`y#4m!`M`Jncnjou;UzN_!p*22M&l57N`LPQJ7i(AmHls_T!Tz$@wb&%?-R
z%^*r2OXXGCV_;67KrMY~FQx#VNH`<yB@~uEiEzKPd%=`GnXo@?7tEhNh4ApSTcJey
zRKj^_|0Fz(@T9bpC^)@<a3JkP@&*VOr~QKXLc$BvRueyi@QSp4ENfOPFsswpQPO9B
zjPts*RF+jtJsZ-VCCyyIp|s&F>+Bx`-jwzQ>F2YFx20W9{TCDgzAWt^%PRd0x!cno
zCC#E_SYT(`DDtkn4K#bwzJ?{!&&>e-hO~QdPCsuT&im6&5?)0eZcDqAa?WQX-<39u
zb_;$5_&{1u>b9Et97$`XZfni}*Q3h&6GYuQvyswUXxow9wgHpkdk5lDe8hKp7hKfF
zHf)OTugL56FJz_ox{&>D&Cv&EO`9*YJ(V{AnHl4Jp!I%;Q^x$~AS~lEVp|q#Ha2l8
z!3_L1sxq$B;1rl9W0wZK$m%|Tns>SuU<;Efc?+Tx--p!fy8u&p%J>(=b{|Lzbd*|H
z4n1xJ4ASE~WOPoV`<>Cx3%KV6I5|DLBG1$F8YtlHIUig}J%5jLa!)S4=+rX@I;8eW
z!Wqt{dgsHMh`l8gIEXFS^*VqVJ%2qG!qVPE?Rwrr;VNx2@ICJ(+G8v-6QH(Un(8_j
znRUHR<IE?m5OA;44b$n+x0j!2%d|<D)|;B|lypEPGq2B&pm^`W4)J|%B7C}rJJCz;
z6=Fwa<dI<C&v4GT1GVY1pT^9%6_xDslWhdYkl<ELa3=|Vr3r2$!JQ=NGZ|pt(>-1|
zPKuA>GbW;~`ekZxKd}AAXqNAyKK&+YurI->1ikdq{{46<^78%V{{7D<I3M-xKcE?4
z-;4n-ZKIH7Kn-|BgRLn5U)@9OV<>9CYb-@|8jmxP+L+x`rvPB)=yYe*X&&IaB<)pQ
zZ$_hK40z!wpwd31oY$8DL>rSR;|!bzyu-|l4Y1#UV;UTd^uTet662uIzzN&HkWq*F
z4AfQA!)OL_x~q&WU>j7Oj6}wLI1O5>*}jdE2K|;`|KEeayG?t#H={8C6p&{@EAOQS
z=@aBvsIm7lgH#r&yVIo*Jb<Gv)=>4o3kLLVZvZOAtJVa7g<9Ohz<c=#fGOU0$^*oy
z{#V25j_x-p-lG;ds6RAwCa|*%dY<4!4gQJXBn{pV)tt#1Tukf~4c<j?ss_7~V44QA
zh%M0I31X*fa5k}LY4H1~k`vG%mz+9<8hn<tGc@=HYU9k*;M2s;(%@f+Eiwee&eq`N
z1m|dQ2;~+N?0+4xXVcUv-kpmAthqYvcN8$dAvS(O<J?q$sn6i|^Obtj&UK!np$0i=
z>Da>P3*d2uSEr!_|4Akg&iDsLj^FhP=ma~H_v37M!;rpsLOmDAAzcCRc4CMF;QJ&S
zIuy{0mZb+V2;Sp6$u<{RhmjmI9l%=z#sc6FnfZ6i@!Kib9>`f5ZQ@~0nK!kq+c0O5
zrwJTG_kp9x&Vfz?g28*@F^WHkEdHEw=A8gC*I1&*w8Sz8Rmzg8JO|uAz@kgynlT2H
zl;Y*WJ{_`7T8&-@Z3>J6T56D4YvsOcG^Jdvl<I9b2N{0l{bD`1v{I{~)DS9l6{|YP
z5=In5-BP?<@n?dTCPV{8+Q~yA?RO&WZAzPHrJXS9q<FbBkO9?k@*&zmQi~MIh{%8T
zfWvA9)6rM8f>QuwE{+$;C4~$k(&L+IWeRCT=9kqXvr1%MO_>|wWpXWItW3;LwVpy6
zk@>HKBJ%-}8K%sg@iMuHF;*r94=qzjBQpP;jtR1^drx!%UH7v9Wd1Z>CRabk%EZiG
z%M{Xx%&*pn%nL;3^^|!iUM81K#>yOTWeRCT=GVU!nGcD~4=MB2c$r*p87p(Fl_?I}
zRp+C(gpZ2Me(2J=x0o7jvaTH|{q+%G(pH)!l$qa;?^oJ=x#rRYZJQs*OZwwQB8fK)
zriUJ|L=o5J@=AuNpN+D0c-WF+%+ta9;w>WYCXr|A@KikITQ7ogILC%muV}f?R66_J
zo&hb+nTo;Tq)ntD(J4)L_!KW!D>G1~JeAeW4hkGV#t04H^0hQ6UM^$SAv?>`_NVX(
zF2?o3$T!v*Al%Kkz|FYI#dwP_^40AQ7@OUUSJ=cb6#t}Qbf&26A6axh(Al@y1n&Z~
zq|G?6{nIk!t4uMyYrGqA8LTNDh`y<VGuT;x3(1gckoP3oB=c?SqTfPEdZ6V(U=y@}
z9=4?-0<xU%iGbr2Fvt=_1aLvH3E5#QJlq$W|Jx>bf%^?apfn82*^cF3&>u8Dn;^~0
zmL^YSr&%;DkS!YhsW%cMZH_KsjElQBB(MZ<Pqb*3kUh;NG<Ts*==<xDojC_Mc0ALl
zuYXEKJ)E0JIx0hF)&RlVt1RCzLzOoiFE2<@+C$_O3YFE%MRRuyjl5o=vivTZ7h`DT
z)eDt1%0=_f7#evkLuE~J(VUiHtFHBtS2k4EEEi2-42`_bp|TdbXsTjp<W&!qb)Ji+
zC5A>`15sJ)Tr_vY(8wzyDl6oo`BMyyygs6`wz+6Ni=mNMOH|fXE}H(`-F27OPE^(n
zE}DWE8hIr}W!>VUDUYF%*Hu*3T`rm(F*Ncji^_VyMe~0#H1e8@%6ig8^M@E3c?Cvg
zz2KtxM+}X;9;333x@da$aMxX4ol#jIxM(KF(8y~w7*<_0t72&6l^d0nbY|4&FO8v*
z*KyS7?k<|2#n41v)yW#@qItm5j8$19T<D{M)-D|FE|Xm}Nj*(<$7-5rcPVz!43D9S
zc9-QYnvxirXm_c0(KN)+M7v9~i{{!GnrL^q+(mOBh9=rwzVD*>OAJl4yWH%e;X_1@
zZl><h?sB(_CNqX6+Fg#gXo_QKqTS_>E}GgHnrL_Vn~P>o3{AAVeCVRNCx#~4UH<K&
zc_oG>+FiP2MP2XTF*MQcGQdUS$B-ShPqe#ayJ%*`&_uh-Bo_^L;)%+Mc9%IWnyX@H
zqTOYgi{`Evnn-uasdmvs%ZYRqHSz}BNjuMO>u0L}urk59iPyXAYc2W!=PtL|#G^<I
z=%dw6@p3`04q3l;WlxrDuBSEG54f^dNH&+xn(W72*%wMSSIe60=Umy>OEwqBn(WtH
z+4o8|SHqg@cWm}^(EJ6-<`P(w{gI3N6UpX+R+D|wmE8kYff-Z0+_=GHd-@xQX33Xq
z?&e^!ySlO$N;X%+n(RKV?0U)Oz7Hnb@5=tJWOJ>o$sXa#zC*IP4BBLmb7emx+1xfl
zhnyL%Y+WfXuQg%h_mklkj~?%95La2Wa}%dHL*K^S?p$jX*h>fJ>2v#G+Q*$UE&}h6
zPXO!#kohf3_?M~HbfN%8RgbR_w+-IZZMcQa@>;_8L3k--X_dGu2m^?{sYe`@)x%PK
z0ji%1m6%&oL0EQwOQjumxQpdAVG$cgSaRJg(_JiSsIt~Y3>#r7a<i1VSOUVr71I&*
zshF6Jim8zYXyuZl0}YXWzYu8Wrc1N%rfYSjau#qtn8$U24FmD8XCdhqUX5Ju)kn9S
z@tX;F20O?wuLg~?xPAak{|L}evkjgF&=dW8$g2R(2ar#yG4CMdz54hT|HlA+3ABD#
zlW7IPKstEWkESp_tof8O_^@U~X8?RyQwkt+n&q$$Yw%bEmht#1(WIV@kdZae67V)@
zC4^}!axVr3(7K+pWX`g*e9i(oEkF%Tornc!HfOA6LoLht!WKgYAghu33<Iziz}R>~
ze;#r^L{3(vOOdxaR3vi0mbJywdT@j9pdctiW3y_gROS^O>6s<1@T)APCK#p^FE_W)
zA$y)>x*pkCq9$qA2yJDAcDIXG<?;Q`R6OA7zYMqg&UuF*k4@MAEi{R<irzuxhAu}<
zQ%(!$(r|Ux!Kn$;PM08Ss1HCRfH?%#0=OPP<{-<Fj;hkBbu||`<1q3+W3|xthp)I2
zSx0T+G%yVqWE!gp93NSHHt^Y^i|&7C+G1GYC59u#%e^dg$S$zi+Bi4)4SGDJTrITR
ze1k!|Of<2Gx8iqLhC(p>N;8ysE(Rs5k#*2!&PV2BMjCluv*?vTw^}rwk-;CiXkUlS
z_gyq_0X{=RKG*P@FfPp!th0#H!DyvhJEK|d<*yxVrSa^-`Y||v-O^7{g^TZVJHM+(
z%j&17$C0m}qW0$FJw8R93_zW67){mB7KEQglyl!xWH|=(d8B*|z@-HK2!OwBWKOWu
zm8cv0QIkh2E<-!}rf)sGaE_&G0^NI%DRndt3t^-smVm96g1UhK{dHu(R5xpl&E5k3
z(Iy-H17+!90EN`4>>5kMmd$Lo3AzLo;|MWyD%AdgbsXG)=-{lp4)TV~L)M>JquXqL
zi>;CG3SA@d1A9H1W4#Esa7IeQ+myoVQ5y}!>(S6uh+Aq2BiAEte8K>!a1L{I3t6H_
zU)q>|x|LQ6AzB)ixT(w?r;?U$rQH%Q?c%K>ZJ$VcgwpOkm9#Nd+6$JbpVk^aaoLL^
z?PHPFs|%#P7cWgFYiuRo5q;(5)-3vZo-#O~<wa_|bC}=OH~?X~#?_QMz!FC67js#p
zlMZb`(}gS<RMWw^_Dah8HL|Xuyjua>OW;NTuT${%Eys1!j5p@#W|kSG)>dsB<}Btg
zWed3_zK|b$EQNILY6}@jfQ2jqkoic5g~&YA6yn!~yds6X5MRiRWoJMnYjTMc@)IfK
z2^R86hlR*&))cZ@7xJ7Gl5~1Nn<-+hAKxd1d?JPP!P7WhlW71lhgyzUbIF|86q2C}
zc~S})XITd6qTo6EPa9%u!W~I<o9vQ8?q(qiJ1j(I)}|0R(qhkr5IL031Erh86LoMN
zTE#N>IPkBOxYZ5=k*9gwd&Pt-83{P#TnsKf<Zurr9kTBnWFQVF*`L|OZPPfISx+b9
zy~4=NkaWm8-)58X4<?(#Pu2w%&mrlU3opH&;*y41J-A(x5%*n}xIrdci@VV!Zk!7*
z-Jjx?h`0wM;tsjQt#`5g-X(6k3orej;%*jk+-%8c_lZl~K^I$_OWgA=ymWku`-g~o
zGa_!N^<~;FB~#l%S2ow;X}dFA_{kPeaRGx*@p6|Yqg|2B{>?O{Dka-Bg79%_iKStY
zS<77V_6Wnr5qT9h`!MAFTxW9-&%VGdLWUx$^k)&l-Jf*GzR^u9BMNETgf>;KdfC5s
z)5^d=+L6Pon{d}BBlk-;t@LlwE*IM25!w;9pXn+~Hzn<Mq2+E*M(%PqZMjX5_D-SY
zW=}d~HP~$4Q@tqJa_5WjRo{ALU+9*2sY{}BrmYpXhcXg(*=*iR`z2fM(p2^}Zc#V6
zM3qEnBcg7#*}QXJFWGX(q_XdDi~5~Q)DMJ~+fNy-9=F*~PgCj<$(DO`eI1G1&u9O^
zE%#-Y+>eE^A|m%)oBcB64upyIh~&E4Oz}o;<+DF@%l*P7caAV#5Ru!-Z!~`!a+@UE
zbxWG!jojpC%aoD6p*nqt6K??Z3m;unGH(?pT-6DK`A~;WF!5>)*U&B_Pb33BNZxsz
zP8@=B6Ms~g#E&~TgZL6bGJXg-gM;_O_I^J=s=-4*r3das$j|(n&HD%{!whypTrixp
z#4PfD;w;6${I;dzz^qOSLmTf(hwAJZ8o(L%bC_~4I5(Xffq8B(Tq!`&0L&#QXL3Vl
zou*z-Aw6Yd64K{7q)qX1J0XUt)eXwK3UdMcriULartrqtd%oivi2?iSBZs$6yO>--
zUG9S*n92`YcvtIEQZPl#TL?~U1)-)^K+rnpb;vvm_^fG}0f6}B3)+8$`g5kL?`!d+
zS=M@+nN$FKfmvsE<!tH_8o;v^X4+wCx`77yotxBFHDqWSh?1{9aCj@sF_`ZzykL#N
z*XO)d&R$5<Kd`QW68dN8?*hp5Sz)p72pkw`bmVoH1+R!m=6f3dvXb|shTdxDc}nJs
z8h2ANU(|S+0B<q=1wf79iyD1wIYcmc*E%C%Z+-JW81r&{^Iu4SH~(t^WS(hRVs8HN
zipJ?Q#Kn-2^;@e5@BWuV8my7xjrox@`j*8*mUbYlR&QugHI;RZErm}7zGLwap8W%h
zr;}wLaS>&`U=v63l=`ET%FUP<B28s2mU+xYt@Y!^VU{wgEV>=tk=~`do!7k7)*or}
zUef96v>&FzY?HLZtsY`z=rx-V=G^qcXgKy&^wCKUC0z*%PWJdB9IZ%em!6_sx)?uB
z7?+-EUHUn3>1n!zt3fdC&$bv`rF8f^)Y0xdTf1{IX7X7_Ee+lI8RTn^r5WJPnV;Cq
zEaR&7`3>7{FdgYKn|&8uw7?lS3e8VP;!hshkroi3BQ^4-VFca!7nTQ4&~@<6avI3T
z-`%exIbVPICxFaDmNM40xuF^ZU7Lz%?-bIAcNRHMQ79ix@iz$VopT7#J2wExe0E3x
z+)8!moxJnZ+77o~hkmYuccyb1T1son9~`u{4^ZA&mNN2=0=KDSpegn1H85C~Sd1P&
z7lO1$#r#Mg_4u|S0rD$)cDbSDyed1@mZaykD{O*9S44@jzGd-r@?T0pw?|ac9WZm7
zi>SSCi&_|?x6(1YYsWfnuS<H#GPHAUViCr5yKC3|JIrBR*Ko}4ZC$sgcHN&LX<WCL
z%XM#~3-#6|d;|hBI``4(EBe5d8_o#O7HYXZV~EPJuI$&Y{3U3zF0nLp<sTs5?aEnq
z*i5?e112-(-7)w!?)_Xu5pE7M#@~C{>;RSR>vYM51JK`3>kEJb=S%|h_q71bFdncx
z+sHH6IgdQ_^(#qAU;hX|=5kAw*w?9q_H`kR`1<M2y%b7c@81sqAHz-~Kwn=2Aakvi
zerjJoX{jQ<ewvelrq$Z+pgd}OH|2F35`Z>Jo!ZyMTJ-ht5TrdU=1rEUum91OO*iJN
z-!wjb{WXi%zCL_NfTijV(HJGlDjX637O!ms_X8=&?dz~z=E5NX(r6;BNz6DdYAIEK
z4WX1b$x%HG{i~Xbe$E#nr&n(XF_%O1Uto%}rUW{nT{}5^q1$`)ZCmsUD?!WK-ST=n
zJ4ImDGo>DQ@SoXW31VkT{PKbcgO|e8n=DZSaNZPW4<$4JKOGW=Q~|h<qVBR(W8l{^
z)aY><PeE?m0-t#TltR?q%J+70o}##yk#`5BJY=O5XemoE_N(kaSR5blX1;6_a}5EW
z;bT&n#wpa(4qsgf<Z{0C5vN<2RW{KYS1jxw(B&n;^%<O-emVg@+CK%EI|<^g+x&pe
z%B@k}n`;1$r<k8o%%7l_{yD>Yi+PuqJA*Tfd)3OlQzw=B)>v#NpeKoUvR(M2#CT5H
z?&6%S3Mu`jS>}L%rXOgzy!VHpxAyKwK%>3;V*r_FS;E-9$gRW~%#;eVJ6_BdSknE-
z@E(~2J+!<5C_~Ge4Ip!Chw`||ID^Q`3ime%j$X?kDLVf63RGsBE7z5SkzH4Ao6R1i
zWkQ)>92RA2po3QCIslnBS;E-LaTj+JhVr`p3rmE7TnFzRpHmu#x+9dvq3&G*9O_b8
zrv82CkY(#3Y`<DC4n!Q7CV)r}Oe+a+VA={G^Et~AH!yv!-{M98H<jBtAfP3pL>;^j
z-%Pn2MSn?g9G70ExSv|W$hdUG)+^F6e8a3vA&tm<<a3efInBz<0g!npUM9D4XNbx?
z)5;Xmh|EXN9&hzrDKd9Z=Bx2CGjif(;yz6`tdK@zKDJk6-X${sLYbe&%be6srqo?X
zBQhU9Au>A;wsjv1AhX**qgKS8+;yHITK8<L=V(g`Rdn#)Iu{*Wx6%0!W!~dF+Y-e(
zAGf7vKu>T_sIzMN8$7Qc%@C$X?T+sbvIknp9IIxCF1(mzmf0NFTZwwA&R<6LRK2g7
z*~IBhIfozbmq1S(&Ecz@W68v29OBAfN7gKTgQ%$n{lN!p1!?uLSE+}+PVa(>KSye@
z6>4S|UK*BbvHTUoh+Q5Pt3fSbr4}%A49lIS8TfPE#8-8i462B~uy!6YjTk;WpEwFP
z!JUVYc4CpvdY0g$P^|NiuK=pq?||0#ww^+H`76<!kp@9|bNEI#GOq#QoaLxK;O~&D
z=yC|_w3Ze2awwR%H-+gpk)BwsvwjHniATZSX{|1&XfMj_G?m4Bd8cSNbb4YrIrIt_
z!!gxx@H0A|HeCiUbhCoNCZt&gz&e1sT7Pm#wF1SdqKi>mPqVhn#Vq49<~3_o-huX>
zW@54MhKuWpdO&4QjV9(GZHQ|~e3mNe&dfDBlUK%xx|B66#n7!Wbj3ddUD9Gr$CnwP
zScOfiqQ9fY$=N!u%VaRpu*uoFVW*>NChIIUm(OEXTmRbx{TQ5^IM@xj8Ch4NW9TR1
zJ1vcjx6X(V#Omq75zyq^Wb<RE3;g(k30la_mIw;y;N;ySLO!67+im{0&_#4tDvRa6
zBc6ZMr^4UsbnyQ!p1(B0ub&J(V)KupbZ5*ER+5kOr-66IGcI0rHqG*^#fY|-f_@&2
zvbBVdnc}mZ;lnAc(}~XuAU@|6mpok;enrBD?2BxszVpArCbokw`vG^3=*t{6pDtO9
zzV7*q(1I$oC=bty1@HQBvBQz^`GQU$;F0lSY3I)9XgE%*@yx#)9{6({X^K#3KR7*)
zz9CQPTks+teNT5vxw$TnjOkA42N1|3BgM1eT@=V8<F$oj_vZhX+pMLk`Ol%O$8n@7
zLJKGC9d{}j9dEssiuW~8F&=%(ozmCPjd=8(>@D2^)p+!s;hj&%{~C2n9!RKk4L}~g
z0%yUKh<T)*C_RBZ9vO|E`5d<1#{92ye?q1A;KZZvPn^=9frLljPd%mj!xpej-vUqR
zuOWp;-#VwX6HLsb@422u{4^|&AvyCoNL_>@O%Ymf02bykxO%}VF!C7OQ2H4#Jo@^R
zO5cQR9=_i?3zPSHu?%&=KGc=R>BC9~p#&a%-|&_WM9ib_=ibsQp*WAeL%gNC5%cKV
z+q<9+`8+bNUC<Rmd3erQa6Td){<jwV5}7>wSCzhj8uIX;4G(}eJp7kB3qC^8Jp3&S
z9tVnt=iJf{LCGT{)l+&ls==f01J1%udy`7%rK*L#y`8vWEuaB=`*pm#Et>KT7=?#_
zx1;VsGbX94QIgNOxC@l^<1_#+AHOc0Uoe!#(_F^vd1V%;k}xac8d0vwPBts9W#MQ>
z(%W6pI_p8eqcavue+zNS6*#5N<4Hq2A?qrA=Jm#|o$gWsMV#TQf$8!w1UVx#_!(Ty
z8KpsQ8o(Taou0#q2Mc)#an~+s<j#8xaF?kB^9iPnBpBoev=~rn9h{reYnd^VpVVSl
ztIxpPbUSL=jmvSIne%|;X9c_cjoQql-uE!+)494DezeS5CYPOs+!7?a-)%(>1A<{M
z1oo&=&T<;A-jCO-{$MG3;hy#q)eFypx8SUw1*_h|PCZl~F0<j`OtdTQ|1X*C)(OsW
z7tp<65H?*A4riN##g(19J3Sn4`oQ#I={-TJobC>wF2rQ?g{j9WZ~7D%Xl~E5`g{7}
z3Z1FCbeZ18i`Gm!Q_bzESs-R<r;ddz?c3eaf-GM;MD&TsgpjDbWFxPW<IL^pKyc?X
zAU_wz@^wR*@C!yP5mO{aT_}e@*Pf_Bmo8M3d}(PB`IEqwF2$iGuvj{MT7R^GyIMqa
zKLZu%kpwx@yRZ<E)pIyF20=<M4Rpc+U=6@jeXNXRnuap^;(<;?2`tJN!{IJ8S{!XS
zKvxVR1_JLh)+K&WlnmE}9Otb5T10YI|G7QUOq~P$elVjyYdH8cC%@-nXKCLRT~;O&
zae5aZmi8s+AE)wrdeC%dxQMh}h9ujZq0FH`u<M-6mdhM8d_LHRU3nSyKks+-4Cr$v
z8Sq$4aw&ee7J|%dV3pw+;gYA-8JPn^vR+yJWAq-C95D(t9Bl+&H=}>PZtxse8WZEF
zaqweG7u1&J=M%sShPsweV{8{F-UB1$I0KMoe3X;LOo(dZ*VUaERRh0KAt7x5;>k7-
ztxDc0wn>;oX;ZCan>)>w3*rJ4L{Vt4m}*bAMOd!0AV>wepuZMcemEQpn_*0<?SV&u
zQMKpxG>XrP>WV%baS)i96yvmS%#NV7-x$U@(OO}a5}~k+wAtJo>k|<tJDWbmdN3Pn
zzVmwy!st=rYHM_h`8kTtUzcv$yAIuZK`aW_>=*>xe&Gao7+#jKc%QL<?BK(KPdRRw
z!6G?2e7MIAJ7#cjNa^ilX~U!@n^7ZbbJK0R_EuTwy=l~@o!4Uca9b;;S-V-I+SYT8
zDQwK{QGe`Vy~YyuG;WSD#nsn(o3>|v>l0%y7#V|d{0O@OSg*pPO655JN>9Vt;rNfk
z$;sh9#+6kKO}U#UO$biFWki3aK4%HDVGxgO@Zz2Bcr$Wl44pndGqZW4HzTyp<3Q3-
z5P8*U6c;aB)zsC5aw;fBmE-WLT%6mHb)Z5;W2h#ofo!qkeF*O+Hy7l3JP-oSWUC$T
zpOxcD0*<$BUbPm}rgnwoHa9iq*3?zhHdj_*SN%|viow7JF$j~uCj1k|<*u!$u(lc9
zguSarV_Wv-O}P_AS`42Sog3QRP!%gL7n^n0;83V+<X_aOudT%EX?lD0AU8VJ-!3qA
zYYJ7?)Q`zo$HuVaNFeA8gRicr3)Na0{Dh9Z)PvYlJycW8j}K_h<~nSPZDF)-2w2!i
zYv~dJ5YtHzR#sI5#smOxdE;6GPg~PmQyUsxQ#aid-`HFc3eLud4Ummq8ihnN%G%r%
z#1y&~rGpAp;1>Dim6eUrRF%zXt^*EAHPx)GE3X9%_E61+Dg#9-0PNbTP<=xvSW(}|
zObUgK>O!NNaiS1yDa5$?HaAu90}n{RF`^I{(6Yc%MQEgTK-o~WuHK@x9o-~BnhOYs
z2c5}b_mFoPyn~#1zfAIYpH<T^G5F2ay@3CqZU=nt*3cc^Tks{rW4@LAOG@^>zs0u#
zIoCVB6>Gmg?~Zep?_0SqCaj#B<n{h+t1rhp=xlH03h$sCeLnjfUmrZ)_8{~At<_0h
z4LzoOw<mS-?%nzlihS7dO+)T2TYdiTA3JCIv2zN1mjZqJ*0X_qMfs@KZCl^bi4z(o
z`73H~J`z9MnuEmK%Cp~b9++ED1=LMjR{-^h@*RY}UqS78_pf}=o4Nv76LWx?<(syO
zupjVT3fIsaLX*idcbeelMtIiv{Ac|rv+TmBAi3v?V<5Q2*#r2UExyop@KolkO!D4x
zZ0hvoc~3FDG3PwwR__Hk(AQ&g<JH?&-tX(>t4-?cowWzZ>AswO^XAUG6Na5lqG>0Z
zS8hZiz{JDKmt&F#(I$@f$w>MhoqksNLMH!LI{kvl-{;HQ=bN77^FHq(*PWO6UfPJ%
zA9d>2Hua27-D^`%>C^$6dR(XOzr=U@#(lnX_W640e*ov~Lt|aH)wjYs^mgy6z22ep
z1bR&;@2|Ip06(Wz_<AnSg{Q29Y3|Utm(^bHPqrTP_4KVv@`C6M_<`4Z2mI&dA2);Z
zo-J&qXB<koXA7J3PtIPzcUpMb1rYV*mJ`Uh+j$4@AGb{N{>&j$pA%O<wX(q1>|1$m
z>-P0`BJWpd2V^|uc!oRMSHj1VI<4sBz2F^hpLe{eC+^n;?$!l<q6^%u3;9A9*kWN_
z;LTeOq7dzn(@v~JDYk&!rhxZi3#fm`+nohGz4WZ57oI!$td(~`m$pkTgDN{ca14+4
zi%VFuOFd8Oj1{O~1>Ng3Vp}{pmI7G1+QZIEK>t;pxCRBI5{|E#=eOrw=*yfm=KNoI
zH~IEn?%e?G9Pi~@eYelcUGD8)-F$xs;laV)#RvBt>mYaszT>U-d%EF*gWj0pk)QFr
zmwO!O@a`5*5E<SdJH8%B9^b;s?4d=N@V%6j<UNmVZ~*yK?g39%NP?WB_V+LEjgaGo
zWB6A#t^LEXsm&K`$7#Jed2;%m0~@@$h28n*XiUPi#sBH1c-g`%tUm?|?^>V#Y7PdU
zZn@0!s?#6!zQ@_iv1es7J?(KcspEan*}D(vbIt+go-G_TpzlE>j&IqE#6OiMi#7WW
zI*Zr)p&3xVzjd!C9g5$GOM_Q&w$btR_dmOyDtvVT*BO~QV6-+DB#gWqaOI{NgOcOz
z@uasd<n7_t=a9E<nzzT<bIyY)y~lWZ;u_EJ{@&CaJ!4p<wfiroAa&6xi0qQ*&2r}H
zX%7^Uo$|aREw0@}CRe6Xx$EjTROOcQ5?Yzt*s#F>GnURRnU%X1R;d_0CTDDZZbehG
znzLZ3zi^2k>4_SinV)ZVH1v<&5NfWgDp*@pSJhZkfn<4O#kvB_+D1<p=O4XR|Cf&O
zkA}et*48zHZ*(={Nt0nr%vq|C+)&ljgfC}|#%~L2L+c9ifNHM05MSCE9paadnvgDU
z+FZvE#?;j}H;s<ZM13mOkFKaKZ(27RUuy{AyD$9E(dg=i@=(P(il9J^9Bn>bl0RWo
zKD0y0jVKo%gBV>=Uk5RDAr{t%kI~@by%u!|twY+#x034{Q57hHnpHD@w7xzgQCE))
zDiR?CGF00%nqP6MEuibvl-G{t*OHL2aBh(b&Mgh<X+jVaxJt|z%0o33qZ_O6<sHnk
z+P9mXf8vLN5WaY^!G5hsHI)ae%Qw{2ZdS-?s<{X=H9-80o&{8(^oork(`u6^|Cg=i
zYB})QN}`=ZFj`G{6Tgt7Yf-+j3SWh(#B6W^XHxj`OMSx{7(>mjZ^ZXgg4lVgNj|Ei
z`0b_O;=<)B$f+3SR-B3{`*o6P8ea?5A2bQBDQ~J${F2OiWxvD`#INI#LQS^*0!mP;
zq=IPjnmR<yji`KW^M*P-<AZxP!YmD#iH52{vmOaf&L(MV;Zs#QhR3Y4AG$(*Ro%uK
zG__H9*36j;t?IMptA?6}svy=ap()^(w6{xg1wWUARw@rQH)&PTDPRS~wwJH5q0R7R
zHr9iaR0!a_@}l}WR2H}kYbvXPmF1ywe8(unZnCDi+7!N|XwkyLne&Ru6nbc5c_UkW
zlm6-z{DJdSd~^mDfJ)VkRaK2uO+jtl>WW%?J51*DoOK52kzm#{Xnc2PW4WP(CKu_?
zIt7F1rxh-IH72=D*2){pYn!1ezLdt9s-A{g{mSqqulb5j-=xg9d@%8sHf1|%L(}y6
z6Evthkp5N>yDdN56#2YOFi1J1f=&39mtX_l#;tA$)>l`<Fyc``{joLOc5IIg4QBT3
zp6Sz$<~GKDrbPu!qclZ)w!Ch$T2eMESW;TLFgUYx>4GxU&srrIDqpLbYOAUm6k4Jh
zZ5c$N8x_9?hHsAHD`MswVnMBh))c<Yk6jrrj`{SCG9UHQ>NMfwXt)Q1$445X+I)x$
z?z0vyCU;(j39VXNzP4#h)F8G4l%r2H*Kr&f!_WO)$d6rZXkh#DV`8?^j4oC&G$!|h
zYih>#lj!w9-0+EA%Ziqi1s4~UEnU1o;a&?)4DG6MX0weQV_I-RkX?Neuod7AHZ@kL
zT8@kQ1Uk)xyEFI}TBWX{VYAT;KG|Fw()FopZm?F+PLD5onPG&zONNd*J$6LR)6k6D
z<h4;3z*yMWSl_4{*p3kRXj{1%L!h-CL8>;v+s#)6`L#e@<;Zskp=v{U<#<Hs(t3DW
zP`Y473C5|&u+$)ZC(<GqqwDcazG{Af2}Z(ERc=2QXPZfFG=qZ0y4*BUG7H3@sZGhj
zq>kPTZE7lEWZiVyS&Y8&6+-(lM(b<rtn$S|jWV@l&opc`O(<D^uufNP)||!Ypm00<
zNA7*$Jg(M@j3jJEdWgNiL@qT@j^Ac%;<&Ht4L_@{23C7c(c;AmN_kz<BUof0q6?u+
z4#ZTB-lH~DZD2>nqX7)a=;XX;z$uJZ!;u?9#_{UbY{sCankpK3O^1b0+=Ou`5H`a<
z1n6((!8s~0KF~$9G&DaiOS;}OOG=AY6wO4oz6PlERhuuYZ{&5!jA7b#n$ixixHfBD
zsfC}GuoI?=s>a-fjrA8`p3#(B8*0eqa9V-uRHDz*so+LElacPF2Mp6T97b^QquzSZ
zhRHV9)~sD;T82YhsFCknU?g&1VIt!pYgb-Tff*D?nvEajPvFQ`foTn{IP#4&UNq^t
zb@d?RsEQ92ZVdACj7AaTH2R~N+7M_cIJGu3MjSiWaFeqAHKlGPf2_-dD(jm=Duk;{
zh5oXi`9NW`lXDn1qft~t`{6gE2rjBdy1wW{>o#^w^ka~QAQ+^5s;g_8o9GwpOwBs3
z3BffR%Qy2v+!(?){Wh{^RpYW3i;vFhAqunJASS$;ES8#<=KP_G*UcCSuu}yd5naUV
zVMKtwx^mk5zp3(nHdS6YcP1v7Xe;*=Iy%?xcqYxO(?&CJ!Q(K~Z`VYo*<5W#M2B;0
z-dG*(72y4xdfdj2S}36G;O3|$vZH2cA43h4=5n1x&>yX!B$cW%_PGc&7*FL<dEZEr
ziksOr0nOfyR(2Bodqn+qip7&av9@mCDCks$##;llk(~pzn(k9?qq%I@30m38vz-pI
zMd(1wlY$?)8V$Q!B4H6Hn|4C1Z0y-itk6#QX0akp_U(jNU!KvRomin=^vz;LoNV0*
zvBinR3T^E-ixqJ@Eh)tAOe9ulzw^yvMVxHl39(Nm5-YSff3sK-Cwq9(w)qKcE3^-O
zvse))y%k~uiNp%+E8i@(*7kJS^AlqC=O)lrXfCllpiS5xWEaT;QCiv7vz>>@){?Sk
z=c(jM_20Ht>!eORjaS~<1=+)KkS!l{-KMpp!gn4r0~+fcW@1Mz6;O7XOHx?axKC1j
z&WsQWD0^%fLM_g9k{y4()z2_`m9Ma!3F3)h0@)_19j)v&GkcH`2wK@wXP<0%@|3@Q
zo=YbUikwka4##MLMK&$~@gh4K%KsBlsCQ*M{W=mRy9Q0Qdf`$fU{tMT@oIr8zJgL2
z;dTj<t&1GBED@KGXuZFQsDlfoZ1c0TgJy~sC$t+aEnew5x@DiFE{PaosemHX5XOtU
zz%mFmDlVWfc2IHIvqyFX@~Cm`d{1b4oEFf9n(`$z&|)1`CZGuGSWyut)E?CoUl+B&
zy7FQhqcQ^SjG)@JqAZ%uvLtB5x^}gRC+f%><7ql*>3my;Y`ufB*0(Dwo(R2G_T>3S
zS{U!dmUdLKTZZh91BtRHPCHuJAY=JyrrkQKX*><&$<{dS<b|x9??mL~e<RJQ<jEEp
zzl+El(@tJI&8g(QVC8&ZV>HQ;b^_yxAW(M5X-Atf*cfh*jXCZ0d?OVk%H9_3XuoSE
zU1MWhdE$LvHm;DJaaicKc7o!mP^fI0(~kC#E$m?%dsJh5p-Q&Ekgal9s=uA2cq)`C
zyXdr|{m7Pf;uNLIW*V}04oh9#PEtG-N|kMO+R+X^-89({8+Tw}*_A`~(qW+)?F7YB
zp-|aorycD)TUcr0LS=go*;|K&ws+2WDikW)?zAgZ_S})Zbuih<D`?lQc+0e}vB)zv
zhD8MYYXr4Oz>h4d<7v&yHdnTVfPS(UL_7Ut=Z9YmHRYpR0pE_GmI!#vPRTkhS7hBB
zVJs8yPRr=1RRZ4Ql2x`(Qc?m4<E`|76?-HiexZQ7BjV2!@ahO^sepGxQ0GZ;_eW6z
z9*&@v3K&)DyhKV#u^hbxmO?x#zg_)08s#6d6_X7pa5;U!DswcVRJ*B^Y>TlhG0900
zY)Rk{vQb4lhY;G%5phf7>nvMe$kr4ck3#WO9o0CVrh_ZE6e62iIQoNWF)GEAK%chL
z+f^){s)Mpt4+&_&8*PlvAfP|ubms{;)S^shkkogggj$yCB;vmn5nm?YkO<c*0YxCi
zm+g~ORD8SsvD1qEUPSyt0S8CKFKaKT-2_bpePIQ$<pfT)lIYVSYE1-}w@<b|*yh3s
zEV`3d#f77`tP?hd@5fOnQR@av(y`mcQ+4Ea@iZN{!Y^zgQb%+d*#KkTJX<%Zt2-~g
zuI{|}3P~9c+OqJlNj|O=PkP9bJZs|)?h)ciI_?GWR2@`Zsw~w+6=X||cFiWV)2&HP
zQ3ct*!h1$Q*AAUaz!MSFDgi&UDATzlwLDV&cHS@IeGyq@0)84noiCsWG@VOQQSs+%
z6<wzRR>m0-SqlaHD1utnUeGd^3=N7P*-e7}De!F(N$35>g2$sM5k7E8KuaR0z=alv
z(NVyK7DY0FqZMp-ArrlxumzG$;1?sf{C%Ru7?=3}q{xmsz3dzEgGeRYb$U^2geB>?
z)5lX$c@-DpX*%$H*)l}x=<dAnmUidGo7bHer-hO-me~rO;t8|3h3q2IL8p%=>A2I!
zQ*}^vsj^h_RGnUE(}x6f?M_hzc?+<{zQu=5FW{>Y)RK4`$u=IcTL+YpEjrpY>o2XC
zJ0s#23n-g!;2!<9_V?)R85hMfc3>xwDf@PK)RcBA$@=-N{f&KaEfX+vprDosI4Xi#
zD(mNqBB*x#;kcFgwT->1!P&QIfRVbz#*TjTFvhB~$%XJiC)wE|DZ;f-K-scGOP7S~
zxzWMYTu5XG4>Xu;+tJQCLOb0S3-6JS55{PWM7<@s+{O?qyLYq`E3{D?w41j|Bgj@9
z5GVU@v=b+^KeBc{g_d_&64`}=Lsa`a)p)9ohNyTNC@6ccv{O(@d(M{L!Qc>20>wUW
z|Fc^>)u{@VhLBA>Kr1_av{O)MZ~o?X7IBB7?JS#pv=b||4}P;)5hq)DKwH`Gqn%ix
zedU|Qia6QL17c;%k9J~(_LFZGE8=AD4~UgrKiY{E+H^ZmoWeV0Opz@>AXfJMXeU;-
zOlXRXKTB`2;Jzp-zL&~Me<4K)vO_|<5`JRE$esvz9P&;_k3%G1_C5gJ2OZJLUIMbu
z0m_a{)8qBbu!w+-aV-+CA%a>ZV6#P;38+m(qV}@N0ya~g+Bxcc0o}67+S#PNtVJR#
zWMw)EZylN7mbIvztU^mw8)0lW0Tq&BOTvLj;OYolyK6G`+_k~dC|QgqZ-mPtG<h3b
z=p>dMOy#*&{9`JilUTOly2@VJ<$^7jV4;&(u21LNzE*DI^){9(gzRc0d=iT<J#KyU
z2^))V37y1m+x!o0{E>}6vGJESmaj&{|12hQB$i+5<d?K>qL)3l<s%Kd>~9_MeD7Pl
zlq0eHd?Ft)7-H$<cNw9RI1$|l%NPGMittG++tT&5GhdmIXWDd@jb*AYd=ksdxzy4v
zwz14^g-+tjh6FUY!^U#ge~nFFXX6`etm1+^hI`%K+rDe#Pi!nt%4Ap9uPt8LCud$8
z%R{a>@hV<!JYTNm-)ZArHkQYW@$%yJkaFe0S3LcjwqMEb_VP}REOU*gmrqg3J2FBq
z?<vI7%cp!F=oQde^5W4`HvNo^<#nZaet9G=zv0WhgxomD%AiF0#*bGrPPKJ2`p7ty
zHr%A+%TJX4zQYYJ{?Qhn4|Iokj_)1O4+Y+%(j$-lr(1z~T@JRJkPl;H`Kb<5aVCAl
z4i<lw#UJk*&=_v`!BB$3QT>#BdRpYH1fFuX^$P$}>S290dvg%K(9S4j_ds5G@TGQj
zG(VszkLWWtp+)RKPno@AYYQEATf9tN!K%X#ai)BkWo$BN^)rh<YR60Y*3!MeQ@*@_
zCGrnjyjl|ggka@A4UqKm3{B`?(fACte@p<7Qht5L?l_34kGy9hAN~9kc*>Elm5bd@
z0^d<PdeQKdqpba{c$IANd2#rD7T*wu&jFt0K4~xiNa|3a@x9dX`2mYDQKgl$KTb}A
zrthi3arEB<z9an;)$2wrr-vFhA+}tW-jST!Ko93^r{{fIPH%NGPM?P@eY~D8YJ7Kf
z#I_fuGK969zA9WA&}lh+4SWySKYsHWeloj<5V_*)1o+tr@GBGGHzdGc3Ve68<9^$Y
z;)f0#$&dcH$>K$&YZJ)1H36P`e0Ef?zF2(T5&l2|IZtam`s0v*Rz>#2ehc^v)jy)Y
z=-F!N<w>h-MEq3(`56iH^pPG5MP<Gy@`og#AD;kUoB)4b0(@fv{N)MoUni*7j}p+|
zo&bL+0sfB(@E<0?w*jBgf&X-cUv<>(cO;N=dII{f+CQZ=qVWviyJO>#ZE=2EN<1|3
z+v_KiI-C!nBYjpS(5Fe$rz=^`y4K3MKY>4QPavNgZe^g~^=k}R2_{Om@@1Yd(&k<d
zJn5yM3e)2NIG)J-;yC<(;pPP8-k$(}Gy(pZ1o$@+;Qx^TpOnBp^Agzkx&;2*CxM)7
z;JbVJt37e;K0X0`X##v@0{q4V_)Az{EdQ4KOJjYdb|#?zVFLW^8lT?o;}-m~Bgf|>
zapN<;%h-|MVmVCABH0f1CvmTS1Kf;NZF;FCx3rE~co(w<i#gHNXfX>oWt~vYg#3wP
z+>21LG6^dIi5?%bvMqk)o~&%evP9R~#^}NqEX~o&C37Z>8H3e(@e38XN)Jnan?fiK
zYtFDHscJ12%wkn-XhRUoI_t153d@M<gKKN+*Ob==D?{~-Sf<&$NmXD8AlH3W=1iD8
zd2+`@?gcS=akQ##<btxw<_#OTw$zo<D@N_g7ene=6CVuD#<H@aV9^5X5(>V!6&Jx-
zD;E^bpF1-)$E?f=2C+^iSX68!6wg|$f^$krXB3tMOJ~nsQdAZ!E1XeMM5&SGHC)Dn
zw0luhU{1;088d@eqn<MkS+UDXBbj4z#@oeAF(|$Cu3>X~+=hlY99K5Qpn_al7=zL4
zyJ9eAv1JS@!SbhIm0mPwa$}c`nl-#JLiD<-7>rpj7LUSms#w(K4OmsYJ_Z-*53yJ-
zri;PALG6m<7&O;x#vr&1uObG+WtlMu+o0MFupYOjE+$tm{ffcB&9NrhF6cr{u~;%D
z-!6NL!C@KmhI%eR#Ue26nUziT!FA<zm0T=@6^E`B__C5Zjz8jbdQF#EX%<JarU?t#
z^)fT}67vWVJ(5d>BM5q-S+*C0(yJI_FpX7Q-Wh|^gIEm4tQd|#1%qYtXGS`sYw2Kw
ziaNoBdhu)oNxk$c^%#s^_#A`bdd(OFB;h|6g@H^K<eH_FvDtdnWeiH?V1+AIN+J$5
zns}W+Sbtg7*r0Oiu)jkN7N+Ou-6}?7Y&59C8FR5+#9F2E)?q6Ml~cL74)RQl^@chJ
z3wE2h%G{j@A`iPRl#{_i4Yk-5OE-5;sA>~nJ>KLr*6YrhQ?<^Hi|eq2HIgzMW`Hyt
z0z)u%XuzHhYwIBkryN~?Ssu$}jAomPplnltMXT8A3FCSW982Y39Nz#8YJz<LxX`$~
zZY?uSvZk)OUf}XIYZ|dE-R7{H3Jg06h(-7UT1j$Q|9>411Sh6^xc4?;k|&^nNft54
zpd)9}y2DT;up3r{zswUrN~to-pQ%&P6Q(6GVFFTa{!N~M&fjGD{W=vr#q$><3sa6r
z`8Rk1NGWxL<*&60chXpF&1YkgGYjd@+uG_ax$-3iG=<L+47c?0{1&Yi0O*24`134(
zp5^EKm4S7nDpGzwA`zD1z*IBBpOF$k3Ulfd9jQ%m29HZBzGH)DbP@e`rUo?QPHaTW
zu+Bu>zDx(vQ{wf&e(mBvZuyT}{yfVUufIjBivX~SBG2C?ptJlm3c_lA#vZsfj<5ga
zz>|N5&EIDEw^{ym)_&ygizA-@yTH*VB46ga;ch@8kjEXYxCp8Rkegp+1WaCrC1K;Z
zf}kb77I`uJ_IWTK;ppJ$?P3Nfe1g3ZfSX_L=aYsT3hM?!u5A@b0N9U%{1N-x`$)g#
z-*4LyBs%zQEYWQM-2C#q=*SpDA<sdDKHh%6jpJW9HlRrtjx`)%QOqPG?Prtf2mn0w
z(|v$Ad5#sfKU7M4Gmk;i5<deRn_8Mlp6?z15BXmKFMUV&<@wr4%YT%{L7@LLNV(FE
zZvsaW;eW+GS9^sIlo5o^q@w&H=UrsD`Q^D>*z)hO<tO6*IF4VQi)|`29KD3m#!{}J
zKLfxbwp)bUr|z-*qCeY+A)dbnn2D46%X5JJmVc9<T+!f<f*R@ze*CMvIK1%7I4Rkr
zWsul!`3*LDK2m7lg+gevq&`BKn}9!KrlI(!Z3m%`6Q`yo;7_pz<?|PJi07Z1fdA2*
zhHGuy01(f=)bhvMZ{#(Ge{`C=^r+oL&gul^uh?h!ZuNJ}FWB`7_;tqy(ebzeBi{bh
zBW{S$qK`jnO7Pk7D-+2q9O8fC7c`Ifp5ZX(lh2y?Z{J}5?g{u`dcp8-7DJh2#P4iU
F{Xex{SR4QV

literal 0
HcmV?d00001

diff --git a/testcases/kernel/security/tomoyo/tomoyo_file_test.c b/testcases/kernel/security/tomoyo/tomoyo_file_test.c
deleted file mode 100644
index 003f47720..000000000
--- a/testcases/kernel/security/tomoyo/tomoyo_file_test.c
+++ /dev/null
@@ -1,304 +0,0 @@
-/******************************************************************************/
-/* This program is free software;  you can redistribute it and/or modify      */
-/* it under the terms of the GNU General Public License as published by       */
-/* the Free Software Foundation; either version 2 of the License, or          */
-/* (at your option) any later version.                                        */
-/*                                                                            */
-/* This program is distributed in the hope that it will be useful,            */
-/* but WITHOUT ANY WARRANTY;  without even the implied warranty of            */
-/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  */
-/* the GNU General Public License for more details.                           */
-/*                                                                            */
-/* You should have received a copy of the GNU General Public License          */
-/* along with this program;  if not, write to the Free Software               */
-/* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    */
-/*                                                                            */
-/******************************************************************************/
-/*
- * tomoyo_file_test.c
- *
- * Testing program for security/tomoyo/
- *
- * Copyright (C) 2005-2010  NTT DATA CORPORATION
- */
-#include "include.h"
-
-static int should_fail = 0;
-
-static void show_prompt(const char *str)
-{
-	printf("Testing %35s: (%s) ", str,
-	       should_fail ? "must fail" : "should success");
-	errno = 0;
-}
-
-static void show_result(int result)
-{
-	if (should_fail) {
-		if (result == EOF) {
-			if (errno == EPERM)
-				printf("OK: Permission denied.\n");
-			else
-				printf("FAILED: %s\n", strerror(errno));
-		} else {
-			printf("BUG!\n");
-		}
-	} else {
-		if (result != EOF)
-			printf("OK\n");
-		else
-			printf("%s\n", strerror(errno));
-	}
-}
-
-static const char *dev_null_path = "/dev/null";
-static const char *truncate_path = "/tmp/truncate_test";
-static const char *ftruncate_path = "/tmp/ftruncate_test";
-static const char *open_creat_path = "/tmp/open_test";
-static const char *mknod_reg_path = "/tmp/mknod_reg_test";
-static const char *mknod_chr_path = "/tmp/mknod_chr_test";
-static const char *mknod_blk_path = "/tmp/mknod_blk_test";
-static const char *mknod_fifo_path = "/tmp/mknod_fifo_test";
-static const char *mknod_sock_path = "/tmp/mknod_sock_test";
-static const char *unlink_path = "/tmp/unlink_test";
-static const char *mkdir_path = "/tmp/mkdir_test";
-static const char *rmdir_path = "/tmp/rmdir_test";
-static const char *link_source_path = "/tmp/link_source_test";
-static const char *link_dest_path = "/tmp/link_dest_test";
-static const char *symlink_source_path = "/tmp/symlink_source_test";
-static const char *symlink_dest_path = "/tmp/symlink_dest_test";
-static const char *rename_source_path = "/tmp/rename_source_test";
-static const char *rename_dest_path = "/tmp/rename_dest_test";
-static const char *socket_path = "/tmp/socket_test";
-
-static int ftruncate_fd = EOF;
-
-static void stage_file_test(void)
-{
-	int fd;
-	{
-		const char buffer[] = "32768 61000";
-		show_prompt("sysctl(READ)");
-		show_result(read_sysctl(TEST_SYSCTL_PATH, NULL, 0));
-		show_prompt("sysctl(WRITE)");
-		show_result(write_sysctl(TEST_SYSCTL_PATH, buffer));
-	}
-
-	/* QUESTION: Is there a file which can be passed to uselib()? */
-	show_prompt("uselib()");
-	show_result(uselib("/bin/true"));
-
-	{
-		int pipe_fd[2] = { EOF, EOF };
-		int error = 0;
-		fflush(stdout);
-		fflush(stderr);
-		if (pipe(pipe_fd) == -1)
-			err(1, "pipe");
-		if (fork() == 0) {
-			execl("/bin/true", "/bin/true", NULL);
-			if (write(pipe_fd[1], &errno, sizeof(errno)) == -1)
-				err(1, "write");
-			_exit(0);
-		}
-		close(pipe_fd[1]);
-		(void)read(pipe_fd[0], &error, sizeof(error));
-		show_prompt("execve()");
-		errno = error;
-		show_result(error ? EOF : 0);
-	}
-
-	show_prompt("open(O_RDONLY)");
-	fd = open(dev_null_path, O_RDONLY);
-	show_result(fd);
-	if (fd != EOF)
-		close(fd);
-
-	show_prompt("open(O_WRONLY)");
-	fd = open(dev_null_path, O_WRONLY);
-	show_result(fd);
-	if (fd != EOF)
-		close(fd);
-
-	show_prompt("open(O_RDWR)");
-	fd = open(dev_null_path, O_RDWR);
-	show_result(fd);
-	if (fd != EOF)
-		close(fd);
-
-	show_prompt("open(O_CREAT | O_EXCL)");
-	fd = open(open_creat_path, O_CREAT | O_EXCL, 0666);
-	show_result(fd);
-	if (fd != EOF)
-		close(fd);
-
-	show_prompt("open(O_TRUNC)");
-	fd = open(truncate_path, O_TRUNC);
-	show_result(fd);
-	if (fd != EOF)
-		close(fd);
-
-	show_prompt("truncate()");
-	show_result(truncate(truncate_path, 0));
-
-	show_prompt("ftruncate()");
-	show_result(ftruncate(ftruncate_fd, 0));
-
-	show_prompt("mknod(S_IFREG)");
-	show_result(mknod(mknod_reg_path, S_IFREG, 0));
-
-	show_prompt("mknod(S_IFCHR)");
-	show_result(mknod(mknod_chr_path, S_IFCHR, MKDEV(1, 3)));
-
-	show_prompt("mknod(S_IFBLK)");
-	show_result(mknod(mknod_blk_path, S_IFBLK, MKDEV(1, 0)));
-
-	show_prompt("mknod(S_IFIFO)");
-	show_result(mknod(mknod_fifo_path, S_IFIFO, 0));
-
-	show_prompt("mknod(S_IFSOCK)");
-	show_result(mknod(mknod_sock_path, S_IFSOCK, 0));
-
-	show_prompt("mkdir()");
-	show_result(mkdir(mkdir_path, 0600));
-
-	show_prompt("rmdir()");
-	show_result(rmdir(rmdir_path));
-
-	show_prompt("unlink()");
-	show_result(unlink(unlink_path));
-
-	show_prompt("symlink()");
-	show_result(symlink(symlink_dest_path, symlink_source_path));
-
-	show_prompt("link()");
-	show_result(link(link_source_path, link_dest_path));
-
-	show_prompt("rename()");
-	show_result(rename(rename_source_path, rename_dest_path));
-
-	{
-		struct sockaddr_un addr;
-		int fd;
-		memset(&addr, 0, sizeof(addr));
-		addr.sun_family = AF_UNIX;
-		strncpy(addr.sun_path, socket_path, sizeof(addr.sun_path) - 1);
-		fd = socket(AF_UNIX, SOCK_STREAM, 0);
-		show_prompt("unix_bind()");
-		show_result(bind(fd, (struct sockaddr *)&addr, sizeof(addr)));
-		if (fd != EOF)
-			close(fd);
-	}
-
-	printf("\n\n");
-}
-
-static void create_files(void)
-{
-	mkdir(rmdir_path, 0700);
-	close(creat(link_source_path, 0600));
-	close(creat(rename_source_path, 0600));
-	close(creat(truncate_path, 0600));
-	close(creat(unlink_path, 0600));
-	ftruncate_fd = open(ftruncate_path, O_WRONLY | O_CREAT, 0600);
-}
-
-static void creanup_files(void)
-{
-	if (ftruncate_fd != EOF)
-		close(ftruncate_fd);
-	ftruncate_fd = EOF;
-	unlink(open_creat_path);
-	unlink(mknod_reg_path);
-	unlink(mknod_chr_path);
-	unlink(mknod_blk_path);
-	unlink(mknod_fifo_path);
-	unlink(mknod_sock_path);
-	rmdir(mkdir_path);
-	unlink(symlink_source_path);
-	unlink(symlink_dest_path);
-	unlink(link_source_path);
-	unlink(link_dest_path);
-	unlink(rename_source_path);
-	unlink(rename_dest_path);
-	unlink(truncate_path);
-	unlink(ftruncate_path);
-	unlink(socket_path);
-}
-
-static void set_file_enforce(int enforce)
-{
-	if (enforce) {
-		set_profile(3, "file::execute");
-		set_profile(3, "file::open");
-		set_profile(3, "file::create");
-		set_profile(3, "file::unlink");
-		set_profile(3, "file::mkdir");
-		set_profile(3, "file::rmdir");
-		set_profile(3, "file::mkfifo");
-		set_profile(3, "file::mksock");
-		set_profile(3, "file::truncate");
-		set_profile(3, "file::symlink");
-		set_profile(3, "file::rewrite");
-		set_profile(3, "file::mkblock");
-		set_profile(3, "file::mkchar");
-		set_profile(3, "file::link");
-		set_profile(3, "file::rename");
-		set_profile(3, "file::chmod");
-		set_profile(3, "file::chown");
-		set_profile(3, "file::chgrp");
-		set_profile(3, "file::ioctl");
-		set_profile(3, "file::chroot");
-		set_profile(3, "file::mount");
-		set_profile(3, "file::umount");
-		set_profile(3, "file::pivot_root");
-	} else {
-		set_profile(0, "file::execute");
-		set_profile(0, "file::open");
-		set_profile(0, "file::create");
-		set_profile(0, "file::unlink");
-		set_profile(0, "file::mkdir");
-		set_profile(0, "file::rmdir");
-		set_profile(0, "file::mkfifo");
-		set_profile(0, "file::mksock");
-		set_profile(0, "file::truncate");
-		set_profile(0, "file::symlink");
-		set_profile(0, "file::rewrite");
-		set_profile(0, "file::mkblock");
-		set_profile(0, "file::mkchar");
-		set_profile(0, "file::link");
-		set_profile(0, "file::rename");
-		set_profile(0, "file::chmod");
-		set_profile(0, "file::chown");
-		set_profile(0, "file::chgrp");
-		set_profile(0, "file::ioctl");
-		set_profile(0, "file::chroot");
-		set_profile(0, "file::mount");
-		set_profile(0, "file::umount");
-		set_profile(0, "file::pivot_root");
-	}
-}
-
-int main(void)
-{
-	tomoyo_test_init();
-
-	printf("***** Testing file hooks in enforce mode. *****\n");
-	create_files();
-	should_fail = 1;
-	set_file_enforce(1);
-	stage_file_test();
-	set_file_enforce(0);
-	clear_status();
-	creanup_files();
-
-	printf("***** Testing file hooks in permissive mode. *****\n");
-	should_fail = 0;
-	create_files();
-	set_file_enforce(0);
-	stage_file_test();
-	creanup_files();
-
-	clear_status();
-	return 0;
-}
diff --git a/testcases/kernel/security/tomoyo/tomoyo_filesystem_test b/testcases/kernel/security/tomoyo/tomoyo_filesystem_test
new file mode 100755
index 0000000000000000000000000000000000000000..e535128a9e8b447d0d32489a6d51fd96618f6628
GIT binary patch
literal 88160
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

literal 0
HcmV?d00001

diff --git a/testcases/kernel/security/tomoyo/tomoyo_filesystem_test.c b/testcases/kernel/security/tomoyo/tomoyo_filesystem_test.c
deleted file mode 100644
index e6e3bb087..000000000
--- a/testcases/kernel/security/tomoyo/tomoyo_filesystem_test.c
+++ /dev/null
@@ -1,633 +0,0 @@
-/******************************************************************************/
-/* This program is free software;  you can redistribute it and/or modify      */
-/* it under the terms of the GNU General Public License as published by       */
-/* the Free Software Foundation; either version 2 of the License, or          */
-/* (at your option) any later version.                                        */
-/*                                                                            */
-/* This program is distributed in the hope that it will be useful,            */
-/* but WITHOUT ANY WARRANTY;  without even the implied warranty of            */
-/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  */
-/* the GNU General Public License for more details.                           */
-/*                                                                            */
-/* You should have received a copy of the GNU General Public License          */
-/* along with this program;  if not, write to the Free Software               */
-/* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    */
-/*                                                                            */
-/******************************************************************************/
-/*
- * tomoyo_filesystem_test.c
- *
- * Testing program for security/tomoyo/
- *
- * Copyright (C) 2005-2010  NTT DATA CORPORATION
- */
-#define _GNU_SOURCE
-#include "include.h"
-
-static void show_prompt(const char *str, const int should_fail)
-{
-	printf("Testing %60s: (%s) ", str,
-	       should_fail ? "must fail" : "should success");
-	errno = 0;
-}
-
-#ifndef MS_MOVE
-#define MS_MOVE         8192
-#endif
-
-static const char *pivot_root_dir = "/sys/kernel/security/";
-
-static int child(void *arg)
-{
-	errno = 0;
-	pivot_root(pivot_root_dir, proc_policy_dir);
-	return errno;
-}
-
-static void mount2(const char *source, const char *target,
-		   const char *filesystemtype)
-{
-	if (mount(source, target, filesystemtype, 0, NULL)) {
-		printf("BUG: mount() failed\n");
-		fflush(stdout);
-	}
-}
-
-static const unsigned char compressed_ext2_image_sample[1350] = {
-	0x1F, 0x8B, 0x08, 0x00, 0xA8, 0xF2, 0x96, 0x4B, 0x02, 0x03, 0xED, 0xDC,
-	0x3D, 0x4B, 0x5B, 0x51, 0x18, 0x07, 0xF0, 0xE7, 0xDE, 0xAB, 0x14, 0x8C,
-	0xAB, 0xD5, 0x9A, 0xF8, 0x36, 0x0B, 0xA1, 0xE0, 0xE0, 0xDC, 0xD0, 0xAD,
-	0xD0, 0xC5, 0xAF, 0x50, 0x9C, 0x42, 0x1D, 0x6A, 0xE6, 0xA6, 0x9B, 0x9B,
-	0x8B, 0xD8, 0xA5, 0x5B, 0x97, 0x2E, 0xF9, 0x0E, 0x85, 0x4C, 0xF6, 0x23,
-	0x74, 0x70, 0x55, 0x28, 0x52, 0xA8, 0xDD, 0xED, 0xB9, 0xB9, 0xB1, 0xA6,
-	0xEA, 0x24, 0xA5, 0x81, 0xDE, 0xDF, 0x0F, 0x9E, 0xDC, 0xB7, 0x13, 0x2E,
-	0xF7, 0xC0, 0xFF, 0x70, 0xCE, 0x85, 0x24, 0x02, 0xA8, 0xAB, 0x7E, 0xF9,
-	0x31, 0x13, 0xB1, 0x95, 0x36, 0xA7, 0x45, 0x44, 0x2F, 0x6D, 0xB3, 0xC9,
-	0x06, 0xEB, 0x55, 0xF5, 0xC7, 0x87, 0x9F, 0x7E, 0x1C, 0xBF, 0x88, 0x68,
-	0xC5, 0xCE, 0xF7, 0x6C, 0xD4, 0x6E, 0x74, 0xFC, 0xF2, 0x62, 0x74, 0xED,
-	0xFA, 0x7B, 0x8D, 0xB8, 0x69, 0x9F, 0x8F, 0xCF, 0x9F, 0x1D, 0x7E, 0x78,
-	0xF7, 0x6D, 0xD8, 0x79, 0xFF, 0x71, 0xD0, 0xED, 0xBC, 0xCD, 0x9A, 0xBD,
-	0x69, 0x3C, 0xEB, 0xE0, 0xCB, 0xF0, 0xA4, 0xF9, 0xF5, 0xF9, 0xCA, 0xE0,
-	0xE0, 0x72, 0xBB, 0x7B, 0xD4, 0x1A, 0xE6, 0x13, 0xD7, 0xAA, 0xE7, 0x82,
-	0x7A, 0x29, 0xAA, 0xF8, 0xC7, 0xEC, 0x28, 0xFF, 0xBD, 0xC8, 0x75, 0x09,
-	0xD4, 0xC6, 0x55, 0x92, 0x4D, 0x71, 0xFA, 0x71, 0x05, 0x4C, 0xCF, 0xA3,
-	0xBB, 0xE3, 0x01, 0x50, 0x0F, 0x93, 0xEB, 0xDF, 0xEB, 0xFA, 0x97, 0x13,
-	0x80, 0x8B, 0x67, 0xD5, 0x02, 0xE4, 0xEE, 0xFD, 0x8B, 0x3F, 0xD6, 0x22,
-	0x0B, 0xA6, 0x6A, 0xC0, 0x5F, 0xF6, 0xB9, 0x1C, 0x7F, 0x9E, 0xDE, 0x37,
-	0xFE, 0xE4, 0xB1, 0x34, 0xD1, 0xEE, 0x71, 0xAA, 0xC5, 0x54, 0xE5, 0xB9,
-	0x27, 0xA9, 0x96, 0x53, 0x35, 0xA3, 0x7C, 0x13, 0x1A, 0xB1, 0x92, 0x6A,
-	0x35, 0xD5, 0xDA, 0xF8, 0x75, 0xE9, 0x86, 0x6E, 0x05, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xE0, 0x81,
-	0xCA, 0xDF, 0xD8, 0xCF, 0x47, 0x96, 0xB7, 0x7F, 0xEF, 0xE7, 0x79, 0xBB,
-	0x5D, 0xFD, 0x87, 0xDF, 0x79, 0x31, 0x97, 0x77, 0xF7, 0xDE, 0xEC, 0x6F,
-	0xEE, 0xEE, 0xF5, 0x5E, 0xBF, 0xD2, 0x57, 0xF0, 0xBF, 0x69, 0xDC, 0xCA,
-	0xFF, 0xCF, 0xA2, 0xCA, 0x3F, 0x50, 0x13, 0x33, 0xBA, 0x00, 0xE4, 0x1F,
-	0x90, 0x7F, 0x40, 0xFE, 0x01, 0xF9, 0x07, 0xE4, 0x1F, 0x90, 0x7F, 0x40,
-	0xFE, 0x01, 0xF9, 0x07, 0xE4, 0x1F, 0x90, 0x7F, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0xFA, 0xF9, 0x05, 0x34, 0xF2,
-	0x14, 0x08, 0x00, 0x00, 0x10, 0x00
-};
-
-int main(void)
-{
-	char c = 0;
-	tomoyo_test_init();
-
-	/* Test mount(). */
-	{
-		set_profile(3, "file::mount");
-		show_prompt("mount('dev\\011name', '/', 'fs\\011name') ", 1);
-		if (mount("dev\tname", "/", "fs\tname", 0, NULL) == EOF &&
-		    errno == EPERM)
-			printf("OK: Permission denied.\n");
-		else if (errno == ENODEV)
-			printf("OK: No such device.\n");
-		else
-			printf("BUG: %s\n", strerror(errno));
-		set_profile(1, "file::mount");
-		show_prompt("mount('dev\\011name', '/', 'fs\\011name') ", 0);
-		if (mount("dev\tname", "/", "fs\tname", 0, NULL) == EOF &&
-		    errno == ENOMEM)
-			printf("OK: Out of memory.\n");
-		else if (errno == ENODEV)
-			printf("OK: No such device.\n");
-		else
-			printf("BUG: %s\n", strerror(errno));
-		set_profile(3, "file::mount");
-		show_prompt("mount('dev\\011name', '/', 'fs\\011name') ", 0);
-		if (mount("dev\tname", "/", "fs\tname", 0, NULL) == EOF &&
-		    errno == ENOMEM)
-			printf("OK: Out of memory.\n");
-		else if (errno == ENODEV)
-			printf("OK: No such device.\n");
-		else
-			printf("BUG: %s\n", strerror(errno));
-		fprintf(domain_fp, "delete allow_mount dev\\011name / "
-			"fs\\011name 0\n");
-		show_prompt("mount('dev\\011name', '/', 'fs\\011name') ", 1);
-		if (mount("dev\tname", "/", "fs\tname", 0, NULL) == EOF &&
-		    errno == EPERM)
-			printf("OK: Permission denied.\n");
-		else if (errno == ENODEV)
-			printf("OK: No such device.\n");
-		else
-			printf("BUG: %s\n", strerror(errno));
-		set_profile(1, "file::mount");
-		show_prompt("mount(NULL, '/', 'tmpfs') ", 0);
-		if (mount(NULL, "/", "tmpfs", 0, NULL))
-			printf("BUG: %s\n", strerror(errno));
-		else
-			printf("OK: Success\n");
-		set_profile(3, "file::mount");
-		show_prompt("mount(NULL, '/', 'tmpfs') ", 0);
-		if (mount(NULL, "/", "tmpfs", 0, NULL))
-			printf("BUG: %s\n", strerror(errno));
-		else
-			printf("OK: Success\n");
-		show_prompt("mount('anydev', '/', 'tmpfs') ", 0);
-		if (mount("anydev", "/", "tmpfs", 0, NULL))
-			printf("BUG: %s\n", strerror(errno));
-		else
-			printf("OK: Success\n");
-		fprintf(domain_fp, "delete allow_mount <NULL> / tmpfs 0\n");
-		fprintf(domain_fp, "allow_mount anydev / tmpfs 0\n");
-		show_prompt("mount(NULL, '/', 'tmpfs') ", 0);
-		if (mount(NULL, "/", "tmpfs", 0, NULL))
-			printf("BUG: %s\n", strerror(errno));
-		else
-			printf("OK: Success\n");
-		fprintf(domain_fp, "delete allow_mount anydev / tmpfs 0\n");
-		set_profile(2, "file::mount");
-		show_prompt("mount(NULL, NULL, 'tmpfs') ", 1);
-		if (mount(NULL, NULL, "tmpfs", 0, NULL))
-			printf("OK: %s\n", strerror(errno));
-		else
-			printf("BUG: Did not fail.\n");
-		show_prompt("mount(NULL, NULL, NULL) ", 1);
-		if (mount(NULL, NULL, NULL, 0, NULL))
-			printf("OK: %s\n", strerror(errno));
-		else
-			printf("BUG: Did not fail.\n");
-		show_prompt("mount('/', NULL, NULL) ", 1);
-		if (mount("/", NULL, NULL, 0, NULL))
-			printf("OK: %s\n", strerror(errno));
-		else
-			printf("BUG: Did not fail.\n");
-		show_prompt("mount('/', NULL, 'tmpfs') ", 1);
-		if (mount("/", NULL, "tmpfs", 0, NULL))
-			printf("OK: %s\n", strerror(errno));
-		else
-			printf("BUG: Did not fail.\n");
-		show_prompt("mount('/', '/', 'nonexistentfs') ", 1);
-		if (mount("/", "/", "nonexistentfs", 0, NULL))
-			printf("OK: %s\n", strerror(errno));
-		else
-			printf("BUG: Did not fail.\n");
-		set_profile(0, "file::mount");
-	}
-
-	mkdir("/tmp/mount/", 0755);
-	mkdir("/tmp/mount_bind/", 0755);
-	mkdir("/tmp/mount_move/", 0755);
-
-	/* Test mount(). */
-	{
-		static char buf[4096];
-		char *dev_ram_path = realpath("/dev/ram0", NULL);
-		if (!dev_ram_path)
-			dev_ram_path = realpath("/dev/ram", NULL);
-		if (!dev_ram_path) {
-			dev_ram_path = "/dev/ram0";
-			mknod(dev_ram_path, S_IFBLK, MKDEV(1, 0));
-		}
-		memset(buf, 0, sizeof(buf));
-		{
-			struct stat sbuf;
-			FILE *fp = NULL;
-			snprintf(buf, sizeof(buf) - 1, "zcat - > %s",
-				 dev_ram_path);
-			if (lstat(dev_ram_path, &sbuf) == 0 &&
-			    S_ISBLK(sbuf.st_mode) && MAJOR(sbuf.st_rdev) == 1)
-				fp = popen(buf, "w");
-			if (fp) {
-				if (fwrite(compressed_ext2_image_sample, 1,
-					   sizeof(compressed_ext2_image_sample),
-					   fp) !=
-				    sizeof(compressed_ext2_image_sample))
-					err(1, "fwrite");
-				pclose(fp);
-			} else
-				fprintf(stderr, "Can't write to %s .\n",
-					dev_ram_path);
-		}
-		set_profile(3, "file::mount");
-
-		/* Test standard case */
-		show_prompt("mount('none', '/tmp/mount/', 'tmpfs') for "
-			    "'/tmp/mount/'", 1);
-		if (mount("none", "/tmp/mount/", "tmpfs", 0, NULL) == EOF &&
-		    errno == EPERM)
-			printf("OK: Permission denied.\n");
-		else
-			printf("BUG: %s\n", strerror(errno));
-
-		/* Test device_name with pattern */
-		snprintf(buf, sizeof(buf) - 1, "mount('%s', '/tmp/mount/', "
-			 "'ext2') for '%s\\*'", dev_ram_path, dev_ram_path);
-		show_prompt(buf, 1);
-		if (mount(dev_ram_path, "/tmp/mount/", "ext2", MS_RDONLY, NULL)
-		    == EOF && errno == EPERM)
-			printf("OK: Permission denied.\n");
-		else
-			printf("BUG: %s\n", strerror(errno));
-
-		/* Test dir_name with pattern */
-		show_prompt("mount('none', '/tmp/mount/', 'tmpfs') for "
-			    "'/tmp/\\?\\?\\?\\?\\?/'", 1);
-		if (mount("none", "/tmp/mount/", "tmpfs", 0, NULL) == EOF &&
-		    errno == EPERM)
-			printf("OK: Permission denied.\n");
-		else
-			printf("BUG: %s\n", strerror(errno));
-
-		/* Test standard case */
-		fprintf(domain_fp, "allow_mount none /tmp/mount/ tmpfs 0\n");
-		show_prompt("mount('none', '/tmp/mount/', 'tmpfs') for "
-			    "'/tmp/mount/'", 0);
-		if (mount("none", "/tmp/mount/", "tmpfs", 0, NULL) == 0)
-			printf("OK\n");
-		else
-			printf("FAILED: %s\n", strerror(errno));
-		fprintf(domain_fp,
-			"delete allow_mount none /tmp/mount/ tmpfs 0\n");
-
-		/* Test device_name with pattern */
-		fprintf(domain_fp, "allow_mount %s\\* /tmp/mount/ ext2 1\n",
-			dev_ram_path);
-		snprintf(buf, sizeof(buf) - 1, "mount('%s', '/tmp/mount/', "
-			 "'ext2') for '%s\\*'", dev_ram_path, dev_ram_path);
-		show_prompt(buf, 0);
-		if (mount(dev_ram_path, "/tmp/mount/", "ext2", MS_RDONLY, NULL)
-		    == 0)
-			printf("OK\n");
-		else
-			printf("FAILED: %s\n", strerror(errno));
-		fprintf(domain_fp, "delete allow_mount %s\\* "
-			"/tmp/mount/ ext2 1\n", dev_ram_path);
-
-		/* Test dir_name with pattern */
-		fprintf(domain_fp,
-			"allow_mount none /tmp/\\?\\?\\?\\?\\?/ tmpfs 0\n");
-		show_prompt("mount('none', '/tmp/mount/', 'tmpfs') for "
-			    "'/tmp/\\?\\?\\?\\?\\?/'", 0);
-		if (mount("none", "/tmp/mount/", "tmpfs", 0, NULL) == 0)
-			printf("OK\n");
-		else
-			printf("FAILED: %s\n", strerror(errno));
-		fprintf(domain_fp, "delete allow_mount none "
-			"/tmp/\\?\\?\\?\\?\\?/ tmpfs 0\n");
-
-		set_profile(0, "file::mount");
-		while (umount("/tmp/mount/") == 0)
-			c++;	/* Dummy. */
-	}
-
-	/* Test mount(). */
-	{
-		mount2("none", "/tmp/mount/", "tmpfs");
-		set_profile(3, "file::mount");
-
-		/* Test remount case */
-		show_prompt("mount('/tmp/mount/', MS_REMOUNT)", 1);
-		if (mount("none", "/tmp/mount/", "tmpfs", MS_REMOUNT, NULL)
-		    == EOF && errno == EPERM)
-			printf("OK: Permission denied.\n");
-		else
-			printf("BUG: %s\n", strerror(errno));
-		show_prompt("mount('/tmp/mount/', MS_REMOUNT)", 1);
-		if (mount(NULL, "/tmp/mount/", NULL, MS_REMOUNT, NULL) == EOF
-		    && errno == EPERM)
-			printf("OK: Permission denied.\n");
-		else
-			printf("BUG: %s\n", strerror(errno));
-		fprintf(domain_fp, "allow_mount something /tmp/mount/ "
-			"--remount 0\n");
-		show_prompt("mount('/tmp/mount/', MS_REMOUNT)", 0);
-		if (mount(NULL, "/tmp/mount/", NULL, MS_REMOUNT, NULL))
-			printf("BUG: %s\n", strerror(errno));
-		else
-			printf("OK: Success.\n");
-		fprintf(domain_fp, "delete allow_mount something /tmp/mount/ "
-			"--remount 0\n");
-
-		/* Test bind case */
-		show_prompt("mount('/tmp/mount/', '/tmp/mount_bind/', "
-			    "MS_BIND)", 1);
-		if (mount("/tmp/mount/", "/tmp/mount_bind/", NULL, MS_BIND,
-			  NULL) == EOF && errno == EPERM)
-			printf("OK: Permission denied.\n");
-		else
-			printf("BUG: %s\n", strerror(errno));
-
-		/* Test move case */
-		show_prompt("mount('/tmp/mount/', '/tmp/mount_move/', "
-			    "MS_MOVE)", 1);
-		if (mount("/tmp/mount/", "/tmp/mount_move/", NULL, MS_MOVE,
-			  NULL) == EOF && errno == EPERM)
-			printf("OK: Permission denied.\n");
-		else
-			printf("BUG: %s\n", strerror(errno));
-
-		/* Test remount case */
-		fprintf(domain_fp, "allow_mount any /tmp/mount/ --remount 0\n");
-		show_prompt("mount('/tmp/mount/', MS_REMOUNT)", 0);
-		if (mount("none", "/tmp/mount/", "tmpfs", MS_REMOUNT, NULL)
-		    == 0)
-			printf("OK\n");
-		else
-			printf("FAILED: %s\n", strerror(errno));
-		fprintf(domain_fp, "delete allow_mount any /tmp/mount/ "
-			"--remount 0\n");
-
-		/* Test bind case */
-		fprintf(domain_fp,
-			"allow_mount /tmp/mount/ /tmp/mount_bind/ --bind 0\n");
-		show_prompt("mount('/tmp/mount/', '/tmp/mount_bind', MS_BIND)",
-			    0);
-		if (mount("/tmp/mount/", "/tmp/mount_bind/", NULL, MS_BIND,
-			  NULL) == 0)
-			printf("OK\n");
-		else
-			printf("FAILED: %s\n", strerror(errno));
-		set_profile(0, "file::mount");
-		umount("/tmp/mount_bind/");
-		fprintf(domain_fp, "delete allow_mount /tmp/mount/ "
-			"/tmp/mount_bind/ --bind 0\n");
-
-		/* Test move case */
-		set_profile(3, "file::mount");
-		fprintf(domain_fp, "allow_unmount /tmp/mount/\n");
-		fprintf(domain_fp, "allow_mount /tmp/mount/ /tmp/mount_move/ "
-			"--move 0\n");
-		show_prompt("mount('/tmp/mount/', '/tmp/mount_move/', "
-			    "MS_MOVE)", 0);
-		if (mount("/tmp/mount/", "/tmp/mount_move/", NULL, MS_MOVE,
-			  NULL) == 0)
-			printf("OK\n");
-		else
-			printf("FAILED: %s\n", strerror(errno));
-		set_profile(0, "file::mount");
-		umount("/tmp/mount_move/");
-		fprintf(domain_fp, "delete allow_unmount /tmp/mount/\n");
-		fprintf(domain_fp, "delete allow_mount /tmp/mount/ "
-			"/tmp/mount_move/ --move 0\n");
-
-		while (umount("/tmp/mount/") == 0)
-			c++;	/* Dummy. */
-	}
-
-	/* Test umount(). */
-	{
-		/* Test standard case */
-		fprintf(domain_fp, "allow_unmount /tmp/mount/\n");
-
-		set_profile(0, "file::umount");
-		mount2("none", "/tmp/mount/", "tmpfs");
-		set_profile(3, "file::umount");
-		show_prompt("umount('/tmp/mount/') for '/tmp/mount/'", 0);
-		if (umount("/tmp/mount/") == 0)
-			printf("OK\n");
-		else
-			printf("BUG: %s\n", strerror(errno));
-		fprintf(domain_fp, "delete allow_unmount /tmp/mount/\n");
-
-		set_profile(0, "file::umount");
-
-		mount2("none", "/tmp/mount/", "tmpfs");
-		set_profile(3, "file::umount");
-		show_prompt("umount('/tmp/mount/') for '/tmp/mount/'", 1);
-		if (umount("/tmp/mount/") == EOF && errno == EPERM)
-			printf("OK: Permission denied.\n");
-		else
-			printf("FAILED: %s\n", strerror(errno));
-
-		/* Test pattern */
-		fprintf(domain_fp, "allow_unmount /tmp/\\?\\?\\?\\?\\?/\n");
-		set_profile(0, "file::umount");
-		mount2("none", "/tmp/mount/", "tmpfs");
-		set_profile(3, "file::umount");
-		show_prompt("umount('/tmp/mount/') for "
-			    "'/tmp/\\?\\?\\?\\?\\?/'", 1);
-		if (umount("/tmp/mount/") == 0)
-			printf("OK\n");
-		else
-			printf("BUG: %s\n", strerror(errno));
-		fprintf(domain_fp,
-			"delete allow_unmount /tmp/\\?\\?\\?\\?\\?/\n");
-
-		set_profile(0, "file::umount");
-		while (umount("/tmp/mount/") == 0)
-			c++;	/* Dummy. */
-	}
-
-	/* Test chroot(). */
-	{
-		set_profile(3, "file::chroot");
-
-		/* Test standard case */
-		fprintf(domain_fp, "allow_chroot /tmp/mount/\n");
-		show_prompt("chroot('/tmp/mount/') for '/tmp/mount/'", 0);
-		fflush(stdout);
-		if (fork() == 0) {
-			if (chroot("/tmp/mount/") == 0)
-				printf("OK\n");
-			else
-				printf("FAILED: %s\n", strerror(errno));
-			fflush(stdout);
-			_exit(0);
-		}
-		wait(NULL);
-		fprintf(domain_fp, "delete allow_chroot /tmp/mount/\n");
-
-		show_prompt("chroot('/tmp/mount/') for '/tmp/mount/'", 1);
-		fflush(stdout);
-		if (fork() == 0) {
-			if (chroot("/tmp/mount/") == EOF && errno == EPERM)
-				printf("OK: Permission denied.\n");
-			else
-				printf("BUG: %s\n", strerror(errno));
-			fflush(stdout);
-			_exit(0);
-		}
-		wait(NULL);
-
-		/* Test pattern */
-		fprintf(domain_fp, "allow_chroot /tmp/\\?\\?\\?\\?\\?/\n");
-		show_prompt("chroot('/tmp/mount/') for "
-			    "'/tmp/\\?\\?\\?\\?\\?/'", 0);
-		fflush(stdout);
-		if (fork() == 0) {
-			if (chroot("/tmp/mount/") == 0)
-				printf("OK\n");
-			else
-				printf("FAILED: %s\n", strerror(errno));
-			fflush(stdout);
-			_exit(0);
-		}
-		wait(NULL);
-		fprintf(domain_fp,
-			"delete allow_chroot /tmp/\\?\\?\\?\\?\\?/\n");
-
-		set_profile(0, "file::chroot");
-	}
-
-	/* Test pivot_root(). */
-	{
-		int error;
-		static char stack[8192];
-		set_profile(3, "file::pivot_root");
-		fprintf(domain_fp, "allow_pivot_root %s %s\n",
-			pivot_root_dir, proc_policy_dir);
-		snprintf(stack, 8191, "pivot_root('%s', '%s')", pivot_root_dir,
-			 proc_policy_dir);
-		show_prompt(stack, 0);
-		{
-			const pid_t pid = ltp_clone_quick(CLONE_NEWNS, child,
-							  NULL);
-			while (waitpid(pid, &error, __WALL) == EOF &&
-			       errno == EINTR)
-				c++;	/* Dummy. */
-		}
-		errno = WIFEXITED(error) ? WEXITSTATUS(error) : -1;
-		if (errno == 0)
-			printf("OK\n");
-		else
-			printf("FAILED: %s\n", strerror(errno));
-
-		fprintf(domain_fp, "delete allow_pivot_root %s %s\n",
-			pivot_root_dir, proc_policy_dir);
-		snprintf(stack, 8191, "pivot_root('%s', '%s')", pivot_root_dir,
-			 proc_policy_dir);
-		show_prompt(stack, 1);
-		{
-			const pid_t pid = ltp_clone_quick(CLONE_NEWNS, child,
-							  NULL);
-			while (waitpid(pid, &error, __WALL) == EOF &&
-			       errno == EINTR)
-				c++;	/* Dummy. */
-		}
-		errno = WIFEXITED(error) ? WEXITSTATUS(error) : -1;
-		if (errno == EPERM)
-			printf("OK: Permission denied.\n");
-		else
-			printf("BUG: %s\n", strerror(errno));
-
-		set_profile(2, "file::pivot_root");
-		snprintf(stack, 8191, "pivot_root('%s', '%s')", pivot_root_dir,
-			 proc_policy_dir);
-		show_prompt(stack, 0);
-		{
-			const pid_t pid = ltp_clone_quick(CLONE_NEWNS, child,
-							  NULL);
-			while (waitpid(pid, &error, __WALL) == EOF &&
-			       errno == EINTR)
-				c++;	/* Dummy. */
-		}
-		errno = WIFEXITED(error) ? WEXITSTATUS(error) : -1;
-		if (errno == 0)
-			printf("OK\n");
-		else
-			printf("FAILED: %s\n", strerror(errno));
-
-		set_profile(0, "file::pivot_root");
-
-	}
-
-	rmdir("/tmp/mount_move/");
-	rmdir("/tmp/mount_bind/");
-	rmdir("/tmp/mount/");
-
-	clear_status();
-	return 0;
-}
diff --git a/testcases/kernel/security/tomoyo/tomoyo_new_file_test b/testcases/kernel/security/tomoyo/tomoyo_new_file_test
new file mode 100755
index 0000000000000000000000000000000000000000..56c7216221421acfd1fc2b47b1a14ddeb820e68c
GIT binary patch
literal 84864
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

literal 0
HcmV?d00001

diff --git a/testcases/kernel/security/tomoyo/tomoyo_new_file_test.c b/testcases/kernel/security/tomoyo/tomoyo_new_file_test.c
deleted file mode 100644
index eb912d726..000000000
--- a/testcases/kernel/security/tomoyo/tomoyo_new_file_test.c
+++ /dev/null
@@ -1,627 +0,0 @@
-/******************************************************************************/
-/* This program is free software;  you can redistribute it and/or modify      */
-/* it under the terms of the GNU General Public License as published by       */
-/* the Free Software Foundation; either version 2 of the License, or          */
-/* (at your option) any later version.                                        */
-/*                                                                            */
-/* This program is distributed in the hope that it will be useful,            */
-/* but WITHOUT ANY WARRANTY;  without even the implied warranty of            */
-/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  */
-/* the GNU General Public License for more details.                           */
-/*                                                                            */
-/* You should have received a copy of the GNU General Public License          */
-/* along with this program;  if not, write to the Free Software               */
-/* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    */
-/*                                                                            */
-/******************************************************************************/
-/*
- * tomoyo_new_file_test.c
- *
- * Testing program for security/tomoyo/
- *
- * Copyright (C) 2005-2010  NTT DATA CORPORATION
- */
-#include "include.h"
-
-static const char *policy = "";
-
-static void show_result(int result, char should_success)
-{
-	int error = errno;
-	printf("%s : ", policy);
-	if (should_success) {
-		if (result != EOF)
-			printf("OK\n");
-		else
-			printf("FAILED: %s\n", strerror(error));
-	} else {
-		if (result == EOF) {
-			if (error == EPERM)
-				printf("OK: Permission denied.\n");
-			else
-				printf("FAILED: %s\n", strerror(error));
-		} else {
-			printf("BUG: didn't fail.\n");
-		}
-	}
-}
-
-static void create2(const char *pathname)
-{
-	set_profile(0, "file::create");
-	set_profile(0, "file::open");
-	close(creat(pathname, 0600));
-	set_profile(3, "file::create");
-	set_profile(3, "file::open");
-	errno = 0;
-}
-
-static void mkdir2(const char *pathname)
-{
-	set_profile(0, "file::mkdir");
-	mkdir(pathname, 0600);
-	set_profile(3, "file::mkdir");
-	errno = 0;
-}
-
-static void unlink2(const char *pathname)
-{
-	set_profile(0, "file::unlink");
-	unlink(pathname);
-	set_profile(3, "file::unlink");
-	errno = 0;
-}
-
-static void rmdir2(const char *pathname)
-{
-	set_profile(0, "file::rmdir");
-	rmdir(pathname);
-	set_profile(3, "file::rmdir");
-	errno = 0;
-}
-
-static void mkfifo2(const char *pathname)
-{
-	set_profile(0, "file::mkfifo");
-	mkfifo(pathname, 0600);
-	set_profile(3, "file::mkfifo");
-	errno = 0;
-}
-
-static void stage_file_test(void)
-{
-	const char buffer[] = "32768 61000";
-	int pipe_fd[2] = { EOF, EOF };
-	int error = 0;
-	int fd;
-	char pbuffer[1024];
-	struct stat sbuf;
-	struct sockaddr_un addr;
-	struct ifreq ifreq;
-	char *filename = "";
-	set_profile(3, "file::execute");
-	set_profile(3, "file::open");
-	set_profile(3, "file::create");
-	set_profile(3, "file::unlink");
-	set_profile(3, "file::mkdir");
-	set_profile(3, "file::rmdir");
-	set_profile(3, "file::mkfifo");
-	set_profile(3, "file::mksock");
-	set_profile(3, "file::truncate");
-	set_profile(3, "file::symlink");
-	set_profile(3, "file::rewrite");
-	set_profile(3, "file::mkblock");
-	set_profile(3, "file::mkchar");
-	set_profile(3, "file::link");
-	set_profile(3, "file::rename");
-	set_profile(3, "file::chmod");
-	set_profile(3, "file::chown");
-	set_profile(3, "file::chgrp");
-	set_profile(3, "file::ioctl");
-	set_profile(3, "file::chroot");
-	set_profile(3, "file::mount");
-	set_profile(3, "file::umount");
-	set_profile(3, "file::pivot_root");
-
-	policy = "allow_read /proc/sys/net/ipv4/ip_local_port_range";
-	write_domain_policy(policy, 0);
-	show_result(read_sysctl(TEST_SYSCTL_PATH, NULL, 0), 1);
-	write_domain_policy(policy, 1);
-	show_result(read_sysctl(TEST_SYSCTL_PATH, NULL, 0), 0);
-
-	policy = "allow_write /proc/sys/net/ipv4/ip_local_port_range";
-	write_domain_policy(policy, 0);
-	show_result(write_sysctl(TEST_SYSCTL_PATH, buffer), 1);
-	write_domain_policy(policy, 1);
-	show_result(write_sysctl(TEST_SYSCTL_PATH, buffer), 0);
-
-	policy = "allow_read/write /proc/sys/net/ipv4/ip_local_port_range";
-	write_domain_policy(policy, 0);
-	show_result(read_sysctl(TEST_SYSCTL_PATH, NULL, 0) &&
-	            write_sysctl(TEST_SYSCTL_PATH, buffer), 1);
-	write_domain_policy(policy, 1);
-	show_result(read_sysctl(TEST_SYSCTL_PATH, NULL, 0) &&
-	            write_sysctl(TEST_SYSCTL_PATH, buffer), 0);
-
-	policy = "allow_read /bin/true";
-	write_domain_policy(policy, 0);
-	show_result(uselib("/bin/true"), 1);
-	write_domain_policy(policy, 1);
-	show_result(uselib("/bin/true"), 0);
-
-	policy = "allow_execute /bin/true";
-	write_domain_policy(policy, 0);
-	fflush(stdout);
-	fflush(stderr);
-	if (pipe(pipe_fd) == -1)
-		err(1, "pipe");
-	if (fork() == 0) {
-		execl("/bin/true", "/bin/true", NULL);
-		if (write(pipe_fd[1], &errno, sizeof(errno)) == -1)
-			err(1, "write");
-		exit(0);
-	}
-	close(pipe_fd[1]);
-	(void)read(pipe_fd[0], &error, sizeof(error));
-	close(pipe_fd[0]);
-	wait(NULL);
-	errno = error;
-	show_result(error ? EOF : 0, 1);
-	write_domain_policy(policy, 1);
-	fflush(stdout);
-	fflush(stderr);
-	if (pipe(pipe_fd) == -1)
-		err(1, "pipe");
-	if (fork() == 0) {
-		execl("/bin/true", "/bin/true", NULL);
-		if (write(pipe_fd[1], &errno, sizeof(errno)) == -1)
-			err(1, "write");
-		_exit(0);
-	}
-	close(pipe_fd[1]);
-	(void)read(pipe_fd[0], &error, sizeof(error));
-	close(pipe_fd[0]);
-	wait(NULL);
-	errno = error;
-	show_result(errno ? EOF : 0, 0);
-
-	policy = "allow_read /dev/null";
-	write_domain_policy(policy, 0);
-	fd = open("/dev/null", O_RDONLY);
-	show_result(fd, 1);
-	if (fd != EOF)
-		close(fd);
-	write_domain_policy(policy, 1);
-	fd = open("/dev/null", O_RDONLY);
-	show_result(fd, 0);
-	if (fd != EOF)
-		close(fd);
-
-	policy = "allow_read /dev/null";
-	write_domain_policy(policy, 0);
-	fd = open("/dev/null", O_RDONLY);
-	show_result(fd, 1);
-	if (fd != EOF)
-		close(fd);
-	write_domain_policy(policy, 1);
-	fd = open("/dev/null", O_RDONLY);
-	show_result(fd, 0);
-	if (fd != EOF)
-		close(fd);
-
-	policy = "allow_read /dev/null";
-	write_domain_policy(policy, 0);
-	fd = open("/dev/null", O_RDONLY);
-	show_result(fd, 1);
-	if (fd != EOF)
-		close(fd);
-	write_domain_policy(policy, 1);
-	fd = open("/dev/null", O_RDONLY);
-	show_result(fd, 0);
-	if (fd != EOF)
-		close(fd);
-
-	policy = "allow_read /dev/null";
-	write_domain_policy(policy, 0);
-	fd = open("/dev/null", O_RDONLY);
-	show_result(fd, 1);
-	if (fd != EOF)
-		close(fd);
-	write_domain_policy(policy, 1);
-	fd = open("/dev/null", O_RDONLY);
-	show_result(fd, 0);
-	if (fd != EOF)
-		close(fd);
-
-	set_profile(3, "file::mkfifo");
-	policy = "allow_mkfifo /tmp/mknod_fifo_test 0644";
-	write_domain_policy(policy, 0);
-	filename = "/tmp/mknod_fifo_test";
-	show_result(mknod(filename, S_IFIFO | 0644, 0), 1);
-	write_domain_policy(policy, 1);
-	unlink2(filename);
-	show_result(mknod(filename, S_IFIFO | 0644, 0), 0);
-
-	memset(pbuffer, 0, sizeof(pbuffer));
-	memset(&sbuf, 0, sizeof(sbuf));
-	filename = "/dev/null";
-	stat(filename, &sbuf);
-	snprintf(pbuffer, sizeof(pbuffer) - 1, "allow_write %s", filename);
-	policy = pbuffer;
-	write_domain_policy(policy, 0);
-	fd = open(filename, O_WRONLY);
-	show_result(fd, 1);
-	if (fd != EOF)
-		close(fd);
-	write_domain_policy(policy, 1);
-	fd = open(filename, O_WRONLY);
-	show_result(fd, 0);
-	if (fd != EOF)
-		close(fd);
-
-	policy = "allow_read/write /tmp/fifo";
-	mkfifo2("/tmp/fifo");
-	write_domain_policy(policy, 0);
-	fd = open("/tmp/fifo", O_RDWR);
-	show_result(fd, 1);
-	if (fd != EOF)
-		close(fd);
-	write_domain_policy(policy, 1);
-	fd = open("/tmp/fifo", O_RDWR);
-	show_result(fd, 0);
-	if (fd != EOF)
-		close(fd);
-
-	policy = "allow_read /dev/null";
-	write_domain_policy(policy, 0);
-	fd = open("/dev/null", O_RDONLY);
-	show_result(fd, 1);
-	if (fd != EOF)
-		close(fd);
-	write_domain_policy(policy, 1);
-	fd = open("/dev/null", O_RDONLY);
-	show_result(fd, 0);
-	if (fd != EOF)
-		close(fd);
-
-	policy = "allow_write /dev/null";
-	write_domain_policy(policy, 0);
-	fd = open("/dev/null", O_WRONLY);
-	show_result(fd, 1);
-	if (fd != EOF)
-		close(fd);
-	write_domain_policy(policy, 1);
-	fd = open("/dev/null", O_WRONLY);
-	show_result(fd, 0);
-	if (fd != EOF)
-		close(fd);
-
-	policy = "allow_read/write /dev/null";
-	write_domain_policy(policy, 0);
-	fd = open("/dev/null", O_RDWR);
-	show_result(fd, 1);
-	if (fd != EOF)
-		close(fd);
-	write_domain_policy(policy, 1);
-	fd = open("/dev/null", O_RDWR);
-	show_result(fd, 0);
-	if (fd != EOF)
-		close(fd);
-
-	policy = "allow_create /tmp/open_test 0644";
-	write_domain_policy(policy, 0);
-	policy = "allow_write /tmp/open_test";
-	write_domain_policy(policy, 0);
-	fd = open("/tmp/open_test", O_WRONLY | O_CREAT | O_EXCL, 0644);
-	show_result(fd, 1);
-	if (fd != EOF)
-		close(fd);
-	unlink2("/tmp/open_test");
-	write_domain_policy(policy, 1);
-	fd = open("/tmp/open_test", O_WRONLY | O_CREAT | O_EXCL, 0644);
-	show_result(fd, 0);
-	if (fd != EOF)
-		close(fd);
-	unlink2("/tmp/open_test");
-
-	policy = "allow_create /tmp/open_test 0644";
-	write_domain_policy(policy, 1);
-
-	policy = "allow_write /tmp/open_test";
-	write_domain_policy(policy, 0);
-	policy = "allow_create /tmp/open_test 0644";
-	write_domain_policy(policy, 0);
-	fd = open("/tmp/open_test", O_WRONLY | O_CREAT | O_EXCL, 0644);
-	show_result(fd, 1);
-	if (fd != EOF)
-		close(fd);
-	unlink2("/tmp/open_test");
-	write_domain_policy(policy, 1);
-	fd = open("/tmp/open_test", O_WRONLY | O_CREAT | O_EXCL, 0644);
-	show_result(fd, 0);
-	if (fd != EOF)
-		close(fd);
-	unlink2("/tmp/open_test");
-	policy = "allow_write /tmp/open_test";
-	write_domain_policy(policy, 1);
-
-	filename = "/tmp/truncate_test";
-	create2(filename);
-
-	policy = "allow_truncate /tmp/truncate_test";
-	write_domain_policy(policy, 0);
-	policy = "allow_write /tmp/truncate_test";
-	write_domain_policy(policy, 0);
-	fd = open(filename, O_WRONLY | O_TRUNC);
-	show_result(fd, 1);
-	if (fd != EOF)
-		close(fd);
-	write_domain_policy(policy, 1);
-	fd = open(filename, O_WRONLY | O_TRUNC);
-	show_result(fd, 0);
-	if (fd != EOF)
-		close(fd);
-	policy = "allow_truncate /tmp/truncate_test";
-	write_domain_policy(policy, 1);
-
-	policy = "allow_write /tmp/truncate_test";
-	write_domain_policy(policy, 0);
-	policy = "allow_truncate /tmp/truncate_test";
-	write_domain_policy(policy, 0);
-	fd = open(filename, O_WRONLY | O_TRUNC);
-	show_result(fd, 1);
-	if (fd != EOF)
-		close(fd);
-	write_domain_policy(policy, 1);
-	fd = open(filename, O_WRONLY | O_TRUNC);
-	show_result(fd, 0);
-	if (fd != EOF)
-		close(fd);
-	policy = "allow_write /tmp/truncate_test";
-	write_domain_policy(policy, 1);
-
-	policy = "allow_truncate /tmp/truncate_test";
-	write_domain_policy(policy, 0);
-	show_result(truncate(filename, 0), 1);
-	write_domain_policy(policy, 1);
-	show_result(truncate(filename, 0), 0);
-
-	policy = "allow_truncate /tmp/truncate_test";
-	write_domain_policy(policy, 0);
-	set_profile(0, "file::open");
-	fd = open(filename, O_WRONLY);
-	set_profile(3, "file::open");
-	show_result(ftruncate(fd, 0), 1);
-	write_domain_policy(policy, 1);
-	show_result(ftruncate(fd, 0), 0);
-	if (fd != EOF)
-		close(fd);
-
-	unlink2(filename);
-
-	policy = "allow_create /tmp/mknod_reg_test 0644";
-	write_domain_policy(policy, 0);
-	filename = "/tmp/mknod_reg_test";
-	show_result(mknod(filename, S_IFREG | 0644, 0), 1);
-	write_domain_policy(policy, 1);
-	unlink2(filename);
-	show_result(mknod(filename, S_IFREG | 0644, 0), 0);
-
-	policy = "allow_mkchar /tmp/mknod_chr_test 0644 1 3";
-	write_domain_policy(policy, 0);
-	filename = "/tmp/mknod_chr_test";
-	show_result(mknod(filename, S_IFCHR | 0644, MKDEV(1, 3)), 1);
-	write_domain_policy(policy, 1);
-	unlink2(filename);
-	show_result(mknod(filename, S_IFCHR | 0644, MKDEV(1, 3)), 0);
-
-	policy = "allow_mkblock /tmp/mknod_blk_test 0644 1 0";
-	write_domain_policy(policy, 0);
-	filename = "/tmp/mknod_blk_test";
-	show_result(mknod(filename, S_IFBLK | 0644, MKDEV(1, 0)), 1);
-	write_domain_policy(policy, 1);
-	unlink2(filename);
-	show_result(mknod(filename, S_IFBLK | 0644, MKDEV(1, 0)), 0);
-
-	policy = "allow_mkfifo /tmp/mknod_fifo_test 0644";
-	write_domain_policy(policy, 0);
-	filename = "/tmp/mknod_fifo_test";
-	show_result(mknod(filename, S_IFIFO | 0644, 0), 1);
-	write_domain_policy(policy, 1);
-	unlink2(filename);
-	show_result(mknod(filename, S_IFIFO | 0644, 0), 0);
-
-	policy = "allow_mksock /tmp/mknod_sock_test 0644";
-	write_domain_policy(policy, 0);
-	filename = "/tmp/mknod_sock_test";
-	show_result(mknod(filename, S_IFSOCK | 0644, 0), 1);
-	write_domain_policy(policy, 1);
-	unlink2(filename);
-	show_result(mknod(filename, S_IFSOCK | 0644, 0), 0);
-
-	policy = "allow_mkdir /tmp/mkdir_test/ 0600";
-	write_domain_policy(policy, 0);
-	filename = "/tmp/mkdir_test";
-	show_result(mkdir(filename, 0600), 1);
-	write_domain_policy(policy, 1);
-	rmdir2(filename);
-	show_result(mkdir(filename, 0600), 0);
-
-	policy = "allow_rmdir /tmp/rmdir_test/";
-	write_domain_policy(policy, 0);
-	filename = "/tmp/rmdir_test";
-	mkdir2(filename);
-	show_result(rmdir(filename), 1);
-	write_domain_policy(policy, 1);
-	mkdir2(filename);
-	show_result(rmdir(filename), 0);
-	rmdir2(filename);
-
-	policy = "allow_unlink /tmp/unlink_test";
-	write_domain_policy(policy, 0);
-	filename = "/tmp/unlink_test";
-	create2(filename);
-	show_result(unlink(filename), 1);
-	write_domain_policy(policy, 1);
-	create2(filename);
-	show_result(unlink(filename), 0);
-	unlink2(filename);
-
-	policy = "allow_symlink /tmp/symlink_source_test";
-	write_domain_policy(policy, 0);
-	filename = "/tmp/symlink_source_test";
-	show_result(symlink("/tmp/symlink_dest_test", filename), 1);
-	write_domain_policy(policy, 1);
-	unlink2(filename);
-	show_result(symlink("/tmp/symlink_dest_test", filename), 0);
-
-	policy = "allow_symlink /tmp/symlink_source_test";
-	write_domain_policy(policy, 0);
-	filename = "/tmp/symlink_source_test";
-	show_result(symlink("/tmp/symlink_dest_test", filename), 1);
-	write_domain_policy(policy, 1);
-	unlink2(filename);
-	show_result(symlink("/tmp/symlink_dest_test", filename), 0);
-
-	policy = "allow_symlink /tmp/symlink_source_test";
-	write_domain_policy(policy, 0);
-	filename = "/tmp/symlink_source_test";
-	show_result(symlink("/tmp/symlink_dest_test", filename), 1);
-	write_domain_policy(policy, 1);
-	unlink2(filename);
-	show_result(symlink("/tmp/symlink_dest_test", filename), 0);
-
-	policy = "allow_symlink /tmp/symlink_source_test";
-	write_domain_policy(policy, 0);
-	filename = "/tmp/symlink_source_test";
-	show_result(symlink("/tmp/symlink_dest_test", filename), 1);
-	write_domain_policy(policy, 1);
-	unlink2(filename);
-	show_result(symlink("/tmp/symlink_dest_test", filename), 0);
-
-	policy = "allow_symlink /tmp/symlink_source_test";
-	write_domain_policy(policy, 0);
-	filename = "/tmp/symlink_source_test";
-	show_result(symlink("/tmp/symlink_dest_test", filename), 1);
-	write_domain_policy(policy, 1);
-	unlink2(filename);
-	show_result(symlink("/tmp/symlink_dest_test", filename), 0);
-
-	policy = "allow_link /tmp/link_source_test /tmp/link_dest_test";
-	write_domain_policy(policy, 0);
-	filename = "/tmp/link_source_test";
-	create2(filename);
-	show_result(link(filename, "/tmp/link_dest_test"), 1);
-	write_domain_policy(policy, 1);
-	unlink2("/tmp/link_dest_test");
-	show_result(link(filename, "/tmp/link_dest_test"), 0);
-	unlink2(filename);
-
-	policy = "allow_rename /tmp/rename_source_test /tmp/rename_dest_test";
-	write_domain_policy(policy, 0);
-	filename = "/tmp/rename_source_test";
-	create2(filename);
-	show_result(rename(filename, "/tmp/rename_dest_test"), 1);
-	write_domain_policy(policy, 1);
-	unlink2("/tmp/rename_dest_test");
-	create2(filename);
-	show_result(rename(filename, "/tmp/rename_dest_test"), 0);
-	unlink2(filename);
-
-	policy = "allow_mksock /tmp/socket_test 0755";
-	write_domain_policy(policy, 0);
-	filename = "/tmp/socket_test";
-	memset(&addr, 0, sizeof(addr));
-	addr.sun_family = AF_UNIX;
-	strncpy(addr.sun_path, filename, sizeof(addr.sun_path) - 1);
-	fd = socket(AF_UNIX, SOCK_STREAM, 0);
-	show_result(bind(fd, (struct sockaddr *)&addr, sizeof(addr)), 1);
-	if (fd != EOF)
-		close(fd);
-	write_domain_policy(policy, 1);
-	unlink2(filename);
-	fd = socket(AF_UNIX, SOCK_STREAM, 0);
-	show_result(bind(fd, (struct sockaddr *)&addr, sizeof(addr)), 0);
-	if (fd != EOF)
-		close(fd);
-
-	filename = "/tmp/rewrite_test";
-	create2(filename);
-	policy = "allow_read/write /tmp/rewrite_test";
-	write_domain_policy(policy, 0);
-	write_exception_policy("deny_rewrite /tmp/rewrite_test", 0);
-	policy = "allow_truncate /tmp/rewrite_test";
-	write_domain_policy(policy, 0);
-
-	fd = open(filename, O_RDONLY);
-	show_result(fd, 1);
-	if (fd != EOF)
-		close(fd);
-
-	fd = open(filename, O_WRONLY | O_APPEND);
-	show_result(fd, 1);
-	if (fd != EOF)
-		close(fd);
-
-	fd = open(filename, O_WRONLY);
-	show_result(fd, 0);
-	if (fd != EOF)
-		close(fd);
-
-	fd = open(filename, O_WRONLY | O_TRUNC);
-	show_result(fd, 0);
-	if (fd != EOF)
-		close(fd);
-
-	fd = open(filename, O_WRONLY | O_TRUNC | O_APPEND);
-	show_result(fd, 0);
-	if (fd != EOF)
-		close(fd);
-
-	show_result(truncate(filename, 0), 0);
-
-	set_profile(0, "file::open");
-	fd = open(filename, O_WRONLY | O_APPEND);
-	set_profile(3, "file::open");
-	show_result(ftruncate(fd, 0), 0);
-
-	show_result(fcntl(fd, F_SETFL, fcntl(fd, F_GETFL) & ~O_APPEND), 0);
-	if (fd != EOF)
-		close(fd);
-
-	write_domain_policy(policy, 1);
-
-	policy = "allow_read/write /tmp/rewrite_test";
-	write_domain_policy(policy, 1);
-	write_exception_policy("deny_rewrite /tmp/rewrite_test", 1);
-
-	unlink2(filename);
-
-	policy = "allow_ioctl socket:[family=2:type=2:protocol=17] "
-	    "35122-35124";
-	write_domain_policy(policy, 0);
-	fd = socket(PF_INET, SOCK_DGRAM, IPPROTO_IP);
-	memset(&ifreq, 0, sizeof(ifreq));
-	snprintf(ifreq.ifr_name, sizeof(ifreq.ifr_name) - 1, "lo");
-	show_result(ioctl(fd, 35123, &ifreq), 1);
-	write_domain_policy(policy, 1);
-	policy = "allow_ioctl " "socket:[family=2:type=2:protocol=17] 0-35122";
-	write_domain_policy(policy, 0);
-	show_result(ioctl(fd, 35123, &ifreq), 0);
-	write_domain_policy(policy, 1);
-	if (fd != EOF)
-		close(fd);
-}
-
-int main(void)
-{
-	tomoyo_test_init();
-	fprintf(domain_fp, "%s /bin/true\n", self_domain);
-	fprintf(domain_fp, "use_profile 255\n");
-	fprintf(domain_fp, "select pid=%u\n", pid);
-	fprintf(profile_fp, "255-PREFERENCE::audit={ max_reject_log=1024 }\n");
-	stage_file_test();
-	fprintf(domain_fp, "use_profile 0\n");
-	clear_status();
-	return 0;
-}
diff --git a/testcases/kernel/security/tomoyo/tomoyo_new_test b/testcases/kernel/security/tomoyo/tomoyo_new_test
new file mode 100755
index 0000000000000000000000000000000000000000..d80f3a0d996d74da9ff37db26952e5dbc08b442a
GIT binary patch
literal 69800
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
Rmg$4^*X|I{twfMy-QRxKS^@w7

literal 0
HcmV?d00001

diff --git a/testcases/kernel/security/tomoyo/tomoyo_new_test.c b/testcases/kernel/security/tomoyo/tomoyo_new_test.c
deleted file mode 100644
index a1ab259e5..000000000
--- a/testcases/kernel/security/tomoyo/tomoyo_new_test.c
+++ /dev/null
@@ -1,652 +0,0 @@
-/******************************************************************************/
-/* This program is free software;  you can redistribute it and/or modify      */
-/* it under the terms of the GNU General Public License as published by       */
-/* the Free Software Foundation; either version 2 of the License, or          */
-/* (at your option) any later version.                                        */
-/*                                                                            */
-/* This program is distributed in the hope that it will be useful,            */
-/* but WITHOUT ANY WARRANTY;  without even the implied warranty of            */
-/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  */
-/* the GNU General Public License for more details.                           */
-/*                                                                            */
-/* You should have received a copy of the GNU General Public License          */
-/* along with this program;  if not, write to the Free Software               */
-/* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    */
-/*                                                                            */
-/******************************************************************************/
-/*
- * tomoyo_new_test.c
- *
- * Testing program for security/tomoyo/
- *
- * Copyright (C) 2005-2010  NTT DATA CORPORATION
- */
-#include "include.h"
-
-static int result;
-static int error;
-
-static void show_result(const char *test, int should_success)
-{
-	error = errno;
-	printf("%s : ", test);
-	if (should_success) {
-		if (error == 0)
-			printf("OK (%d)\n", result);
-		else
-			printf("FAILED: %s\n", strerror(error));
-	} else {
-		if (error == 0)
-			printf("BUG: Didn't fail (%d)\n", result);
-		else if (error == EPERM)
-			printf("OK: permission denied\n");
-		else
-			printf("FAILED: %s\n", strerror(error));
-	}
-}
-
-static void test_read_etc_fstab(void)
-{
-	result = open("/etc/fstab", O_RDONLY);
-}
-
-static void test_write_dev_null(void)
-{
-	result = open("/dev/null", O_WRONLY);
-}
-
-static void cleanup_file_open(void)
-{
-	if (result != EOF)
-		close(result);
-}
-
-static void test_mkdir_testdir(void)
-{
-	result = mkdir("/tmp/testdir", 0755);
-}
-
-static void cleanup_mkdir_testdir(void)
-{
-	rmdir("/tmp/testdir");
-}
-
-static void setup_mkdir_testdir(void)
-{
-	mkdir("/tmp/testdir", 0755);
-}
-
-static void test_rmdir_testdir(void)
-{
-	result = rmdir("/tmp/testdir");
-}
-
-static void setup_execute_bin_true(void)
-{
-	fprintf(domain_fp, "%s /bin/true\n", self_domain);
-	fprintf(domain_fp, "use_profile 0\n");
-	fprintf(domain_fp, "select pid=%u\n", pid);
-}
-
-static void cleanup_execute_bin_true(void)
-{
-	wait(NULL);
-	fprintf(domain_fp, "delete %s /bin/true\n", self_domain);
-	fprintf(domain_fp, "select pid=%u\n", pid);
-}
-
-static void test_execute_bin_true(void)
-{
-	char *argv[] = { "/bin/true", NULL };
-	char *envp[] = { "HOME=/", NULL };
-	int pipe_fd[2] = { EOF, EOF };
-	if (pipe(pipe_fd) == -1)
-		err(1, "pipe");
-	switch (fork()) {
-	case 0:
-		execve("/bin/true", argv, envp);
-		error = errno;
-		if (write(pipe_fd[1], &error, sizeof(error)) == -1)
-			err(1, "write");
-		_exit(0);
-		break;
-	case -1:
-		error = ENOMEM;
-		break;
-	}
-	close(pipe_fd[1]);
-	(void)read(pipe_fd[0], &error, sizeof(error));
-	close(pipe_fd[0]);
-	result = error ? EOF : 0;
-	errno = error;
-}
-
-static void test_chmod_dev_null(void)
-{
-	result = chmod("/dev/null", 0666);
-}
-
-static void test_chown_dev_null(void)
-{
-	result = chown("/dev/null", 0, -1);
-}
-
-static void test_chgrp_dev_null(void)
-{
-	result = chown("/dev/null", -1, 0);
-}
-
-static void test_ioctl_dev_null(void)
-{
-	int fd = open("/dev/null", O_RDWR);
-	errno = 0;
-	result = ioctl(fd, 0x5451, NULL);
-	error = errno;
-	close(fd);
-	errno = error;
-}
-
-static void setup_chmod_group(void)
-{
-	write_exception_policy("path_group CHMOD_TARGET /dev/null", 0);
-	write_exception_policy("number_group CHMOD_MODES 0666", 0);
-}
-
-static void cleanup_chmod_group(void)
-{
-	write_exception_policy("path_group CHMOD_TARGET /dev/null", 1);
-	write_exception_policy("number_group CHMOD_MODES 0666", 1);
-}
-
-static void setup_chown_group(void)
-{
-	write_exception_policy("path_group CHOWN_TARGET /dev/\\*", 0);
-	write_exception_policy("number_group CHOWN_IDS 0x0-0xFFFE", 0);
-}
-
-static void cleanup_chown_group(void)
-{
-	write_exception_policy("path_group CHOWN_TARGET /dev/\\*", 1);
-	write_exception_policy("number_group CHOWN_IDS 0x0-0xFFFE", 1);
-}
-
-static void setup_ioctl_group(void)
-{
-	write_exception_policy("path_group IOCTL_TARGET /dev/\\*", 0);
-	write_exception_policy("number_group IOCTL_NUMBERS 0x5450-0x5452", 0);
-}
-
-static void cleanup_ioctl_group(void)
-{
-	write_exception_policy("path_group IOCTL_TARGET /dev/\\*", 1);
-	write_exception_policy("number_group IOCTL_NUMBERS 0x5450-0x5452", 1);
-}
-
-static void setup_open_group(void)
-{
-	write_exception_policy("path_group READABLE /etc/\\*", 0);
-	write_exception_policy("number_group READABLE_IDS 0-0xFFF", 0);
-}
-
-static void cleanup_open_group(void)
-{
-	cleanup_file_open();
-	write_exception_policy("path_group READABLE /etc/\\*", 1);
-	write_exception_policy("number_group READABLE_IDS 0-0xFFF", 1);
-}
-
-static void test_file_open_0(void)
-{
-	result = open("/tmp/testfile0", O_RDONLY, 0600);
-}
-
-static void test_file_open_1(void)
-{
-	result = open("/tmp/testfile1", O_CREAT | O_RDONLY, 0600);
-}
-
-static void test_file_open_2(void)
-{
-	result = open("/tmp/testfile2", O_TRUNC | O_RDONLY, 0600);
-}
-
-static void test_file_open_3(void)
-{
-	result = open("/tmp/testfile3", O_TRUNC | O_CREAT | O_RDONLY, 0600);
-}
-
-static void test_file_open_4(void)
-{
-	result = open("/tmp/testfile4", O_APPEND | O_RDONLY, 0600);
-}
-
-static void test_file_open_5(void)
-{
-	result = open("/tmp/testfile5", O_APPEND | O_CREAT | O_RDONLY, 0600);
-}
-
-static void test_file_open_6(void)
-{
-	result = open("/tmp/testfile6", O_APPEND | O_TRUNC | O_RDONLY, 0600);
-}
-
-static void test_file_open_7(void)
-{
-	result = open("/tmp/testfile7",
-		      O_APPEND | O_TRUNC | O_CREAT | O_RDONLY, 0600);
-}
-
-static void test_file_open_8(void)
-{
-	result = open("/tmp/testfile8", O_WRONLY, 0600);
-}
-
-static void test_file_open_9(void)
-{
-	result = open("/tmp/testfile9", O_CREAT | O_WRONLY, 0600);
-}
-
-static void test_file_open_10(void)
-{
-	result = open("/tmp/testfile10", O_TRUNC | O_WRONLY, 0600);
-}
-
-static void test_file_open_11(void)
-{
-	result = open("/tmp/testfile11", O_TRUNC | O_CREAT | O_WRONLY, 0600);
-}
-
-static void test_file_open_12(void)
-{
-	result = open("/tmp/testfile12", O_APPEND | O_WRONLY, 0600);
-}
-
-static void test_file_open_13(void)
-{
-	result = open("/tmp/testfile13", O_APPEND | O_CREAT | O_WRONLY, 0600);
-}
-
-static void test_file_open_14(void)
-{
-	result = open("/tmp/testfile14", O_APPEND | O_TRUNC | O_WRONLY, 0600);
-}
-
-static void test_file_open_15(void)
-{
-	result = open("/tmp/testfile15",
-		      O_APPEND | O_TRUNC | O_CREAT | O_WRONLY, 0600);
-}
-
-static void test_file_open_16(void)
-{
-	result = open("/tmp/testfile16", O_RDWR, 0600);
-}
-
-static void test_file_open_17(void)
-{
-	result = open("/tmp/testfile17", O_CREAT | O_RDWR, 0600);
-}
-
-static void test_file_open_18(void)
-{
-	result = open("/tmp/testfile18", O_TRUNC | O_RDWR, 0600);
-}
-
-static void test_file_open_19(void)
-{
-	result = open("/tmp/testfile19", O_TRUNC | O_CREAT | O_RDWR, 0600);
-}
-
-static void test_file_open_20(void)
-{
-	result = open("/tmp/testfile20", O_APPEND | O_RDWR, 0600);
-}
-
-static void test_file_open_21(void)
-{
-	result = open("/tmp/testfile21", O_APPEND | O_CREAT | O_RDWR, 0600);
-}
-
-static void test_file_open_22(void)
-{
-	result = open("/tmp/testfile22", O_APPEND | O_TRUNC | O_RDWR, 0600);
-}
-
-static void test_file_open_23(void)
-{
-	result = open("/tmp/testfile23", O_APPEND | O_TRUNC | O_CREAT | O_RDWR,
-		      0600);
-}
-
-static void setup_test_file(void)
-{
-	int i;
-	char buffer[32];
-	buffer[31] = '\0';
-	for (i = 0; i < 24; i += 2) {
-		snprintf(buffer, sizeof(buffer) - 1, "/tmp/testfile%u", i);
-		close(open(buffer, O_WRONLY | O_CREAT, 0600));
-	}
-	write_exception_policy("deny_rewrite /tmp/testfile\\$", 0);
-}
-
-static void setup_test_file_truncate(void)
-{
-	setup_test_file();
-	write_domain_policy("allow_truncate /tmp/testfile\\$", 0);
-	set_profile(3, "file::truncate");
-}
-
-static void setup_all_test_file(void)
-{
-	int i;
-	char buffer[32];
-	buffer[31] = '\0';
-	for (i = 0; i < 24; i++) {
-		snprintf(buffer, sizeof(buffer) - 1, "/tmp/testfile%u", i);
-		close(open(buffer, O_WRONLY | O_CREAT, 0600));
-	}
-	write_exception_policy("deny_rewrite /tmp/testfile\\$", 0);
-}
-
-static void setup_all_test_file_truncate(void)
-{
-	setup_all_test_file();
-	write_domain_policy("allow_truncate /tmp/testfile\\$", 0);
-	set_profile(3, "file::truncate");
-}
-
-static void cleanup_test_file(void)
-{
-	int i;
-	char buffer[32];
-	buffer[31] = '\0';
-	for (i = 0; i < 24; i++) {
-		snprintf(buffer, sizeof(buffer) - 1, "/tmp/testfile%u", i);
-		unlink(buffer);
-	}
-	write_exception_policy("deny_rewrite /tmp/testfile\\$", 1);
-	cleanup_file_open();
-}
-
-static void cleanup_test_file_truncate(void)
-{
-	cleanup_test_file();
-	write_domain_policy("allow_truncate /tmp/testfile\\$", 1);
-	set_profile(0, "file::truncate");
-}
-
-static struct test_struct {
-	void (*do_setup) (void);
-	void (*do_test) (void);
-	void (*do_cleanup) (void);
-	const char *name;
-	const char *policy;
-} tests[] = {
-	{
-	NULL, test_read_etc_fstab, cleanup_file_open, "file::open",
-		    "allow_read /etc/fstab"}, {
-	NULL, test_read_etc_fstab, cleanup_file_open, "file::open",
-		    "allow_read /etc/fstab"}, {
-	NULL, test_read_etc_fstab, cleanup_file_open, "file::open",
-		    "allow_read /etc/fstab"}, {
-	setup_open_group, test_read_etc_fstab, cleanup_open_group,
-		    "file::open", "allow_read @READABLE"}, {
-	NULL, test_write_dev_null, cleanup_file_open, "file::open",
-		    "allow_write /dev/null"}, {
-	NULL, test_write_dev_null, cleanup_file_open, "file::open",
-		    "allow_write /dev/null"}, {
-	NULL, test_write_dev_null, cleanup_file_open, "file::open",
-		    "allow_write /dev/null"}, {
-	cleanup_mkdir_testdir, test_mkdir_testdir,
-		    cleanup_mkdir_testdir, "file::mkdir",
-		    "allow_mkdir /tmp/testdir/ 0755"}, {
-	cleanup_mkdir_testdir, test_mkdir_testdir,
-		    cleanup_mkdir_testdir, "file::mkdir",
-		    "allow_mkdir /tmp/testdir/ 0755"}, {
-	cleanup_mkdir_testdir, test_mkdir_testdir,
-		    cleanup_mkdir_testdir, "file::mkdir",
-		    "allow_mkdir /tmp/testdir/ 0755"}, {
-	setup_mkdir_testdir, test_rmdir_testdir, cleanup_mkdir_testdir,
-		    "file::rmdir", "allow_rmdir /tmp/testdir/"}, {
-	setup_mkdir_testdir, test_rmdir_testdir, cleanup_mkdir_testdir,
-		    "file::rmdir", "allow_rmdir /tmp/testdir/"}, {
-	setup_mkdir_testdir, test_rmdir_testdir, cleanup_mkdir_testdir,
-		    "file::rmdir", "allow_rmdir /tmp/testdir/"}, {
-	setup_execute_bin_true, test_execute_bin_true,
-		    cleanup_execute_bin_true, "file::execute",
-		    "allow_execute /bin/true"}, {
-	setup_execute_bin_true, test_execute_bin_true,
-		    cleanup_execute_bin_true, "file::execute",
-		    "allow_execute /bin/true"}, {
-	setup_execute_bin_true, test_execute_bin_true,
-		    cleanup_execute_bin_true, "file::execute",
-		    "allow_execute /bin/true"}, {
-	NULL, test_chmod_dev_null, NULL, "file::chmod",
-		    "allow_chmod /dev/null 0666"}, {
-	NULL, test_chown_dev_null, NULL, "file::chown",
-		    "allow_chown /dev/null 0"}, {
-	NULL, test_chgrp_dev_null, NULL, "file::chgrp",
-		    "allow_chgrp /dev/null 0"}, {
-	NULL, test_ioctl_dev_null, NULL, "file::ioctl",
-		    "allow_ioctl /dev/null 0x5451"}, {
-	setup_chmod_group, test_chmod_dev_null, cleanup_chmod_group,
-		    "file::chmod", "allow_chmod @CHMOD_TARGET @CHMOD_MODES"}, {
-	setup_chown_group, test_chown_dev_null, cleanup_chown_group,
-		    "file::chown", "allow_chown @CHOWN_TARGET @CHOWN_IDS"}, {
-	setup_chown_group, test_chgrp_dev_null, cleanup_chown_group,
-		    "file::chgrp", "allow_chgrp @CHOWN_TARGET @CHOWN_IDS"}, {
-	setup_ioctl_group, test_ioctl_dev_null, cleanup_ioctl_group,
-		    "file::ioctl", "allow_ioctl @IOCTL_TARGET @IOCTL_NUMBERS"},
-	{
-	setup_test_file, test_file_open_0, cleanup_test_file,
-		    "file::open", "allow_read /tmp/testfile0"}, {
-	setup_test_file, test_file_open_1, cleanup_test_file,
-		    "file::open", "allow_read /tmp/testfile1"}, {
-	setup_test_file, test_file_open_1, cleanup_test_file,
-		    "file::create", "allow_create /tmp/testfile1 0600"}, {
-	setup_test_file, test_file_open_2, cleanup_test_file,
-		    "file::open", "allow_read /tmp/testfile2"}, {
-	setup_test_file, test_file_open_2, cleanup_test_file,
-		    "file::truncate", "allow_truncate /tmp/testfile2"}, {
-	setup_test_file_truncate, test_file_open_2,
-		    cleanup_test_file_truncate, "file::rewrite",
-		    "allow_rewrite /tmp/testfile2"}, {
-	setup_test_file, test_file_open_3, cleanup_test_file,
-		    "file::open", "allow_read /tmp/testfile3"}, {
-	setup_test_file, test_file_open_3, cleanup_test_file,
-		    "file::create", "allow_create /tmp/testfile3 0600"}, {
-	setup_test_file, test_file_open_4, cleanup_test_file,
-		    "file::open", "allow_read /tmp/testfile4"}, {
-	setup_test_file, test_file_open_5, cleanup_test_file,
-		    "file::open", "allow_read /tmp/testfile5"}, {
-	setup_test_file, test_file_open_5, cleanup_test_file,
-		    "file::create", "allow_create /tmp/testfile5 0600"}, {
-	setup_test_file, test_file_open_6, cleanup_test_file,
-		    "file::open", "allow_read /tmp/testfile6"}, {
-	setup_test_file, test_file_open_6, cleanup_test_file,
-		    "file::truncate", "allow_truncate /tmp/testfile6"}, {
-	setup_test_file_truncate, test_file_open_6,
-		    cleanup_test_file_truncate, "file::rewrite",
-		    "allow_rewrite /tmp/testfile6"}, {
-	setup_test_file, test_file_open_7, cleanup_test_file,
-		    "file::open", "allow_read /tmp/testfile7"}, {
-	setup_test_file, test_file_open_7, cleanup_test_file,
-		    "file::create", "allow_create /tmp/testfile7 0600"}, {
-	setup_test_file, test_file_open_8, cleanup_test_file,
-		    "file::open", "allow_write /tmp/testfile8"}, {
-	setup_test_file, test_file_open_8, cleanup_test_file,
-		    "file::rewrite", "allow_rewrite /tmp/testfile8"}, {
-	setup_test_file, test_file_open_9, cleanup_test_file,
-		    "file::open", "allow_write /tmp/testfile9"}, {
-	setup_test_file, test_file_open_9, cleanup_test_file,
-		    "file::create", "allow_create /tmp/testfile9 0600"}, {
-	setup_test_file, test_file_open_9, cleanup_test_file,
-		    "file::rewrite", "allow_rewrite /tmp/testfile9"}, {
-	setup_test_file, test_file_open_10, cleanup_test_file,
-		    "file::open", "allow_write /tmp/testfile10"}, {
-	setup_test_file, test_file_open_10, cleanup_test_file,
-		    "file::truncate", "allow_truncate /tmp/testfile10"}, {
-	setup_test_file, test_file_open_10, cleanup_test_file,
-		    "file::rewrite", "allow_rewrite /tmp/testfile10"}, {
-	setup_test_file, test_file_open_11, cleanup_test_file,
-		    "file::open", "allow_write /tmp/testfile11"}, {
-	setup_test_file, test_file_open_11, cleanup_test_file,
-		    "file::create", "allow_create /tmp/testfile11 0600"}, {
-	setup_test_file, test_file_open_11, cleanup_test_file,
-		    "file::rewrite", "allow_rewrite /tmp/testfile11"}, {
-	setup_test_file, test_file_open_12, cleanup_test_file,
-		    "file::open", "allow_write /tmp/testfile12"}, {
-	setup_test_file, test_file_open_13, cleanup_test_file,
-		    "file::open", "allow_write /tmp/testfile13"}, {
-	setup_test_file, test_file_open_13, cleanup_test_file,
-		    "file::create", "allow_create /tmp/testfile13 0600"}, {
-	setup_test_file, test_file_open_14, cleanup_test_file,
-		    "file::open", "allow_write /tmp/testfile14"}, {
-	setup_test_file, test_file_open_14, cleanup_test_file,
-		    "file::truncate", "allow_truncate /tmp/testfile14"}, {
-	setup_test_file_truncate, test_file_open_14,
-		    cleanup_test_file_truncate, "file::rewrite",
-		    "allow_rewrite /tmp/testfile14"}, {
-	setup_test_file, test_file_open_15, cleanup_test_file,
-		    "file::open", "allow_write /tmp/testfile15"}, {
-	setup_test_file, test_file_open_15, cleanup_test_file,
-		    "file::create", "allow_create /tmp/testfile15 0600"}, {
-	setup_test_file, test_file_open_16, cleanup_test_file,
-		    "file::open", "allow_read/write /tmp/testfile16"}, {
-	setup_test_file, test_file_open_16, cleanup_test_file,
-		    "file::rewrite", "allow_rewrite /tmp/testfile16"}, {
-	setup_test_file, test_file_open_17, cleanup_test_file,
-		    "file::open", "allow_read/write /tmp/testfile17"}, {
-	setup_test_file, test_file_open_17, cleanup_test_file,
-		    "file::create", "allow_create /tmp/testfile17 0600"}, {
-	setup_test_file, test_file_open_17, cleanup_test_file,
-		    "file::rewrite", "allow_rewrite /tmp/testfile17"}, {
-	setup_test_file, test_file_open_18, cleanup_test_file,
-		    "file::open", "allow_read/write /tmp/testfile18"}, {
-	setup_test_file, test_file_open_18, cleanup_test_file,
-		    "file::truncate", "allow_truncate /tmp/testfile18"}, {
-	setup_test_file, test_file_open_18, cleanup_test_file,
-		    "file::rewrite", "allow_rewrite /tmp/testfile18"}, {
-	setup_test_file, test_file_open_19, cleanup_test_file,
-		    "file::open", "allow_read/write /tmp/testfile19"}, {
-	setup_test_file, test_file_open_19, cleanup_test_file,
-		    "file::create", "allow_create /tmp/testfile19 0600"}, {
-	setup_test_file, test_file_open_19, cleanup_test_file,
-		    "file::rewrite", "allow_rewrite /tmp/testfile19"}, {
-	setup_test_file, test_file_open_20, cleanup_test_file,
-		    "file::open", "allow_read/write /tmp/testfile20"}, {
-	setup_test_file, test_file_open_21, cleanup_test_file,
-		    "file::open", "allow_read/write /tmp/testfile21"}, {
-	setup_test_file, test_file_open_21, cleanup_test_file,
-		    "file::create", "allow_create /tmp/testfile21 0600"}, {
-	setup_test_file, test_file_open_22, cleanup_test_file,
-		    "file::open", "allow_read/write /tmp/testfile22"}, {
-	setup_test_file, test_file_open_22, cleanup_test_file,
-		    "file::truncate", "allow_truncate /tmp/testfile22"}, {
-	setup_test_file_truncate, test_file_open_22,
-		    cleanup_test_file_truncate, "file::rewrite",
-		    "allow_rewrite /tmp/testfile22"}, {
-	setup_test_file, test_file_open_23, cleanup_test_file,
-		    "file::open", "allow_read/write /tmp/testfile23"}, {
-	setup_test_file, test_file_open_23, cleanup_test_file,
-		    "file::create", "allow_create /tmp/testfile23 0600"}, {
-	setup_all_test_file, test_file_open_0, cleanup_test_file,
-		    "file::open", "allow_read /tmp/testfile0"}, {
-	setup_all_test_file, test_file_open_2, cleanup_test_file,
-		    "file::open", "allow_read /tmp/testfile2"}, {
-	setup_all_test_file, test_file_open_2, cleanup_test_file,
-		    "file::truncate", "allow_truncate /tmp/testfile2"}, {
-	setup_all_test_file_truncate, test_file_open_2,
-		    cleanup_test_file_truncate, "file::rewrite",
-		    "allow_rewrite /tmp/testfile2"}, {
-	setup_all_test_file, test_file_open_4, cleanup_test_file,
-		    "file::open", "allow_read /tmp/testfile4"}, {
-	setup_all_test_file, test_file_open_6, cleanup_test_file,
-		    "file::open", "allow_read /tmp/testfile6"}, {
-	setup_all_test_file, test_file_open_6, cleanup_test_file,
-		    "file::truncate", "allow_truncate /tmp/testfile6"}, {
-	setup_all_test_file_truncate, test_file_open_6,
-		    cleanup_test_file_truncate, "file::rewrite",
-		    "allow_rewrite /tmp/testfile6"}, {
-	setup_all_test_file, test_file_open_8, cleanup_test_file,
-		    "file::open", "allow_write /tmp/testfile8"}, {
-	setup_all_test_file, test_file_open_8, cleanup_test_file,
-		    "file::rewrite", "allow_rewrite /tmp/testfile8"}, {
-	setup_all_test_file, test_file_open_10, cleanup_test_file,
-		    "file::open", "allow_write /tmp/testfile10"}, {
-	setup_all_test_file, test_file_open_10, cleanup_test_file,
-		    "file::truncate", "allow_truncate /tmp/testfile10"}, {
-	setup_all_test_file, test_file_open_10, cleanup_test_file,
-		    "file::rewrite", "allow_rewrite /tmp/testfile10"}, {
-	setup_all_test_file, test_file_open_12, cleanup_test_file,
-		    "file::open", "allow_write /tmp/testfile12"}, {
-	setup_all_test_file, test_file_open_14, cleanup_test_file,
-		    "file::open", "allow_write /tmp/testfile14"}, {
-	setup_all_test_file, test_file_open_14, cleanup_test_file,
-		    "file::truncate", "allow_truncate /tmp/testfile14"}, {
-	setup_all_test_file_truncate, test_file_open_14,
-		    cleanup_test_file_truncate, "file::rewrite",
-		    "allow_rewrite /tmp/testfile14"}, {
-	setup_all_test_file, test_file_open_16, cleanup_test_file,
-		    "file::open", "allow_read/write /tmp/testfile16"}, {
-	setup_all_test_file, test_file_open_16, cleanup_test_file,
-		    "file::rewrite", "allow_rewrite /tmp/testfile16"}, {
-	setup_all_test_file, test_file_open_18, cleanup_test_file,
-		    "file::open", "allow_read/write /tmp/testfile18"}, {
-	setup_all_test_file, test_file_open_18, cleanup_test_file,
-		    "file::truncate", "allow_truncate /tmp/testfile18"}, {
-	setup_all_test_file, test_file_open_18, cleanup_test_file,
-		    "file::rewrite", "allow_rewrite /tmp/testfile18"}, {
-	setup_all_test_file, test_file_open_20, cleanup_test_file,
-		    "file::open", "allow_read/write /tmp/testfile20"}, {
-	setup_all_test_file, test_file_open_22, cleanup_test_file,
-		    "file::open", "allow_read/write /tmp/testfile22"}, {
-	setup_all_test_file, test_file_open_22, cleanup_test_file,
-		    "file::truncate", "allow_truncate /tmp/testfile22"}, {
-	setup_all_test_file_truncate, test_file_open_22,
-		    cleanup_test_file_truncate, "file::rewrite",
-		    "allow_rewrite /tmp/testfile22"}, {
-	NULL}
-};
-
-int main(void)
-{
-	int i;
-	tomoyo_test_init();
-	for (i = 0; tests[i].do_test; i++) {
-		int trial;
-		for (trial = 0; trial < 2; trial++) {
-			int should_fail;
-			for (should_fail = 0; should_fail < 2; should_fail++) {
-				if (tests[i].do_setup)
-					tests[i].do_setup();
-				if (!should_fail)
-					write_domain_policy(tests[i].policy, 0);
-				set_profile(3, tests[i].name);
-				tests[i].do_test();
-				show_result(tests[i].policy, !should_fail);
-				set_profile(0, tests[i].name);
-				if (tests[i].do_cleanup)
-					tests[i].do_cleanup();
-				if (!should_fail)
-					write_domain_policy(tests[i].policy, 1);
-			}
-		}
-	}
-	for (i = 0; tests[i].do_test; i++) {
-		int mode;
-		for (mode = 0; mode < 4; mode++) {
-			if (tests[i].do_setup)
-				tests[i].do_setup();
-			set_profile(mode, tests[i].name);
-			tests[i].do_test();
-			show_result(tests[i].name, 1);
-			set_profile(0, tests[i].name);
-			if (tests[i].do_cleanup)
-				tests[i].do_cleanup();
-		}
-	}
-	fprintf(domain_fp, "delete %s\n", self_domain);
-	return 0;
-}
diff --git a/testcases/kernel/security/tomoyo/tomoyo_policy_io_test b/testcases/kernel/security/tomoyo/tomoyo_policy_io_test
new file mode 100755
index 0000000000000000000000000000000000000000..4c6c145b88f4254e6662e0d76f68bf475b285cf8
GIT binary patch
literal 49648
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

literal 0
HcmV?d00001

diff --git a/testcases/kernel/security/tomoyo/tomoyo_policy_io_test.c b/testcases/kernel/security/tomoyo/tomoyo_policy_io_test.c
deleted file mode 100644
index b1897a0fc..000000000
--- a/testcases/kernel/security/tomoyo/tomoyo_policy_io_test.c
+++ /dev/null
@@ -1,195 +0,0 @@
-/******************************************************************************/
-/* This program is free software;  you can redistribute it and/or modify      */
-/* it under the terms of the GNU General Public License as published by       */
-/* the Free Software Foundation; either version 2 of the License, or          */
-/* (at your option) any later version.                                        */
-/*                                                                            */
-/* This program is distributed in the hope that it will be useful,            */
-/* but WITHOUT ANY WARRANTY;  without even the implied warranty of            */
-/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  */
-/* the GNU General Public License for more details.                           */
-/*                                                                            */
-/* You should have received a copy of the GNU General Public License          */
-/* along with this program;  if not, write to the Free Software               */
-/* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    */
-/*                                                                            */
-/******************************************************************************/
-/*
- * tomoyo_policy_io_test.c
- *
- * Testing program for security/tomoyo/
- *
- * Copyright (C) 2005-2010  NTT DATA CORPORATION
- */
-#include "include.h"
-
-static FILE *policy_fp = NULL;
-static const char *policy_file = "";
-
-static void try_io(const char *policy, const char should_success)
-{
-	FILE *fp = fopen(policy_file, "r");
-	char buffer[8192];
-	int policy_found = 0;
-	memset(buffer, 0, sizeof(buffer));
-	printf("%s: ", policy);
-	fprintf(policy_fp, "%s\n", policy);
-	if (!fp) {
-		printf("BUG: policy read failed\n");
-		return;
-	}
-	while (fgets(buffer, sizeof(buffer) - 1, fp)) {
-		char *cp = strchr(buffer, '\n');
-		if (cp)
-			*cp = '\0';
-		if (!strcmp(buffer, policy)) {
-			policy_found = 1;
-			break;
-		}
-	}
-	fclose(fp);
-	if (should_success) {
-		if (policy_found)
-			printf("OK\n");
-		else
-			printf("BUG: policy write failed\n");
-	} else {
-		if (!policy_found)
-			printf("OK : write rejected.\n");
-		else
-			printf("BUG: policy write not rejected.\n");
-	}
-	fprintf(policy_fp, "delete %s\n", policy);
-}
-
-static void stage_policy_io_test(void)
-{
-	int i;
-	policy_file = proc_policy_domain_policy;
-	policy_fp = domain_fp;
-	for (i = 0; i < 3; i++) {
-		try_io("allow_chroot /", 1);
-		try_io("allow_chroot ", 0);
-		try_io("allow_chroot /mnt0/", 1);
-		try_io("allow_chroot /var1/chroot2/", 1);
-		try_io("allow_chroot /mnt0/", 1);
-		try_io("allow_chroot /mnt0/", 1);
-		try_io("allow_chroot /mnt0/", 1);
-		try_io("allow_chroot /mnt\\?\\*/", 1);
-		try_io("allow_chroot /mnt\\?\\*/", 1);
-		try_io("allow_unmount /", 1);
-		try_io("allow_unmount /sys1/", 1);
-		try_io("allow_unmount /initrd2/", 1);
-		try_io("allow_unmount /initrd/dev3/", 1);
-		try_io("allow_unmount /initrd/\\*\\+/", 1);
-		try_io("allow_unmount /initrd/\\@\\*/", 1);
-		try_io("allow_unmount /initrd2/", 1);
-		try_io("allow_pivot_root / /proc3/", 1);
-		try_io("allow_pivot_root /sys5/ /proc3/", 1);
-		try_io("allow_pivot_root /sys/", 0);
-		try_io("allow_pivot_root *", 0);
-		try_io("allow_pivot_root /sys5/ /proc3/", 1);
-		try_io("allow_mount / / --bind 0xD", 1);
-		try_io("allow_mount / / --move 0xF", 1);
-		try_io("allow_mount / --remount", 0);
-		try_io("allow_mount /", 0);
-		try_io("allow_mount none /tmp/ tmpfs 0x1", 1);
-		try_io("allow_mount none /tmp/ tmpfs", 0);
-		try_io("allow_mount none /tmp/ nonexistent 0x0", 1);
-		try_io("allow_mount none /proc/ proc 0x0", 1);
-		try_io("allow_mount none /selinux/ selinuxfs 0x0", 1);
-		try_io("allow_mount /proc/bus/usb /proc/bus/usb/ usbfs 0x0", 1);
-		try_io("allow_mount none /dev/pts/ devpts 0x0", 1);
-		try_io("allow_mount any / --remount 0xC00", 1);
-		try_io("allow_mount /dev/sda1 /boot/ ext3 0xC00", 1);
-		try_io("allow_mount none /dev/shm/ tmpfs 0x0", 1);
-		try_io("allow_mount none /proc/sys/fs/binfmt_misc/ binfmt_misc "
-		       "0x0", 1);
-		try_io("allow_mount none /proc/sys/fs/binfmt_misc/ binfmt_misc "
-		       "0x0 0x1", 0);
-		try_io("allow_mount none /proc/sys/fs/binfmt_misc/ tmpfs "
-		       "binfmt_misc 0x0", 0);
-		try_io("allow_mount /proc/bus/usb /proc/bus/usb/ usbfs 0x0", 1);
-	}
-	policy_file = proc_policy_exception_policy;
-	policy_fp = exception_fp;
-	for (i = 0; i < 3; i++) {
-		try_io("allow_read /tmp/abc", 1);
-		try_io("allow_read /tmp/abc\\*", 1);
-		try_io("allow_read abc", 1);
-		try_io("allow_read /tmp/abc/", 1);
-		try_io("allow_read", 0);
-		try_io("allow_read *", 1);
-		try_io("file_pattern /\\*\\*\\*", 1);
-		try_io("file_pattern /abc", 1);
-		try_io("file_pattern /abc /def", 0);
-		try_io("file_pattern abcdef", 1);
-		try_io("path_group TEST /", 1);
-		try_io("path_group TEST /boo", 1);
-		try_io("path_group TEST /bar", 1);
-		try_io("path_group TEST /\\*", 1);
-		try_io("path_group TEST / /", 0);
-		try_io("path_group TEST /boo", 1);
-		try_io("path_group TEST /bar", 1);
-		try_io("path_group TEST boo", 1);
-		try_io("path_group TEST boo/", 1);
-		try_io("path_group TEST /bar", 1);
-		try_io("path_group TEST3 /\\*", 1);
-		try_io("path_group TEST3 / /", 0);
-		try_io("path_group TEST3 /boo", 1);
-		try_io("path_group TEST3 /bar", 1);
-		try_io("path_group TEST3 boo", 1);
-		try_io("path_group TEST3 boo/", 1);
-		try_io("deny_rewrite /", 1);
-		try_io("deny_rewrite /foo", 1);
-		try_io("deny_rewrite /\\*", 1);
-		try_io("deny_rewrite /\\:", 0);
-		try_io("deny_rewrite / /", 0);
-		try_io("deny_rewrite @/TEST", 1);
-		try_io("aggregator /boo/\\* /BOO", 1);
-		try_io("aggregator /boo/\\* /BOO\\*", 0);
-		try_io("aggregator /boo/\\*/ /BOO", 1);
-		try_io("aggregator /boo/\\* /BOO/", 1);
-		try_io("keep_domain <kernel>", 1);
-		try_io("keep_domain <kernel> /sbin/init", 1);
-		try_io("keep_domain <kernel> foo", 0);
-		try_io("keep_domain <kernel> \\*", 0);
-		try_io("keep_domain /ssh", 1);
-		try_io("keep_domain /ssh /foo", 0);
-		try_io("keep_domain /foo from <kernel>", 1);
-		try_io("keep_domain /foo from <kernel> /sbin/init", 1);
-		try_io("keep_domain from <kernel> /sbin/init", 0);
-		try_io("keep_domain \\* from <kernel> /sbin/init", 0);
-		try_io("no_keep_domain <kernel>", 1);
-		try_io("no_keep_domain <kernel> /sbin/init", 1);
-		try_io("no_keep_domain <kernel> foo", 0);
-		try_io("no_keep_domain <kernel> \\*", 0);
-		try_io("no_keep_domain /ssh", 1);
-		try_io("no_keep_domain /ssh /foo", 0);
-		try_io("no_keep_domain /foo from <kernel>", 1);
-		try_io("no_keep_domain /foo from <kernel> /sbin/init", 1);
-		try_io("no_keep_domain from <kernel> /sbin/init", 0);
-		try_io("no_keep_domain \\* from <kernel> /sbin/init", 0);
-		try_io("initialize_domain /foo", 1);
-		try_io("initialize_domain /\\*", 1);
-		try_io("initialize_domain /foo /bar", 0);
-		try_io("initialize_domain /foo from /bar", 1);
-		try_io("initialize_domain /foo from <kernel> /bar", 1);
-		try_io("initialize_domain /\\* from <kernel>", 1);
-		try_io("initialize_domain /foo from <kernel> \\*", 0);
-		try_io("no_initialize_domain /foo", 1);
-		try_io("no_initialize_domain /\\*", 1);
-		try_io("no_initialize_domain /foo /bar", 0);
-		try_io("no_initialize_domain /foo from /bar", 1);
-		try_io("no_initialize_domain /foo from <kernel> /bar", 1);
-		try_io("no_initialize_domain /\\* from <kernel>", 1);
-		try_io("no_initialize_domain /foo from <kernel> \\*", 0);
-	}
-}
-
-int main(void)
-{
-	tomoyo_test_init();
-	stage_policy_io_test();
-	return 0;
-}
diff --git a/testcases/kernel/security/tomoyo/tomoyo_policy_memory_test b/testcases/kernel/security/tomoyo/tomoyo_policy_memory_test
new file mode 100755
index 0000000000000000000000000000000000000000..7f308afc4e190d7665092f97e217d5cde0033f35
GIT binary patch
literal 34080
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
EA1^IOrvLx|

literal 0
HcmV?d00001

diff --git a/testcases/kernel/security/tomoyo/tomoyo_policy_memory_test.c b/testcases/kernel/security/tomoyo/tomoyo_policy_memory_test.c
deleted file mode 100644
index a6620ba30..000000000
--- a/testcases/kernel/security/tomoyo/tomoyo_policy_memory_test.c
+++ /dev/null
@@ -1,358 +0,0 @@
-/******************************************************************************/
-/* This program is free software;  you can redistribute it and/or modify      */
-/* it under the terms of the GNU General Public License as published by       */
-/* the Free Software Foundation; either version 2 of the License, or          */
-/* (at your option) any later version.                                        */
-/*                                                                            */
-/* This program is distributed in the hope that it will be useful,            */
-/* but WITHOUT ANY WARRANTY;  without even the implied warranty of            */
-/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  */
-/* the GNU General Public License for more details.                           */
-/*                                                                            */
-/* You should have received a copy of the GNU General Public License          */
-/* along with this program;  if not, write to the Free Software               */
-/* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    */
-/*                                                                            */
-/******************************************************************************/
-/*
- * tomoyo_policy_memory_test.c
- *
- * Testing program for security/tomoyo/
- *
- * Copyright (C) 2005-2010  NTT DATA CORPORATION
- */
-/*
- * Usage: Run this program using init= boot option.
- */
-#include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
-#include <unistd.h>
-#include <sys/mount.h>
-
-static void BUG(const char *msg)
-{
-	printf("%s", msg);
-	fflush(stdout);
-	while (1)
-		sleep(100);
-}
-
-static const char *policy_file = NULL;
-static const char *policy = NULL;
-
-static void get_meminfo(unsigned int *policy_memory)
-{
-	FILE *fp = fopen("/sys/kernel/security/tomoyo/meminfo", "r");
-	if (!fp || fscanf(fp, "Policy: %u", policy_memory) != 1 || fclose(fp))
-		BUG("BUG: Policy read error\n");
-}
-
-static void check_policy_common(const int found_expected, const int id)
-{
-	FILE *fp = fopen(policy_file, "r");
-	char buffer[8192];
-	int policy_found = 0;
-	memset(buffer, 0, sizeof(buffer));
-	if (!fp)
-		BUG("BUG: Policy read error\n");
-	while (fgets(buffer, sizeof(buffer) - 1, fp)) {
-		char *cp = strchr(buffer, '\n');
-		if (cp)
-			*cp = '\0';
-		if (strcmp(buffer, policy))
-			continue;
-		policy_found = 1;
-		break;
-	}
-	fclose(fp);
-	if (policy_found != found_expected) {
-		printf("BUG: Policy write error: %s %s at %d\n", policy,
-		       found_expected ? "not added" : "not deleted", id);
-		BUG("");
-	}
-}
-
-static inline void check_policy_written(FILE * fp, const int id)
-{
-	fflush(fp);
-	check_policy_common(1, id);
-}
-
-static inline void check_policy_deleted(FILE * fp, const int id)
-{
-	fflush(fp);
-	check_policy_common(0, id);
-}
-
-static const char *domain_testcases[] = {
-	"allow_create /tmp/mknod_reg_test 0600",
-	"allow_create /tmp/open_test 0600",
-	"allow_create /tmp/open_test 0600",
-	"allow_create /tmp/open_test 0600",
-	"allow_execute /bin/true",
-	"allow_execute /bin/true",
-	"allow_execute /bin/true0",
-	"allow_execute /bin/true1",
-	"allow_execute /bin/true2",
-	"allow_execute /bin/true3",
-	"allow_execute /bin/true4",
-	"allow_execute /bin/true5",
-	"allow_execute /bin/true6",
-	"allow_execute /bin/true7",
-	"allow_execute /bin/true7",
-	"allow_execute /bin/true7",
-	"allow_execute /bin/true8",
-	"allow_ioctl socket:[family=2:type=2:protocol=17] 0-35122",
-	"allow_ioctl socket:[family=2:type=2:protocol=17] 35122-35124",
-	"allow_link /tmp/link_source_test /tmp/link_dest_test",
-	"allow_mkblock /tmp/mknod_blk_test 0600 1 0",
-	"allow_mkchar /tmp/mknod_chr_test 0600 1 3",
-	"allow_mkdir /tmp/mkdir_test/ 0755",
-	"allow_mkfifo /tmp/mknod_fifo_test 0600",
-	"allow_mkfifo /tmp/mknod_fifo_test 0600",
-	"allow_mksock /tmp/mknod_sock_test 0600",
-	"allow_mksock /tmp/socket_test 0600",
-	"allow_read /bin/true",
-	"allow_read /bin/true",
-	"allow_read /dev/null",
-	"allow_read /dev/null",
-	"allow_read /dev/null",
-	"allow_read /dev/null",
-	"allow_read /dev/null",
-	"allow_read /dev/null",
-	"allow_read /foo",
-	"allow_read /proc/sys/net/ipv4/ip_local_port_range",
-	"allow_read /proc/sys/net/ipv4/ip_local_port_range",
-	"allow_read/write /bar",
-	"allow_read/write /dev/null",
-	"allow_read/write /dev/null",
-	"allow_read/write /proc/sys/net/ipv4/ip_local_port_range",
-	"allow_read/write /proc/sys/net/ipv4/ip_local_port_range",
-	"allow_read/write /tmp/fifo",
-	"allow_read/write /tmp/fifo",
-	"allow_read/write /tmp/rewrite_test",
-	"allow_rename /tmp/rename_source_test /tmp/rename_dest_test",
-	"allow_rmdir /tmp/rmdir_test/",
-	"allow_symlink /symlink",
-	"allow_symlink /symlink",
-	"allow_symlink /symlink",
-	"allow_symlink /symlink",
-	"allow_symlink /tmp/symlink_source_test",
-	"allow_symlink /tmp/symlink_source_test",
-	"allow_symlink /tmp/symlink_source_test",
-	"allow_symlink /tmp/symlink_source_test",
-	"allow_symlink /tmp/symlink_source_test",
-	"allow_truncate /tmp/rewrite_test",
-	"allow_truncate /tmp/truncate_test",
-	"allow_truncate /tmp/truncate_test",
-	"allow_unlink /tmp/unlink_test",
-	"allow_write /123",
-	"allow_write /dev/null",
-	"allow_write /dev/null",
-	"allow_write /devfile",
-	"allow_write /devfile",
-	"allow_write /proc/sys/net/ipv4/ip_local_port_range",
-	"allow_write /proc/sys/net/ipv4/ip_local_port_range",
-	"allow_write /tmp/open_test",
-	"allow_write /tmp/open_test",
-	"allow_write /tmp/open_test",
-	"allow_write /tmp/truncate_test",
-	"allow_write /tmp/truncate_test",
-	"allow_rewrite /tmp/rewrite_test",
-	"allow_rewrite /tmp/rewrite_test",
-	"allow_mount /dev/sda1 /mnt/sda1/ ext3 0x123",
-	"allow_mount /dev/sda1 /mnt/sda1/ ext3 123",
-	"allow_mount /dev/sda1 /mnt/sda1/ ext3 0123",
-	"allow_mount /dev/sda1 /mnt/sda1/ ext3 0x123",
-	"allow_mount /dev/sda1 /mnt/sda1/ ext3 123",
-	"allow_mount /dev/sda1 /mnt/sda1/ ext3 0123",
-	"allow_chroot /",
-	"allow_chroot /",
-	"allow_chroot /mnt/",
-	"allow_pivot_root / /proc/",
-	"allow_pivot_root /mnt/ /proc/mnt/",
-	"allow_unmount /",
-	"allow_unmount /proc/",
-	NULL
-};
-
-static void domain_policy_test(const unsigned int before)
-{
-	unsigned int after;
-	int j;
-	policy_file = "/sys/kernel/security/tomoyo/domain_policy";
-	for (j = 0; domain_testcases[j]; j++) {
-		int i;
-		FILE *fp = fopen(policy_file, "w");
-		if (!fp)
-			BUG("BUG: Policy write error\n");
-		fprintf(fp, "<kernel>\n");
-		policy = domain_testcases[j];
-		printf("Processing: %s\n", policy);
-		for (i = 0; i < 100; i++) {
-			fprintf(fp, "%s\n", policy);
-			if (!i)
-				check_policy_written(fp, 1);
-			fprintf(fp, "delete %s\n", policy);
-		}
-		check_policy_deleted(fp, 1);
-		for (i = 0; i < 100; i++)
-			fprintf(fp, "%s\n", policy);
-		check_policy_written(fp, 2);
-		fprintf(fp, "delete %s\n", policy);
-		check_policy_deleted(fp, 2);
-		fclose(fp);
-		for (i = 0; i < 30; i++) {
-			usleep(100000);
-			get_meminfo(&after);
-			if (before == after)
-				break;
-		}
-		if (before != after) {
-			printf("Policy: %d\n", after - before);
-			BUG("Policy read/write test: Fail\n");
-		}
-	}
-	for (j = 0; j < 10; j++) {
-		int i;
-		FILE *fp = fopen(policy_file, "w");
-		if (!fp)
-			BUG("BUG: Policy write error\n");
-		fprintf(fp, "<kernel> /sbin/init\n");
-		for (i = 0; domain_testcases[i]; i++)
-			fprintf(fp, "%s\n", domain_testcases[i]);
-		fprintf(fp, "delete <kernel> /sbin/init\n");
-		fclose(fp);
-		for (i = 0; i < 50; i++) {
-			usleep(100000);
-			get_meminfo(&after);
-			if (before == after)
-				break;
-		}
-		if (before != after) {
-			printf("Policy: %d\n", after - before);
-			BUG("Policy read/write test: Fail\n");
-		}
-	}
-}
-
-static const char *exception_testcases[] = {
-	"allow_read /tmp/mknod_reg_test",
-	"allow_env HOME",
-	"path_group PG1 /",
-	"path_group PG2 /",
-	"address_group AG3 0.0.0.0",
-	"address_group AG3 1.2.3.4-5.6.7.8",
-	"address_group AG3 f:ee:ddd:cccc:b:aa:999:8888",
-	"address_group AG4 0:1:2:3:4:5:6:7-8:90:a00:b000:c00:d0:e:f000",
-	"number_group NG1 1000",
-	"number_group NG2 10-0x100000",
-	"number_group NG3 01234567-0xABCDEF89",
-	"deny_autobind 1024",
-	"deny_autobind 32668-65535",
-	"deny_autobind 0-1023",
-	"initialize_domain /usr/sbin/sshd",
-	"no_initialize_domain /usr/sbin/sshd",
-	"initialize_domain /usr/sbin/sshd from /bin/bash",
-	"no_initialize_domain /usr/sbin/sshd from /bin/bash",
-	"initialize_domain /usr/sbin/sshd from "
-	    "<kernel> /bin/mingetty/bin/bash",
-	"no_initialize_domain /usr/sbin/sshd from "
-	    "<kernel> /bin/mingetty/bin/bash",
-	"keep_domain <kernel> /usr/sbin/sshd /bin/bash",
-	"no_keep_domain <kernel> /usr/sbin/sshd /bin/bash",
-	"keep_domain /bin/pwd from <kernel> /usr/sbin/sshd /bin/bash",
-	"no_keep_domain /bin/pwd from <kernel> /usr/sbin/sshd /bin/bash",
-	"keep_domain /bin/pwd from /bin/bash",
-	"no_keep_domain /bin/pwd from /bin/bash",
-	"file_pattern /proc/\\$/task/\\$/environ",
-	"file_pattern /proc/\\$/task/\\$/auxv",
-	"allow_read /etc/ld.so.cache",
-	"allow_read /proc/meminfo",
-	"allow_read /proc/sys/kernel/version",
-	"allow_read /etc/localtime",
-	"allow_read /proc/self/task/\\$/attr/current",
-	"allow_read /proc/self/task/\\$/oom_score",
-	"allow_read /proc/self/wchan",
-	"allow_read /lib/ld-2.5.so",
-	"file_pattern pipe:[\\$]",
-	"file_pattern socket:[\\$]",
-	"file_pattern /var/cache/logwatch/logwatch.\\*/",
-	"file_pattern /var/cache/logwatch/logwatch.\\*/\\*",
-	"deny_rewrite /var/log/\\*",
-	"deny_rewrite /var/log/\\*/\\*",
-	"aggregator /etc/rc.d/rc\\?.d/\\?\\+\\+smb /etc/rc.d/init.d/smb",
-	"aggregator /etc/rc.d/rc\\?.d/\\?\\+\\+crond /etc/rc.d/init.d/crond",
-	NULL
-};
-
-static void exception_policy_test(const unsigned int before)
-{
-	unsigned int after;
-	int j;
-	policy_file = "/sys/kernel/security/tomoyo/exception_policy";
-	for (j = 0; exception_testcases[j]; j++) {
-		int i;
-		FILE *fp = fopen(policy_file, "w");
-		if (!fp)
-			BUG("BUG: Policy write error\n");
-		policy = exception_testcases[j];
-		printf("Processing: %s\n", policy);
-		for (i = 0; i < 100; i++) {
-			fprintf(fp, "%s\n", policy);
-			if (!i)
-				check_policy_written(fp, 1);
-			fprintf(fp, "delete %s\n", policy);
-		}
-		check_policy_deleted(fp, 1);
-		for (i = 0; i < 100; i++)
-			fprintf(fp, "%s\n", policy);
-		check_policy_written(fp, 2);
-		fprintf(fp, "delete %s\n", policy);
-		check_policy_deleted(fp, 2);
-		fclose(fp);
-		for (i = 0; i < 30; i++) {
-			usleep(100000);
-			get_meminfo(&after);
-			if (before == after)
-				break;
-		}
-		if (before != after) {
-			printf("Policy: %d\n", after - before);
-			BUG("Policy read/write test: Fail\n");
-		}
-	}
-	for (j = 0; j < 10; j++) {
-		int i;
-		FILE *fp = fopen(policy_file, "w");
-		if (!fp)
-			BUG("BUG: Policy write error\n");
-		for (i = 0; exception_testcases[i]; i++)
-			fprintf(fp, "%s\n", exception_testcases[i]);
-		for (i = 0; exception_testcases[i]; i++)
-			fprintf(fp, "delete %s\n", exception_testcases[i]);
-		fclose(fp);
-		for (i = 0; i < 50; i++) {
-			usleep(100000);
-			get_meminfo(&after);
-			if (before == after)
-				break;
-		}
-		if (before != after) {
-			printf("Policy: %d\n", after - before);
-			BUG("Policy read/write test: Fail\n");
-		}
-	}
-}
-
-int main(void)
-{
-	unsigned int before;
-	mount("/proc", "/proc/", "proc", 0, NULL);
-	get_meminfo(&before);
-	domain_policy_test(before);
-	exception_policy_test(before);
-	BUG("Policy read/write test: Success\n");
-	return 0;
-}
diff --git a/testcases/kernel/security/tomoyo/tomoyo_rewrite_test b/testcases/kernel/security/tomoyo/tomoyo_rewrite_test
new file mode 100755
index 0000000000000000000000000000000000000000..60361b70023ed0555c4782de85490e4fab80e426
GIT binary patch
literal 44712
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

literal 0
HcmV?d00001

diff --git a/testcases/kernel/security/tomoyo/tomoyo_rewrite_test.c b/testcases/kernel/security/tomoyo/tomoyo_rewrite_test.c
deleted file mode 100644
index 7bc22c39b..000000000
--- a/testcases/kernel/security/tomoyo/tomoyo_rewrite_test.c
+++ /dev/null
@@ -1,169 +0,0 @@
-/******************************************************************************/
-/* This program is free software;  you can redistribute it and/or modify      */
-/* it under the terms of the GNU General Public License as published by       */
-/* the Free Software Foundation; either version 2 of the License, or          */
-/* (at your option) any later version.                                        */
-/*                                                                            */
-/* This program is distributed in the hope that it will be useful,            */
-/* but WITHOUT ANY WARRANTY;  without even the implied warranty of            */
-/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  */
-/* the GNU General Public License for more details.                           */
-/*                                                                            */
-/* You should have received a copy of the GNU General Public License          */
-/* along with this program;  if not, write to the Free Software               */
-/* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    */
-/*                                                                            */
-/******************************************************************************/
-/*
- * tomoyo_rewrite_test.c
- *
- * Testing program for security/tomoyo/
- *
- * Copyright (C) 2005-2010  NTT DATA CORPORATION
- */
-#include "include.h"
-
-static int should_fail = 0;
-
-static void show_prompt(const char *str)
-{
-	printf("Testing %35s: (%s) ", str,
-	       should_fail ? "must fail" : "must success");
-	errno = 0;
-}
-
-static void show_result(int result)
-{
-	if (should_fail) {
-		if (result == EOF) {
-			if (errno == EPERM)
-				printf("OK: Permission denied.\n");
-			else
-				printf("BUG!\n");
-		} else {
-			printf("BUG!\n");
-		}
-	} else {
-		if (result != EOF)
-			printf("OK\n");
-		else
-			printf("BUG!\n");
-	}
-}
-
-#define REWRITE_PATH "/tmp/rewrite_test"
-
-static void stage_rewrite_test(void)
-{
-	int fd;
-
-	/* Start up */
-	write_domain_policy("allow_read/write " REWRITE_PATH, 0);
-	write_domain_policy("allow_truncate " REWRITE_PATH, 0);
-	write_domain_policy("allow_create " REWRITE_PATH " 0600", 0);
-	write_domain_policy("allow_unlink " REWRITE_PATH, 0);
-	write_exception_policy("deny_rewrite " REWRITE_PATH, 0);
-	set_profile(3, "file::open");
-	set_profile(3, "file::create");
-	set_profile(3, "file::truncate");
-	set_profile(3, "file::rewrite");
-	set_profile(3, "file::unlink");
-	close(open(REWRITE_PATH, O_WRONLY | O_APPEND | O_CREAT, 0600));
-
-	/* Enforce mode */
-	should_fail = 0;
-
-	show_prompt("open(O_RDONLY)");
-	fd = open(REWRITE_PATH, O_RDONLY);
-	show_result(fd);
-	close(fd);
-
-	show_prompt("open(O_WRONLY | O_APPEND)");
-	fd = open(REWRITE_PATH, O_WRONLY | O_APPEND);
-	show_result(fd);
-	close(fd);
-
-	should_fail = 1;
-	show_prompt("open(O_WRONLY)");
-	fd = open(REWRITE_PATH, O_WRONLY);
-	show_result(fd);
-	close(fd);
-
-	show_prompt("open(O_WRONLY | O_TRUNC)");
-	fd = open(REWRITE_PATH, O_WRONLY | O_TRUNC);
-	show_result(fd);
-	close(fd);
-
-	show_prompt("open(O_WRONLY | O_TRUNC | O_APPEND)");
-	fd = open(REWRITE_PATH, O_WRONLY | O_TRUNC | O_APPEND);
-	show_result(fd);
-	close(fd);
-
-	show_prompt("truncate()");
-	show_result(truncate(REWRITE_PATH, 0));
-
-	fd = open(REWRITE_PATH, O_WRONLY | O_APPEND);
-	show_prompt("ftruncate()");
-	show_result(ftruncate(fd, 0));
-
-	show_prompt("fcntl(F_SETFL, ~O_APPEND)");
-	show_result(fcntl(fd, F_SETFL, fcntl(fd, F_GETFL) & ~O_APPEND));
-	close(fd);
-
-	/* Permissive mode */
-	set_profile(2, "file::open");
-	set_profile(2, "file::create");
-	set_profile(2, "file::truncate");
-	set_profile(2, "file::rewrite");
-	set_profile(2, "file::unlink");
-	should_fail = 0;
-
-	show_prompt("open(O_RDONLY)");
-	fd = open(REWRITE_PATH, O_RDONLY);
-	show_result(fd);
-	close(fd);
-
-	show_prompt("open(O_WRONLY | O_APPEND)");
-	fd = open(REWRITE_PATH, O_WRONLY | O_APPEND);
-	show_result(fd);
-	close(fd);
-
-	show_prompt("open(O_WRONLY)");
-	fd = open(REWRITE_PATH, O_WRONLY);
-	show_result(fd);
-	close(fd);
-
-	show_prompt("open(O_WRONLY | O_TRUNC)");
-	fd = open(REWRITE_PATH, O_WRONLY | O_TRUNC);
-	show_result(fd);
-	close(fd);
-
-	show_prompt("open(O_WRONLY | O_TRUNC | O_APPEND)");
-	fd = open(REWRITE_PATH, O_WRONLY | O_TRUNC | O_APPEND);
-	show_result(fd);
-	close(fd);
-
-	show_prompt("truncate()");
-	show_result(truncate(REWRITE_PATH, 0));
-
-	fd = open(REWRITE_PATH, O_WRONLY | O_APPEND);
-	show_prompt("ftruncate()");
-	show_result(ftruncate(fd, 0));
-
-	show_prompt("fcntl(F_SETFL, ~O_APPEND)");
-	show_result(fcntl(fd, F_SETFL, fcntl(fd, F_GETFL) & ~O_APPEND));
-	close(fd);
-
-	/* Clean up */
-	unlink(REWRITE_PATH);
-	write_exception_policy("deny_rewrite " REWRITE_PATH, 0);
-	printf("\n\n");
-}
-
-int main(void)
-{
-	tomoyo_test_init();
-	stage_rewrite_test();
-	clear_status();
-	return 0;
-}
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

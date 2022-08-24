Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99EE0C32796
	for <ltp@archiver.kernel.org>; Wed, 24 Aug 2022 12:41:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CE4183CA3B2
	for <ltp@archiver.kernel.org>; Wed, 24 Aug 2022 14:41:21 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DFEB43CA2E5
 for <ltp@lists.linux.it>; Wed, 24 Aug 2022 14:41:11 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C7A0A200B83
 for <ltp@lists.linux.it>; Wed, 24 Aug 2022 14:41:10 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 94AC2342E1;
 Wed, 24 Aug 2022 12:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1661344869; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=d6vxsUjqFwzShMYphdpABVA7FTMEwEc4FAU8n9GYycU=;
 b=k0Vbmn/Ul33YqnANElDPuOyrPhHdk5nnHW5h/jJXlu7bk0Gx6O1r3+JrVTsAFPAwdIW+5J
 7sRk74v0H0dwiRwIMGK/PNFYTO1xQ1AgfPGNvO8VL5hhAKKCq4QvERT0MtcKckgT0bi7bl
 ScS4Ft13ILYrhD/V1fv6KFzUHkR2Ars=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5074B13AC0;
 Wed, 24 Aug 2022 12:41:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id o/TGDWUcBmPwVgAAMHmgww
 (envelope-from <andrea.cervesato@suse.com>); Wed, 24 Aug 2022 12:41:09 +0000
To: ltp@lists.linux.it
Date: Wed, 24 Aug 2022 14:40:17 +0200
Message-Id: <20220824124017.14286-1-andrea.cervesato@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] Rewrite process_vm01 test using new LTP API
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Now test is run on process_vm_writev by default and process_vm_readv can
be selected by passing -r command line option.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                             |   2 +-
 testcases/kernel/syscalls/cma/process_vm01.c | 464 ++++++++-----------
 2 files changed, 188 insertions(+), 278 deletions(-)

diff --git a/runtest/syscalls b/runtest/syscalls
index 3847e8af2..70f22fbd5 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1031,7 +1031,7 @@ profil01 profil01
 process_vm_readv01 process_vm01 -r
 process_vm_readv02 process_vm_readv02
 process_vm_readv03 process_vm_readv03
-process_vm_writev01 process_vm01 -w
+process_vm_writev01 process_vm01
 process_vm_writev02 process_vm_writev02
 
 prot_hsymlinks prot_hsymlinks
diff --git a/testcases/kernel/syscalls/cma/process_vm01.c b/testcases/kernel/syscalls/cma/process_vm01.c
index 16f14d66b..bfd5c5acb 100644
--- a/testcases/kernel/syscalls/cma/process_vm01.c
+++ b/testcases/kernel/syscalls/cma/process_vm01.c
@@ -1,47 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (C) 2012 Linux Test Project, Inc.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * Further, this software is distributed without any warranty that it
- * is free of the rightful claim of any third person regarding
- * infringement or the like.  Any license provided herein, whether
- * implied or otherwise, applies only to this software file.  Patent
- * licenses, if any, provided herein do not apply to combinations of
- * this program with other software, or any other product whatsoever.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA.
+ * Copyright (c) Linux Test Project, 2012
+ * Copyright (C) 2021 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
  */
 
-/*
- * errno tests shared by process_vm_readv, process_vm_writev tests.
+/*\
+ * [Description]
+ *
+ * Test errno codes in process_vm_readv and process_vm_writev syscalls.
  */
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <sys/syscall.h>
-#include <sys/uio.h>
-#include <sys/wait.h>
-#include <sys/mman.h>
-#include <errno.h>
-#include <signal.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
-#include <unistd.h>
-#include <limits.h>
+
 #include <pwd.h>
-#include "config.h"
-#include "test.h"
-#include "safe_macros.h"
+#include <stdlib.h>
+#include "tst_test.h"
 #include "lapi/syscalls.h"
 
 struct process_vm_params {
@@ -56,137 +27,27 @@ struct process_vm_params {
 	unsigned long flags;
 };
 
-static int rflag;
-static int wflag;
-
-static option_t options[] = {
-	{"r", &rflag, NULL},
-	{"w", &wflag, NULL},
-	{NULL, NULL, NULL}
-};
-
-static char TCID_readv[] = "process_vm_readv";
-static char TCID_writev[] = "process_vm_writev";
-char *TCID = "cma01";
-int TST_TOTAL = 1;
-static void (*cma_test_params) (struct process_vm_params * params) = NULL;
-
-static void setup(char *argv[]);
-static void cleanup(void);
-static void help(void);
-
-static void cma_test_params_read(struct process_vm_params *params);
-static void cma_test_params_write(struct process_vm_params *params);
-static void cma_test_errnos(void);
-
-int main(int argc, char *argv[])
-{
-	int lc;
-
-	tst_parse_opts(argc, argv, options, &help);
-
-	setup(argv);
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-		cma_test_errnos();
-	}
-	cleanup();
-	tst_exit();
-}
-
-static void setup(char *argv[])
-{
-	tst_require_root();
-
-	if (rflag && wflag)
-		tst_brkm(TBROK, NULL, "Parameters -r -w can not be used"
-			 " at the same time.");
-	else if (rflag) {
-		TCID = TCID_readv;
-		cma_test_params = cma_test_params_read;
-	} else if (wflag) {
-		TCID = TCID_writev;
-		cma_test_params = cma_test_params_write;
-	} else
-		tst_brkm(TBROK, NULL, "Parameter missing, required -r or -w.");
-	TEST_PAUSE;
-}
-
-static void cleanup(void)
-{
-}
-
-static void help(void)
-{
-	printf("  -r      Use process_vm_readv\n");
-	printf("  -w      Use process_vm_writev\n");
-}
-
-static void cma_test_params_read(struct process_vm_params *params)
-{
-	TEST(tst_syscall(__NR_process_vm_readv,
-			 params->pid,
-			 params->lvec, params->liovcnt,
-			 params->rvec, params->riovcnt,
-			 params->flags));
-}
-
-static void cma_test_params_write(struct process_vm_params *params)
-{
-	TEST(tst_syscall(__NR_process_vm_writev,
-			 params->pid,
-			 params->lvec, params->liovcnt,
-			 params->rvec, params->riovcnt,
-			 params->flags));
-}
-
-static int cma_check_ret(long expected_ret, long act_ret)
-{
-	if (expected_ret == act_ret) {
-		tst_resm(TPASS, "expected ret success - "
-			 "returned value = %ld", act_ret);
-	} else {
-		tst_resm(TFAIL, "unexpected failure - "
-			 "returned value = %ld, expected: %ld",
-			 act_ret, expected_ret);
-		return 1;
-	}
-	return 0;
-}
-
-static int cma_check_errno(long expected_errno)
-{
-	if (TEST_ERRNO == expected_errno)
-		tst_resm(TPASS | TTERRNO, "expected failure");
-	else if (TEST_ERRNO == 0) {
-		tst_resm(TFAIL, "call succeeded unexpectedly");
-		return 1;
-	} else {
-		tst_resm(TFAIL | TTERRNO, "unexpected failure - "
-			 "expected = %ld : %s, actual",
-			 expected_errno, strerror(expected_errno));
-		return 2;
-	}
-	return 0;
-}
+static char *str_read;
+static void (*test_params)(struct process_vm_params *params);
 
-static struct process_vm_params *cma_alloc_sane_params(void)
+static struct process_vm_params *alloc_params(void)
 {
 	struct process_vm_params *sane_params;
 	int len;
 
 	len = getpagesize();
-	sane_params = SAFE_MALLOC(NULL, sizeof(struct process_vm_params));
+
+	sane_params = SAFE_MALLOC(sizeof(struct process_vm_params));
 	sane_params->len = len;
-	sane_params->ldummy = SAFE_MALLOC(NULL, len);
-	sane_params->rdummy = SAFE_MALLOC(NULL, len);
+	sane_params->ldummy = SAFE_MALLOC(len);
+	sane_params->rdummy = SAFE_MALLOC(len);
 
-	sane_params->lvec = SAFE_MALLOC(NULL, sizeof(struct iovec));
+	sane_params->lvec = SAFE_MALLOC(sizeof(struct process_vm_params));
 	sane_params->lvec->iov_base = sane_params->ldummy;
 	sane_params->lvec->iov_len = len;
 	sane_params->liovcnt = 1;
 
-	sane_params->rvec = SAFE_MALLOC(NULL, sizeof(struct iovec));
+	sane_params->rvec = SAFE_MALLOC(sizeof(struct process_vm_params));
 	sane_params->rvec->iov_base = sane_params->rdummy;
 	sane_params->rvec->iov_len = len;
 	sane_params->riovcnt = 1;
@@ -197,7 +58,7 @@ static struct process_vm_params *cma_alloc_sane_params(void)
 	return sane_params;
 }
 
-static void cma_free_params(struct process_vm_params *params)
+static void free_params(struct process_vm_params *params)
 {
 	if (params) {
 		free(params->ldummy);
@@ -208,195 +69,244 @@ static void cma_free_params(struct process_vm_params *params)
 	}
 }
 
-static void cma_test_sane_params(void)
+static void test_readv(struct process_vm_params *params)
+{
+	TEST(tst_syscall(__NR_process_vm_readv,
+		params->pid,
+		params->lvec, params->liovcnt,
+		params->rvec, params->riovcnt,
+		params->flags));
+}
+
+static void test_writev(struct process_vm_params *params)
+{
+	TEST(tst_syscall(__NR_process_vm_writev,
+		params->pid,
+		params->lvec, params->liovcnt,
+		params->rvec, params->riovcnt,
+		params->flags));
+}
+
+static void check_errno(long expected_errno)
+{
+	if (TST_ERR == expected_errno)
+		tst_res(TPASS | TTERRNO, "expected failure");
+	else if (TST_ERR == 0)
+		tst_res(TFAIL, "call succeeded unexpectedly");
+	else
+		tst_res(TFAIL | TTERRNO, "unexpected failure - "
+			"expected = %ld : %s, actual",
+			expected_errno, strerror(expected_errno));
+}
+
+static void test_sane_params(void)
 {
 	struct process_vm_params *sane_params;
 
-	sane_params = cma_alloc_sane_params();
-	tst_resm(TINFO, "test_sane_params");
-	cma_test_params(sane_params);
-	cma_check_ret(sane_params->len, TEST_RETURN);
-	cma_free_params(sane_params);
+	tst_res(TINFO, "Testing sane parameters");
+
+	sane_params = alloc_params();
+	test_params(sane_params);
+	TST_EXP_EQ_LI(TST_RET, sane_params->len);
+	free_params(sane_params);
 }
 
-static void cma_test_flags(void)
+static void test_flags(void)
 {
 	struct process_vm_params *params;
 	long flags[] = { -INT_MAX, -1, 1, INT_MAX, 0 };
-	int flags_size = sizeof(flags) / sizeof(flags[0]);
+	int flags_size = ARRAY_SIZE(flags) / sizeof(flags[0]);
 	int i;
 
-	params = cma_alloc_sane_params();
+	params = alloc_params();
+
 	for (i = 0; i < flags_size; i++) {
 		params->flags = flags[i];
-		tst_resm(TINFO, "test_flags, flags=%ld", flags[i]);
-		cma_test_params(params);
+
+		tst_res(TINFO, "Testing flags=%ld", flags[i]);
+		test_params(params);
+
 		/* atm. only flags == 0 is allowed, everything else
-		 * should fail with EINVAL */
+		 * should fail with EINVAL
+		 */
 		if (flags[i] != 0) {
-			cma_check_ret(-1, TEST_RETURN);
-			cma_check_errno(EINVAL);
+			TST_EXP_EQ_LI(TST_RET, -1);
+			check_errno(EINVAL);
 		} else {
-			cma_check_ret(params->len, TEST_RETURN);
+			TST_EXP_EQ_LI(TST_RET, params->len);
 		}
 	}
-	cma_free_params(params);
+
+	free_params(params);
 }
 
-static void cma_test_iov_len_overflow(void)
+static void test_iov_len_overflow(void)
 {
 	struct process_vm_params *params;
-	ssize_t maxlen = -1;
-	params = cma_alloc_sane_params();
-
-	params->lvec->iov_len = maxlen;
-	params->rvec->iov_len = maxlen;
-	tst_resm(TINFO, "test_iov_len_overflow");
-	cma_test_params(params);
-	cma_check_ret(-1, TEST_RETURN);
-	cma_check_errno(EINVAL);
-	cma_free_params(params);
+
+	tst_res(TINFO, "Testing iov_len = -1");
+
+	params = alloc_params();
+	params->lvec->iov_len = -1;
+	params->rvec->iov_len = -1;
+	test_params(params);
+	TST_EXP_EQ_LI(TST_RET, -1);
+	check_errno(EINVAL);
+	free_params(params);
 }
 
-static void cma_test_iov_invalid(void)
+static void test_iov_invalid(void)
 {
 	struct process_vm_params *sane_params;
 	struct process_vm_params params_copy;
 
-	sane_params = cma_alloc_sane_params();
-	/* make a shallow copy we can 'damage' */
+	sane_params = alloc_params();
 
+	tst_res(TINFO, "Testing lvec->iov_base = -1");
 	params_copy = *sane_params;
-	tst_resm(TINFO, "test_iov_invalid - lvec->iov_base");
 	params_copy.lvec->iov_base = (void *)-1;
-	cma_test_params(&params_copy);
-	cma_check_ret(-1, TEST_RETURN);
-	cma_check_errno(EFAULT);
+	test_params(&params_copy);
+	TST_EXP_EQ_LI(TST_RET, -1);
+	check_errno(EFAULT);
 
+	tst_res(TINFO, "Testing rvec->iov_base = -1");
 	params_copy = *sane_params;
-	tst_resm(TINFO, "test_iov_invalid - rvec->iov_base");
 	params_copy.rvec->iov_base = (void *)-1;
-	cma_test_params(&params_copy);
-	cma_check_ret(-1, TEST_RETURN);
-	cma_check_errno(EFAULT);
+	test_params(&params_copy);
+	TST_EXP_EQ_LI(TST_RET, -1);
+	check_errno(EFAULT);
 
+	tst_res(TINFO, "Testing lvec = -1");
 	params_copy = *sane_params;
-	tst_resm(TINFO, "test_iov_invalid - lvec");
 	params_copy.lvec = (void *)-1;
-	cma_test_params(&params_copy);
-	cma_check_ret(-1, TEST_RETURN);
-	cma_check_errno(EFAULT);
+	test_params(&params_copy);
+	TST_EXP_EQ_LI(TST_RET, -1);
+	check_errno(EFAULT);
 
+	tst_res(TINFO, "Testing rvec = -1");
 	params_copy = *sane_params;
-	tst_resm(TINFO, "test_iov_invalid - rvec");
 	params_copy.rvec = (void *)-1;
-	cma_test_params(&params_copy);
-	cma_check_ret(-1, TEST_RETURN);
-	cma_check_errno(EFAULT);
+	test_params(&params_copy);
+	TST_EXP_EQ_LI(TST_RET, -1);
+	check_errno(EFAULT);
 
-	cma_free_params(sane_params);
+	free_params(sane_params);
 }
 
-static void cma_test_invalid_pid(void)
+static void test_invalid_pid(void)
 {
 	pid_t invalid_pid = -1;
 	struct process_vm_params *params;
+	struct process_vm_params params_copy;
+
+	params = alloc_params();
+
+	tst_res(TINFO, "Testing invalid PID");
+	params_copy = *params;
+	params_copy.pid = invalid_pid;
+	test_params(&params_copy);
+	TST_EXP_EQ_LI(TST_RET, -1);
+	check_errno(ESRCH);
 
-	params = cma_alloc_sane_params();
-	tst_resm(TINFO, "test_invalid_pid");
-	params->pid = invalid_pid;
-	cma_test_params(params);
-	cma_check_ret(-1, TEST_RETURN);
-	cma_check_errno(ESRCH);
-	cma_free_params(params);
-
-	invalid_pid = tst_get_unused_pid(cleanup);
-
-	params = cma_alloc_sane_params();
-	params->pid = invalid_pid;
-	cma_test_params(params);
-	cma_check_ret(-1, TEST_RETURN);
-	cma_check_errno(ESRCH);
-	cma_free_params(params);
+	tst_res(TINFO, "Testing unused PID");
+	params_copy = *params;
+	invalid_pid = tst_get_unused_pid();
+	params_copy.pid = invalid_pid;
+	test_params(&params_copy);
+	TST_EXP_EQ_LI(TST_RET, -1);
+	check_errno(ESRCH);
+
+	free_params(params);
 }
 
-static void cma_test_invalid_perm(void)
+static void test_invalid_perm(void)
 {
 	char nobody_uid[] = "nobody";
 	struct passwd *ltpuser;
-	int status;
 	struct process_vm_params *params;
 	pid_t child_pid;
 	pid_t parent_pid;
-	int ret = 0;
+	int status;
+
+	tst_res(TINFO, "Testing invalid permissions on given PID");
 
-	tst_resm(TINFO, "test_invalid_perm");
 	parent_pid = getpid();
-	child_pid = fork();
-	switch (child_pid) {
-	case -1:
-		tst_brkm(TBROK | TERRNO, cleanup, "fork");
-		break;
-	case 0:
-		ltpuser = getpwnam(nobody_uid);
-		if (ltpuser == NULL)
-			tst_brkm(TBROK | TERRNO, NULL, "getpwnam failed");
-		SAFE_SETUID(NULL, ltpuser->pw_uid);
-
-		params = cma_alloc_sane_params();
+	child_pid = SAFE_FORK();
+	if (!child_pid) {
+		ltpuser = SAFE_GETPWNAM(nobody_uid);
+		SAFE_SETUID(ltpuser->pw_uid);
+
+		params = alloc_params();
 		params->pid = parent_pid;
-		cma_test_params(params);
-		ret |= cma_check_ret(-1, TEST_RETURN);
-		ret |= cma_check_errno(EPERM);
-		cma_free_params(params);
-		exit(ret);
-	default:
-		SAFE_WAITPID(cleanup, child_pid, &status, 0);
-		if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
-			tst_resm(TFAIL, "child returns %d", status);
+		test_params(params);
+		TST_EXP_EQ_LI(TST_RET, -1);
+		check_errno(EPERM);
+		free_params(params);
+		return;
 	}
+
+	SAFE_WAITPID(child_pid, &status, 0);
 }
 
-static void cma_test_invalid_protection(void)
+static void test_invalid_protection(void)
 {
 	struct process_vm_params *sane_params;
 	struct process_vm_params params_copy;
-	void *p;
-
-	sane_params = cma_alloc_sane_params();
-	/* make a shallow copy we can 'damage' */
+	void *data;
+	int len;
 
-	p = mmap(NULL, getpagesize(), PROT_NONE,
-		 MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
-	if (p == MAP_FAILED)
-		tst_brkm(TBROK | TERRNO, cleanup, "mmap");
+	len = getpagesize();
+	sane_params = alloc_params();
+	data = SAFE_MMAP(NULL, len, PROT_NONE, MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
 
+	tst_res(TINFO, "Testing data with invalid protection (lvec)");
 	params_copy = *sane_params;
-	params_copy.lvec->iov_base = p;
-	tst_resm(TINFO, "test_invalid_protection lvec");
-	cma_test_params(&params_copy);
-	cma_check_ret(-1, TEST_RETURN);
-	cma_check_errno(EFAULT);
+	params_copy.lvec->iov_base = data;
+	test_params(&params_copy);
+	TST_EXP_EQ_LI(TST_RET, -1);
+	check_errno(EFAULT);
 
+	tst_res(TINFO, "Testing data with invalid protection (rvec)");
 	params_copy = *sane_params;
-	params_copy.rvec->iov_base = p;
-	tst_resm(TINFO, "test_invalid_protection rvec");
-	cma_test_params(&params_copy);
-	cma_check_ret(-1, TEST_RETURN);
-	cma_check_errno(EFAULT);
+	params_copy.rvec->iov_base = data;
+	test_params(&params_copy);
+	TST_EXP_EQ_LI(TST_RET, -1);
+	check_errno(EFAULT);
 
-	SAFE_MUNMAP(cleanup, p, getpagesize());
+	SAFE_MUNMAP(data, len);
+	free_params(sane_params);
+}
 
-	cma_free_params(sane_params);
+static void run(void)
+{
+	test_sane_params();
+	test_flags();
+	test_iov_len_overflow();
+	test_iov_invalid();
+	test_invalid_pid();
+	test_invalid_perm();
+	test_invalid_protection();
 }
 
-static void cma_test_errnos(void)
+static void setup(void)
 {
-	cma_test_sane_params();
-	cma_test_flags();
-	cma_test_iov_len_overflow();
-	cma_test_iov_invalid();
-	cma_test_invalid_pid();
-	cma_test_invalid_perm();
-	cma_test_invalid_protection();
+	if (str_read) {
+		tst_res(TINFO, "Selected process_vm_readv");
+		test_params = test_readv;
+	} else {
+		tst_res(TINFO, "Selected process_vm_writev");
+		test_params = test_writev;
+	}
 }
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.forks_child = 1,
+	.needs_checkpoints = 1,
+	.needs_root = 1,
+	.options = (struct tst_option[]) {
+		{"r", &str_read, "Use process_vm_read instead of process_vm_write"},
+		{},
+	},
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

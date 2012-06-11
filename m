Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1Se5Jh-0007De-JR
	for ltp-list@lists.sourceforge.net; Mon, 11 Jun 2012 14:10:01 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Se5Jd-0002Lw-Cv
	for ltp-list@lists.sourceforge.net; Mon, 11 Jun 2012 14:10:01 +0000
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q5BE9pd1010008
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 11 Jun 2012 10:09:52 -0400
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with
	ESMTP id q5BE9o0t029756
	for <ltp-list@lists.sourceforge.net>; Mon, 11 Jun 2012 10:09:51 -0400
Message-ID: <4FD5FC2E.5050202@redhat.com>
Date: Mon, 11 Jun 2012 16:09:50 +0200
From: Jan Stancek <jstancek@redhat.com>
MIME-Version: 1.0
References: <cover.1339421791.git.jstancek@redhat.com>
In-Reply-To: <cover.1339421791.git.jstancek@redhat.com>
Content-Type: multipart/mixed; boundary="------------080007010309030704000505"
Subject: [LTP] [PATCH v3 3/3] syscalls/cma: add errno tests
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------080007010309030704000505
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


Based on proposed man page:
http://ozlabs.org/~cyeoh/cma/process_vm_readv.txt

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 runtest/syscalls                             |    3 +
 testcases/kernel/syscalls/cma/process_vm01.c |  431 ++++++++++++++++++++++++++
 2 files changed, 434 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/syscalls/cma/process_vm01.c



--------------080007010309030704000505
Content-Type: text/x-patch;
 name="0003-syscalls-cma-add-errno-tests.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="0003-syscalls-cma-add-errno-tests.patch"

diff --git a/runtest/syscalls b/runtest/syscalls
index e203d5e..6cdb23e 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -732,6 +732,9 @@ pread03_64 pread03_64
 
 profil01 profil01
 
+process_vm_readv01 process_vm01 -r
+process_vm_writev01 process_vm01 -w
+
 pselect01 pselect01
 pselect01_64 pselect01_64
 
diff --git a/testcases/kernel/syscalls/cma/process_vm01.c b/testcases/kernel/syscalls/cma/process_vm01.c
new file mode 100644
index 0000000..d5bec69
--- /dev/null
+++ b/testcases/kernel/syscalls/cma/process_vm01.c
@@ -0,0 +1,431 @@
+/*
+ * Copyright (C) 2012 Linux Test Project, Inc.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of version 2 of the GNU General Public
+ * License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it would be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ * Further, this software is distributed without any warranty that it
+ * is free of the rightful claim of any third person regarding
+ * infringement or the like.  Any license provided herein, whether
+ * implied or otherwise, applies only to this software file.  Patent
+ * licenses, if any, provided herein do not apply to combinations of
+ * this program with other software, or any other product whatsoever.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
+ * 02110-1301, USA.
+ */
+
+/*
+ * errno tests shared by process_vm_readv, process_vm_writev tests.
+ */
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/syscall.h>
+#include <sys/uio.h>
+#include <sys/wait.h>
+#include <sys/mman.h>
+#include <errno.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <limits.h>
+#include <pwd.h>
+#include "config.h"
+#include "test.h"
+#include "usctest.h"
+#include "safe_macros.h"
+#include "process_vm.h"
+
+struct process_vm_params {
+	int len;
+	char *ldummy;
+	char *rdummy;
+	pid_t pid;
+	struct iovec *lvec;
+	unsigned long liovcnt;
+	struct iovec *rvec;
+	unsigned long riovcnt;
+	unsigned long flags;
+};
+
+static int rflag;
+static int wflag;
+
+static option_t options[] = {
+	{"r", &rflag, NULL},
+	{"w", &wflag, NULL},
+	{NULL, NULL, NULL}
+};
+
+static char TCID_readv[] = "process_vm_readv";
+static char TCID_writev[] = "process_vm_writev";
+char *TCID = "cma01";
+int  TST_TOTAL = 1;
+static void (*cma_test_params)(struct process_vm_params *params) = NULL;
+
+static void setup(char *argv[]);
+static void cleanup(void);
+static void help(void);
+
+static void cma_test_params_read(struct process_vm_params *params);
+static void cma_test_params_write(struct process_vm_params *params);
+static void cma_test_errnos(void);
+
+int main(int argc, char *argv[])
+{
+	int lc;
+	char *msg;
+
+	msg = parse_opts(argc, argv, options, &help);
+	if (msg != NULL)
+		tst_brkm(TBROK, tst_exit, "OPTION PARSING ERROR - %s", msg);
+
+	setup(argv);
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		Tst_count = 0;
+		cma_test_errnos();
+	}
+	cleanup();
+	tst_exit();
+}
+
+static void setup(char *argv[])
+{
+	tst_require_root(NULL);
+
+	if (rflag && wflag)
+		tst_brkm(TBROK, NULL, "Parameters -r -w can not be used"
+				" at the same time.");
+	else if (rflag) {
+		TCID = TCID_readv;
+#if defined(__NR_process_vm_readv)
+		cma_test_params = cma_test_params_read;
+#else
+		tst_brkm(TCONF, NULL, "process_vm_readv does not"
+				" exist on your system.");
+#endif
+	} else if (wflag) {
+		TCID = TCID_writev;
+#if defined(__NR_process_vm_writev)
+		cma_test_params = cma_test_params_write;
+#else
+		tst_brkm(TCONF, NULL, "process_vm_writev does not"
+				" exist on your system.");
+#endif
+	} else
+		tst_brkm(TBROK, NULL, "Parameter missing, required -r or -w.");
+	TEST_PAUSE;
+}
+
+static void cleanup(void)
+{
+	TEST_CLEANUP;
+}
+
+static void help(void)
+{
+	printf("  -r      Use process_vm_readv\n");
+	printf("  -w      Use process_vm_writev\n");
+}
+
+static void cma_test_params_read(struct process_vm_params *params)
+{
+	TEST(test_process_vm_readv(params->pid,
+				params->lvec, params->liovcnt,
+				params->rvec, params->riovcnt,
+				params->flags));
+}
+
+static void cma_test_params_write(struct process_vm_params *params)
+{
+	TEST(test_process_vm_writev(params->pid,
+				params->lvec, params->liovcnt,
+				params->rvec, params->riovcnt,
+				params->flags));
+}
+
+static int cma_check_ret(long expected_ret, long act_ret)
+{
+	if (expected_ret == act_ret) {
+		tst_resm(TPASS, "expected ret success - "
+				"returned value = %ld", act_ret);
+	} else {
+		tst_resm(TFAIL, "unexpected failure - "
+				"returned value = %ld, expected: %ld",
+				act_ret, expected_ret);
+		return 1;
+	}
+	return 0;
+}
+
+static int cma_check_errno(long expected_errno)
+{
+	if (TEST_ERRNO == expected_errno)
+		tst_resm(TPASS|TTERRNO, "expected failure");
+	else if (TEST_ERRNO == 0) {
+		tst_resm(TFAIL, "call succeeded unexpectedly");
+		return 1;
+	} else {
+		tst_resm(TFAIL|TTERRNO, "unexpected failure - "
+				"expected = %ld : %s, actual",
+				expected_errno, strerror(expected_errno));
+		return 2;
+	}
+	return 0;
+}
+
+static struct process_vm_params *cma_alloc_sane_params()
+{
+	struct process_vm_params *sane_params;
+	int len;
+
+	len = getpagesize();
+	sane_params = SAFE_MALLOC(NULL, sizeof(struct process_vm_params));
+	sane_params->len = len;
+	sane_params->ldummy = SAFE_MALLOC(NULL, len);
+	sane_params->rdummy = SAFE_MALLOC(NULL, len);
+
+	sane_params->lvec = SAFE_MALLOC(NULL, sizeof(struct iovec));
+	sane_params->lvec->iov_base = sane_params->ldummy;
+	sane_params->lvec->iov_len = len;
+	sane_params->liovcnt = 1;
+
+	sane_params->rvec = SAFE_MALLOC(NULL, sizeof(struct iovec));
+	sane_params->rvec->iov_base = sane_params->rdummy;
+	sane_params->rvec->iov_len = len;
+	sane_params->riovcnt = 1;
+
+	sane_params->flags = 0;
+	sane_params->pid = getpid();
+
+	return sane_params;
+}
+
+static void cma_free_params(struct process_vm_params *params)
+{
+	if (params) {
+		free(params->ldummy);
+		free(params->rdummy);
+		free(params->lvec);
+		free(params->rvec);
+		free(params);
+	}
+}
+
+static void cma_test_sane_params(void)
+{
+	struct process_vm_params *sane_params;
+
+	sane_params = cma_alloc_sane_params();
+	tst_resm(TINFO, "test_sane_params");
+	cma_test_params(sane_params);
+	cma_check_ret(sane_params->len, TEST_RETURN);
+	cma_free_params(sane_params);
+}
+
+static void cma_test_flags(void)
+{
+	struct process_vm_params *params;
+	long flags[] = { -INT_MAX, -1, 1, INT_MAX, 0 };
+	int flags_size = sizeof(flags)/sizeof(flags[0]);
+	int i;
+
+	params = cma_alloc_sane_params();
+	for (i = 0; i < flags_size; i++) {
+		params->flags = flags[i];
+		tst_resm(TINFO, "test_flags, flags=%ld", flags[i]);
+		cma_test_params(params);
+		/* atm. only flags == 0 is allowed, everything else
+		 * should fail with EINVAL */
+		if (flags[i] != 0) {
+			cma_check_ret(-1, TEST_RETURN);
+			cma_check_errno(EINVAL);
+		} else {
+			cma_check_ret(params->len, TEST_RETURN);
+		}
+	}
+	cma_free_params(params);
+}
+
+static void cma_test_iov_len_overflow(void)
+{
+	struct process_vm_params *params;
+	ssize_t maxlen = -1;
+	params = cma_alloc_sane_params();
+
+	params->lvec->iov_len = maxlen;
+	params->rvec->iov_len = maxlen;
+	tst_resm(TINFO, "test_iov_len_overflow");
+	cma_test_params(params);
+	cma_check_ret(-1, TEST_RETURN);
+	cma_check_errno(EINVAL);
+	cma_free_params(params);
+}
+
+static void cma_test_iov_invalid(void)
+{
+	struct process_vm_params *sane_params;
+	struct process_vm_params params_copy;
+
+	sane_params = cma_alloc_sane_params();
+	/* make a shallow copy we can 'damage' */
+
+	params_copy = *sane_params;
+	tst_resm(TINFO, "test_iov_invalid - lvec->iov_base");
+	params_copy.lvec->iov_base = (void *)-1;
+	cma_test_params(&params_copy);
+	cma_check_ret(-1, TEST_RETURN);
+	cma_check_errno(EFAULT);
+
+	params_copy = *sane_params;
+	tst_resm(TINFO, "test_iov_invalid - rvec->iov_base");
+	params_copy.rvec->iov_base = (void *)-1;
+	cma_test_params(&params_copy);
+	cma_check_ret(-1, TEST_RETURN);
+	cma_check_errno(EFAULT);
+
+	params_copy = *sane_params;
+	tst_resm(TINFO, "test_iov_invalid - lvec");
+	params_copy.lvec = (void *)-1;
+	cma_test_params(&params_copy);
+	cma_check_ret(-1, TEST_RETURN);
+	cma_check_errno(EFAULT);
+
+	params_copy = *sane_params;
+	tst_resm(TINFO, "test_iov_invalid - rvec");
+	params_copy.rvec = (void *)-1;
+	cma_test_params(&params_copy);
+	cma_check_ret(-1, TEST_RETURN);
+	cma_check_errno(EFAULT);
+
+	cma_free_params(sane_params);
+}
+
+static void cma_test_invalid_pid(void)
+{
+	const char pid_max[]="/proc/sys/kernel/pid_max";
+	pid_t invalid_pid = -1;
+	struct process_vm_params *params;
+	FILE *fp;
+	char buff[512];
+
+	params = cma_alloc_sane_params();
+	tst_resm(TINFO, "test_invalid_pid");
+	params->pid = invalid_pid;
+	cma_test_params(params);
+	cma_check_ret(-1, TEST_RETURN);
+	cma_check_errno(ESRCH);
+	cma_free_params(params);
+
+	fp = fopen(pid_max, "r");
+	if (fp == NULL)
+		tst_brkm(TBROK, cleanup,
+				"Could not open %s", pid_max);
+	if (!fgets(buff, sizeof(buff), fp))
+		tst_brkm(TBROK, cleanup,
+				"Could not read %s", pid_max);
+	fclose(fp);
+	invalid_pid = atol(buff) + 1;
+
+	params = cma_alloc_sane_params();
+	params->pid = invalid_pid;
+	cma_test_params(params);
+	cma_check_ret(-1, TEST_RETURN);
+	cma_check_errno(ESRCH);
+	cma_free_params(params);
+}
+
+static void cma_test_invalid_perm(void)
+{
+	char nobody_uid[] = "nobody";
+	struct passwd *ltpuser;
+	int status;
+	struct process_vm_params *params;
+	pid_t child_pid;
+	pid_t parent_pid;
+	int ret = 0;
+
+	tst_resm(TINFO, "test_invalid_perm");
+	parent_pid = getpid();
+	child_pid = fork();
+	switch (child_pid) {
+		case -1:
+			tst_brkm(TBROK|TERRNO, cleanup, "fork");
+			break;
+		case 0:
+			ltpuser = getpwnam(nobody_uid);
+			if (ltpuser == NULL)
+				tst_brkm(TBROK|TERRNO, NULL,
+						"getpwnam failed");
+			if (setuid(ltpuser->pw_uid) == -1)
+				tst_brkm(TBROK|TERRNO, NULL,
+						"setuid(%u) failed", ltpuser->pw_uid);
+
+			params = cma_alloc_sane_params();
+			params->pid = parent_pid;
+			cma_test_params(params);
+			ret |= cma_check_ret(-1, TEST_RETURN);
+			ret |= cma_check_errno(EPERM);
+			cma_free_params(params);
+			exit(ret);
+		default:
+			if (waitpid(child_pid, &status, 0) == -1)
+				tst_brkm(TBROK|TERRNO, cleanup, "waitpid");
+			if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
+				tst_resm(TFAIL, "child returns %d", status);
+	}
+}
+
+static void cma_test_invalid_protection(void)
+{
+	struct process_vm_params *sane_params;
+	struct process_vm_params params_copy;
+	void *p;
+
+	sane_params = cma_alloc_sane_params();
+	/* make a shallow copy we can 'damage' */
+
+	p = mmap(NULL, getpagesize(), PROT_NONE,
+			MAP_PRIVATE|MAP_ANONYMOUS, 0, 0);
+	if (p == MAP_FAILED)
+		tst_brkm(TBROK|TERRNO, cleanup, "mmap");
+
+	params_copy = *sane_params;
+	params_copy.lvec->iov_base = p;
+	tst_resm(TINFO, "test_invalid_protection lvec");
+	cma_test_params(&params_copy);
+	cma_check_ret(-1, TEST_RETURN);
+	cma_check_errno(EFAULT);
+
+	params_copy = *sane_params;
+	params_copy.rvec->iov_base = p;
+	tst_resm(TINFO, "test_invalid_protection rvec");
+	cma_test_params(&params_copy);
+	cma_check_ret(-1, TEST_RETURN);
+	cma_check_errno(EFAULT);
+
+	if (munmap(p, getpagesize()) < 0)
+		tst_brkm(TBROK|TERRNO, cleanup, "munmap");
+
+	cma_free_params(sane_params);
+}
+
+static void cma_test_errnos()
+{
+	cma_test_sane_params();
+	cma_test_flags();
+	cma_test_iov_len_overflow();
+	cma_test_iov_invalid();
+	cma_test_invalid_pid();
+	cma_test_invalid_perm();
+	cma_test_invalid_protection();
+}


--------------080007010309030704000505
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
--------------080007010309030704000505
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------080007010309030704000505--

